#!/bin/bash
TARGET="/www/wwwroot/trangtri4mua.com/docs/REVIEWER_FEEDBACK.md"
REPO_DIR="/www/wwwroot/trangtri4mua.com/docs"

cd "$REPO_DIR" || exit 1
LAST_HASH=$(md5sum "$TARGET" 2>/dev/null | awk '{print $1}')
echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FEEDBACK_WATCHER] Initialized watcher on $TARGET (hash: $LAST_HASH)"

while true; do
    sleep 60
    
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    # 1. Fetch remote GitHub origin/main
    git fetch origin main --quiet 2>&1
    
    # 2. Check if remote has new commits ahead of local
    BEHIND=$(git rev-list HEAD..origin/main --count 2>/dev/null || echo 0)
    
    if [ "$BEHIND" -gt 0 ]; then
        echo "[$TIMESTAMP] [FEEDBACK_WATCHER] DETECTED $BEHIND NEW COMMIT(S) ON GITHUB! Pulling..."
        PULL_OUTPUT=$(git pull origin main 2>&1)
        echo "[$TIMESTAMP] [FEEDBACK_WATCHER] Pull result: $PULL_OUTPUT"
        
        NEW_HASH=$(md5sum "$TARGET" 2>/dev/null | awk '{print $1}')
        if [ "$NEW_HASH" != "$LAST_HASH" ]; then
            echo "[$TIMESTAMP] [FEEDBACK_WATCHER] >>> CRITICAL: REVIEWER_FEEDBACK.md has been updated via git pull! ($LAST_HASH -> $NEW_HASH)"
            LAST_HASH="$NEW_HASH"
        fi
    else
        # Also check local file modifications
        CURRENT_HASH=$(md5sum "$TARGET" 2>/dev/null | awk '{print $1}')
        if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
            echo "[$TIMESTAMP] [FEEDBACK_WATCHER] >>> LOCAL UPDATE DETECTED in $TARGET! ($LAST_HASH -> $CURRENT_HASH)"
            LAST_HASH="$CURRENT_HASH"
        else
            echo "[$TIMESTAMP] [FEEDBACK_WATCHER] [1-MIN CHECK] Git fetched origin/main (0 new commits). REVIEWER_FEEDBACK.md hash: $LAST_HASH (Status: Up to date)"
        fi
    fi
done
