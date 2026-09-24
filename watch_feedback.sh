#!/bin/bash
TARGET="/www/wwwroot/trangtri4mua.com/docs/REVIEWER_FEEDBACK.md"
REPO_DIR="/www/wwwroot/trangtri4mua.com/docs"

LAST_HASH=$(md5sum "$TARGET" 2>/dev/null | awk '{print $1}')
echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FEEDBACK_WATCHER] Started watching $TARGET (initial hash: $LAST_HASH)"

while true; do
    sleep 60
    
    # 1. Check if remote git repository has new commits
    cd "$REPO_DIR" && git fetch origin main --quiet 2>/dev/null
    BEHIND=$(git rev-list HEAD..origin/main --count 2>/dev/null || echo 0)
    if [ "$BEHIND" -gt 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FEEDBACK_WATCHER] Remote git updates detected ($BEHIND commits behind). Pulling..."
        git pull origin main --quiet 2>/dev/null
    fi

    # 2. Check if local file hash changed
    CURRENT_HASH=$(md5sum "$TARGET" 2>/dev/null | awk '{print $1}')
    if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FEEDBACK_WATCHER] NEW UPDATE DETECTED in $TARGET! (hash changed: $LAST_HASH -> $CURRENT_HASH)"
        LAST_HASH="$CURRENT_HASH"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FEEDBACK_WATCHER] 1-min check: REVIEWER_FEEDBACK.md is up to date (hash: $LAST_HASH)"
    fi
done
