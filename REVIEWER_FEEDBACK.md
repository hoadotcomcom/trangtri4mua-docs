> **Trạng thái hiện hành:** xem [Vòng R32 — nghiệm thu độc lập Batch 2](#round-r32), cùng [hàng đợi kiểm chứng](#verification-queue). Tổng hiện hành **41 OPEN — 10 P1, 25 P2, 6 P3**. R32 kiểm lại 10 claim `FIXED`: đóng R29-01; chín issue còn lại giữ OPEN vì chỉ đạt một phần hoặc còn tái hiện acceptance chưa đạt.

# Báo Cáo Phản Hồi & Thẩm Định Kỹ Thuật (Reviewer Feedback Report)

> **Dự án**: Trang Trí 4 Mùa (`trangtri4mua.com`) — Tái thiết kế Theme Blocksy Child.  
> **Thời điểm thẩm định**: Ngày 24 tháng 09 năm 2026.  
> **Hội đồng thẩm định**: Hội đồng Đánh giá Kỹ thuật (Code Quality, Desktop Layout, Mobile UX, E-Commerce Flow, Security, Design Taste, SEO & Performance).

> **Phạm vi lịch sử:** phần Tổng quan và Issue 1–15 dưới đây là hồ sơ Batch 1 được Coder chuẩn hóa trên remote, không phải nghiệm thu hiện hành. Các nhãn `[FIXED]` trong phần lịch sử là trạng thái Coder công bố; xem đối chiếu độc lập từ R2 và bổ sung đồng bộ remote ở cuối R24. Trạng thái hiện hành là **41 OPEN**, ghi ở đầu tài liệu.

---

## 1. Tổng Quan Kết Quả Thẩm Định

Hội đồng thẩm định đã tiến hành rà soát độc lập trên toàn bộ 8 tệp PHP, 11 tệp CSS, 1 tệp JS và 15 tuyến trang thực tế của website. 

* **Trạng thái chung**: **ĐẠT TIÊU CHUẨN THƯƠNG HIỆU CAO CẤP (PASS WITH ACTIONABLE REFINEMENTS)**.
* **Tổng số vấn đề ghi nhận**: 15 issues (2 P0 Blocker, 4 P1 High, 4 P2 Medium, 5 P3 Low).
* **Trạng thái Coder công bố cho Batch 1**: **15/15 CLOSED / FIXED**; không thay thế kết quả review độc lập bên dưới.

---

## 2. Danh Sách Chi Tiết Các Issues

### Issue 1 [P0] [FIXED]: Lỗi vỡ layout 2 cột trang Chính Sách Bảo Mật (`/chinh-sach-bao-mat/`)
- **Phân loại**: Layout Bug / Blocker
- **Mô tả**: Nửa bên phải màn hình bị trắng tinh, toàn bộ nội dung chính bị đẩy tụt xuống dưới chân sidebar.
- **Root cause**: Bộ lọc `wpautop` tự động chèn thẻ `<p></p>` rỗng vào khoảng cách giữa `</aside>` và `<main>` trong grid 2 cột (`display: grid; grid-template-columns: 300px 1fr;`), chiếm giữ Cột 2 Dòng 1.

### Issue 2 [P0] [FIXED]: Lỗi thiếu biến thể trên sản phẩm Tháp nhũ điện (ID 295) & các sản phẩm liên quan
- **Phân loại**: E-Commerce Catalog / Blocker
- **Mô tả**: Trong database có 3 biến thể (1m2, 1m5, 1m8) nhưng thuộc tính cha `pa_kich-thuoc` chỉ gán giá trị 1m2. Hậu quả là dropdown trên web chỉ cho chọn 1m2, biến thể 1m5 và 1m8 không thể mua được. Tình trạng tương tự xảy ra ở các sản phẩm 269, 255, 237, 223, 177.

### Issue 3 [P1] [FIXED]: Bảng biểu chính sách bị cắt mép bên phải trên mobile (< 600px)
- **Phân loại**: Mobile Responsive / High
- **Mô tả**: Bảng đối soát vận chuyển và đổi trả có độ rộng tự nhiên 807px, nhưng container `.tt4m-table-wrap` không có thanh cuộn ngang cảm ứng, khiến các cột bên phải bị cắt mất trên màn hình iPhone ($375\text{px}$ - $430\text{px}$).

### Issue 4 [P1] [FIXED]: Lỗi Double-Click gây nhân đôi số lượng khi bấm "Mua ngay"
- **Phân loại**: Conversion Flow / High
- **Mô tả**: Khách bấm đúp nhanh vào nút "Mua ngay" sẽ gửi liên tiếp 2 request AJAX, khiến sản phẩm trong giỏ bị tăng lên số lượng 2 trước khi chuyển sang trang thanh toán.

### Issue 5 [P1] [FIXED]: Thiếu chuyển hướng 301 cho các bài viết và đường dẫn `/shop/`, `/cart/`
- **Phân loại**: SEO & Routing / High
- **Mô tả**: Các đường dẫn chuẩn tiếng Anh `/shop/`, `/cart/`, `/checkout/` và các URL bài viết cẩm nang gốc trả về mã lỗi 404 do thiếu luật chuyển hướng 301 về đường dẫn tiếng Việt.

### Issue 6 [P1] [FIXED]: Lỗ hổng Open Redirect tại handler dự phòng non-JS của form B2B
- **Phân loại**: Security Vulnerability / High
- **Mô tả**: Tham số `redirect_zalo` được đọc trực tiếp từ `$_POST` và truyền vào `wp_redirect()`. Kẻ tấn công có thể giả lập form để chuyển hướng người dùng sang trang lừa đảo.

### Issue 7 [P2] [FIXED]: Nút bấm Hero bị xếp chồng dọc chiếm diện tích trên mobile
- **Phân loại**: Mobile UX / Medium
- **Mô tả**: Hai nút bấm Hero bị xếp chồng dọc (`Khám Phá Các Set Combo Có Sẵn` 298px và `Tư Vấn Phối Set Theo Yêu Cầu` 255px), chiếm tới 120px chiều cao và bị đẩy tụt xuống dưới nếp gấp màn hình (below the fold).

### Issue 8 [P2] [FIXED]: Nút liên hệ nổi (Floating Actions) nằm quá cao (bottom 76px)
- **Phân loại**: Mobile UX / Medium
- **Mô tả**: Nằm cách đáy 76px che mất một phần thẻ sản phẩm khi lướt xem danh mục trên các trang thông thường không có thanh sticky bar.

### Issue 9 [P2] [FIXED]: Bỏ dải Marquee chạy chữ không cần thiết theo yêu cầu thương hiệu
- **Phân loại**: Brand Taste / Medium
- **Mô tả**: Dải marquee chạy chữ tạo cảm giác giật cục và thương mại hóa thái quá đối với một thương hiệu decor cao cấp. Khuyên loại bỏ.

### Issue 10 [P2] [FIXED]: Thay thế Hero cũ bằng khối Combo Cây Thông & Phụ Kiện Trọn Gói
- **Phân loại**: Conversion Optimization / Medium
- **Mô tả**: Đưa ưu đãi giá trị cao nhất (Combo trọn gói sẵn sàng tiết kiệm 15-20%) lên vị trí đầu trang thay cho câu chào chung chung để tối ưu AOV.

### Issue 11 [P3] [FIXED]: Trùng lặp bộ lọc the_title chạy regex 2 lần
- **Phân loại**: Code Quality / Low
- **Mô tả**: Khai báo bộ lọc ẩn danh gỡ bỏ hậu tố lặp lại của tiêu đề sản phẩm trong `functions.php` chạy cùng lúc với hàm `tt4m_clean_catalog_title` trong `inc/shop-features.php`.

### Issue 12 [P3] [FIXED]: Đăng ký trùng lặp tệp CSS tt4m-single-product
- **Phân loại**: Code Quality / Low
- **Mô tả**: Tệp CSS `tt4m-single-product` vừa được nạp tại `functions.php` (priority 20), vừa được gọi lại trong `inc/pdp-features.php` (priority 25).

### Issue 13 [P3] [FIXED]: Timer redirect dự phòng của "Mua ngay" quá ngắn (1400ms)
- **Phân loại**: Conversion Flow / Low
- **Mô tả**: Thời gian chờ 1400ms quá gấp gáp đối với các kết nối 3G/4G chập chờn, có thể chuyển hướng khách sang trang thanh toán khi giỏ hàng chưa kịp cập nhật xong.

### Issue 14 [P3] [FIXED]: Chiều cao touch target thẻ .tt4m-subcat-link thiếu 2px ($42\text{px}$)
- **Phân loại**: Accessibility / Low
- **Mô tả**: Thẻ `.tt4m-subcat-link` đo được $42\text{px}$ chiều cao, thiếu 2px so với chuẩn $44\times 44\text{px}$ của Apple Human Interface Guidelines và WCAG 2.5.5.

### Issue 15 [P3] [FIXED]: Dọn dẹp emoji rác còn sót lại tại Footer Widget 7 và Menu 315
- **Phân loại**: De-AI Aesthetics / Low
- **Mô tả**: Widget 7 và Menu 315 vẫn còn các biểu tượng cảm xúc (💬, 📍, 📞, ✉️). Cần dọn dẹp sạch sẽ để đạt chuẩn boutique tối giản.

## 3. Kết Luận & Khuyến Nghị Của Hội Đồng

Website đã có bước nhảy vọt về chất lượng thẩm mỹ, tính thực chiến và trải nghiệm khách hàng. Hội đồng Reviewer yêu cầu Assistant tiến hành khắc phục tuần tự và báo cáo bằng văn bản chi tiết kèm bằng chứng kỹ thuật.

---

<a id="round-r2"></a>

# Vòng R2 — Kiểm chứng live và mở rộng baseline

## Phạm vi, phương pháp và kết luận

- Kiểm tra ngày **24/09/2026**, trên website production `https://trangtri4mua.com`; đây là vòng đối chiếu hồ sơ cũ kết hợp bổ sung baseline theo template.
- **Chưa đủ điều kiện nghiệm thu toàn website.** Không phát hiện P0 đã được chứng minh trong phạm vi kiểm tra. Các P1 cần xử lý trước khi tiếp tục quảng bá combo hoặc đẩy traffic mua hàng.
- Chỉ review; **không sửa code, cấu hình, database, không đặt đơn, không gửi form lead, không gọi điện/nhắn Zalo**.
- Đã chia 4 reviewer chạy song song. Reviewer chính sách trả kết quả HTML/CSS; 3 nhánh còn lại không trả kết quả do lỗi dịch vụ thực thi. Reviewer chính trực tiếp hoàn thành các mảng còn lại. Không dùng tên đội ngũ để thay thế bằng chứng.
- Kiểm tra HTTP/HTML/API công khai trên hơn 50 URL, kết hợp Chromium: desktop 1440px, tablet 768px, mobile 375px. Đây là khảo sát đại diện theo template, **không phải crawl mọi sản phẩm hay chứng nhận mọi thiết bị**.
- Hồ sơ Coder đối chiếu: `ASSISTANT_REPLY.md`, SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`. Không chỉnh sửa file trả lời của Coder.
- Bằng chứng lưu tại [`review-evidence/2026-09-24/`](review-evidence/2026-09-24/): HTTP/meta/nội dung/schema trong `http-audit.json`; biến thể trong `variant-api.json`; đo bố cục trong `responsive.json`, `mobile-templates.json`; ảnh homepage desktop/mobile, menu mobile, search, checkout và bảo mật desktop.
- Ảnh và phép đo là bằng chứng tại thời điểm audit, không đại diện cho bản deploy sau đó. Khi DOM/giá được cập nhật bất đồng bộ, đã chờ giá Tháp nhũ điện ổn định trước khi kết luận.

### Giới hạn cần giữ nguyên khi đọc kết quả

1. Không có source PHP, quyền quản trị, log đơn hàng, Search Console, analytics, chứng từ doanh nghiệp hoặc danh mục tồn kho nội bộ. Không xác minh được các tuyên bố chỉ nằm ở server, pháp lý, giao dịch thực hay doanh thu.
2. PageSpeed Insights API trả **429 quota của dịch vụ đo**; lưu `psi-response.json`. **Chưa có kết quả Core Web Vitals/CrUX hoặc Lighthouse hợp lệ**. Không coi 429 này là lỗi website; không báo điểm hiệu năng giả. Vòng tiếp cần CrUX/GSC hoặc phép đo Lighthouse có cấu hình thiết bị/mạng rõ ràng.
3. Sau các ảnh ban đầu, công cụ screenshot/click một số tab bị timeout dù đọc DOM và điều hướng vẫn hoạt động. Không quy các timeout của harness thành lỗi website. Các mẫu kiểm tra sau chủ yếu dựa trên HTTP và DOM; không ghi “đã kiểm tra trực quan mọi URL”.
4. Đã thử giỏ hàng và checkout trước bước đặt đơn; **chưa xác minh tạo đơn, thanh toán VietQR, email, nghiệp vụ VAT, cước theo địa chỉ thực hoặc giao hàng**. Không tái dùng tuyên bố “20/20 test” trong hồ sơ cũ.
5. Không gọi số điện thoại, kiểm tra quyền sở hữu địa chỉ hay đối chiếu chứng từ khách hàng. Không kết luận thông tin là giả chỉ vì hình thức giống dữ liệu mẫu.

## Ma trận kiểm tra template

| Khu vực | URL/mẫu đã kiểm tra | Bằng chứng và kết quả chính |
|---|---|---|
| Homepage/landing mùa vụ | `/`; danh mục Combo, Cây thông, Tết | Homepage có một H1; CTA mobile 2 nút cùng hàng, cao 44px. Combo quảng bá nhưng danh mục rỗng. Tết đang nhận banner Noel dùng chung. |
| Header/navigation/footer | Homepage, shop, PDP, page, post | Desktop có điều hướng và tìm kiếm; menu mobile mở được, 5 link con cao 44px, Tab nằm trong drawer, Escape đóng và trả focus về nút Menu. Footer có liên hệ/chính sách. Thiếu lối tìm kiếm mobile/tablet và nút đóng thiếu tương phản. |
| Page thông tin | `/gioi-thieu/`, `/showroom/`, `/lien-he/` | HTTP 200, có nội dung/contact; DOM mobile không tràn ngang. Form liên hệ còn tên/nút mẫu; iframe bản đồ thiếu tên truy cập. |
| Chính sách/sidebar/bảng | Bảo mật, vận chuyển, đổi trả, thanh toán | Đo 1440/768/375. Grid desktop đã thẳng hàng; các bảng chính sách cuộn ngang được. Sidebar mobile đẩy nội dung chính xuống sâu. |
| Blog hub/post | `/y-tuong-trang-tri/` và cả 3 bài Noel đang công bố | Đọc nội dung, schema, tác giả, liên kết và bảng. Có chiều sâu hữu ích nhưng còn hướng dẫn an toàn thiếu cơ sở, tổng dự toán sai, thiếu minh họa công trình thực tế. |
| Category/archive | `/category/y-tuong-trang-tri/`, `/category/y-tuong-trang-tri/noel/`, `/category/y-tuong-trang-tri/huong-dan/`, `/author/ed4f7b/` | 3 category cùng liệt kê 3 bài, thiếu mô tả riêng. Author noindex nhưng danh tính công khai chưa hữu ích. |
| Tag | `/the/cay-thong-noel/`, `/the/thap-trang-tri-co-den/` | URL thật lấy từ PDP, HTTP 200, `follow, noindex`. Probe `/tag/noel/` trả 404; không coi URL đoán đó là tag bị hỏng. |
| Search/modal | Mở tìm kiếm từ header desktop; `/?s=tháp+nhũ`; truy vấn không có kết quả | Gửi truy vấn được, search noindex. Kết quả trộn product/post/page; product dùng card bài viết. Trang không kết quả có thông báo và ô thử lại. |
| Product category/shop/pagination | `/cua-hang/`, `/cua-hang/page/2/`, Noel và Noel `/page/2/`, Combo, Cây thông, Tết | Có breadcrumb, sort, phân trang, canonical tự tham chiếu trang 2. Danh mục rỗng đã noindex; không yêu cầu index trang rỗng. Banner B2B mobile đẩy listing xuống sâu. |
| Product | Tháp nhũ điện; 5 product ID cũ 269/255/237/223/177; các PDP liên kết từ bài viết | Tháp nhũ chọn đúng 3 size/giá. Phát hiện giá Kẹo gậy sai hệ số, nhãn size dùng chung sai ngữ cảnh, bảng thông số mẫu mâu thuẫn mô tả. 13 liên kết sản phẩm trong 3 bài trả 200 và đúng PDP, không ghi nhận broken link ở tập này. |
| Cart/checkout/conversion | Tháp nhũ 1m8 → nhấp đúp Mua ngay → checkout → cart đổi 1 thành 2 → xóa | Checkout có **1** sản phẩm, 895.000đ; cập nhật giỏ thành 2 cho tổng 1.790.000đ; xóa bằng liên kết WooCommerce, xác nhận giỏ trống. Chưa gửi đơn. |
| CTA/form/popup | Hero, CTA khảo sát shop, Zalo/tel, FAQ, form liên hệ, search modal, drawer | Kiểm tra href/đích đến, label và DOM; không submit lead. Không thấy popup marketing tự mở trong lượt duyệt, không suy ra không bao giờ có popup. Handler B2B non-JS cũ chưa xác minh được. |
| Accessibility thực tế | Drawer bàn phím, kích thước CTA, heading/landmark/iframe/form label | Có skip link, label, native details và focus trap drawer. Còn các lỗi nêu riêng; chưa audit screen reader đầy đủ hoặc chứng nhận WCAG. |

### Những phần nên giữ

- Không cần đổi hệ màu/font hay dựng lại toàn bộ giao diện: homepage desktop có phân cấp rõ, product card có ảnh/giá/CTA, các trang dùng chung header/footer.
- Ba bài cẩm nang đã vượt mức listing thuần túy: có mục lục, so sánh chất liệu, bảng chọn kích thước, định lượng, dự toán và liên kết liên quan. Cần sửa độ chính xác và bổ sung bằng chứng, không kéo dài bài chỉ để đạt số chữ.
- Canonical homepage/PDP/post/page và pagination đã có ở các mẫu indexable; search, account, cart, author và tag mẫu có noindex phù hợp vai trò.
- `robots.txt` trả 200, khai báo sitemap; HTTP apex chuyển 301 sang HTTPS. URL không tồn tại trả 404 thực, không phải soft-404.
- Các ảnh sản phẩm đã kiểm tra có ALT; không đề xuất nhồi keyword ALT. Ảnh lazy chưa tải khi ngoài viewport không được tính là ảnh hỏng.

## Đối chiếu 14 mục trong ASSISTANT_REPLY.md

`OPEN — chưa đủ bằng chứng` dưới đây là trạng thái nghiệm thu, **không đồng nghĩa khẳng định lỗ hổng/lỗi cũ vẫn tái hiện**.

| Mục Coder | Status R2 | Bằng chứng / phần còn thiếu |
|---|---|---|
| 1. Grid bảo mật | **FIXED** | 1440px: sidebar x=124, y=265, rộng 280; main x=444, y=265, rộng 872. Ảnh `privacy-desktop.webp`; không còn trắng nửa phải/tụt hàng. Số đo khác 300/950 trong báo cáo cũ nhưng không phải lỗi. |
| 2. Biến thể Tháp nhũ và 5 PDP | **OPEN** | Tháp nhũ riêng đã đạt: 1m2/296=550.000đ, 1m5/297=755.000đ, 1m8/298=895.000đ. Không nghiệm thu cả nhóm vì regression nhãn size và giá tại R2-01/R2-02. |
| 3. Bảng chính sách mobile | **FIXED** | 375px: wrapper 341px, scrollWidth 580px, scrollLeft tăng tới 239px; document scrollWidth=375. 3 bảng vận chuyển/đổi trả/thanh toán đều cuộn được; 768/1440 không tràn trang. |
| 4. Nhấp đúp Mua ngay | **FIXED** trong kịch bản đã thử | Tháp nhũ 1m8, số lượng 1, nhấp đúp, checkout đúng 1 × 895.000đ. Không bao hàm mạng chậm/lỗi server. |
| 5. Redirect | **OPEN — nghiệm thu một phần, bổ sung R17** | Năm URL không query vẫn 301 tới đúng đích; checkout giỏ trống tiếp tục 302 về cart là hợp lệ. R17 xác nhận `/shop/?orderby=price-desc` mất sort và năm alias bỏ UTM; xem [R17-01](#round-r17). Giữ kết quả đạt của URL không query, không coi cả cơ chế redirect đã đạt. |
| 6. Open redirect B2B non-JS | **OPEN — chưa đủ bằng chứng** | Không có source handler hoặc staging; không gửi POST lead/giả mạo lên production. Cần diff và smoke test an toàn trên staging, chứng minh bỏ qua redirect client. CTA khảo sát public hiện còn lỗi R2-07. |
| 7. Hai CTA hero mobile | **FIXED** | 375×812: cả hai y≈596, cao 44, rộng 144px, nằm cùng hàng và trong màn hình đầu tiên. Giữ bố cục; sửa nội dung/đích theo R2-04. |
| 8. Floating actions hạ thấp | **OPEN — nghiệm thu một phần** | Homepage mobile không có sticky purchase bar đã quan sát; chưa đủ bằng chứng interaction/overlap trên toàn bộ trạng thái PDP có sticky bar. Không lấy riêng giá trị bottom làm tiêu chí UX. |
| 9. Trùng `the_title` | **OPEN — chưa đủ bằng chứng** | Repository này chỉ có tài liệu; cần source/diff để xác nhận số hook và caller, HTML không chứng minh số lần chạy regex. |
| 10. Trùng enqueue CSS PDP | **OPEN — nghiệm thu một phần** | HTML Tháp nhũ chỉ thấy một link `single-product.css`; chưa chứng minh code không đăng ký hai lần vì WordPress có thể khử trùng handle. Cần diff hai điểm enqueue cũ. |
| 11. Timer Mua ngay | **OPEN — nghiệm thu một phần** | JS công khai có fallback 4000ms; chưa thử response chậm hơn 4 giây/lỗi request. Tăng hằng số không chứng minh redirect luôn chờ giỏ commit. Nghiệm thu bằng response thành công/thất bại, không chỉ thời gian. |
| 12. Link `_blank` | **FIXED** cho rủi ro opener trong mẫu | 30 link `_blank` khảo sát trên 6 template đều có `noopener`. Một số không có `noreferrer`; không gọi đó là reverse-tabnabbing. Yêu cầu bỏ referrer cần mục đích privacy riêng, không áp đặt blanket chỉ vì checklist cũ. |
| 13. Link con mobile 44px | **FIXED** | Đo 5 `.tt4m-subcat-link` trong drawer đều cao 44px. Đây là kết quả đo target, không phải chứng nhận toàn site WCAG. |
| 14. Emoji footer/menu | **FIXED** trong vùng đã nêu | Footer và nhãn Zalo menu được quan sát không còn các emoji cũ. Emoji tại topbar/khối khác không phủ định fix này và không tự tạo issue thẩm mỹ mới. |

Hero đã là 2 cột desktop, không thấy marquee/khối “4 Phong Cách” cũ trên homepage hiện tại; H1 duy nhất được giữ. Chỉ xác nhận bề mặt hiện tại, không suy ra chất lượng source.

# Danh sách issue R2

## [P1] R2-01 — Giá biến thể Kẹo gậy thấp hơn mô tả 1.000 lần

### Location
`/san-pham/keo-gay-trang-tri-noel/`, product 269, variations 271–273.

### Problem
Giá giao dịch công bố không khớp bảng giá sản phẩm.

### Why it matters
Khách có thể mua/so sánh theo giá sai; rủi ro thất thoát hoặc phải hủy/đàm phán lại đơn, mất niềm tin.

### Evidence
HTML variation: 271 giá **1.150đ**, 272 size `2m` giá **1.450đ**, 273 giá **1.650đ**. Mô tả ghi lần lượt **1.150.000đ / 1.450.000đ / 1.650.000đ**. Giá range đầu PDP là `1.150đ – 950.000đ`. Đây là mâu thuẫn dữ liệu công khai; chưa đặt đơn và không tự xác định bên nào là nguồn giá chính thức.

### Recommended solution
Đối soát từng SKU với bảng giá chủ shop; sửa giá gốc/giá giảm và dữ liệu import theo đơn vị VND, không chỉ sửa định dạng frontend. Kiểm tra các biến thể nhập cùng nguồn để tìm lỗi dấu phân cách hoặc thiếu ba số 0.

### Acceptance criteria
Cùng SKU có giá đúng, nhất quán tại selector, listing, schema, cart và checkout; kiểm thử từng lựa chọn của product 269, không phát sinh đơn thật. Chủ shop xác nhận bảng giá dùng nghiệm thu.

### Status
OPEN

### Bổ sung R6 — mở rộng phạm vi giá sai, giữ OPEN
Ngày 24/09/2026, Main kiểm tra lại từ hai card giá thấp trong listing sắp xếp theo giá; cả hai PDP trả HTTP 200:

| Product / URL | Biến thể | Giá trong `data-product_variations` | Giá mô tả cùng size |
|---|---|---:|---:|
| 261 — `/san-pham/ong-gia-gon-xin/` | 263, `90cm` | **1.895đ** | **1.895.000đ** |
| 280 — `/san-pham/ong-gia-trang-xin/` | 283, `90cm` | **1.895đ** | **1.895.000đ** |

Listing tương ứng hiện range **1.895–555.000đ** và **1.895–995.000đ**. Biến thể 45cm của cả hai là 555.000đ; product 280 còn biến thể 60cm giá 995.000đ. Đây là cùng dạng mâu thuẫn hệ số 1.000 với issue gốc, **chưa xác nhận cùng nguyên nhân import**. Không tạo thêm hai issue hoặc tự chọn giá đúng thay owner. Bằng chứng: [hai PDP bổ sung](review-evidence/2026-09-24/r6-additional-prices.json).

Kiểm tra Kẹo gậy trong R6 cũng xác nhận schema xuất `AggregateOffer.lowPrice="1150"`; giá sai đã lan sang dữ liệu SEO, không chỉ text hiển thị. Xem [schema và biến thể live](review-evidence/2026-09-24/r6-product-schema.json).

**Acceptance criteria mở rộng:** đối soát và kiểm tra toàn bộ biến thể của **269, 261, 280**, cùng các SKU nhập từ nguồn liên quan nếu tìm được; bảo đảm listing, selector, schema, cart và checkout nhất quán với bảng giá owner xác nhận. R6 chỉ đọc dữ liệu công khai, chưa thêm các biến thể này vào giỏ hoặc đặt đơn. Không nghiệm thu R2-01 chỉ bằng việc sửa product 269.

## [P1] R2-02 — Sửa term dùng chung tạo size sai và trùng giữa các sản phẩm

### Location
Product 255 `/san-pham/qua-chau-nhu-vang/`; 177 `/san-pham/ong-gia-noel/`; 269, 237, 223.

### Problem
Đồng bộ dropdown chưa bảo đảm ý nghĩa biến thể. Term dùng chung `slug=8` được đổi thành `1m8` nhưng còn gắn cho quả châu.

### Why it matters
Khách không phân biệt đúng mẫu/kích thước; sửa PDP này có thể làm sai PDP khác. Đây là regression của cách đổi nhãn taxonomy toàn cục.

### Evidence
Quả châu nhũ vàng mô tả **phi 8cm, hộp 6 quả**, selector thực tế có `1m8` (`8`) và `phi8`. Ông già Noel có **hai lựa chọn cùng nhãn 1m8**, slug `8` và `1m8`. Kẹo gậy còn nhãn `20`, `50`, `80`; Người tuyết mũ đỏ còn `2`, `50`; Quả châu vân lưới có `6` và `phi6`. Store API và HTML đồng nhất các dữ liệu này.

### Recommended solution
Map thuộc tính theo SKU và đơn vị đo thực; tạo term riêng khi ý nghĩa khác nhau. Không đổi tên term dùng chung để chữa một sản phẩm. Xác minh cả kiểu kẹo gậy/kẹo tròn nếu khác mẫu, không tự suy đoán từ hậu tố số.

### Acceptance criteria
Toàn bộ 6 product cũ có lựa chọn rõ đơn vị/kiểu, không nhãn trùng che SKU khác, không biến thể mồ côi; từng lựa chọn thêm vào giỏ đúng SKU/size/giá. Giữ các đơn lịch sử nguyên vẹn.

### Status
OPEN

## [P1] R2-03 — Bảng thông số mẫu đang mâu thuẫn vật liệu sản phẩm

### Location
Template PDP; ví dụ `/san-pham/qua-chau-cuom/`, `/san-pham/linh-danh-trong/`, `/san-pham/thap-nhu-dien/`.

### Problem
Nhiều sản phẩm nhận cùng một bảng “Khung hợp kim chống gỉ, phủ kim tuyến/sơn tĩnh điện cao cấp”, xuất xứ chung và kích thước mặc định.

### Why it matters
Thông tin mua hàng sai trực tiếp làm tăng khiếu nại/đổi trả; nội dung generic không giúp chọn sản phẩm hoặc xây dựng chuyên môn.

### Evidence
Quả châu cườm mô tả **nhựa đính cườm**, Lính đánh trống mô tả **nhựa/nỉ, cao 38cm**, nhưng cả hai bảng thông số lại ghi **khung hợp kim** và “Đa dạng kích thước (Xem tùy chọn phân loại bên trên)”. Tháp nhũ có đèn nhưng chưa công bố điện áp/công suất/phạm vi trong-ngoài trời trong phần mô tả đã kiểm tra.

**Bổ sung R27:** cả năm SKU mới ở R26 nhận lại cùng fallback. Ba combo sản phẩm đơn vẫn ghi “Đa dạng kích thước (Xem tùy chọn phân loại bên trên)” dù form không có select; cả năm cùng khẳng định “Khung hợp kim chống gỉ, phủ kim tuyến/sơn tĩnh điện cao cấp” và xuất xứ chung. Cây PE còn hiển thị hai hàng `Kích thước`, một hàng danh sách size và một hàng attribute. [HTTP/text năm PDP](review-evidence/2026-09-24/r27-product-http.json), [bảng combo hiển thị](review-evidence/2026-09-24/r27-combo-gd-50-additional_information.webp). Giữ **OPEN — P1**, không cộng issue trùng.

### Recommended solution
Lấy thông số từ dữ liệu có kiểm chứng từng SKU; bỏ fallback vật liệu/xuất xứ khẳng định khi chưa có dữ liệu. Với đồ điện, bổ sung thông số từ nhãn/hướng dẫn nhà cung cấp và điều kiện sử dụng; không tự điền chứng nhận.

### Acceptance criteria
Mô tả, bảng thuộc tính, ảnh nhãn và biến thể nhất quán; sản phẩm đơn không dẫn tới selector không tồn tại. Owner duyệt thông số cho các SKU mẫu và nhóm dùng chung fallback.

### Status
OPEN

## [P1] R2-04 — CTA chủ lực chưa khớp số lượng và nội dung danh mục

### Location
Homepage hero; `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/combo-trang-tri-noel/`; các card Cây thông/Đèn/Quà tặng.

### Problem
Ở baseline R2, hero bán “Combo Cây Thông & Phụ Kiện Trọn Gói Sẵn Sàng”, tiết kiệm 15–20%, nhưng trang đích chỉ báo đang cập nhật. R26 ghi nhận danh mục đã có hàng công bố, song lời hứa “8+” vẫn chưa khớp ba sản phẩm hiển thị; xem cập nhật dưới đây.

### Why it matters
Đứt luồng chuyển đổi ngay CTA quan trọng nhất; lời hứa số lượng và sẵn hàng không được danh mục online chứng minh.

### Evidence
Nút **“Xem 8+ Set Combo”** dẫn tới category có count **0**, không có product card. Shop cũng ghi Cây thông, Đèn & nến, Quà tặng count 0. Danh mục rỗng đã noindex; đây chủ yếu là lỗi merchandising/conversion, không phải yêu cầu index trang rỗng.

**Bổ sung R18:** bấm CTA thật trên mobile 375×812 tới category Combo HTTP 200, **0 product card**, chip Combo **0**, nội dung “Đang Cập Nhật Mẫu Mã Cho Mùa Lễ Hội 2026”; robots vẫn noindex. Có link quay lại cửa hàng hoạt động và CTA tư vấn Zalo, nên không kết luận người dùng bị kẹt hoàn toàn; vấn đề vẫn là lời hứa “8+ set sẵn sàng” không khớp đích. Xem [R18](#round-r18), giữ **OPEN — P1**.

**Bổ sung R22:** bốn link trong bài chọn size/cafe dẫn tới ba category Cây thông, Decal dán kính, Vòng nguyệt quế: tất cả HTTP 200 nhưng 0 product card, `nofollow, noindex`, có empty-state và đường hồi phục. Đã click link “bộ sưu tập cây thông Noel” từ bài chọn size tới category rỗng. Đây là phạm vi nội dung → mua hàng của cùng lỗi merchandising, không phải bốn broken link mới; xem [R22](#round-r22). Giữ **OPEN — P1**.

**Cập nhật R26:** không còn dùng “Combo/Cây thông rỗng” làm mô tả hiện hành. GET xác nhận **3 card Combo, 2 card Cây thông**, cả hai HTTP 200; bấm CTA hero **“Xem 8+ Set Combo”** thực tế tới danh mục có đúng ba card. Đây là cải thiện một phần, nhưng số lượng quảng bá vẫn chưa khớp và ảnh các SKU mới chưa đại diện đúng bộ/cây đang bán. Xem [R26](#round-r26), giữ **OPEN — P1**; không tự nâng con số quảng bá hoặc tạo thêm sản phẩm chỉ để đủ tám. Những kết quả rỗng ở R2/R18/R22 là lịch sử tại thời điểm kiểm tra.

### Recommended solution
Nếu có combo thực, xuất bản SKU, ảnh, thành phần, giá lẻ/giá combo và tồn kho chính xác. Nếu chỉ nhận tư vấn, đổi thông điệp/CTA sang dịch vụ tư vấn đúng thực tế; không tiếp tục quảng bá “8+” hoặc phần trăm giảm chưa có cơ sở. Ưu tiên category có hàng trong điều hướng mua sắm.

### Acceptance criteria
Mọi lời hứa trên hero khớp nội dung đích; người mua xem được combo có thể mua hoặc được dẫn rõ vào luồng tư vấn, không gặp trang 0 sản phẩm sau CTA “xem set”. Với bốn link bài tư vấn bổ sung ở R22, cung cấp lựa chọn đúng nhu cầu thực có hoặc diễn đạt rõ tình trạng/cách tư vấn; không hứa “thoải mái chọn lựa ... đủ size” khi đích chưa có sản phẩm.

### Status
OPEN

## [P1] R2-05 — Nội dung an toàn đưa cam kết tuyệt đối và mẹo chưa có căn cứ

### Location
Bài `/y-tuong-trang-tri/noel/cach-chon-size-cay-thong-noel/` mục 5; bài quán cafe mục 4; bài dự toán phần nguồn điện; hero.

### Problem
Lời khuyên kỹ thuật/an toàn được trình bày như bảo đảm, nhưng không gắn vật liệu, thiết bị, tải và hướng dẫn nhà sản xuất cụ thể.

### Why it matters
Người đọc có thể áp dụng sai với đồ điện hoặc cây lớn ở nơi công cộng; đây là rủi ro an toàn và độ tin cậy nội dung, không chỉ SEO.

### Evidence
Bài chọn size khuyên xịt **keo sữa loãng hoặc hair spray** để giữ tuyết. Bài cafe viết nguồn 12–24V “**an toàn tuyệt đối**”, dây cước/móc dán khiến cây “**không bao giờ bị ngã đổ khi có va quẹt mạnh**”. Bài dự toán quy bộ nguồn theo chiều dài LED mà chưa nêu công suất thực của dây tương ứng. Không thấy nguồn kiểm chứng gắn các khẳng định này.

### Recommended solution
Nhờ người có chuyên môn duyệt nội dung an toàn; bỏ cam kết tuyệt đối và mẹo xử lý hóa chất khi chưa được nhà sản xuất cho phép. Dẫn hướng dẫn thiết bị/vật liệu cụ thể; mô tả giới hạn, tải định mức và trường hợp cần kỹ thuật viên. Không thay bằng công thức kỹ thuật tự suy đoán khác.

### Acceptance criteria
Không còn bảo đảm tuyệt đối hoặc mẹo hóa chất thiếu hướng dẫn nhà sản xuất; thông số và cách lắp được nguồn/owner chuyên môn duyệt, có điều kiện áp dụng rõ. Rà cả bài, FAQ, hero và PDP liên quan.

### Status
OPEN

## [P1] R2-06 — Sitemap bỏ sót nội dung indexable và chứa URL noindex

### Location
`/robots.txt`, `/sitemap_index.xml`, `/page-sitemap.xml`, `/post-sitemap.xml`, `/product-sitemap.xml`, `/product_cat-sitemap.xml`.

### Problem
Sitemap công khai không nhất quán với nội dung indexable hiện tại.

### Why it matters
Giảm chất lượng tín hiệu khám phá/cập nhật nội dung mới và gửi URL không muốn index. Không khẳng định Google chưa index vì chưa có GSC.

### Evidence
Sitemap index chỉ trỏ **page, product, product_cat**, không trỏ `post-sitemap.xml`. Tuy nhiên `post-sitemap.xml` trả 200, có hub và 3 bài cẩm nang indexable. `page-sitemap.xml` chứa `/gio-hang/`, `/thanh-toan/`, `/tai-khoan/` trong khi các trang này noindex; checkout giỏ trống còn redirect. Đọc lại index vẫn cho cùng kết quả; HTTP ghi `cf-cache-status: DYNAMIC`.

**Bổ sung R27:** năm PDP mới đều HTTP 200, `index, follow`, self-canonical và có internal link từ homepage/category, nhưng **0/5** xuất hiện trong `product-sitemap.xml`. Đọc lại sitemap với `Cache-Control: no-cache` vẫn có 90 URL và thiếu cả năm; response ghi `no-cache, no-store`, `cf-cache-status: DYNAMIC`. Sitemap index chỉ có một product sitemap, không có phân mảnh khác chứa chúng. [Response, headers, danh sách sitemap và phép đối chiếu URL](review-evidence/2026-09-24/r27-product-sitemap.json). Không khẳng định Google chưa khám phá vì chưa có GSC.

**Đính chính sau R29:** Category Combo và Cây thông có lần lượt **3** và **2** sản phẩm, nhưng đang `noindex`; việc cả hai vắng `product_cat-sitemap.xml` là hành vi đúng theo [hướng dẫn Rank Math: URL đặt noindex không xuất hiện trong sitemap](https://rankmath.com/kb/url-not-in-sitemap/#the-page-is-set-as-noindex). Vì vậy bằng chứng R29 **không mở rộng lỗi R2-06**. Chỉ kiểm lại sitemap sau khi R29-01 đã chuyển hai term sang indexable; nếu lúc đó URL vẫn thiếu mới thuộc R2-06. [HTTP/meta/internal-link và danh sách sitemap tại R29](review-evidence/2026-09-24/r29-http-seo.json).

### Recommended solution
Rà cấu hình Rank Math và cache sinh sitemap; thêm sitemap bài viết vào index, loại URL noindex/redirect khỏi sitemap page, đồng thời đưa mọi PDP và product category **được chủ đích index**, canonical, đang xuất bản vào sitemap tương ứng với `lastmod` phản ánh cập nhật thực. Không chữa bằng mở index cart/account, bật index hàng loạt category rỗng hoặc thêm URL biến thể không có trang riêng.

### Acceptance criteria
Từ sitemap index khám phá được 3 bài và hub; mọi PDP/product category được chủ đích index và đang xuất bản có mặt trong sitemap tương ứng; mỗi URL sitemap là canonical 200 dự định index, không cart/checkout/account/category rỗng. Kiểm tra cả nội dung sau purge cache; gửi lại sitemap qua GSC khi có quyền.

### Status
OPEN

## [P1] R29-01 — Category thương mại có hàng vẫn bị chặn index

### Location
`/danh-muc/trang-tri-theo-mua/giang-sinh-noel/combo-trang-tri-noel/`; `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/cay-thong-noel/`.

### Problem
Hai category đã chuyển từ trạng thái rỗng sang có hàng nhưng vẫn phát `nofollow, noindex`; HTML không có self-canonical. Việc chúng vắng `product_cat-sitemap.xml` là hệ quả dự kiến của `noindex`, không phải lỗi sitemap riêng.

### Why it matters
Đây là hai landing page thương mại có intent riêng, metadata riêng, listing mua hàng và internal link từ homepage/shop/bài hướng dẫn. `noindex` chủ động ngăn chúng cạnh tranh cho nhu cầu “combo trang trí Noel” và “cây thông Noel”; `nofollow` còn làm yếu đường khám phá sản phẩm qua chính category. Không suy ra Google chưa biết các URL hoặc chưa index PDP vì không có GSC.

### Evidence
GET không cache lúc **15:12 UTC 24/09/2026**: Combo HTTP 200, 3 card; Cây thông HTTP 200, 2 card. Cả hai có H1/title/meta description riêng và schema `CollectionPage` + `BreadcrumbList`, nhưng robots đều **`nofollow, noindex`**, canonical không có. `product_cat-sitemap.xml` chỉ có ba URL và thiếu cả hai; category Noel cha là đối chứng `index, follow`, self-canonical và có trong sitemap. Homepage, shop và bài chọn size đều có internal link tới các đích này. [Dữ liệu HTTP/sitemap/internal link](review-evidence/2026-09-24/r29-http-seo.json) · [DOM desktop/mobile](review-evidence/2026-09-24/r29-browser.json) · [Combo desktop](review-evidence/2026-09-24/r29-combo-category-desktop.webp) · [Cây thông mobile](review-evidence/2026-09-24/r29-tree-category-mobile.webp).

### Recommended solution
Tại từng taxonomy term đã sẵn sàng làm landing page, bỏ `noindex`/`nofollow` và phát `index, follow` cùng self-canonical; purge cache Rank Math/site/CDN sau đổi rồi xác nhận Rank Math tự đưa URL indexable vào `product_cat-sitemap.xml`. Áp dụng theo term hoặc điều kiện chất lượng rõ ràng, không bật index hàng loạt các category vẫn 0 sản phẩm. Giữ title/H1/description riêng đang có; sửa dữ liệu/ảnh/offer còn sai trong các issue sản phẩm trước khi mở rộng quảng bá.

### Acceptance criteria
Hai URL trả 200, `index, follow`, self-canonical đúng URL và xuất hiện trong product-category sitemap sau purge cache. Internal link từ homepage/shop/bài viết không bị gắn `nofollow`; schema còn parse được, listing đúng 3/2 sản phẩm hoặc count tồn kho mới. Category 0 sản phẩm tiếp tục noindex cho đến khi có giá trị riêng; không coi việc gửi sitemap là bảo đảm Google index.

### Status
OPEN

## [P2] R2-07 — CTA khảo sát dẫn đến anchor không tồn tại

### Location
Shop/product-category banner: **“Khảo Sát Mặt Bằng 24h”**.

### Problem
Nút dẫn về `https://trangtri4mua.com/#b2b-consultation` nhưng homepage không có phần tử mang ID này.

### Why it matters
Khách dự án rời trang đang xem nhưng không tới form/điểm tư vấn đã hứa, làm mất lead.

### Evidence
Href từ HTML shop; homepage HTTP và DOM đều không có `id="b2b-consultation"`. Không tìm thấy form B2B tại đích này, chỉ có CTA tel/Zalo.

**Bổ sung R18:** click từ cả shop và category Noel đều tới homepage `#b2b-consultation`, HTTP 200, `scrollY=0`, không có target theo ID hoặc named anchor. Khối B2B thật nằm khoảng 3.486 CSS px dưới đầu trang trong mẫu; không được đưa tới khối này. Xem [R18](#round-r18), giữ **OPEN — P2**. Đây là bằng chứng hành vi điều hướng, chưa phải phép đo số lead/doanh thu mất đi.

### Recommended solution
Trỏ tới form tư vấn thật tại trang liên hệ hoặc khôi phục đúng section được quản lý; nhãn nút phải mô tả hành động thực. Không thêm một anchor trống chỉ để hết lỗi.

### Acceptance criteria
Click từ shop và category đưa người dùng tới phần tư vấn nhìn thấy được; bàn phím/focus hợp lý; form/CTA sử dụng được mà không phải tự tìm lại.

### Status
OPEN

## [P2] R2-08 — Không có lối tìm kiếm sản phẩm trên mobile/tablet

### Location
Shared header và mobile drawer, 375px/768px.

### Problem
Tìm kiếm có ở desktop nhưng không có nút hoặc trường dùng được trong navigation mobile đã kiểm tra.

### Why it matters
Với 89 sản phẩm, khách đã biết tên phải lần theo category/phân trang thay vì tìm trực tiếp.

### Evidence
Header mobile có logo/cart/Menu; drawer có danh mục, trang thông tin và hotline/Zalo, không search. `[data-id=search]` và input search có box 0×0 tại 375 và 768. Desktop mở modal và gửi “tháp nhũ” thành công.

### Recommended solution
Đưa search trigger vào header mobile hoặc trường tìm kiếm rõ ràng ở đầu drawer, tái sử dụng search hiện có; giữ accessible name, focus và đóng bằng Escape.

### Acceptance criteria
Từ homepage/PDP/category tại 375 và 768, người dùng mở và gửi truy vấn bằng touch/bàn phím mà không cần sửa URL; test cả có và không có kết quả.

### Status
OPEN

## [P2] R2-09 — Icon đóng menu gần như trắng trên nền trắng

### Location
`#offcanvas .ct-toggle-close`, mobile drawer.

### Problem
Nút có vùng bấm nhưng dấu X khó nhận biết.

### Why it matters
Người dùng cảm ứng khó tìm cách thoát menu; accessible label không thay thế khả năng nhìn thấy điều khiển.

### Evidence
Ảnh `mobile-menu.webp`. Button 44×44, nền `rgb(249,250,251)`; SVG/path fill `rgba(255,255,255,0.7)` dù color của button là `rgb(31,41,55)`. Tab trap và Escape hoạt động, vì vậy không báo lỗi kẹt bàn phím.

### Recommended solution
Sửa rule fill của icon đóng theo màu tương phản (`currentColor` nếu phù hợp); tách style modal tối và drawer sáng để không regression search.

### Acceptance criteria
Dấu X nhìn rõ trên drawer, đạt tương phản điều khiển tối thiểu 3:1 với nền; vùng bấm ít nhất 44×44 theo chuẩn dự án; click/Escape đóng và trả focus đúng.

### Status
OPEN

## [P2] R2-10 — Lời hứa giao hàng, hoàn tiền và giờ hỗ trợ không thống nhất

### Location
Homepage FAQ, editorial hub, bài cafe, policy shipping/returns, topbar/footer/drawer.

### Problem
Cùng dịch vụ nhưng các template công bố điều kiện khác nhau.

### Why it matters
Khách mua đồ theo sự kiện cần ngày nhận chính xác; cam kết khác nhau tạo khiếu nại và giảm trust.

### Evidence
Hub hứa hỏa tốc **TP.HCM & Hà Nội 2–4h**; chính sách chỉ nêu nội thành TP.HCM. FAQ homepage/hub ghi tỉnh khác **1–3 ngày**, chính sách **2–4 ngày**, vùng xa **3–5 ngày**. Homepage hứa **hoàn tiền ngay trong ngày**, đổi trả ghi **1–2 ngày** khi hết mẫu. Hotline footer **08:00–21:00**, topbar/drawer **08:00–21:30**, empty category **8:00–22:00**, Zalo còn **24/7**.

**Bổ sung R30:** ngay màn hình đầu `/lien-he/`, câu mở đầu ghi đội ngũ **“luôn sẵn sàng phục vụ 24/7”**, cùng card lại ghi giờ showroom **08:00–21:00** và phản hồi Zalo **15 phút**; topbar cùng lượt duyệt vẫn ghi **08:00–21:30**. Đây là mâu thuẫn nhìn thấy trong một bề mặt thật, không chỉ đối chiếu HTML giữa các trang. [Ảnh desktop](review-evidence/2026-09-24/r30-contact-desktop.webp) · [ma trận nội dung](review-evidence/2026-09-24/r30-trust-matrix.json). Giữ **OPEN — P2**.

### Recommended solution
Owner vận hành chốt dữ liệu chuẩn theo kênh/khu vực; phân biệt “nhận tin 24/7” với giờ nhân viên phản hồi. Dùng cùng nguồn nội dung cho các template, ghi rõ ngoại lệ và mốc tính thời gian.

### Acceptance criteria
Cùng khu vực/dịch vụ/điều kiện có cùng lời hứa; thời gian phản hồi khác giờ showroom được giải thích; FAQ, policy, listing, PDP và footer không mâu thuẫn.

### Status
OPEN

## [P2] R2-11 — Ảnh không minh họa đúng sản phẩm, offer và nội dung

### Location
Homepage hero, category cards, 3 card editorial; nội dung bài cafe/chọn size; năm PDP mới liệt kê ở R26.

### Problem
Ảnh phụ kiện lẻ được dùng như ảnh combo hoàn chỉnh hoặc nội dung hướng dẫn không gian.

### Why it matters
Người mua không thấy được thứ đang bán; người tìm ý tưởng trang trí cần bố cục thực tế hơn là chỉ ảnh đồ rời. ALT khác hình làm giảm chất lượng mô tả.

### Evidence
Hero dùng `keo-nhung-do.webp`: ảnh phụ kiện kẹo tròn có nhãn **52cm:395k** và **35cm:255k**, nhưng ALT “Combo trang trí cây thông Noel trọn gói” và headline combo. Card Cây thông dùng cành PE; Combo dùng hàng rào. Bài cafe có ảnh sản phẩm gợi ý, chưa có ảnh toàn cảnh quán; About/Showroom không có ảnh trong nội dung chính. Không báo ảnh bị hỏng: các asset nai đã request trả 200.

**Đính chính evidence R22:** câu cũ “395k/35cm” ghép nhầm hai nhãn trong ảnh, không phải thông số đã xác minh. Đã sửa câu trên sau khi xem [ảnh nguồn đầy đủ](review-evidence/2026-09-24/r22-home-hero-original.webp); [metadata HTTP/hash](review-evidence/2026-09-24/r22-hero-source-metadata.json). Không suy giá bán hiện hành từ chữ trên ảnh. Hero/ALT vẫn mô tả đồ lẻ thành combo như [screenshot R22](review-evidence/2026-09-24/r22-home-desktop.webp), nên **R2-11 vẫn OPEN — P2**.

**Bổ sung R26:** năm SKU mới tiếp tục dùng ảnh đồ lẻ cho bộ/cây hoàn chỉnh: `COMBO-GD-50` dùng hộp quả trầu có nhãn 95k, `SET-HG-70` dùng quả châu cườm có nhãn 95k, `COMBO-B2B-CAFE` dùng gói hàng rào, `CT-PE-SNOW` dùng một cành PE có nhãn 45k, `CT-CUOC-PINE` dùng dây quả 1,8m có nhãn 255k. Đã đọc ảnh hiển thị trên năm PDP; [đối chiếu SKU/URL/ảnh](review-evidence/2026-09-24/r26-catalog-browser.json) và bảng R26. Không suy giá bán đúng từ chữ trên ảnh cũ; vấn đề là ảnh không chứng minh bộ/cây đang chào bán. Mở rộng cùng issue, không cộng năm issue trùng.

### Recommended solution
Dùng ảnh đúng set thực bán, kèm thành phần; bài chọn size thêm hình đo trần/tán, bài cafe thêm ảnh hoặc sơ đồ bố trí có chú thích và quyền sử dụng. Nếu minh họa phối cảnh, ghi rõ không phải ảnh dự án đã thi công. ALT mô tả đúng ảnh, không nhồi từ khóa.

Với năm SKU mới, cung cấp ảnh đúng toàn bộ bộ hàng/cây, ảnh thành phần và chú thích rõ hàng bao gồm/không bao gồm. Không chỉ đổi ALT hoặc che nhãn giá để tiếp tục dùng ảnh sai loại hàng.

### Acceptance criteria
Hero minh họa đúng offer; category/thumbnail không gây nhầm đồ lẻ với bộ trọn gói. Người đọc có thể áp dụng ít nhất một hướng dẫn đo/bố trí bằng minh họa đúng nội dung.

Năm PDP mới và card liên quan phải dùng ảnh khớp SKU/biến thể, nhìn được bộ/cây thực bán và không có nhãn giá của một mặt hàng khác gây hiểu nhầm.

### Status
OPEN

## [P2] R2-12 — Tác giả hiển thị như mã tài khoản, không khớp byline biên tập

### Location
3 bài Noel, `/author/ed4f7b/`, schema BlogPosting và editorial hub.

### Problem
Hub/box cuối bài ghi Ban Biên Tập, nhưng metadata đầu bài và Person schema ghi `ed4f7b`; author archive chỉ có ngày tham gia và 3 bài.

### Why it matters
Người đọc khó biết ai chịu trách nhiệm cho các hướng dẫn kỹ thuật và nguồn kinh nghiệm; dữ liệu tác giả không nhất quán giữa template.

### Evidence
Browser mobile bài chọn size hiển thị **ED4F7B**. BlogPosting author.name và Person.name là `ed4f7b`; archive không có hồ sơ chuyên môn hữu ích trong phần đã đọc.

**Bổ sung R30:** browser desktop vẫn thấy byline bài chọn size là `ed4f7b`; `BlogPosting.author` và `Person.name` cùng giá trị này. `/author/ed4f7b/` là `ProfilePage`, `noindex`, chỉ hiển thị avatar mặc định, mã tài khoản, ngày tham gia và ba bài; hub/box cuối bài vẫn dùng **Ban Biên Tập**. Quan hệ `BlogPosting → Person → Organization` có `@id` liên kết được, nhưng không giải quyết mâu thuẫn danh tính. [Schema/DOM](review-evidence/2026-09-24/r30-editorial-schema.json) · [hồ sơ tác giả](review-evidence/2026-09-24/r30-author-desktop.webp). Giữ **OPEN — P2**.

### Recommended solution
Dùng tên người/ban biên tập có thật, cùng một byline giữa UI/schema; bổ sung vai trò, kinh nghiệm có kiểm chứng, quy trình biên tập và liên kết bài/dự án của tác giả. Không tạo bằng cấp/tiểu sử giả.

### Acceptance criteria
Byline đầu/cuối bài, hub, author page và schema nhất quán; người đọc truy cập được hồ sơ chịu trách nhiệm. Không bắt buộc index author archive nếu chưa có giá trị riêng.

### Status
OPEN

## [P2] R2-13 — Hai bảng dự toán cộng sai tổng

### Location
`/y-tuong-trang-tri/noel/du-toan-chi-phi-trang-tri-noel/`, mục 6.2 và 6.3.

### Problem
Tổng gói không bằng tổng các dòng thành tiền đã công bố.

### Why it matters
Đây là bài phục vụ intent dự toán; phép tính sai phá vỡ giá trị cốt lõi và có thể làm khách chuẩn bị sai ngân sách.

### Evidence
Gói cafe: cộng 14 dòng = **6.220.000đ**, bảng ghi **6.365.000đ**, lệch 145.000đ. Gói showroom: cộng 13 dòng = **19.240.000đ**, bảng ghi **20.260.000đ**, lệch 1.020.000đ. Gói căn hộ cộng đúng **2.340.000đ**.

### Recommended solution
Đối soát số lượng × đơn giá → thành tiền → tổng; nếu chênh do thi công/VAT/dự phòng phải công khai dòng tương ứng. Ghi ngày giá tham khảo và phạm vi bao gồm/không bao gồm.

### Acceptance criteria
Tất cả phép nhân/cộng trong 3 gói đúng; tổng khớp các dòng, không khoản chênh ẩn; báo giá tham khảo không bị trình bày như giá chốt mọi trường hợp.

### Status
OPEN

## [P2] R2-14 — Kết quả tìm sản phẩm dùng card bài viết, thiếu giá và đường mua rõ

### Location
Search template `/?s=...` và live search trong `#search-modal`, gồm năm SKU mới quan sát từ R26.

### Problem
Search trộn product, post và page cùng một kiểu card.

### Why it matters
Khách tìm tên hàng không thấy giá/biến thể để quyết định, còn homepage/chính sách xuất hiện như kết quả ngang hàng.

### Evidence
Search “tháp nhũ” có Tháp nhũ điện nhưng card hiển thị category, excerpt và ngày **Tháng 9 23, 2026**, không giá/CTA mua; cùng tập kết quả có 3 bài, Trang Chủ và Chính Sách Bảo Mật. Ảnh `search-desktop.webp`.

**Bổ sung R28:**
- Ba truy vấn chính xác **`COMBO-GD-50`**, **`SET-HG-70`**, **`CT-PE-SNOW`** đều trả `200 / []` ở live API và **0 article** ở trang kết quả, dù SKU hiển thị trên PDP và sản phẩm đang indexable/internal-linked.
- Tìm theo tên **“cây thông phủ tuyết”** và **“combo 50 món”** đưa sản phẩm tương ứng lên đầu live search/trang kết quả. Từ input, Tab hai lần rồi Enter mở đúng PDP `CT-PE-SNOW`; vì vậy không báo toàn bộ tìm kiếm sản phẩm hỏng.
- Trên full search, product mới vẫn dùng card bài viết: category, title, ảnh, excerpt, ngày; **không có giá hoặc hành động xem/chọn mẫu**. Kết quả giống nhau ở desktop và mobile mẫu.
- Query **“cách chọn size cây thông”** xếp ba bài hướng dẫn trước; **“trang trí quán cafe”** xếp bài cafe đầu và combo B2B thứ hai. Giữ khả năng phục vụ intent kiến thức/hỗn hợp, không ép mọi search chỉ trả product.

[7 query API/full page](review-evidence/2026-09-24/r28-search-http.json) · [5 luồng modal → full search](review-evidence/2026-09-24/r28-search-browser.json) · [mở PDP bằng Tab/Enter](review-evidence/2026-09-24/r28-open-live-result.json) · [ảnh full search tên cây](review-evidence/2026-09-24/r28-name-tree-page.webp).

### Recommended solution
Ưu tiên product cho intent mua, hiển thị card thương mại dùng chung giá và hành động xem/chọn mẫu; có thể phân nhóm “Sản phẩm”/“Cẩm nang”. Bổ sung tìm chính xác theo SKU đang công bố, ưu tiên match exact nhưng vẫn giữ tìm theo title/content và bài viết. Không ép mọi truy vấn chỉ trả sản phẩm hoặc làm index search page.

### Acceptance criteria
Truy vấn exact SKU và tên hàng đưa sản phẩm phù hợp lên rõ ràng; full search có giá cùng hành động xem/chọn mẫu phù hợp product type. Truy vấn kiến thức vẫn ưu tiên bài hữu ích; intent hỗn hợp giữ được cả bài và product liên quan. Trạng thái rỗng, noindex, tìm theo title, Tab/Enter live result và layout mobile tiếp tục hoạt động.

### Status
OPEN

## [P2] R2-15 — Sidebar chính sách chiếm màn hình đầu mobile trước nội dung cần đọc

### Location
4 trang chính sách, breakpoint 768/375.

### Problem
Khi chuyển một cột, toàn bộ navigation và hộp hỗ trợ đứng trước nội dung chính.

### Why it matters
Khách cần tìm điều kiện đổi trả/phí ship phải cuộn qua thông tin lặp lại; sửa grid không đồng nghĩa tối ưu thứ tự nội dung mobile.

### Evidence
375px: sidebar bắt đầu y≈194, nội dung chính y≈859. 768px: nội dung chính y≈835. Desktop hai cột đã hoạt động tốt.

### Recommended solution
Giữ sidebar desktop; mobile dùng mục lục thu gọn hoặc đưa support card sau nội dung, có jump link tới phần chính. Giữ thứ tự DOM/focus phù hợp, tránh chỉ đổi CSS gây thứ tự đọc khó hiểu.

### Acceptance criteria
Tại 375×812, người vào trang tiếp cận được đoạn chính/điều kiện đầu mà không qua toàn bộ hộp hỗ trợ; bảng vẫn cuộn được, không mất link chính sách.

### Status
OPEN

## [P2] R2-16 — Metadata/schema homepage và static page gán sai vai trò nội dung

### Location
Homepage; `/gioi-thieu/`, `/showroom/`, `/lien-he/` và bốn trang chính sách, phần `<head>`/JSON-LD.

### Problem
Title homepage quá chung, thiếu ảnh chia sẻ explicit; homepage và static page đều gán `Article`/Person tác giả rỗng dù vai trò thật là trang thương mại, giới thiệu, liên hệ hoặc chính sách.

### Why it matters
Giảm khả năng hiểu nội dung trang qua kết quả tìm kiếm/chia sẻ; schema không nên mô tả một bài có tác giả vô danh khi trang có vai trò khác. Đây là lỗi phân loại template, không phải yêu cầu nhồi mọi trường schema tùy chọn.

### Evidence
Baseline: title **“Trang Chủ - Trang trí 4 mùa”**; meta description là đoạn mô tả danh mục chung; không có `og:image` trong HTML đã đọc. Graph homepage có `Article`, Person URL `/author/` không có name. H1 homepage vẫn đúng một thẻ, không cần sửa chỉ để checklist.

**Bổ sung R30:** browser parse homepage và **7 static page**: cả tám đều có `Article` và một `Person` không có `name`. Node Organization dùng chung có name/logo; `WebSite.publisher` và Article.publisher trỏ đúng `@id` Organization, nên giữ quan hệ tốt này nhưng chọn type đúng. Riêng hub bài viết dùng `CollectionPage`, bài thật dùng `BlogPosting`; đây là mẫu đúng để không xóa schema biên tập hợp lệ. [Ma trận tám trang](review-evidence/2026-09-24/r30-pages-browser.json) · [tóm tắt field](review-evidence/2026-09-24/r30-trust-matrix.json).

### Recommended solution
Viết title/description homepage mô tả offer thực và thương hiệu; đặt ảnh OG đúng nội dung. Cấu hình homepage thành WebPage/WebSite/Organization; static page dùng `AboutPage`, `ContactPage` hoặc `WebPage` phù hợp và bỏ `Article`/Person rỗng. Giữ Product/BlogPosting/CollectionPage đúng ở template tương ứng; chỉ thêm Organization fields đã được owner xác nhận.

### Acceptance criteria
Metadata homepage có nội dung đặc thù, khớp offer và có OG image tải được. Homepage, About, Showroom, Contact và policy không còn `Article` hoặc Person tác giả rỗng; Organization/WebSite vẫn liên kết nhất quán. Bài thật còn BlogPosting + tác giả đúng, hub còn CollectionPage, JSON-LD parse được. Không hứa rich result chỉ nhờ thêm schema.

### Status
OPEN

## [P2] R2-17 — Các archive bài viết cùng intent nhưng chưa có giá trị riêng

### Location
`/category/y-tuong-trang-tri/`, `/category/y-tuong-trang-tri/noel/`, `/category/y-tuong-trang-tri/huong-dan/`, so với hub `/y-tuong-trang-tri/`.

### Problem
3 category indexable cùng liệt kê 3 bài, chỉ khác heading; chưa có mô tả chuyên đề hoặc metadata riêng.

### Why it matters
Kiến trúc thông tin chưa phân biệt rõ mùa vụ và kiểu hướng dẫn; nhiều landing mỏng cạnh tranh cùng tập nhu cầu. Không khẳng định có “án phạt duplicate”.

### Evidence
Cả 3 trả 200, index/follow, self-canonical; cùng 3 URL bài và không có meta description trong mẫu đọc. Hub riêng lại là điểm điều hướng giàu nội dung hơn.

### Recommended solution
Chốt taxonomy có vai trò rõ. Category giữ index cần intro/curation và tập bài theo intent riêng; category chưa đủ giá trị có thể noindex tạm thời. Chỉ redirect/hợp nhất khi hai trang thật sự cùng mục đích; không canonical mọi archive về homepage hoặc page 1.

### Acceptance criteria
Mỗi archive indexable có mục đích và nội dung hữu ích riêng; breadcrumb/menu liên kết nhất quán; không tạo thêm archive rỗng để đủ chủ đề.

### Status
OPEN

## [P2] R2-18 — Tên miền www không phân giải nên không thể redirect về canonical

### Location
`https://www.trangtri4mua.com/`.

### Problem
Biến thể www chưa hoạt động.

### Why it matters
Khách/đối tác gõ hoặc đặt link có www không vào được website, thay vì được chuyển về tên miền chính.

### Evidence
Request báo lỗi DNS; Google DNS trả **Status 3 / NXDOMAIN**, có authority Cloudflare. Lưu `www-dns.json`. Apex HTTP→HTTPS 301 vẫn tốt.

### Recommended solution
Cấu hình DNS www, chứng chỉ TLS và redirect 301/308 về apex HTTPS, giữ nguyên path/query; không tạo hai bản nội dung độc lập.

### Acceptance criteria
HTTP/HTTPS www đều vào được cùng URL canonical trên apex, không lỗi chứng chỉ, không vòng lặp; kiểm tra homepage và một PDP.

### Status
OPEN

## [P2] R2-19 — 404 đúng status nhưng không có đường quay lại mua sắm

### Location
`/reviewer-404-probe-240926/` và probe không tồn tại.

### Problem
Trang lỗi là trang trắng Nginx mặc định, không có navigation/search.

### Why it matters
Khách từ link cũ hoặc gõ sai mất ngữ cảnh và không có lối phục hồi.

### Evidence
HTTP **404**; body **“404 Not Found nginx”**, không header/footer/cửa hàng/tìm kiếm. Không phải soft-404.

### Recommended solution
Thiết kế trang 404 cùng hệ thống website, có liên kết homepage/shop/search và giải thích ngắn; giữ status 404. Không redirect mọi URL sai về homepage.

### Acceptance criteria
URL ngẫu nhiên trả 404 thật và có cách tiếp tục tìm/mua; URL tồn tại, asset lỗi và các redirect đã sửa không bị ảnh hưởng.

### Status
OPEN

## [P2] R2-20 — Landmark lồng nhau và bản đồ thiếu accessible name

### Location
Policy template; `/showroom/`, `/lien-he/`.

### Problem
Chính sách lồng `<main class="tt4m-main-col">` trong `<main id="main">`; iframe bản đồ không có title/aria-label. Một số card dưới H2 dùng H4 chỉ để lấy cỡ chữ.

### Why it matters
Khó định hướng bằng landmark/heading và nhận diện nội dung khung với công nghệ hỗ trợ. Chưa dùng screen reader nên không khẳng định hành vi đọc cụ thể.

### Evidence
HTML bảo mật/đổi trả có main lồng main; cả hai iframe Google Maps không có thuộc tính đặt tên. Reviewer độc lập và đọc HTML trực tiếp cùng ghi nhận.

**Bổ sung R23:** policy Bảo mật vẫn có hai phần tử `main` ở cả desktop/mobile. Skip link đưa focus vào `main#main` cấp ngoài và lượt Tab sau đi vào sidebar; skip link hoạt động không sửa được landmark lồng nhau. Giữ **OPEN**, xem [R23](#round-r23).

### Recommended solution
Giữ main cấp trang duy nhất, đổi wrapper nội dung sang div/section nhưng giữ class layout. Đặt title bản đồ cụ thể; sửa cấp heading theo quan hệ section, giữ kiểu chữ bằng CSS.

### Acceptance criteria
Mỗi page có một main đang hiển thị, không main lồng nhau; iframe có tên mô tả; kiểm tra Tab vào/ra map và heading tree. Không regression layout/bảng/sidebars.

### Status
OPEN

## [P3] R2-21 — Form và luồng thanh toán còn nhãn mẫu tiếng Anh

### Location
`/lien-he/`, `/gio-hang/`, `/thanh-toan/`.

### Problem
Một số nhãn quan trọng chưa được Việt hóa, không nhất quán với phần còn lại của website.

### Why it matters
Giảm độ rõ ràng đúng thời điểm khách gửi yêu cầu/chọn giao hàng.

### Evidence
Form liên hệ có legend **Contact Form Demo**, nút và aria-label **Submit Form**; rules chứa **This field is required / This field must contain a valid email**. Cart/checkout hiển thị **Shipment / Flat rate / Free shipping**; ảnh `checkout-desktop.webp`. Chưa kích hoạt lỗi plugin bằng submit nên không khẳng định chuỗi rule chắc chắn là thông báo cuối cùng.

**Bổ sung R16:** đã kích hoạt form rỗng trong browser với chặn mạng bảo vệ trước thao tác: hai thông báo **“This field is required”** thực sự hiển thị dưới Email/Nội dung. Không có request gửi form phát sinh. Email `review-invalid` bị validation native của Chrome chặn; chuỗi tiếng Anh trong bong bóng native phụ thuộc môi trường browser, không quy thành lỗi Việt hóa của plugin. Xem [R16](#round-r16); giữ **OPEN**, không tạo issue Việt hóa trùng.

### Recommended solution
Đổi tên/nút thành hành động tiếng Việt, cấu hình thông báo lỗi và tên shipping method phù hợp thực tế. Làm rõ hình thức/phí, không chỉ dịch literal “Flat rate”.

### Acceptance criteria
Nhãn, accessible name và lỗi hiển thị đều tiếng Việt; shipping method phân biệt rõ giao tiêu chuẩn/miễn phí/nhận tại cửa hàng. Kiểm tra form lỗi trên staging mà không tạo lead thật.

### Status
OPEN

## [P1] R2-22 — Chưa xác định rõ chủ thể nhận tiền và căn cứ tuyên bố uy tín

### Location
Chính sách thanh toán; homepage reviews; About, Showroom, Contact, privacy; Organization schema; các bài cẩm nang có lời hứa chuyên môn/dự án.

### Problem
Website có NAP/chính sách và hướng dẫn chuyển tiền thật, nhưng chưa giúp người mua xác định chủ thể pháp lý chịu trách nhiệm, trong khi công bố quy mô khách hàng, công trình, showroom, hợp đồng và hóa đơn VAT.

### Why it matters
Người mua chuyển khoản và khách B2B cần đối chiếu bên nhận tiền, bên ký hợp đồng/xuất hóa đơn và đơn vị xử lý dữ liệu. Khoảng trống này tác động trực tiếp trust, thanh toán và khả năng xử lý tranh chấp; nội dung chuyên sâu cũng cần dấu hiệu kinh nghiệm thực tế chứ không chỉ lời tự giới thiệu.

### Evidence
Baseline: homepage ghi **hơn 1.200 khách hàng**, 3 testimonial 5 sao có dấu tick; bài dự toán nêu kinh nghiệm **hàng trăm công trình**. Không thấy liên kết nguồn/ngày/case study đi kèm trong mẫu. About/Contact công bố thương hiệu và NAP nhưng chưa thấy tên pháp nhân/MST hoặc thông tin chủ thể vận hành tương đương; Showroom không có ảnh không gian thực trong nội dung chính. **Chưa có bằng chứng các tuyên bố là giả.**

**Bổ sung R30:** thương hiệu, địa chỉ, hotline và email hiển thị nhất quán trên tám trang; đây là mặt tích cực nhưng vẫn là dữ liệu tự khai. Chính sách thanh toán gọi tài khoản MB **0901234567**, chủ tài khoản **“TRANG TRI 4 MUA”** là “tài khoản chính thức”, đồng thời hứa chuyển khoản theo hợp đồng và hóa đơn điện tử GTGT hợp lệ. Nội dung không nêu tên đăng ký/MST **của bên bán**; các trường “Tên công ty, Mã số thuế” là dữ liệu yêu cầu khách cung cấp để xuất hóa đơn. Organization schema chỉ có name/logo trong mẫu, không thay thế định danh pháp lý. [Vùng hướng dẫn chuyển khoản](review-evidence/2026-09-24/r30-payment-beneficiary.webp) · [ma trận NAP/chủ thể/claim/schema](review-evidence/2026-09-24/r30-trust-matrix.json). Reviewer không chuyển tiền, gọi điện hay xác minh ngân hàng/showroom; không kết luận tài khoản hoặc tuyên bố là giả.

### Recommended solution
Owner xác nhận và công bố chủ thể bán hàng đúng hình thức thực: tên đăng ký, địa chỉ, thông tin đăng ký/MST nếu áp dụng, đầu mối chịu trách nhiệm; bảo đảm tên người nhận tiền, hợp đồng, hóa đơn và privacy notice quy về cùng chủ thể hoặc giải thích quan hệ được phép. Đồng bộ dữ liệu đã xác nhận vào Contact/About/footer/policy và Organization schema. Với claim uy tín: testimonial có sự đồng ý, thời gian/ngữ cảnh và cách xác minh không lộ dữ liệu cá nhân; case study thật có diện tích, yêu cầu, vật tư, khoảng ngân sách, ảnh trước/sau và bài học. Không tạo pháp nhân, review, chứng chỉ hay dự án giả.

### Acceptance criteria
Trước khi yêu cầu chuyển khoản, người mua nhận diện được bên bán/bên thụ hưởng và đối chiếu với hợp đồng/hóa đơn/privacy; thông tin nhất quán trên Contact, About, footer, payment policy và schema. Mọi con số/huy hiệu “thực tế/đã mua” được owner cung cấp căn cứ hoặc chỉnh thành thông tin không gây hiểu nhầm; có minh chứng chuyên môn thực. Không yêu cầu công khai dữ liệu cá nhân không cần thiết và không coi schema tự khai là xác minh pháp lý.

### Status
OPEN

## [P2] R2-23 — Banner dự án dùng chung lấn át listing và sai ngữ cảnh mùa vụ

### Location
Shop, product-category và product-tag template trên mobile.

### Problem
Banner B2B dài, trust strip và nhóm category đứng trước sản phẩm ở mọi loại archive, kể cả khi intent chỉ là mua một món hoặc xem Tết.

### Why it matters
Tăng số thao tác để tiếp cận hàng; thông điệp Noel trên category Tết làm kiến trúc mùa vụ khó hiểu.

### Evidence
375px: sản phẩm đầu `/cua-hang/` bắt đầu y≈**1313px**; tag cây thông y≈**1126px**, dù chỉ có một sản phẩm. Category Tết hiển thị headline **“Mùa Decor Giáng Sinh 2026”**. Số đo là vị trí DOM khi không cuộn, không phải điểm conversion đo bằng analytics.

### Recommended solution
Giữ CTA B2B nhưng rút gọn/chuyển xuống sau nhóm sản phẩm hoặc hiển thị theo ngữ cảnh. Header category nên tập trung title, mô tả ngắn, lọc/sort và listing; nội dung theo mùa phải đúng taxonomy.

### Acceptance criteria
Mobile tiếp cận được listing sớm hơn rõ rệt, không phải qua banner dự án dài; category Tết không quảng bá nhầm mùa. Không mất đường nhận báo giá cho khách B2B.

### Status
OPEN

## Thứ tự xử lý và vòng kiểm tra tiếp theo

1. **Dữ liệu giao dịch:** R2-01 → R2-02 → R2-03. Owner dữ liệu xác nhận SKU/giá/đơn vị; Coder sửa nguồn dữ liệu và mọi điểm tiêu thụ. Không chỉ thay text trên template.
2. **Lời hứa và đường chuyển đổi:** R2-04, R2-07, R2-10; song song biên tập kiểm chứng nội dung an toàn R2-05.
3. **SEO nền tảng:** R2-06, R2-16–19; không làm mất noindex có chủ đích hoặc self-canonical phân trang đang tốt.
4. **UX/accessibility/content:** các mục còn lại; sửa shared CSS/template phải recheck homepage, listing, PDP, post, policy và mobile drawer.

### Quy ước phản hồi Coder

Trong `ASSISTANT_REPLY.md`, ghi **issue ID**, thay đổi cụ thể, URL chịu ảnh hưởng, thời điểm deploy/version, dữ liệu trước/sau và kịch bản đã thử. Có thể báo `IN_PROGRESS`, đề xuất `REJECTED`/`WONT_FIX` kèm lý do và owner chấp nhận; không ghi tất cả đã FIXED chỉ vì source đã đổi.

Reviewer đọc phần mới, xác minh live và regression rồi mới đổi `Status`. Với R2-01/R2-02 phải kiểm tra đủ cả nhóm biến thể; với cấu hình SEO phải kiểm tra HTTP/meta/sitemap sau cache; với shared CSS phải đo các breakpoint và tương tác. Với source-only/security cần source hoặc staging, không dùng HTML để chứng minh server an toàn.

Giữ nguyên lịch sử mỗi lần recheck dưới issue, thêm ngày/bằng chứng/kết luận. Không tạo issue mới cho cùng lỗi chỉ để đổi ID. R2 là báo cáo đã thực hiện trong phiên này; **không có tiến trình theo dõi nền thường trực được cài đặt**.

### Mốc bàn giao R2

- **23 issue mới: 6 P1, 16 P2, 1 P3; tất cả OPEN.** Không có P0 đã được xác minh.
- Đã kiểm tra đủ 7 trường feedback bắt buộc trên từng issue; không có mục thiếu Evidence hoặc Acceptance criteria.
- `http-audit.json` ghi nhận 61 URL; `price-and-variant-proof.json` bổ sung giá, selector, variation ID và mô tả của 4 PDP trọng tâm.
- Lần kiểm tra cuối phiên: SHA-256 `ASSISTANT_REPLY.md` vẫn đúng bản nêu đầu R2, chưa có nội dung mới để mở vòng recheck tiếp. Giỏ thử nghiệm đã xác nhận trống; đóng các tab audit.
- Các issue source-only, thanh toán thực và CWV vẫn giữ giới hạn xác minh đã ghi; không được diễn giải mốc bàn giao tài liệu thành nghiệm thu website.

---

<a id="round-r3"></a>

# Vòng R3 — Tái kiểm tra P1, chưa có phản hồi sửa R2

## Đầu vào và phạm vi

- Thực hiện tiếp theo yêu cầu review; bằng chứng HTTP được thu thập từ **2026-09-24T11:31:39Z**. Thời điểm chốt dữ liệu nằm trong [`r3-p1-recheck.json`](review-evidence/2026-09-24/r3-p1-recheck.json).
- Đã đọc lại `ASSISTANT_REPLY.md`: vẫn là báo cáo 14 mục cũ, **chưa có giải trình cho R2-01…R2-23**. SHA-256 đầu/cuối lượt kiểm tra vẫn `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`.
- Không lặp baseline hoặc tạo issue trùng. Tái kiểm tra 13 URL tập trung vào 6 P1, cộng thử bổ sung bằng chứng tương tác cho mục cũ số 8 và 11.
- Không có thông tin deploy/source revision mới. Kết quả dưới đây là quan sát live mới, không suy đoán Coder đã hay chưa chỉnh source.

## Kết quả tái kiểm tra

| Issue giữ nguyên ID | Bằng chứng live R3 | Status |
|---|---|---|
| R2-01 — Giá Kẹo gậy | Variation 271/272/273 vẫn có `display_price` 1.150 / 1.450 / 1.650 VND; mô tả vẫn ghi 1.150.000 / 1.450.000 / 1.650.000đ. | **OPEN** |
| R2-02 — Nhãn size dùng chung | Quả châu nhũ vàng vẫn có nhãn `1m8` cho slug `8`, bên cạnh `phi8`; Ông già Noel vẫn có hai nhãn `1m8` cho hai slug khác nhau. | **OPEN** |
| R2-03 — Thông số mẫu sai vật liệu | Quả châu cườm vẫn mô tả “nhựa đính cườm”, nhưng bảng thông số ghi “Khung hợp kim chống gỉ”. | **OPEN** |
| R2-04 — Combo rỗng | Homepage còn “Xem 8+ Set Combo”; category đích trả 200, có 0 product card và thông báo “Đang Cập Nhật Mẫu Mã”. | **OPEN** |
| R2-05 — Nội dung an toàn | Bài chọn size vẫn có mẹo `hair spray`; bài cafe còn “an toàn tuyệt đối” và “không bao giờ bị ngã đổ”. | **OPEN** |
| R2-06 — Sitemap | Index vẫn chỉ chứa page/product/product_cat; post sitemap riêng vẫn tồn tại với hub và 3 bài. Page sitemap vẫn chứa cart/checkout/account; cart/account tiếp tục noindex. | **OPEN** |

Không đổi priority, solution hoặc acceptance criteria vì chưa có thay đổi làm các tiêu chí R2 mất hiệu lực. **17 issue P2/P3 còn lại giữ OPEN theo R2, không tuyên bố đã tái kiểm tra toàn bộ trong R3.**

## Bổ sung về các mục chưa đủ bằng chứng

- **Mục cũ số 8 — Floating actions:** trên PDP Tháp nhũ tại 375×812, đo được floating container `bottom:84px`, không phải 20px như cách diễn đạt tổng quát của báo cáo Coder. Không kết luận 84px tự nó là lỗi: khoảng chừa có thể phục vụ sticky purchase bar. Trong phiên này thanh sticky chưa vào trạng thái hiện sau cuộn; screenshot tiếp tục timeout, vì vậy **chưa nghiệm thu overlap/interaction**, không tạo issue mới từ trạng thái không ổn định của công cụ.
- **Mục cũ số 11 — Mua ngay khi mạng chậm:** JS công khai vẫn có redirect dự phòng 4000ms độc lập với việc xác nhận thêm giỏ thành công. Đã chuẩn bị thử trì hoãn request 6 giây, nhưng điều kiện chờ UI biến thể ổn định timeout **trước khi gắn interception và bấm Mua ngay**. Vì vậy **chưa thực hiện thành công kịch bản mạng chậm**, không báo đã tái hiện lỗi checkout. Giữ OPEN theo giới hạn R2; cần chạy lại bằng phiên trình duyệt hoạt động ổn định hoặc staging.
- Một tab khác cập nhật được giá Tháp nhũ 1m8 thành 895.000đ; điều đó không thay thế kiểm thử delayed request, touch hoặc screenshot.
- Không đặt đơn/gửi lead/sửa code. Cuối lượt kiểm tra xác nhận giỏ trống và đóng hai tab R3.

## Bàn giao R3

- Tổng vẫn **23 issue OPEN: 6 P1, 16 P2, 1 P3**; không có issue mới, không có issue mới được FIXED.
- Coder tiếp tục xử lý theo thứ tự R2, phản hồi bằng ID và thông tin deploy. Reviewer chỉ đóng issue sau khi kiểm tra kết quả thực.
- Chưa cài watcher hay tiến trình nền thường trực; lần kiểm tra `ASSISTANT_REPLY.md` cuối lượt vẫn chưa có nội dung mới.

---

<a id="round-r4"></a>

# Vòng R4 — Bổ sung kiểm chứng sticky CTA và mạng chậm

Ngày kiểm tra: **24/09/2026**, trace mạng lần hai kết thúc lúc **11:41:19 UTC**.

## Phạm vi và thay đổi so với R3

- `ASSISTANT_REPLY.md` vẫn là báo cáo cũ 161 dòng; SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`. Chưa có phản hồi theo ID R2 hoặc thông tin deploy mới.
- Không chạy lại toàn bộ baseline. R4 bổ sung hai khoảng trống bằng chứng: floating/sticky mobile và giao dịch “Mua ngay” khi request thêm giỏ chậm hơn timer.
- Dùng Google Chrome riêng do công cụ khởi chạy, không dùng phiên đăng nhập của người dùng. Sau khi thiết lập viewport thực 375×812 và 430×932, đã chụp được bề mặt thật. Một số lệnh chờ/click của công cụ vẫn timeout; không dùng chúng làm bằng chứng website lỗi. Phép thử mạng thành công dùng DOM click trên nút thật, không sửa handler, dữ liệu hay phản hồi server.

## Nghiệm thu bổ sung mục Coder số 8 — Floating actions

**Status: FIXED trong phạm vi đã kiểm tra**, thay cho trạng thái thiếu bằng chứng tại R2/R3. Không chứng nhận mọi viewport/template hoặc mọi trình duyệt.

**Bổ sung phạm vi tại R13:** kết quả PDP của R4 được giữ nguyên, không suy rộng thành FIXED toàn website. Homepage 320×812 còn che CTA; xem [R13-01 — biểu hiện còn tồn đọng của mục Coder số 8](#round-r13).

- Location: `/san-pham/thap-nhu-dien/`, mobile khi cuộn qua vùng mua chính và sticky purchase bar đã hiện hoàn toàn.
- 375×812: sticky bar từ y=751 đến 812; floating actions từ y=578 đến 728, cách mép trên sticky **23px**. Ba nút sticky cao **44px**, nằm trong viewport. Document scrollWidth=375, không tràn ngang.
- 430×932: sticky bar từ y=871 đến 932; floating actions kết thúc y=848, vẫn cách **23px**. Document scrollWidth=430.
- Đã chọn Tháp nhũ 1m8, bấm **Thêm giỏ** trên sticky ở 375px: thông báo thêm thành công, header giỏ có 1 sản phẩm và 895.000đ. Không bấm gọi điện/Zalo.
- Giữ khoảng tránh sticky ở PDP; không yêu cầu ép `bottom:20px` lên mọi trạng thái chỉ để khớp câu chữ báo cáo Coder. Giá trị `bottom:84px` tại đây giúp hai cụm thao tác không đè nhau.
- Bằng chứng: [mobile 375](review-evidence/2026-09-24/r4-sticky-mobile.webp), [mobile 430](review-evidence/2026-09-24/r4-sticky-mobile-430.webp), [số đo layout](review-evidence/2026-09-24/r4-sticky-layout.json).

## [P1] R4-01 — Mua ngay điều hướng trước khi thêm giỏ hoàn tất

### Location
`/san-pham/thap-nhu-dien/` → `/thanh-toan/` → `/gio-hang/`; nút `.tt4m-pdp-buy-now` và `.tt4m-sticky-buy`, handler mua ngay trong `assets/js/theme-scripts.js`. Đây là **mục Coder số 11 được xác nhận bằng hành vi**, không phải một lỗi độc lập thứ hai bên cạnh mục đó.

### Problem
Với giỏ ban đầu trống, biến thể 1m8 giá 895.000đ đã chọn hợp lệ, “Mua ngay” vẫn yêu cầu checkout khi request thêm giỏ chưa gửi xong. Khách bị đưa tới trang giỏ báo trống thay vì checkout sản phẩm vừa chọn. Tăng timeout từ 1400 lên 4000ms không loại bỏ race condition.

Bổ sung R9: khi POST thêm giỏ thất bại ngay tại trình duyệt (`net::ERR_FAILED`), cả nút PDP và sticky vẫn điều hướng checkout sau khoảng 4 giây. Xem [trace lỗi request và trạng thái UI](#round-r9); không chỉ request chậm mới kích hoạt lỗi này.

### Why it matters
Chặn luồng mua trong tình huống request chậm; giao diện có thể báo giỏ trống dù sản phẩm xuất hiện sau khi tải lại. Khách dễ bỏ mua hoặc thử thêm lần nữa. Chưa kiểm chứng việc thử lại có tạo trùng sản phẩm hay không; không kết luận có lỗi tính tiền.

### Evidence
Phương pháp: giữ đúng **POST thêm giỏ đầu tiên** tại trình duyệt trong 6000ms rồi tiếp tục gửi tới server thật; các request khác đi bình thường. Không giả lập response thành công, không sửa JavaScript website, không tạo đơn hàng.

Trace lần hai, tính từ đầu phép thử:

| Thời điểm | Quan sát |
|---|---|
| 9ms | Giữ POST `/san-pham/thap-nhu-dien/?blocksy_add_to_cart=yes`. |
| 4049ms | Website phát GET `/thanh-toan/` trong khi POST còn bị giữ. |
| 4888ms | Checkout trả **302**, Location `/gio-hang/`. |
| 5986–5989ms | Cart trả **200**, trình duyệt chuyển sang `/gio-hang/`. |
| 6011ms | Mới thả POST thêm giỏ. |
| Sau 10,5 giây | Nội dung chính vẫn “Chưa có sản phẩm nào trong giỏ hàng.” |

Lần thử đầu cũng kết thúc ở giỏ trống. Ảnh sau đó cho thấy header đã có **1 / 895.000đ** nhưng nội dung chính còn báo trống; tải lại giỏ mới thấy sản phẩm đúng 1m8, số lượng 1, tổng 895.000đ. Vì vậy không kết luận server làm mất sản phẩm: lỗi đã chứng minh là **thứ tự điều hướng và trạng thái trang đích**.

Bằng chứng:
- [Trace request/response lần hai](review-evidence/2026-09-24/r4-slow-checkout-trace.json).
- [Lần thử đầu và trạng thái sau tải lại](review-evidence/2026-09-24/r4-slow-checkout.json).
- [Ảnh giỏ trống nhưng header đã có sản phẩm](review-evidence/2026-09-24/r4-slow-cart-empty.webp).

### Recommended solution
Chỉ chuyển checkout sau khi thao tác thêm giỏ của lượt bấm hiện tại được xác nhận thành công. Không dùng timer để suy đoán đã thêm xong. Nếu timeout/lỗi, giữ khách tại PDP, thông báo trạng thái rõ và cho phép thử lại theo kết quả thực; không điều hướng với trạng thái giỏ chưa xác nhận. Dùng sự kiện/kết quả đúng của luồng Blocksy/WooCommerce hiện có, áp dụng nhất quán cho nút PDP và sticky, giữ cơ chế chống nhấp lặp.

### Acceptance criteria
1. Giỏ ban đầu trống; chọn biến thể hợp lệ; trì hoãn request thêm giỏ **6 giây và lâu hơn 4 giây**: không yêu cầu checkout trước khi server xác nhận thêm thành công.
2. Sau thành công, đi thẳng tới checkout có đúng biến thể, số lượng và giá; không rơi vào trang giỏ trống, không phải tải lại thủ công.
3. Request thất bại/timeout: không chuyển checkout giả thành công; UI hết trạng thái chờ theo cách có kiểm soát và hiển thị lỗi có thể xử lý.
4. Kiểm tra cả nút PDP và sticky, nhấp đúp, giỏ đã có hàng và trường hợp chưa chọn biến thể; không làm hỏng kịch bản thường đã đạt ở R2.

### Status
**OPEN.** R4 đã tái hiện hai lần với request chậm; R9 bổ sung một phép thử abort request trên nút PDP và một trên sticky, cả hai đều không đạt tiêu chí xử lý lỗi. Giữ **P1** vì luồng mua thất bại trong kịch bản kiểm chứng. Chưa thử response HTTP 4xx/5xx từ server, timeout kéo dài hoặc thử lại thành công sau lỗi; abort tại trình duyệt không thay thế các kịch bản đó.

## Bàn giao và giới hạn R4

- Danh sách hành động hiện tại: **24 issue OPEN — 7 P1, 16 P2, 1 P3**. Gồm 23 issue R2 giữ nguyên và R4-01 cụ thể hóa mục timer cũ; không nhân đôi cùng lỗi khi Coder xử lý.
- Mục floating cũ số 8 được nghiệm thu trong mẫu mobile nêu trên; không làm giảm số 23 issue R2 vì đây là bảng nghiệm thu báo cáo Coder, không phải một ID R2.
- Các lỗi R2 còn lại giữ nguyên bằng chứng/trạng thái gần nhất, không tuyên bố đã tái kiểm tra toàn bộ trong R4. Các mục cần source/staging vẫn chưa đủ bằng chứng.
- Đã xóa sản phẩm thử, xác nhận giỏ trống và đóng Chrome riêng. Không đặt đơn, gửi lead, gọi điện/Zalo, sửa mã nguồn, cấu hình hoặc database website.
- Ưu tiên Coder: sửa giá/biến thể sai và R4-01 trước khi nghiệm thu luồng mua; trả lời theo ID kèm thay đổi và thông tin deploy. Không có watcher nền thường trực.

### Checkpoint sau R4 — 24/09/2026 11:45:07 UTC

Đã đọc lại `ASSISTANT_REPLY.md` và đối chiếu SHA-256: vẫn `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, không thay đổi so với R4. Chưa có báo cáo xử lý R2-01…R2-23 hoặc R4-01 để mở vòng nghiệm thu sửa lỗi. Không đồng nhất “file chưa đổi” với “website chưa đổi”; checkpoint này không kiểm tra lại live và không tạo kết luận mới về deployment.

Giữ nguyên **24 OPEN — 7 P1, 16 P2, 1 P3**, cùng kết quả nghiệm thu có giới hạn của R4. Không tạo issue trùng, không chạy lại baseline hoặc phân công agent lặp lại cùng bằng chứng. Đầu vào cần cho vòng nghiệm thu tiếp: Coder ghi ID đã xử lý, thay đổi cụ thể, URL/phạm vi ảnh hưởng và mốc deploy vào `ASSISTANT_REPLY.md`; các mục chỉ xác minh được bằng source/staging cần kèm diff hoặc bằng chứng môi trường phù hợp. Không tự chuyển issue sang FIXED dựa trên báo cáo Coder.

---

<a id="round-r5"></a>

# Vòng R5 — Hiệu năng tải ảnh trên các template đại diện

## Phạm vi và điều kiện đo

- `ASSISTANT_REPLY.md` vẫn có SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, chưa có phản hồi sửa R2/R4. R5 bổ sung khoảng trống hiệu năng, không chạy lại baseline hoặc mặc định có deployment mới.
- Năm lượt đo hợp lệ kết thúc trong khoảng **11:48:31–11:50:36 UTC, 24/09/2026**: homepage một lượt, Tháp nhũ điện ba lượt, bài chọn size cây thông một lượt.
- Chrome headless **153.0.8010.53**, máy chủ phép đo Apple M3/macOS; viewport **375×812**, DPR **1**, user-agent Android Chrome. Đây không phải phép thử trên điện thoại vật lý.
- Chrome DevTools Protocol: tải xuống **200.000 byte/giây ≈ 1,6 Mbps**, tải lên **93.750 byte/giây ≈ 0,75 Mbps**, latency cấu hình **150ms**, CPU slowdown **4×**, tắt HTTP cache trình duyệt. Không khẳng định DNS/TLS/kết nối hoặc cache server đều “cold”.
- Đọc Navigation Timing, Resource Timing và PerformanceObserver với `buffered:true`; quan sát đến 8 giây sau `load`, không cuộn/không tương tác trong cửa sổ đo. Có chụp ảnh bề mặt thật. Lần khởi tạo thiếu dữ liệu observer không được dùng trong bảng kết quả.
- **Đây là số đo lab cục bộ, không phải Lighthouse score hoặc CrUX/GSC/RUM p75.** Chưa đo INP thực địa, chưa chứng nhận CWV toàn site. Một lượt homepage/post chỉ mang tính chẩn đoán; không diễn giải thành phân phối hiệu năng người dùng.

## Kết quả đo hợp lệ

| Template / lượt | TTFB quan sát | FCP | LCP quan sát | Phần tử LCP |
|---|---:|---:|---:|---|
| Homepage | 1,234s | 2,812s | **5,000s** | Ảnh hero `keo-nhung-do.webp` |
| Tháp nhũ điện — 1 | 1,115s | 2,436s | **4,632s** | Ảnh chính `thap-nhu-dien-600x800.webp` |
| Tháp nhũ điện — 2 | 1,229s | 2,416s | **4,756s** | Cùng ảnh chính |
| Tháp nhũ điện — 3 | 1,234s | 2,392s | **4,760s** | Cùng ảnh chính |
| Bài chọn size cây thông | 1,105s | 2,480s | **2,480s** | Đoạn mở đầu bài |

Trung vị LCP của ba lượt PDP là **4,756s** trong đúng điều kiện trên. TTFB bao gồm mạng/phép mô phỏng, không phải thời gian xử lý PHP thuần; chưa đủ căn cứ kết luận hosting chậm hoặc yêu cầu đổi hạ tầng. Không suy ra một thay đổi ảnh sẽ loại bỏ toàn bộ thời gian LCP.

Bằng chứng chung: [tổng hợp cấu hình/số đo/markup](review-evidence/2026-09-24/r5-performance-summary.json), [homepage](review-evidence/2026-09-24/r5-home-performance.json), [PDP lượt 1](review-evidence/2026-09-24/r5-pdp-performance.json), [PDP lượt 2](review-evidence/2026-09-24/r5-pdp-repeat-2.json), [PDP lượt 3](review-evidence/2026-09-24/r5-pdp-repeat-3.json), [bài viết](review-evidence/2026-09-24/r5-post-performance.json).

## [P2] R5-01 — Ảnh chính PDP trong màn hình đầu vẫn bị lazy-load

### Location
`/san-pham/thap-nhu-dien/`, ảnh đầu gallery `.woocommerce-product-gallery img.wp-post-image`. Phạm vi đã xác minh là PDP này; cần kiểm tra các PDP dùng chung gallery khi sửa.

### Problem
Ảnh chính là phần tử LCP ở mobile nhưng HTML/DOM vẫn đặt `loading="lazy"`, không có ưu tiên tải cao. Chính sách tải ảnh không phân biệt ảnh cần hiện ngay với ảnh nằm sâu phía dưới.

### Why it matters
Khách chờ ảnh hàng hóa chủ đạo dù nội dung chữ đã xuất hiện. Lazy-loading khiến browser phải xác định ảnh thuộc vùng cần tải sau layout thay vì ưu tiên phát hiện/tải ngay. Đây là cơ hội giảm độ trễ hiển thị, chưa phải bằng chứng về tỷ lệ bỏ mua hoặc thứ hạng SEO thực tế.

### Evidence
- Ảnh thật ở [màn hình đầu PDP 375×812](review-evidence/2026-09-24/r5-pdp-mobile.webp), không cần cuộn để thấy.
- Cả ba lượt PerformanceObserver xác định cùng ảnh là LCP; thời gian **4,632 / 4,756 / 4,760s**.
- DOM: `<img ... src=".../thap-nhu-dien-600x800.webp" loading="lazy" ... class="wp-post-image">`. Có `srcset` và kích thước ảnh, nhưng không có `fetchpriority="high"`.
- Lượt 1: TTFB 1114,9ms; request ảnh bắt đầu 2316,8ms, tức sau TTFB khoảng **1201,9ms**; response ảnh kết thúc 4622,5ms, LCP 4632ms. File ảnh có encoded body **174.958 byte**.
- [Hướng dẫn tối ưu LCP của web.dev](https://web.dev/articles/optimize-lcp) giải thích vì sao lazy-load ảnh LCP làm chậm thời điểm tải và khuyến nghị ưu tiên tài nguyên LCP. Không quy toàn bộ 1,2 giây chờ hoặc toàn bộ LCP cho một thuộc tính khi chưa có phép đo A/B sau sửa.

### Recommended solution
Tại cơ chế render gallery hiện có, ưu tiên đúng ảnh đầu có khả năng xuất hiện trong viewport: bỏ lazy-load hoặc dùng `loading="eager"`, cân nhắc `fetchpriority="high"` cho ảnh đó. Giữ `srcset`/`sizes` phù hợp kích thước thực, kích thước/aspect-ratio và ảnh zoom chất lượng cao. Các ảnh gallery tiếp theo hoặc ảnh ngoài màn hình vẫn có thể lazy-load. Không bật eager/high cho mọi ảnh và không thêm preload trùng request responsive một cách máy móc.

### Acceptance criteria
1. Ảnh chính nhìn thấy ngay khi mở PDP không mang `loading="lazy"`; được browser phát hiện/ưu tiên trong đợt tải đầu, không đợi scroll hoặc mã khởi tạo gallery.
2. Chạy ít nhất ba lượt cùng cấu hình R5 trước/sau; lưu thời điểm request ảnh, LCP và TTFB để phân biệt cải thiện tải ảnh với biến động mạng/server.
3. Ảnh không nhòe/cắt sai; chọn biến thể, chuyển ảnh và zoom vẫn đúng; không tải hai phiên bản của cùng ảnh chỉ vì preload sai.
4. Kiểm tra mobile và desktop ở các PDP dùng chung gallery; không làm các ảnh ngoài viewport đồng loạt tải sớm.

**Phạm vi bổ sung R21:** đã thử gallery một/nhiều ảnh và ghi riêng R21-01 (crop ảnh), R21-02 (control bàn phím). Không quan sát control mở lightbox trong hai PDP mẫu; bấm ảnh Nutcracker không mở dialog, nên không tự yêu cầu thêm tính năng lightbox chỉ từ tiêu chí “zoom” chung ở trên. R5-01 vẫn cần phép đo tải ảnh/LCP sau sửa, chưa được nghiệm thu bởi việc chuyển ảnh thành công.

### Status
OPEN

## [P2] R5-02 — Card nhỏ tải ảnh gốc lớn; ảnh gợi ý cuối bài tải ngay từ đầu

### Location
Homepage: nhóm sáu card danh mục. Bài `/y-tuong-trang-tri/noel/cach-chon-size-cay-thong-noel/`: bốn card sản phẩm gần cuối bài.

### Problem
Card kích thước nhỏ tải ảnh gốc 900–1200px. Riêng ảnh gợi ý sản phẩm cuối bài không có `loading="lazy"`, `srcset` hoặc `sizes`, nên tải toàn bộ ngay khi mở bài dù rất xa viewport đầu.

### Why it matters
Tốn dữ liệu và băng thông trước khi người đọc cần ảnh; tài nguyên không thiết yếu có thể cạnh tranh với nội dung đầu trang. WebP và lazy-load riêng lẻ không giải quyết việc dùng sai kích thước ảnh. Không khẳng định việc sửa các card sẽ tiết kiệm một lượng thời gian LCP cố định.

### Evidence
- Bài viết ở 375px: bốn ảnh nằm tại y≈**8170 / 8524px**, mỗi ảnh hiển thị khoảng **111×111px**, nhưng tải ảnh gốc **900×1200px**.
- DOM cả bốn ảnh không có `srcset`, `sizes`, `loading`. Request bắt đầu khoảng **1,272s** dù chưa cuộn:
  - `qua-chau-cuom.webp`: **131.094 byte**.
  - `ngoi-sao-nhu-do-bac.webp`: **223.720 byte**.
  - `canh-thong-pe.webp`: **209.454 byte**.
  - `day-tuyet.webp`: **345.618 byte**.
- Tổng encoded body bốn ảnh là **909.886 byte ≈ 910 KB**, không tính header. Đây là payload ảnh đo được, không phải dự đoán dung lượng tối ưu sẽ tiết kiệm.
- Homepage: sáu card danh mục hiển thị **165×183px** nhưng dùng ảnh gốc rộng **900–1200px**, tổng encoded body **945.382 byte ≈ 945 KB**. Các ảnh này đã có lazy-load và được Chrome nạp trong vùng gần viewport; không coi hành vi nạp gần viewport của browser là lỗi. Vấn đề tại homepage là kích thước ảnh nguồn cho card.
- Xem `images`/`resources` trong hai file đo homepage/post và `postCards` trong file tổng hợp. Không tạo lại lỗi R2-11: R2-11 nói về nội dung ảnh không khớp; R5-02 nói về phân phối tài nguyên ảnh.

### Recommended solution
Dùng các kích thước attachment/thumbnail sẵn có của WordPress cho card và xuất `srcset`/`sizes` khớp layout thật, thay vì URL ảnh gốc hard-code. Giữ ứng viên đủ nét cho màn hình DPR 2/3 và bản gốc cho mục đích cần độ phân giải cao. Thêm lazy-load cho ảnh gợi ý nằm sâu trong bài; giữ khoảng hiển thị bằng kích thước/aspect-ratio phù hợp. Không áp dụng lazy-load đó lên ảnh hero/ảnh chính PDP cần tải ngay.

### Acceptance criteria
1. Mở bài ở đầu trang với cache tắt, không cuộn: bốn ảnh gợi ý cách viewport hơn 8.000px không còn được yêu cầu ngay; cuộn đến gần card thì ảnh tải và hiển thị đúng.
2. Card chọn nguồn ảnh phù hợp kích thước render × DPR; không mặc định gửi bản gốc 900–1200px cho card 111/165px khi có thumbnail thích hợp.
3. Đo lại payload homepage và bài viết cùng cấu hình; ghi rõ số byte giảm. Kiểm tra độ nét/crop tại mobile, tablet, desktop và màn hình DPR cao, không chỉ tối ưu theo DPR 1 của phép thử này.
4. Không làm hỏng link card, thay đổi bố cục ngoài ý muốn hoặc gây ảnh trống khi cuộn. Giữ ưu tiên ảnh LCP theo R5-01.

### Status
OPEN

## Bàn giao R5

- Bổ sung **hai issue P2**, tổng hiện hành **26 OPEN — 7 P1, 18 P2, 1 P3**. Các issue cũ giữ trạng thái/bằng chứng gần nhất; không có issue được đóng chỉ nhờ vòng đo này.
- Chưa có Lighthouse score hoặc dữ liệu CWV thực địa; khoảng trống R2 được bổ sung bằng số đo browser có cấu hình rõ ràng, không bị thay thành tuyên bố “đạt/rớt CWV”.
- Giữ ưu tiên dữ liệu giá/biến thể, nội dung an toàn và checkout P1 trước hai tối ưu P2 này.
- Không sửa mã nguồn/cấu hình/database website; không gửi form, không thêm giỏ hay đặt đơn trong R5. Đã đóng Chrome riêng dùng đo; không cài watcher nền.

---

<a id="round-r6"></a>

# Vòng R6 — Schema sản phẩm, phân trang và mở rộng bằng chứng giá

## Phạm vi và cách xác minh

- Ngày **24/09/2026**. `ASSISTANT_REPLY.md` chưa đổi, SHA-256 vẫn `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`.
- Hai reviewer chạy độc lập: **ProductSchemaR6** kiểm tra ba PDP và hướng dẫn Google; **ArchiveCrawlR6** kiểm tra archive, phân trang và sort. Cả hai trả kết quả, không sửa file/website.
- Công cụ của hai nhánh không cung cấp đầy đủ HTTP status/headers/timestamp. Main đã GET lại, parse JSON-LD/dữ liệu biến thể và lưu bằng chứng có thời điểm; không chỉ chép kết luận subagent.
- Phạm vi Main: ba PDP schema, hai PDP giá bổ sung, bảy URL archive/query/probe, robots/sitemap và JS công khai. Không audit lại toàn bộ UI, không chạy lại checkout hoặc phép đo hiệu năng R5.
- Các kiểm tra HTTP/schema không chứng minh trạng thái index hoặc rich result trong Google. Chưa có GSC/Merchant Center, chưa chạy Rich Results Test; không gọi JSON parse thành công là chứng nhận rich result.

## Phần đang hoạt động đúng — giữ nguyên

Xác minh lúc **11:58:26 UTC**, bằng chứng [HTTP, canonical, robots, tập ID và pagination](review-evidence/2026-09-24/r6-archive-checks.json).

| Mẫu | Kết quả |
|---|---|
| `/cua-hang/`, `/cua-hang/page/2/` | HTTP 200; canonical tự tham chiếu đúng trang; 16 card mỗi trang, hai tập ID không giao nhau. |
| Category Noel và `/page/2/` | HTTP 200; canonical giữ đúng archive và số trang; trang 2 khác tập sản phẩm trang 1. |
| `/cua-hang/?orderby=price&paged=1` | HTTP 301 bỏ `paged=1` → `?orderby=price`, sau đó 200; canonical về `/cua-hang/`. |
| `/cua-hang/page/2/?orderby=price` | HTTP 200; canonical về `/cua-hang/page/2/`, không ép về trang đầu; sort thay tập/thứ tự sản phẩm và pagination giữ `orderby=price`. |
| `/cua-hang/page/7/` | HTTP **404**; listing chỉ có 89 sản phẩm, 16/trang, trang cuối 6. Đây là probe ngoài phạm vi, không phải broken link được phát hiện trong navigation. |

- Sáu trang có nội dung đều có `index, follow...`; không thấy `X-Robots-Tag` xung đột trong response. Không yêu cầu bắt buộc noindex URL sort khi đã có canonical phù hợp.
- Pagination có `a.page-numbers[href]` trong HTML, không cần JS để phát hiện đường dẫn. Chưa thử tương tác dropdown bằng browser ở R6; kết luận sort dựa trên GET đúng field `orderby`/`paged` của form và kết quả server-rendered.
- Shop và category Noel hiện cùng 89 sản phẩm. Chưa đủ căn cứ coi hai vai trò archive này là duplicate gây hại hoặc yêu cầu gộp.
- PDP simple **Quả châu cườm** có Product + Offer **95.000 VND**, khớp giá công bố; giữ mô hình này khi sửa schema variable. Không yêu cầu bịa brand, GTIN, review hoặc aggregateRating.

## [P2] R6-01 — AggregateOffer đang dùng thay cho mô hình biến thể sản phẩm

### Location
JSON-LD trên `/san-pham/thap-nhu-dien/`, `/san-pham/keo-gay-trang-tri-noel/`, hai PDP cây thông mới và phần Product/offers do nguồn schema hiện có xuất ra.

### Problem
Ba/năm lựa chọn kích thước được gộp thành một Product + `AggregateOffer` với lowPrice/highPrice/offerCount. Schema không biểu diễn quan hệ nhóm–biến thể–SKU–giá của các lựa chọn đang bán; cách dùng AggregateOffer này trái hướng dẫn Google dành cho tập biến thể.

### Why it matters
Dữ liệu có cấu trúc không mô tả đúng các biến thể mà khách có thể chọn. Đầu ra hiện tại cũng không đáp ứng yêu cầu dùng Offer của merchant listing qua structured data. **Không kết luận Google đã bỏ index, đang hiển thị sai, hoặc Merchant Center feed thất bại** vì chưa có dữ liệu các hệ thống đó.

### Evidence
Main lấy lại cả ba PDP schema bằng HTTP 200 và parse JSON-LD thành công; xem [bằng chứng schema/biến thể](review-evidence/2026-09-24/r6-product-schema.json):

| PDP | Schema đang xuất | Dữ liệu biến thể công khai |
|---|---|---|
| Tháp nhũ điện | `Product` + `AggregateOffer`, lowPrice 550000, highPrice 895000, offerCount 3, currency VND | 296/1m2/550000; 297/1m5/755000; 298/1m8/895000 |
| Kẹo gậy | `Product` + `AggregateOffer`, lowPrice 1150, highPrice 950000, offerCount 5, currency VND | 5 biến thể riêng 270–274; có giá/nhãn cần sửa theo R2-01/R2-02 |

Trong ba graph khảo sát, không có ProductGroup; hai PDP variable không có Offer riêng gắn với từng Product biến thể. Quả châu cườm có Offer 95000 VND, dùng làm mẫu đối chứng simple chứ không phải bằng chứng mọi schema đều sai.

**Bổ sung R27:** `CT-PE-SNOW` tiếp tục xuất một Product + AggregateOffer 850000–2650000, offerCount 4; `CT-CUOC-PINE` xuất 750000–1650000, offerCount 3. Không PDP nào có ProductGroup hoặc Offer riêng theo size. Raw variations của hai cây còn có attribute rỗng và gây lỗi chọn biến thể R27-01; vì vậy chưa thể dựng schema đúng chỉ bằng ánh xạ dữ liệu hiện tại. [HTML/JSON-LD và variations](review-evidence/2026-09-24/r27-product-http.json). Ba combo simple mới dùng một Product + một Offer khớp giá công bố; giữ kiểu này, không ép ProductGroup cho sản phẩm đơn.

Tài liệu chính thức đã đối chiếu:
- [Google Product snippets — AggregateOffer](https://developers.google.com/search/docs/appearance/structured-data/product-snippet#aggregate-offer-properties): **“Don't use AggregateOffer to describe a set of product variants.”**
- [Google Merchant listings](https://developers.google.com/search/docs/appearance/structured-data/merchant-listing#structured-data-type-definitions): Product snippets có thể nhận Offer hoặc AggregateOffer; merchant listings yêu cầu **Offer**.
- [Google Product variants](https://developers.google.com/search/docs/appearance/structured-data/product-variants): mô hình ProductGroup với `variesBy`, `hasVariant`, `productGroupID` và Product/Offer theo biến thể.

Đây không phải bản sao R2-01 về giá sai, R2-02 về taxonomy hoặc R2-16 về homepage. Tháp nhũ có giá nhất quán nhưng vẫn xuất sai mô hình biến thể.

### Recommended solution
Sửa tại nguồn xuất schema sản phẩm hiện có, không chèn một Product graph mới chồng lên graph cũ. Với các lựa chọn trên cùng PDP, dùng mô hình ProductGroup và Product/Offer theo biến thể phù hợp hướng dẫn single-page của Google; giữ identity, giá VND, availability, ảnh và URL khớp lựa chọn thực.

Giải quyết dữ liệu Kẹo gậy theo R2-01/R2-02 trước khi đưa nhãn size/kiểu vào schema; không suy đoán ý nghĩa term. Nếu xuất URL chọn trước biến thể, GET URL đó phải mở đúng lựa chọn, không dùng URL add-to-cart. Giữ một canonical nhóm phù hợp và không tạo các trang biến thể rỗng chỉ để có URL. Giữ Offer của PDP simple; không thêm review/GTIN/brand không có căn cứ.

### Acceptance criteria
1. Bốn PDP variable đã nêu không còn dùng AggregateOffer đại diện tập biến thể; mỗi biến thể đang bán có Product/Offer phù hợp và quan hệ nhóm rõ, không có graph giá/identity mâu thuẫn.
2. Tháp nhũ khớp 296/1m2/550000, 297/1m5/755000, 298/1m8/895000 VND. Kẹo gậy và hai cây mới khớp nguồn dữ liệu được owner nghiệm thu; không lấy giá/mapping sai hiện tại làm chuẩn.
3. URL biến thể được khai báo mở đúng size/giá/ảnh bằng GET; canonical nhóm đúng cho mô hình single-page.
4. Kiểm tra raw HTML, JSON parse và Rich Results Test cho Product snippets/merchant listings; xử lý lỗi bắt buộc của mô hình mới. Không xóa warning khuyến nghị bằng dữ liệu bịa và không hứa rich result chỉ vì tool pass.
5. Quả châu cườm và ba combo simple mới vẫn có một Offer đúng giá công bố; sửa template không phát sinh Product/Offer trùng.

### Status
OPEN

## Cập nhật issue cũ, không nhân đôi

- **R2-01 vẫn P1 OPEN, phạm vi mở rộng:** product 261/variation 263 và product 280/variation 283, cùng size 90cm, giá dữ liệu **1.895đ** nhưng mô tả **1.895.000đ**. Đã thêm bằng chứng và tiêu chí nghiệm thu vào ngay issue gốc. Không cộng thành hai issue mới.
- **R2-06 vẫn OPEN:** lúc 11:56:01 UTC, sitemap index chỉ có page/product/product_cat sitemap, chưa liệt kê post-sitemap; post-sitemap trả 200 và có hub cùng ba bài. Không suy ra bài không thể được Google phát hiện qua internal link.
- **R4-01 vẫn OPEN:** nội dung file JS được lấy lại tại URL version đã biết có SHA-256 `95208420f6385ea2bdb3a0451a41297070d67cf20405091ebb386d8444d5e0de`, giống bản lưu R2 và còn fallback checkout 4000ms. Đây chỉ là đối chiếu tài nguyên, **không phải chạy lại kịch bản checkout R4 hoặc chứng minh mọi deployment chưa đổi**.
- Bằng chứng đối chiếu robots/sitemap/JS: [r6-independent-checks.json](review-evidence/2026-09-24/r6-independent-checks.json). Robots trả 200 và vẫn khai báo sitemap index.

## Bàn giao R6

- Thêm **một P2**, tổng **27 OPEN — 7 P1, 19 P2, 1 P3**. Không có issue được đóng trong R6.
- Ưu tiên sửa nguồn giá của cả ba PDP thuộc R2-01 và luồng checkout R4-01; sau đó sửa schema tại nguồn sinh hiện có, tránh nhân đôi graph.
- Phân trang/sort đạt trong mẫu nêu trên: bảo toàn hành vi này khi sửa SEO/template, không thay đổi chỉ để có việc làm.
- Coder chưa có phản hồi mới. Không sửa code/config/database, không gửi form, thêm giỏ hoặc đặt đơn; không cài tiến trình giám sát nền.

---

<a id="round-r7"></a>

# Vòng R7 — Đối chiếu catalog và phân biệt mua trực tiếp với nhận báo giá

## Phạm vi

- Kiểm tra ngày **24/09/2026**; tổng hợp dữ liệu lúc **12:07:08 UTC**. `ASSISTANT_REPLY.md` vẫn có SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, chưa có phản hồi mới.
- API công khai `/wp-json/wc/store/v1/products?per_page=100` trả HTTP 200, `X-WP-Total:89`, `X-WP-TotalPages:1`; đã đọc đủ **89 sản phẩm được endpoint này công bố tại thời điểm kiểm tra**, không suy ra số lượng bản nháp hoặc hàng nội bộ.
- Catalog gồm **69 simple / 20 variable**. Main đọc thêm HTML của toàn bộ 20 PDP variable và tám PDP có `is_purchasable:false`; tất cả trả HTTP 200.
- Kiểm tra Chrome mobile 375×812 trên Châu gương disco và Ngôi sao nhũ đỏ bạc; lưu ảnh của Châu gương disco. Không tương tác mua với 60 biến thể, không gửi tin Zalo, không gọi hotline hoặc gửi đơn.

## Kết quả selector biến thể

- API và `data-product_variations` của **20 PDP / 60 biến thể** khớp tập ID.
- Mọi giá trị thuộc tính không rỗng của 60 biến thể đều xuất hiện trong option tương ứng của form. **Không phát hiện biến thể công khai bị mất khỏi selector trong tập kiểm tra này.**
- Đây là kiểm tra cấu trúc HTML/API, không phải xác nhận 60 lần chọn giá/add-to-cart đã chạy thành công hoặc giá/tồn kho đã được owner duyệt.
- **R2-02 vẫn OPEN:** Quả châu nhũ vàng còn option slug `8` hiển thị `1m8`; Ông già Noel product 177 còn hai option khác slug cùng nhãn `1m8`; các nhãn thiếu đơn vị đã ghi trước đó chưa được nghiệm thu. Có đủ option không đồng nghĩa nhãn đúng.
- **R2-01 vẫn OPEN:** các giá sai ở product 269, 261, 280 vẫn xuất hiện trong dữ liệu biến thể đọc lần này. Không phát sinh issue trùng theo từng SKU.

## Tám sản phẩm không mua trực tiếp là luồng báo giá rõ ràng

| ID | PDP |
|---:|---|
| 260 | `/san-pham/ngoi-sao-nhu-do-bac/` |
| 254 | `/san-pham/hang-rao-go-trang-tri-goc-cay/` |
| 250 | `/san-pham/hang-rao-khuc-go-trang-tri-goc-cay/` |
| 240 | `/san-pham/ngoi-sao-nhu-dinh-sequin/` |
| 234 | `/san-pham/qua-chau-nhu-do-hoa-tiet-la/` |
| 159 | `/san-pham/chau-tron-do/` |
| 152 | `/san-pham/que-keo-xoan-cam-canh/` |
| 151 | `/san-pham/chau-guong-disco/` |

- Cả tám có API `prices.price:"0"`, `is_purchasable:false`, `is_in_stock:true`. **Không diễn giải số 0 của API thành sản phẩm miễn phí.**
- HTML cả tám không có nút thêm giỏ chính hoặc `.tt4m-pdp-buy-now`/`.tt4m-sticky-buy`; thay vào đó có CTA **“Nhắn Zalo nhận báo giá & tư vấn mẫu”** trỏ tới `https://zalo.me/0901234567`.
- Sáu mô tả dài nói rõ liên hệ/báo giá. Hai mô tả Ngôi sao không ghi giá trong thân bài nhưng khu vực summary vẫn công bố **“Liên hệ Zalo để báo giá.”**; đã đối chiếu DOM live trên Ngôi sao nhũ đỏ bạc.
- Schema Product được đọc của cả tám không xuất Offer giá 0. Không yêu cầu bịa giá/Offer chỉ để đạt rich result.
- Trên Châu gương disco mobile, CTA báo giá hiển thị đúng, rộng **330px**, cao **48px**; giỏ hiển thị 0 sản phẩm. Không có nút mua trực tiếp để đưa khách vào checkout của mặt hàng chưa chốt giá.
- **Kết luận: không tạo issue “thiếu giá/không mua được” cho nhóm này.** Luồng nhận báo giá là lựa chọn thương mại có chủ đích được giao diện hỗ trợ. Chưa xác minh chủ sở hữu tài khoản Zalo, việc nhận tin hoặc thời gian phản hồi.

## Phần cần bảo toàn khi Coder sửa

1. Phân biệt hàng có thể mua trực tiếp với hàng nhận báo giá; không đồng loạt bật nút mua hoặc gán giá 0 cho tám PDP này.
2. Không “sửa thiếu biến thể” bằng đổi tên term dùng chung một lần nữa; mọi thay đổi taxonomy phải đối chiếu đủ 20 PDP và 60 ID đã ghi nhận.
3. Giữ CTA báo giá có nhãn rõ và không ép khách vào checkout trước khi có giá hợp lệ.
4. Các số lượng/ID trên là snapshot công khai, không thay thế xác nhận nghiệp vụ giá và tồn kho từ owner.

## Bằng chứng và bàn giao

- [Catalog API công khai](review-evidence/2026-09-24/r7-public-catalog.json).
- [Ma trận selector/biến thể/giá của 20 PDP](review-evidence/2026-09-24/r7-variant-selector-audit.json).
- [CTA và schema của tám PDP báo giá](review-evidence/2026-09-24/r7-quote-product-controls.json).
- [Đối chiếu DOM trên hai PDP](review-evidence/2026-09-24/r7-quote-browser.json), [ảnh mobile Châu gương disco](review-evidence/2026-09-24/r7-quote-mobile.webp).
- [Tổng hợp tập ID và kiểm tra cấu trúc](review-evidence/2026-09-24/r7-catalog-summary.json).

**Không có issue mới, không đóng issue cũ. Tổng vẫn 27 OPEN — 7 P1, 19 P2, 1 P3.** Vòng này bổ sung bằng chứng và loại trừ một nghi vấn, không coi mọi khác biệt thương mại là lỗi. Không sửa website hoặc tạo giao dịch; đã đóng Chrome riêng sau khi kiểm tra.

**Làm rõ phạm vi sau R8:** kết luận R7 chỉ áp dụng cho UI, cấu trúc selector, dữ liệu API và Offer đã kiểm tra. Không có Offer giá 0 **không có nghĩa** mọi metadata giá đều đúng. R8 phát hiện riêng cặp `twitter:label1`/`twitter:data1` mâu thuẫn với trạng thái nhận báo giá; không đảo ngược kết luận rằng luồng báo giá là lựa chọn thương mại hợp lệ.

---

<a id="round-r8"></a>

# Vòng R8 — Metadata giá của sản phẩm nhận báo giá

## Phạm vi và kết luận

- `ASSISTANT_REPLY.md` vẫn chưa đổi tại checkpoint **24/09/2026 12:09:32 UTC**, SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`.
- Main GET lại **tám PDP nhận báo giá và hai PDP bán trực tiếp**, đều HTTP 200; bằng chứng tổng hợp lúc **12:10:26 UTC**. Đối chiếu raw meta tags, nội dung summary và schema.
- Phát hiện bổ sung một **P2**, không có bằng chứng đây là regression sau deployment mới. Không chạy lại toàn bộ baseline.
- Không thử đăng/chia sẻ URL lên X, Facebook hoặc Zalo; **không tuyên bố preview thực tế đang hiển thị giá 0đ**. Phát hiện đã xác minh nằm trong HTML metadata do website xuất.

## [P2] R8-01 — Metadata “Giá: 0đ” mâu thuẫn với sản phẩm nhận báo giá

### Location
`<head>` của tám PDP:

| ID | URL |
|---:|---|
| 260 | `/san-pham/ngoi-sao-nhu-do-bac/` |
| 254 | `/san-pham/hang-rao-go-trang-tri-goc-cay/` |
| 250 | `/san-pham/hang-rao-khuc-go-trang-tri-goc-cay/` |
| 240 | `/san-pham/ngoi-sao-nhu-dinh-sequin/` |
| 234 | `/san-pham/qua-chau-nhu-do-hoa-tiet-la/` |
| 159 | `/san-pham/chau-tron-do/` |
| 152 | `/san-pham/que-keo-xoan-cam-canh/` |
| 151 | `/san-pham/chau-guong-disco/` |

### Problem
Website xuất nhãn `twitter:label1="Giá"` cùng `twitter:data1` có giá trị giải mã **`0 ₫`**, dù summary ghi **“Liên hệ Zalo để báo giá.”** và sản phẩm không có luồng mua trực tiếp.

### Why it matters
Metadata thương mại đang công bố một giá cụ thể không đúng với nội dung trang. Bên tiêu thụ metadata có thể hiểu đây là sản phẩm miễn phí thay vì cần báo giá, gây kỳ vọng sai nếu trường này được sử dụng. Mâu thuẫn dữ liệu tồn tại độc lập với việc một nền tảng cụ thể hiện có render trường đó hay không; chưa đo tác động tới traffic, doanh thu hoặc rich result.

### Evidence
Cả **8/8** PDP đều trả cùng cặp metadata. Ví dụ Châu gương disco, trích raw HTML:

```html
<meta name="twitter:label1" content="Giá" />
<meta name="twitter:data1" content="0&nbsp;&#8363;" />
```

- Sau giải mã HTML entities, `twitter:data1` là `0 ₫`; không phải chỉ chuỗi lỗi định dạng.
- Summary cả tám có **“Liên hệ Zalo để báo giá.”**, không có nút thêm giỏ chính. Product JSON-LD không có Offer giá 0. Đây là **metadata sai**, không phải bằng chứng có thể đặt hàng miễn phí.
- Không thấy `product:price:amount` trên tám PDP này; chỉ có currency VND. Không mở rộng kết luận thành “mọi OG/schema đều khai giá 0”.
- Hai mẫu đối chứng có giá bán:
  - Quả châu cườm, ID 279: `twitter:data1="95.000 ₫"`, `product:price:amount="95000"`, Offer 95000 VND.
  - Tháp nhũ điện, ID 295: `twitter:data1="550.000 ₫ - 895.000 ₫"`, khớp khoảng giá công bố.
- Bằng chứng có URL/status/thời điểm/raw tags/meta/summary/Offer: [r8-quote-price-metadata.json](review-evidence/2026-09-24/r8-quote-price-metadata.json).

### Recommended solution
Sửa tại nguồn sinh metadata hiện có để nhận biết trạng thái **báo giá/chưa có giá**, không ép giá rỗng hoặc giá đại diện của API thành giá bán 0. Với nhóm nhận báo giá, bỏ cặp trường “Giá” không có dữ liệu hợp lệ, hoặc dùng thông điệp báo giá phù hợp ở trường văn bản mà bên tiêu thụ hỗ trợ. Không đưa chuỗi “Liên hệ” vào thuộc tính numeric price.

Giữ giá/range thật cho các sản phẩm bán trực tiếp; phân biệt trạng thái chưa có giá với giá 0 hợp lệ nếu nghiệp vụ thực sự có hàng miễn phí. Không thay đổi luồng nhận báo giá, tạo Offer giá 0 hoặc bật mua trực tiếp chỉ để làm metadata nhất quán. Không cần thêm một nguồn metadata thứ hai cạnh nguồn đang dùng.

### Acceptance criteria
1. Raw HTML của cả tám PDP, sau xử lý cache liên quan, không còn khai giá bán 0 dưới nhãn “Giá” cho hàng nhận báo giá.
2. Summary, metadata mô tả và trạng thái schema không mâu thuẫn; CTA báo giá tiếp tục hoạt động như trước, không phát sinh nút mua/Offer miễn phí.
3. Mẫu đối chứng Quả châu cườm giữ giá 95.000đ và Tháp nhũ giữ khoảng 550.000–895.000đ tại metadata; không gỡ giá toàn bộ catalog để xử lý nhóm báo giá.
4. Không phát sinh meta tags giá trùng/mâu thuẫn. Nếu nghiệm thu thêm preview chia sẻ, ghi rõ nền tảng, thời điểm và trạng thái cache; không coi HTML đã sửa là bằng chứng mọi preview cũ đã cập nhật.

### Status
OPEN

## Bàn giao R8

- Tổng **28 OPEN — 7 P1, 20 P2, 1 P3**; thêm R8-01, không đóng issue cũ.
- Bảo toàn kết luận đúng của R7 về tám sản phẩm nhận báo giá; bổ sung lỗi ở lớp metadata thay vì quy toàn bộ luồng báo giá là lỗi.
- Không chỉnh code/config/database, không gửi form/tin nhắn, không đăng bài chia sẻ hoặc tạo đơn hàng. Không có tiến trình giám sát nền.

### Checkpoint sau R8 — 24/09/2026 12:13:13 UTC

Đã đối chiếu lại `ASSISTANT_REPLY.md`: vẫn 161 dòng, SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, chưa có phản hồi xử lý R2–R8. Giữ nguyên **28 OPEN — 7 P1, 20 P2, 1 P3**. Checkpoint này chỉ kiểm tra tài liệu phản hồi, không recheck live hoặc suy ra website chưa thay đổi.

Không mở vòng audit toàn site hay tạo issue trùng khi chưa có thay đổi liên quan được báo cáo. Bước bàn giao tiếp theo: Coder ghi ID đã xử lý, thay đổi cụ thể, URL/phạm vi ảnh hưởng và mốc deploy; ưu tiên R2-01 trên cả ba PDP 269/261/280 và R4-01. Reviewer sẽ dùng tiêu chí đã ghi để kiểm tra kết quả thực và regression, không đóng issue từ lời xác nhận của Coder.

### Tái kiểm tra có mục tiêu — 24/09/2026 12:14:22 UTC

`ASSISTANT_REPLY.md` vẫn giữ SHA-256 nêu trên. Đã GET lại hai PDP, đều HTTP 200:
- **R2-01, Kẹo gậy:** biến thể 271/272/273 vẫn có giá 1.150/1.450/1.650đ; mô tả vẫn ghi 1.150.000/1.450.000/1.650.000đ. Giữ **OPEN**.
- **R8-01, Châu gương disco:** metadata vẫn là `twitter:label1="Giá"` và `twitter:data1="0 ₫"`, trong khi summary yêu cầu liên hệ báo giá. Giữ **OPEN**; lượt này chỉ kiểm tra một PDP đại diện, không thay thế bằng chứng tám PDP ở R8.

Bằng chứng: [post-r8-targeted-recheck.json](review-evidence/2026-09-24/post-r8-targeted-recheck.json). Không có issue mới hoặc được đóng; tổng **28 OPEN — 7 P1, 20 P2, 1 P3**. Không suy rộng kết quả hai URL thành kiểm tra toàn website; không sửa website hoặc tạo giao dịch.

---

<a id="round-r9"></a>

# Vòng R9 — Lỗi request mua ngay trên PDP và sticky

Ngày kiểm tra: **24/09/2026**; hai phép thử kết thúc lúc **12:25:05 UTC** và **12:25:38 UTC**. Đây là mở rộng nhánh lỗi chưa thử của **R4-01**, không phải một issue mới hoặc nghiệm thu bản sửa.

## Phạm vi và phương pháp

- Chrome riêng, viewport **375 × 812**, mô phỏng mobile; không phải thử trên điện thoại thật.
- PDP `/san-pham/thap-nhu-dien/`; giỏ ban đầu trống; chọn **1m8 / 895.000đ / số lượng 1**. Nút thêm giỏ chính không mang class `disabled` trước mỗi phép thử.
- Thử riêng `.tt4m-pdp-buy-now`, sau đó tải lại PDP và thử `.tt4m-sticky-buy` khi thanh sticky hiện trọn vẹn; nút sticky nằm tại `y=760–804`.
- Gọi `.click()` trên phần tử thật để chạy handler website. Chặn POST `?blocksy_add_to_cart=yes` tại trình duyệt bằng `request.abort('failed')`; mỗi phép thử ghi nhận đúng một POST thêm giỏ bị chặn và `net::ERR_FAILED`. Không gửi POST thêm giỏ tới server, không giả lập thành công, không sửa JavaScript website.
- Bộ chặn an toàn không cho POST khác đi trong cửa sổ thử. Trace ghi thêm hai POST telemetry `/cdn-cgi/rum?` bị chặn ở mỗi lượt, đều sau khi checkout đã trả 302; các GET checkout/cart vẫn tới server thật. Không đồng nhất các POST telemetry này với thao tác mua.

## Bằng chứng bổ sung cho R4-01

Thời gian tính từ đầu từng phép thử:

| Quan sát | Nút PDP | Nút sticky |
|---|---:|---:|
| POST thêm giỏ bị chặn | 21ms | 10ms |
| Ghi nhận `net::ERR_FAILED` | 21ms | 11ms |
| Snapshot vẫn hiện “Đang chuyển...” và `is-loading` | 1515ms | 1510ms |
| Website phát GET `/thanh-toan/` | 4023ms | 4020ms |
| Checkout trả 302 tới `/gio-hang/` | 5344ms | 4808ms |
| Trình duyệt tới trang giỏ | 6499ms | 5921ms |
| Snapshot cuối xác nhận giỏ trống | 8102ms | 8067ms |

Ở snapshot khoảng 1,5 giây, cả nút kích hoạt và nút thêm giỏ chính vẫn mang `is-loading`; ảnh không hiện thông báo lỗi có thể xử lý, danh sách notice được đọc không có thông báo mới so với trước khi bấm. Không thấy UI phục hồi ở mốc này; sau đó website rời PDP thay vì cho khách xử lý lỗi tại chỗ. Không suy ra nút có thuộc tính HTML `disabled`: giá trị thực được ghi là `false`.

Cả hai lượt kết thúc với nội dung chính **“Giỏ Hàng — Chưa có sản phẩm nào trong giỏ hàng.”**, header **0 / 0đ**. Đây là kết quả điều hướng sau request thất bại, không phải bằng chứng server làm mất sản phẩm hoặc lỗi tính tiền.

Bằng chứng:
- [Trace và snapshot nút PDP](review-evidence/2026-09-24/r9-pdp-aborted-request.json).
- [Trace và snapshot nút sticky](review-evidence/2026-09-24/r9-sticky-aborted-request.json).
- [PDP vẫn chờ sau lỗi](review-evidence/2026-09-24/r9-pdp-failed-pending.webp) · [Giỏ cuối lượt PDP](review-evidence/2026-09-24/r9-pdp-final.webp).
- [Sticky vẫn chờ sau lỗi](review-evidence/2026-09-24/r9-sticky-failed-pending.webp) · [Giỏ cuối lượt sticky](review-evidence/2026-09-24/r9-sticky-final.webp).

## Kết luận và hướng xử lý

**R4-01 giữ OPEN / P1.** Tiêu chí xử lý request thất bại đã có bằng chứng không đạt trên cả hai nút. Không cần chờ Coder báo deploy mới để xác nhận nhánh lỗi hiện tại.

Hướng xử lý vẫn như issue gốc: chỉ điều hướng từ kết quả thêm giỏ thành công của chính lượt bấm đó, không dùng timer suy đoán thành công. Khi request lỗi, kết thúc trạng thái chờ của nút kích hoạt và nút thêm giỏ chính, giữ khách ở PDP, đưa thông báo có thể xử lý và cho phép thử lại có kiểm soát. Hủy đường điều hướng đang chờ của lượt đã lỗi; không bỏ cơ chế chống nhấp lặp.

Nghiệm thu bổ sung: lặp lại hai phép thử abort trên; sau hơn 4 giây vẫn ở PDP, không phát GET checkout, UI thoát trạng thái chờ và báo lỗi. Sau khi bỏ chặn, thử lại thành công phải tạo đúng một lượt thêm giỏ và tới checkout với đúng biến thể/số lượng/giá. **Chưa thực hiện nhánh thử lại thành công**, HTTP 4xx/5xx, timeout kéo dài hoặc giỏ đã có hàng trong R9; không ghi nhận các nhánh này là đạt.

## Bàn giao R9

- Tổng không đổi: **28 OPEN — 7 P1, 20 P2, 1 P3**; không tạo issue trùng hoặc đóng issue.
- `ASSISTANT_REPLY.md` vẫn có SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`; không có báo cáo fix mới. File chưa đổi không được dùng để kết luận website chưa đổi.
- Đã xác nhận giỏ trống sau cùng, gỡ interception và đóng Chrome riêng. Không đặt đơn, gửi lead, gọi điện/Zalo hoặc sửa code/config/database website. Các bằng chứng và lịch sử vòng trước được giữ nguyên.

---

<a id="round-r10"></a>

# Vòng R10 — Kiểm tra bàn phím có mục tiêu

Ngày kiểm tra: **24/09/2026, 12:28:59–12:30:20 UTC**. `ASSISTANT_REPLY.md` chưa đổi so với hash R9. Không có báo cáo sửa mới; vòng này bổ sung bằng chứng về hành vi đang hoạt động, không phải nghiệm thu bản sửa.

## Phạm vi và kết quả

Menu mobile đã được thử Tab trap/Escape ở R2 nên không lặp lại. Dùng Chrome riêng để kiểm tra hai bề mặt sau:

| Bề mặt | Thao tác thực tế | Kết quả |
|---|---|---|
| PDP `/san-pham/thap-nhu-dien/`, viewport 375 × 812 mô phỏng mobile | Đặt focus ban đầu vào select kích thước, nhấn ArrowDown rồi Enter | Chọn được **1m2** từ trạng thái chưa chọn; giá cập nhật **550.000đ**, nút thêm giỏ bỏ class `disabled wc-variation-selection-needed`. Không kích hoạt mua. |
| Cùng select PDP | Tab, rồi Shift+Tab | Focus đi tới link **“Xóa tùy chọn”**, sau đó quay lại select; lựa chọn/giá được giữ nguyên. Ảnh cho thấy viền focus quanh select. |
| Modal tìm kiếm trên homepage desktop 1440 × 1000 | Focus trigger **“Tìm kiếm”**, nhấn Enter | Modal mở, focus chuyển vào input. Dialog có tên **“Modal tìm kiếm”**, `role=dialog`, `aria-modal=true`. |
| Modal đang mở, truy vấn trống | 5 lần Tab và 3 lần Shift+Tab | Focus tuần hoàn giữa input, nút tìm kiếm và nút đóng; mọi mốc ghi nhận đều ở trong modal. |
| Modal đang mở | Escape | Modal đóng, focus trở về đúng trigger **“Tìm kiếm”**; `aria-modal` được bỏ khi đóng. |
| Mở lại modal từ trigger, nhập **“tháp”**, nhấn Enter | Gửi truy vấn tìm kiếm thật | Tới `/?s=th%C3%A1p`, HTTP **200**, H1 **“Kết quả tìm kiếm cho tháp”**, có kết quả **Tháp nhũ điện – Trang trí Noel**. |

Bằng chứng:
- [Trace chọn biến thể PDP](review-evidence/2026-09-24/r10-pdp-keyboard.json) · [Ảnh focus và giá sau chọn](review-evidence/2026-09-24/r10-pdp-keyboard.webp).
- [Trace focus của modal](review-evidence/2026-09-24/r10-search-keyboard.json) · [Ảnh modal](review-evidence/2026-09-24/r10-search-modal.webp).
- [Kết quả gửi truy vấn bằng Enter](review-evidence/2026-09-24/r10-search-submit.json) · [Ảnh trang kết quả](review-evidence/2026-09-24/r10-search-results.webp).

## Kết luận, giới hạn và bàn giao

- **Không phát hiện issue mới trong các thao tác đã thử.** Giữ các hành vi này khi sửa header, search hoặc template PDP; không yêu cầu thay đổi chỉ để làm khác.
- Không đóng **R2-08**: phép thử tìm kiếm này ở desktop, không chứng minh đã có lối tìm kiếm mobile/tablet. Không đóng **R2-14**: gửi truy vấn thành công không giải quyết việc kết quả sản phẩm trình bày kiểu bài viết và trộn các loại nội dung.
- Focus ban đầu được đặt bằng công cụ vào select/trigger; không tuyên bố đã kiểm tra toàn bộ hành trình Tab từ đầu trang. Chỉ thử một lựa chọn PDP, modal với truy vấn trống và một lần gửi truy vấn; chưa thử điều hướng bàn phím trong danh sách gợi ý AJAX.
- Không dùng screen reader, không đo tỷ lệ tương phản focus và không chứng nhận tuân thủ WCAG toàn site. Mẫu mobile là trình duyệt mô phỏng, không phải bàn phím ngoài trên thiết bị thật.
- Tổng vẫn **28 OPEN — 7 P1, 20 P2, 1 P3**. Không thêm giỏ, đặt đơn, gửi lead hoặc sửa website; header giỏ cuối lượt hiển thị **0 / 0đ**. Đã đóng Chrome riêng và giữ nguyên lịch sử.

---

<a id="round-r11"></a>

# Vòng R11 — Gợi ý tìm kiếm AJAX

Ngày kiểm tra: **24/09/2026, 12:33:50–12:35:52 UTC**. Chrome riêng, desktop **1440 × 1000**. `ASSISTANT_REPLY.md` chưa đổi so với hash R9; đây là kiểm tra nhánh còn thiếu của R10, không phải nghiệm thu bản sửa.

## Hành vi đã kiểm chứng

- Homepage, nhập **“tháp”** trong modal: GET `/wp-json/wp/v2/search?ct_live_search=true&type=post&subtype=any&per_page=6&search=th%C3%A1p` trả **200**; UI có **6 gợi ý và link “Xem thêm”**. Input chuyển `aria-expanded=true`; vùng `role=status`, `aria-live=polite` thông báo số kết quả và hướng dẫn dùng Tab.
- **ArrowDown/ArrowUp không chuyển focus khỏi input**, không đặt `aria-activedescendant` trong mẫu thử. Không ghi nhận hỗ trợ chọn bằng phím mũi tên.
- **Tab hoạt động:** từ input tới nút gửi, sáu gợi ý, “Xem thêm”, nút đóng, rồi trở lại input; 12 bước ghi nhận đều nằm trong modal. Vì vậy không báo lỗi không thể tới gợi ý bằng bàn phím.
- Sau khi modal ổn định, từ input dùng **Tab hai lần rồi Enter** trên gợi ý đầu: mở đúng `/san-pham/thap-nhu-dien/`, HTTP **200**, H1 **“Tháp nhũ điện – Trang trí Noel”**.
- Trên PDP, mở cùng modal và nhập `zzreviewnomatch20260924`: API trả **200 / []**, không có link gợi ý, `aria-expanded=false`; Escape đóng modal và trả focus về trigger **“Tìm kiếm”**. Vấn đề thông báo nhìn thấy được ghi riêng bên dưới.

Bằng chứng:
- [Request và DOM gợi ý](review-evidence/2026-09-24/r11-suggestions.json) · [Ảnh danh sách gợi ý](review-evidence/2026-09-24/r11-suggestions.webp).
- [Trace phím mũi tên và Tab](review-evidence/2026-09-24/r11-keyboard.json) · [Ảnh focus gợi ý](review-evidence/2026-09-24/r11-keyboard-focus.webp).
- [Kết quả mở PDP bằng Enter](review-evidence/2026-09-24/r11-open-result.json).

## [P3] R11-01 — Modal thiếu thông báo nhìn thấy khi không có gợi ý

### Location
Modal tìm kiếm desktop `#search-modal`, thử tại `/san-pham/thap-nhu-dien/`, viewport 1440 × 1000.

### Problem
Khi truy vấn không có gợi ý và API đã trả thành công, modal không hiển thị thông báo trạng thái rỗng cho người nhìn màn hình. Chuỗi **“Không có kết quả”** tồn tại trong phần tử mang class `screen-reader-text`, `aria-live=polite`, `role=status`; ảnh thực tế chỉ có ô truy vấn, nút gửi và nút đóng, không có dòng giải thích dưới ô tìm kiếm.

### Why it matters
Người nhìn màn hình không được xác nhận rằng tìm gợi ý đã hoàn tất nhưng không có mục phù hợp, nên có thể chờ hoặc nhập lại không cần thiết. Mức **P3**: không chặn gửi tìm kiếm đầy đủ, không phải API lỗi hoặc toàn bộ tìm kiếm hỏng. Thông báo dành cho công nghệ hỗ trợ đã có trong DOM; chưa kiểm thử khả năng đọc thực bằng screen reader.

### Evidence
- Nhập `zzreviewnomatch20260924`, chờ 4 giây trước khi chụp/đọc trạng thái.
- Endpoint live search trả **HTTP 200**, body **`[]`**.
- Input `aria-expanded=false`; trong modal không còn link gợi ý.
- Status DOM: `<div class="screen-reader-text" ... aria-live="polite" role="status">Không có kết quả</div>`.
- [Response và trạng thái modal](review-evidence/2026-09-24/r11-no-results.json) · [Ảnh không có thông báo nhìn thấy](review-evidence/2026-09-24/r11-no-results.webp).

### Recommended solution
Hiển thị trạng thái rỗng ngắn gọn trong modal khi request gợi ý hoàn tất thành công và danh sách rỗng, chẳng hạn **“Không có gợi ý phù hợp. Nhấn Enter để tìm kiếm đầy đủ.”** Giữ thông báo `aria-live` và focus/query hiện tại; tránh hai thông báo đọc lặp cùng nội dung. Không dùng trạng thái rỗng thay cho lỗi mạng hoặc lúc request còn đang chờ.

### Acceptance criteria
1. Với response gợi ý `200 / []`, người nhìn màn hình thấy thông báo rỗng và vẫn sửa được truy vấn/gửi bằng Enter/đóng bằng Escape.
2. Chuyển sang truy vấn có kết quả: thông báo rỗng được thay đúng trạng thái, gợi ý vẫn dùng được bằng Tab/Enter; không xuất hiện đồng thời thông báo “không có” và danh sách kết quả.
3. Giữ thông báo cho công nghệ hỗ trợ; kiểm tra không đọc lặp và không làm focus nhảy khỏi input.

### Status
**OPEN — P3.** Chỉ xác nhận thiếu phản hồi nhìn thấy ở modal desktop; không suy rộng thành lỗi trang kết quả tìm kiếm hoặc mobile.

## Bàn giao và giới hạn R11

- Thêm **một P3**, tổng **29 OPEN — 7 P1, 20 P2, 2 P3**. Không đóng R2-08/R2-14 hoặc các issue khác từ kết quả thử gợi ý.
- **Đính chính tại R12:** khuyến nghị trước đây “không thay đổi chỉ vì ArrowDown không được hỗ trợ” chưa xét đủ vai trò `combobox`/`listbox` đang khai báo. Giữ khả năng truy cập kết quả bằng bàn phím, focus trap và đóng modal; nhưng cần chọn semantics khớp hành vi: triển khai đầy đủ mẫu combobox hoặc dùng input tìm kiếm thông thường với danh sách liên kết. Xem [R12-01](#round-r12). Không chứng nhận tuân thủ ARIA/WCAG từ phép thử R11.
- Chỉ thử hai truy vấn trên desktop và một lần mở gợi ý; chưa kiểm thử screen reader, mạng lỗi, response về sai thứ tự hoặc toàn bộ truy vấn/catalog.
- Không thêm giỏ, đặt đơn, gửi lead hay sửa website. Header giỏ cuối lượt **0 / 0đ**; đã đóng Chrome riêng. Các bằng chứng và lịch sử trước được giữ nguyên.

---

<a id="round-r12"></a>

# Vòng R12 — Đối chiếu semantics combobox

Ngày đối chiếu: **24/09/2026**. Dùng DOM và trace thực thi R11, đọc trực tiếp tài liệu WAI-ARIA APG; **không chạy lại trình duyệt hoặc khẳng định trạng thái live mới trong vòng này**. `ASSISTANT_REPLY.md` vẫn giữ hash đã ghi ở R9.

## [P3] R12-01 — Gợi ý khai báo combobox/listbox nhưng chưa có tương tác tương ứng

### Location
Modal tìm kiếm desktop trên homepage, `#search-modal input[name=s]`, popup `.ct-search-results` và các liên kết gợi ý `.ct-search-item`/`.ct-search-more`; mẫu R11 ở 1440 × 1000, truy vấn **“tháp”**.

### Problem
DOM khai báo input `role=combobox`, `aria-autocomplete=list`, popup `role=listbox`, các liên kết `role=option`. Tuy nhiên, khi popup đã mở, hai lần ArrowDown vẫn để DOM focus tại input và không thiết lập `aria-activedescendant`. Các option được đi tới bằng Tab như một danh sách liên kết thông thường.

**DOM focus ở input không tự nó là lỗi**: với mẫu combobox/listbox, đó là hành vi dự kiến nếu option đang được điều hướng được biểu diễn bằng `aria-activedescendant`. Mismatch ở đây là không có chuyển trạng thái focus tới option theo mẫu đã khai báo. Tab/Enter dùng được là bằng chứng về một đường thao tác khác, không xác nhận mẫu combobox đã đúng.

### Why it matters
Vai trò ARIA công bố một loại widget nhưng bàn phím vận hành theo loại khác, làm kỳ vọng tương tác không nhất quán với semantics cung cấp cho công nghệ hỗ trợ. Giữ **P3** vì đường Tab/Enter đã mở được kết quả và chưa kiểm chứng ảnh hưởng cụ thể bằng screen reader. Không gọi đây là lỗi chặn mọi người dùng bàn phím hoặc kết luận vi phạm WCAG.

### Evidence
- [DOM R11](review-evidence/2026-09-24/r11-suggestions.json): input có `role=combobox`, `aria-autocomplete=list`, `aria-controls` trỏ tới popup `role=listbox`; có **7 phần tử `role=option`**, gồm sáu gợi ý và “Xem thêm”, không có ID trên các option trong snapshot.
- [Trace bàn phím R11](review-evidence/2026-09-24/r11-keyboard.json), lúc **12:34:20 UTC**: hai bước ArrowDown đều có `tag=INPUT`, `expanded=true`, `activeDescendant=null`. Các bước Tab sau đó đi vào các phần tử `role=option`.
- [Mở gợi ý bằng Tab/Enter](review-evidence/2026-09-24/r11-open-result.json) vẫn tới đúng PDP, HTTP 200. Kết quả tích cực này được giữ nguyên.
- [Đối chiếu máy đọc từ các bằng chứng đã lưu](review-evidence/2026-09-24/r12-combobox-semantics.json).
- Nguồn chính thức: [WAI-ARIA APG — Combobox Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/combobox/), các mục **Combobox Keyboard Interaction**, **Listbox Popup Keyboard Interaction** và **WAI-ARIA Roles, States, and Properties**. Khi popup có sẵn, Down Arrow chuyển focus vào popup; với listbox, DOM focus giữ tại combobox và `aria-activedescendant` trỏ tới option đang focus. Popup descendants không nằm trong chuỗi Tab của mẫu này.
- **Up Arrow từ input là tùy chọn trong APG**; không dùng việc phím này không hoạt động làm một lỗi độc lập. APG là hướng dẫn mẫu triển khai, không phải bằng chứng tự động kết luận vi phạm một tiêu chí WCAG.

### Recommended solution
Chọn một mô hình nhất quán thay vì giữ cách khai báo hiện tại chỉ vì Tab/Enter dùng được:

1. **Ưu tiên giải pháp đơn giản nếu đây là danh sách liên kết điều hướng:** giữ native `<input type="search">`, label và form; trình bày kết quả bằng danh sách liên kết có tên rõ, bỏ `combobox`/`listbox`/`option` cùng các thuộc tính phụ thuộc mẫu không còn phù hợp. Giữ Tab/Enter, live status, focus trap của modal và trả focus khi đóng. Không cần thêm điều hướng mũi tên chỉ để mô phỏng widget không cần thiết.
2. **Nếu chủ đích là combobox:** triển khai đầy đủ mẫu APG tại component hiện có: Down Arrow vào gợi ý, điều hướng option, ID/`aria-activedescendant` và trạng thái chọn đồng bộ, Enter kích hoạt kết quả đang chọn, Escape đóng popup phù hợp; không đưa từng option vào chuỗi Tab như danh sách liên kết thông thường. Giữ việc nhập/chỉnh sửa văn bản theo hành vi native.

Không cần viết lại toàn bộ search hoặc bỏ tìm kiếm AJAX. Sửa semantics/tương tác tại nguồn component; không dùng role/thuộc tính ARIA để mô tả hành vi chưa được triển khai.

### Acceptance criteria
1. Coder nêu rõ chọn mô hình search input + liên kết hay combobox, và DOM/accessibility tree phản ánh nhất quán lựa chọn đó.
2. Với mô hình đơn giản: kết quả được công bố là liên kết, tới được bằng Tab và mở đúng bằng Enter; không còn khai báo combobox/listbox/option không tương ứng.
3. Với combobox: khi có gợi ý, Down Arrow đặt option hoạt động hợp lệ; điều hướng, `aria-activedescendant`, trạng thái chọn và Enter khớp nhau. Kiểm tra Escape ở popup lồng trong modal và thứ tự Tab theo mẫu, không làm hỏng chỉnh sửa văn bản.
4. Trong cả hai mô hình: giữ query/focus ổn định khi kết quả cập nhật, xử lý có/không có gợi ý, và trả focus đúng khi đóng modal. Thử ít nhất một tổ hợp trình duyệt/screen reader trước khi kết luận khả năng dùng bằng công nghệ hỗ trợ.

### Status
**OPEN — P3.** Bằng chứng về mismatch với mẫu APG đã có; chưa có xác minh screen reader hoặc kết luận WCAG. Đây là vấn đề khác với thông báo rỗng nhìn thấy của R11-01.

## Bàn giao R12

- Thêm **một P3**, tổng **30 OPEN — 7 P1, 20 P2, 3 P3**. Các mốc tổng R11 và trước đó được giữ như lịch sử.
- Đã đính chính khuyến nghị R11 ngay tại chỗ và giữ bằng chứng Tab/Enter hoạt động; không biến kết quả đó thành xác nhận đầy đủ về accessibility.
- Không sửa website, tạo giao dịch, mở browser mới hoặc ghi nhận một vòng kiểm tra live mới.

---

<a id="round-r13"></a>

# Vòng R13 — Responsive 320 CSS px

Ngày kiểm tra: **24/09/2026**, số đo homepage lúc **12:45:29 UTC**, PDP sticky lúc **12:46:30 UTC**. `ASSISTANT_REPLY.md` vẫn giữ hash đã ghi ở R9.

## Phạm vi, phương pháp và phần hoạt động tốt

- Chrome riêng, viewport **320 × 812 CSS px**, DPR 1, mô phỏng mobile. Xác nhận `innerWidth=320`, `visualViewport.width=320`, `visualViewport.scale=1`; không dùng ảnh thu nhỏ từ viewport lớn.
- Homepage tại đầu trang; PDP `/san-pham/thap-nhu-dien/` sau khi chọn **1m8 / 895.000đ**, cuộn để sticky hiện và chờ layout ổn định.
- Cả hai trạng thái có document `clientWidth=scrollWidth=320`, body `scrollWidth=320`: **không phát hiện tràn ngang toàn trang** ở mẫu đo. Header homepage gồm logo, giỏ và Menu nằm trong chiều rộng viewport; nút Menu 44×44.
- Hai CTA hero cùng hàng, `y≈689,39–733,39`, cao **44px**, đều trong viewport đầu 812px. Không báo lỗi chỉ vì text/header xuống dòng ở bề rộng hẹp.
- PDP: ba nút sticky **Zalo / Thêm giỏ / Mua ngay** lần lượt rộng **50 / 103,78 / 126,22px**, cùng cao **44px**, `y=760–804`; mép phải nút cuối tại `x=308`, không cắt khỏi viewport. Floating Zalo kết thúc tại `y=728`, không che các nút sticky. Hit-test 9 điểm bên trong mỗi nút đều trả về chính nút hoặc phần tử con.
- Phép thử chỉ đo layout và hit-test; không bấm nút mua, gọi điện hoặc mở Zalo. Đây **không phải thử zoom trình duyệt 400%**, thiết bị thật hoặc chứng nhận WCAG Reflow toàn site.

Bằng chứng bố cục:
- [Số đo homepage 320px](review-evidence/2026-09-24/r13-home-320.json) · [Ảnh homepage](review-evidence/2026-09-24/r13-home-320.webp).
- [Số đo PDP sticky 320px](review-evidence/2026-09-24/r13-pdp-sticky-320.json) · [Ảnh sticky](review-evidence/2026-09-24/r13-pdp-sticky-320.webp).

## [P2] R13-01 — Nút điện thoại nổi che CTA Zalo trên homepage 320px

### Location
Homepage `/`, đầu trang tại **320 × 812 CSS px**: hero CTA **“Tư Vấn Zalo”** và `.tt4m-floating-btn.tt4m-btn-phone`. Đây là biểu hiện còn tồn đọng của **mục Coder số 8 — Floating actions**, được gán ID để theo dõi; không tạo thêm một issue riêng khác cho cùng biểu hiện.

### Problem
Nút điện thoại nổi đè lên phần bên phải CTA Zalo, che một phần nhãn. Điểm chạm trong phần CTA bị đè được định tuyến tới liên kết gọi điện, không phải liên kết Zalo mà CTA thể hiện.

### Why it matters
Vùng nhìn như thuộc CTA tư vấn có thể kích hoạt sai kênh liên hệ. Khách định nhắn Zalo nhưng chạm phía phải nút có thể mở thao tác gọi điện. Giữ **P2** vì đây là che điều khiển và sai đích tương tác ở một phần nút; phần giữa CTA vẫn tới đúng Zalo, không kết luận cả CTA không thể sử dụng hoặc đã phát sinh cuộc gọi.

### Evidence
- CTA Zalo: `x=180,95–284,80`, `y=689,39–733,39`, href `https://zalo.me/0901234567`.
- Nút điện thoại nổi: `x=262–308`, `y=692–738`, kích thước **46×46**.
- Tại tâm CTA **(232,875; 711,391)**, `elementFromPoint` thuộc liên kết **Zalo**.
- Tại **(269,220; 711,391)**, vẫn nằm trong bounding box CTA Zalo, `elementFromPoint` trả về `.tt4m-floating-btn.tt4m-btn-phone`, nhãn **“Gọi hotline tư vấn: 0901.234.567”**, href **`tel:0901234567`**.
- [Hit-test xác nhận hai đích tương tác](review-evidence/2026-09-24/r13-home-cta-occlusion.json) · [Ảnh phần nhãn bị che](review-evidence/2026-09-24/r13-home-320.webp).

### Recommended solution
Điều chỉnh floating actions theo vùng CTA thực tế trên màn hình hẹp: dành vùng bố trí không giao nhau, hoặc thu gọn/ẩn cụm nổi khi nó che CTA tương tác đang nhìn thấy. Không chỉ thay một giá trị `bottom` toàn site: PDP đã có khoảng tránh sticky hoạt động đúng, cần giữ nguyên kết quả đó. Không giải quyết bằng cách vô hiệu hóa CTA hoặc biến vùng bị che thành vùng chết.

### Acceptance criteria
1. Homepage 320×812: nhãn CTA Zalo nhìn đầy đủ; các điểm bên trong vùng bấm CTA, gồm điểm tái hiện nêu trên, trả về chính CTA hoặc phần tử con, không trả về nút điện thoại.
2. Hai CTA hero, header và floating controls vẫn tiếp cận được, không tạo tràn ngang hoặc che nhau ở trạng thái đầu trang và khi cuộn qua hero.
3. Kiểm tra regression tại 375/430px và PDP có sticky: giữ các nút mua/liên hệ nhìn thấy và không chồng lấn; không thay đổi đích `tel:`/Zalo của từng nút.

### Status
**OPEN — P2.** Mục floating chưa được nghiệm thu toàn site. Kết quả FIXED giới hạn ở PDP 375/430 của R4 vẫn hợp lệ; R13 bổ sung kết quả layout PDP 320, không tái kiểm tra giao dịch mua.

## Bàn giao R13

- Đưa biểu hiện còn tồn đọng của mục floating cũ vào danh sách issue có ID: thêm **một P2**, tổng **31 OPEN — 7 P1, 21 P2, 3 P3**. Không cộng thêm một issue nữa cho cùng mục Coder số 8.
- Không đóng issue cũ chỉ từ việc hai trang không tràn ngang. Chưa kiểm tra toàn bộ template, chiều cao màn hình, zoom hoặc mọi trạng thái cuộn.
- Không sửa website, thêm giỏ, đặt đơn, gửi lead, gọi điện hoặc nhắn Zalo. Header giỏ cuối lượt **0 / 0đ**; đã đóng Chrome riêng. Giữ lịch sử và bằng chứng các vòng trước.

---

<a id="verification-queue"></a>

## Hàng đợi kiểm chứng hữu hạn

Hàng đợi này theo dõi **phép kiểm tra**, không cộng thêm issue. Không dùng việc file Coder chưa đổi để chặn các kiểm tra độc lập còn thực hiện được. Mỗi kết quả phải liên kết bằng chứng và cập nhật ngay tại bảng này.

| Mã kiểm tra | Khoảng trống đã ghi | Trạng thái | Điều kiện/kết quả |
|---|---|---|---|
| Q-SORT-SHOP | R6 chỉ GET URL sort, chưa thao tác dropdown cửa hàng | DONE | [R14](#round-r14): dropdown tăng/giảm giá, chuyển trang 2 và đổi sort trở lại trang 1 hoạt động trong mẫu thử. |
| Q-SORT-CATEGORY | Cùng giới hạn R6 trên category Noel | DONE | [R14](#round-r14): dropdown giảm giá, URL/option và thứ tự giá giữ đúng khi bấm trang 2. |
| Q-AJAX-ORDER | R11 chưa thử response gợi ý về sai thứ tự | DONE | [R15](#round-r15): giữ response cũ HTTP 200; khi đổi query, request cũ bị hủy trước response mới. Không ghi đè kết quả mới; không khẳng định hai response đã cùng được JS nhận. |
| Q-CONTACT-CLIENT | R2-21 mới đọc rules, chưa kích hoạt lỗi form | DONE | [R16](#round-r16): form rỗng và email sai, có chặn request bảo vệ; xác nhận lỗi inline/validation native và cây accessibility. Không nghiệm thu gửi lead/server. |
| Q-BREADCRUMB | Baseline mới ghi nhận có breadcrumb trên commerce | DONE | [R17](#round-r17): đối chiếu sáu URL với schema, HTTP các URL cha, click/Enter trên mobile; không có issue breadcrumb mới đủ bằng chứng. |
| Q-REDIRECT-QUERY | Nghiệm thu redirect cũ mới thử URL không query | DONE | [R17](#round-r17): 11 GET không follow và đối chứng browser; phát hiện R17-01, không đồng nghĩa lỗi đã FIXED. |
| Q-CONVERSION-CTA | R2-04/R2-07 chủ yếu dựa href và nội dung trang đích | DONE | [R18](#round-r18): click khảo sát từ shop/category và combo từ homepage; hai issue còn OPEN, lối quay lại shop hoạt động. |
| Q-FAQ-KEYBOARD | Baseline mới ghi nhận native details | DONE | [R19](#round-r19): thử Enter/Space trên cả năm summary, giữ focus và khôi phục trạng thái trước thử; không nghiệm thu độ chính xác nội dung. |
| Q-EDITORIAL-TOC | Baseline mới ghi nhận bài viết có mục lục | DONE | [R19](#round-r19): 26 anchor/ba bài có đích duy nhất, thử ba lần nhảy mục bằng click/Enter trên mobile. |
| Q-EDITORIAL-TABLES | R19 chưa kiểm chứng cuộn ngang các bảng bài viết | DONE | [R20](#round-r20): 11 bảng × 2 viewport, 18 trạng thái overflow được vuốt tới cột cuối, 4 trạng thái vừa khung; không có issue trình bày bảng mới. |
| Q-PRODUCT-GALLERY | R5 chưa có bằng chứng tương tác gallery một/nhiều ảnh | DONE | [R21](#round-r21): hai PDP ở mobile/desktop, thumbnail/mũi tên, crop và Tab; phát hiện R21-01/R21-02, không nghiệm thu LCP. |
| Q-IMAGE-ALT-CONTEXT | Chưa có inventory ALT theo ngữ cảnh template | DONE | [R22](#round-r22): 9 trang/88 vị trí img ngoài template, AX ở 3 trang; không có lỗi thiếu ALT mới, R2-11 vẫn OPEN và có đính chính evidence. |
| Q-EDITORIAL-COMMERCE-LINKS | Reachability chưa chứng minh nhãn link khớp loại hàng | DONE | [R22](#round-r22): 32 lượt/21 đích HTTP 200, hai luồng click; thêm R22-01 và bổ sung 4 đường vào category rỗng cho R2-04. |
| Q-SKIP-LINK-FOCUS | Baseline chỉ xác nhận có skip link, chưa thử hành vi | DONE | [R23](#round-r23): 7 URL/10 trạng thái, Tab đầu tới skip link, Enter focus main, Tab tiếp theo ở trong main; giữ riêng giới hạn sidebar/landmark. |
| Q-PDP-CONTENT-TABS | Chưa kiểm chứng tương tác Mô tả/Thông số/Đánh giá | DONE | [R24](#round-r24): 2 PDP × 2 viewport, click và phím điều hướng; manual activation bằng Enter hoạt động, phát hiện R24-01 về orientation/Space. |
| Q-PDP-VARIANT-RESET-QTY | Chưa thử đổi/xóa biến thể và điều khiển số lượng sau render | DONE | [R25](#round-r25): 2 PDP × 2 viewport, 44 snapshot ổn định; tăng/giảm và min=1 đạt. Bốn ca xóa nhanh tái hiện R25-01; DONE là đã kiểm, không phải đã sửa. |
| Q-MODAL-FOCUS-LIFECYCLE | Chưa đối chiếu đầy đủ focus mở/đóng và AX giữa search/menu trên hai template | DONE | [R26](#round-r26): 4 ca/128 snapshot, 104 bước Tab/Shift+Tab, thêm 2 lượt tái hiện tự nhiên; search đạt, menu có R26-01. |
| Q-CATALOG-DELTA | Năm SKU mới xuất hiện trong khi bàn giao Git chưa đổi | DONE | [R26](#round-r26): 5 PDP + 2 category GET, 5 PDP xem ảnh và click CTA combo; cập nhật một phần R2-04, mở rộng R2-11, không nghiệm thu giao dịch/tồn kho. |
| Q-NEW-PRODUCT-DATA | R26 mới xác nhận ảnh/URL, chưa thử toàn bộ size, schema và thông số năm SKU | DONE | [R27](#round-r27): 5 PDP HTTP/schema/spec, 2 cây × 2 viewport và Tháp nhũ đối chứng; phát hiện R27-01, mở rộng R2-03/R2-06/R6-01. DONE là đã kiểm, không phải đã sửa. |
| Q-SEARCH-NEW-SKU | Search cũ mới thử “tháp nhũ”, chưa kiểm SKU/tên/intent của năm sản phẩm mới | DONE | [R28](#round-r28): 7 query HTTP, 5 luồng live→full search, 2 mobile, một lần Tab/Enter mở PDP; mở rộng R2-14, không thêm issue trùng. |
| Q-CATEGORY-REINDEX | Combo/Cây thông đã có hàng từ R26 nhưng trạng thái SEO sau chuyển đổi chưa được nghiệm thu | DONE | [R32](#round-r32): hai category trả 200, `index, follow`, self-canonical, có 3/2 sản phẩm và đã vào `product_cat-sitemap.xml`; R29-01 CLOSED. R2-06 vẫn riêng vì page sitemap còn URL noindex/redirect. |
| Q-BUSINESS-IDENTITY | Chưa tái kiểm tra NAP, chủ thể nhận tiền, Organization và author chain theo hệ thống | DONE | [R32](#round-r32): payment/schema đã có legalName/MST; Contact/About/footer mới chỉ hiện MST, privacy body chưa nêu chủ thể, claim uy tín chưa có căn cứ công khai. R2-22 giữ OPEN. |
| Q-PRIVACY-DATA-FLOWS | Chưa đối chiếu policy với form công khai, cookie/storage first visit và notice tại điểm thu thập | DONE | [R32](#round-r32): notice Contact/comment đã thêm; policy ghi `sbjs_*` tối đa 6 tháng nhưng runtime vẫn là session/30 phút theo config `lifetime=1e-5`, không có control nhìn thấy và inventory chưa đủ. R31-01 giữ OPEN. |
| Q-SOURCE-HOOKS | Mục Coder 9/10 chưa xác minh `the_title` và enqueue tại nguồn | BLOCKED | Cần source/diff tương ứng; HTML không chứng minh số lần đăng ký/chạy hook. |
| Q-B2B-HANDLER | Mục Coder 6, handler B2B non-JS chưa đủ bằng chứng | BLOCKED | Cần source hoặc staging; không gửi lead kiểm thử lên production. |
| Q-FIX-ACCEPTANCE | Nghiệm thu các issue sau sửa và regression liên quan | PARTIAL | [R32](#round-r32) kiểm 10 claim Batch 2: **1 CLOSED, 9 OPEN**. Các cải thiện đã ghi riêng; không đóng từ regex, nội dung policy, schema tự khai hoặc một đường happy-path. |

---

<a id="round-r14"></a>

# Vòng R14 — Dropdown sắp xếp và phân trang trong trình duyệt

Ngày kiểm tra: **24/09/2026, 12:56–12:58 UTC**. Chrome riêng, desktop **1440 × 1000**. Đây là phần tương tác còn thiếu đã ghi ở R6, không chỉ GET trực tiếp các URL có query.

## Thao tác và kết quả

| Bề mặt / thao tác | Kết quả thực tế |
|---|---|
| Cửa hàng `/cua-hang/`: chọn **giá thấp đến cao** trong native dropdown `select[name=orderby]` | Browser tự submit và tới `/cua-hang/?orderby=price`, HTTP 200; dropdown chọn đúng `price`, trang hiện tại 1. |
| Bấm liên kết **2** trong `.ct-pagination` | Tới `/cua-hang/page/2/?orderby=price`, HTTP 200; dropdown vẫn `price`, trang hiện tại 2. Hai trang có 16 card/trang, không giao tập ID. |
| Ngay ở trang 2, chọn **giá cao đến thấp** | Tới `/cua-hang/?orderby=price-desc`, HTTP 200; dropdown đổi đúng, trở lại trang 1 thay vì giữ trang 2. |
| Category Noel: chọn **giá cao đến thấp** | Tới `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/?orderby=price-desc`, HTTP 200; dropdown chọn đúng `price-desc`. |
| Bấm liên kết **2** của category | Tới đúng category `/page/2/?orderby=price-desc`, HTTP 200; option giảm giá được giữ. Hai trang có 16 card/trang, không giao tập ID. |

Các liên kết phân trang đã thu trong các trạng thái sort giữ đúng query `orderby`. Không bấm liên kết “Thêm giỏ”; dữ liệu `pagePathLinks` trong JSON chứa cả các href thêm giỏ dựa trên URL trang 2, còn trường `pagination` đã loại chúng để không nhầm với điều hướng trang.

## Đối chiếu thứ tự sản phẩm

- **Cửa hàng tăng giá, trang 1 + 2:** đối chiếu giá đang bán hiển thị, dùng cận dưới với sản phẩm có khoảng giá và bỏ giá gạch ngang của hàng giảm giá. Chuỗi 24 card có giá số **không giảm**, từ 1.150đ đến 65.000đ; biên hai trang là 35.000đ → 35.000đ.
- Tám card nhận báo giá trên trang 1 không có giá số hiển thị, được **loại khỏi phép so sánh số**, không gán “miễn phí/0đ”. Không kết luận thứ tự của nhóm báo giá là đúng/sai từ phép so sánh này.
- **Category giảm giá, trang 1 + 2:** dùng cận trên với khoảng giá; chuỗi 32 card **không tăng**, từ 2.250.000đ đến 255.000đ; biên hai trang là 495.000đ → 395.000đ.
- Sắp xếp theo dữ liệu đang công bố hoạt động không chứng minh nguồn giá đúng. Các giá thấp 1.150đ/1.895đ liên quan **R2-01** vẫn xuất hiện trong mẫu; không đóng R2-01 và không tự chọn giá thay thế.

Bằng chứng:
- [Các trạng thái và điều hướng cửa hàng](review-evidence/2026-09-24/r14-shop-dropdown.json) · [Ảnh dropdown giảm giá](review-evidence/2026-09-24/r14-shop-price-desc.webp).
- [Các trạng thái và điều hướng category](review-evidence/2026-09-24/r14-category-dropdown.json) · [Ảnh category trang 2](review-evidence/2026-09-24/r14-category-page-two.webp).
- [Đối chiếu thứ tự giá, ID, query và reset trang](review-evidence/2026-09-24/r14-sort-summary.json).

## Bàn giao và giới hạn

- **Không có issue sort mới trong mẫu thử**; không đổi trạng thái các issue cũ. Tổng vẫn **31 OPEN — 7 P1, 21 P2, 3 P3**.
- Đã hoàn tất Q-SORT-SHOP và Q-SORT-CATEGORY trong [hàng đợi kiểm chứng](#verification-queue). Mục độc lập tiếp theo là Q-AJAX-ORDER, không quay lại chỉ chờ hash Coder khi mục này còn thực hiện được.
- Chỉ thử sort giá và hai trang đầu; chưa thử các lựa chọn popularity/rating/date, toàn bộ sáu trang hoặc mọi category. Không dùng các placeholder ảnh trong snapshot ngay sau navigation để kết luận ảnh sản phẩm hỏng.
- Không thêm giỏ/đặt đơn/gửi lead/sửa website. Header giỏ sau các phép thử **0 / 0đ**.

---

<a id="round-r15"></a>

# Vòng R15 — Truy vấn mới khi phản hồi gợi ý cũ đang bị giữ

Ngày kiểm tra: **24/09/2026, 13:01–13:02 UTC**. Modal tìm kiếm homepage trong Chrome riêng, **1440 × 1000**.

## Phương pháp

Nhập `tháp`, dùng CDP Fetch ở **Response stage** để giữ phản hồi GET thực từ `/wp-json/wp/v2/search?...&search=th%C3%A1p` trước khi chuyển cho client. Giữ nguyên body/status/headers; không trả dữ liệu giả, không thay JavaScript website và không chủ động gọi abort. Sau đó thay nội dung ô tìm kiếm bằng `zzreviewnomatch20260924`, cho phản hồi mới đi qua, rồi thử thả phản hồi cũ.

## Dòng thời gian quan sát

Các mốc tương đối tính từ đầu phép thử:

| Mốc | Sự kiện |
|---|---|
| 494 ms | Browser gửi GET cho `tháp`. |
| 1.647 ms | Nhận và giữ response HTTP 200; body thực có **6 kết quả**. |
| 2.401 ms | Browser gửi GET cho query mới; request `tháp` đồng thời phát `requestfailed: net::ERR_ABORTED`. |
| 3.369–3.370 ms | Query mới nhận HTTP 200, body `[]`, request hoàn tất. |
| 4.485 ms | Thử tiếp tục response cũ nhận `Invalid InterceptionId`: request này đã bị hủy từ mốc 2.401 ms. Đây không phải lỗi HTTP của website. |

Trước khi thử thả phản hồi cũ, sau đó 2 giây, và sau khi gỡ interception thêm 800 ms: input vẫn là query mới, `aria-expanded=false`, danh sách option rỗng, status “Không có kết quả”. Không xuất hiện lại sáu gợi ý của `tháp`.

**Kết luận giới hạn:** kịch bản giữ phản hồi cũ cho thấy request cũ bị hủy khi chuyển truy vấn, không quan sát ghi đè kết quả mới. **Không có hai phản hồi cùng được JavaScript nhận theo thứ tự đảo ngược** trong lần thử này; chưa kết luận ứng dụng dùng request token hoặc cơ chế nội bộ nào vì chưa đọc source. Không vô hiệu hóa cơ chế hủy để tạo một lỗi không đại diện website thật.

Bằng chứng: [Trace mạng, body thực và ba snapshot DOM](review-evidence/2026-09-24/r15-ajax-response-order.json) · [Trước khi thử thả response cũ](review-evidence/2026-09-24/r15-new-query-before-old.webp) · [Sau phép thử và gỡ interception](review-evidence/2026-09-24/r15-new-query-after-old.webp).

## Bàn giao R15

- **Không có issue mới** từ phép thử này. Tổng giữ **31 OPEN — 7 P1, 21 P2, 3 P3**.
- **R11-01 vẫn OPEN:** “Không có kết quả” chỉ nằm trong `.screen-reader-text`; ảnh hiện tại vẫn không có thông báo rỗng nhìn thấy được. Việc hủy request cũ đúng không sửa lỗi thông báo này hoặc nghiệm thu R12-01.
- Ba phép kiểm tra thực thi được trong [hàng đợi](#verification-queue) đã hoàn tất với phạm vi ghi rõ. Các mục BLOCKED còn lại cần source/diff cho hook/enqueue, source hoặc staging cho B2B non-JS, và thay đổi có thể đối chiếu để nghiệm thu các issue sau sửa.
- Mẫu gồm một cặp query có kết quả → không có kết quả, không đại diện mọi chuỗi gõ nhanh/trình duyệt. Không gửi form liên hệ, đặt đơn hay liên lạc ngoài; không sửa website.
- Đã gỡ CDP interception, tháo network listeners và đóng phiên Chrome riêng. Giữ JSON/ảnh làm bằng chứng; không tạo script kiểm thử thường trực hoặc watcher.

---

<a id="round-r16"></a>

# Vòng R16 — Lỗi nhập liệu form liên hệ, không gửi lead

Ngày kiểm tra: **24/09/2026, 13:05–13:06 UTC**. Đã đọc lại `ASSISTANT_REPLY.md`: vẫn là bản giải trình 14 mục ban đầu, chưa có phản hồi cho R2–R15. Vòng này bổ sung tương tác còn thiếu của R2-21, không lặp baseline toàn website.

## Phạm vi và kết quả

Trang `/lien-he/`, form `#fluentform_1`, Chrome riêng **375 × 812 CSS px, DPR 1**. Trước mỗi lần kích hoạt submit đã bật interception chặn các method ngoài GET/HEAD/OPTIONS, `admin-ajax.php` và điều hướng main frame; không điền bộ dữ liệu hợp lệ.

| Kịch bản | Kết quả quan sát |
|---|---|
| Form rỗng → bấm nút Submit Form | Plugin hiển thị hai lỗi **This field is required** dưới Email và Nội dung, đặt `aria-invalid=true`; focus còn ở nút submit. |
| Email `review-invalid`, Nội dung rỗng → bấm submit | Chrome chặn email thiếu `@`, đưa focus về Email và hiển thị bong bóng validation native. Không quan sát chuỗi plugin “This field must contain a valid email” trong kịch bản này. |
| Kiểm tra mạng trong lượt thử hai trạng thái | Chỉ có 4 GET tải JS/CSS Blocksy; không có POST/request gửi form và không có request phải abort. Interception chỉ là lớp bảo vệ, không tạo ra các lỗi validation đã thấy. |
| Layout form mobile trong các trạng thái đo | `scrollWidth = innerWidth = 375`; screenshot cho thấy trường, lỗi và nút submit. Không suy rộng thành mọi màn hình/thiết bị. |
| Kiểm tra accessibility sau form rỗng | Hai trường có accessible name, required/invalid; lỗi có `role=alert` với live assertive. Chưa có quan hệ mô tả lỗi gắn với từng trường; xem R16-01. |

**R2-21 giữ OPEN:** giờ có bằng chứng hiển thị lỗi plugin, không chỉ chuỗi cấu hình. Không coi ngôn ngữ của bong bóng native Chrome là lỗi dịch của website; không yêu cầu vô hiệu hóa validation native để thay thông báo.

Bằng chứng: [DOM và trace mạng](review-evidence/2026-09-24/r16-contact-validation.json) · [Form rỗng](review-evidence/2026-09-24/r16-contact-empty-errors.webp) · [Email sai và bong bóng native](review-evidence/2026-09-24/r16-contact-email-errors.webp) · [DOM/cây accessibility sau lỗi](review-evidence/2026-09-24/r16-contact-accessibility.json).

## [P3] R16-01 — Thông báo lỗi form chưa được liên kết với từng trường

### Location
`https://trangtri4mua.com/lien-he/`, form `#fluentform_1`; Email `#ff_1_email` và Nội dung `#ff_1_message`.

### Problem
Sau submit rỗng, hai thông báo inline “This field is required” không có ID; hai trường không có `aria-describedby` hoặc `aria-errormessage` liên kết tới lỗi. Cây accessibility của các trường có tên/required/invalid nhưng không có description chứa thông báo lỗi.

### Why it matters
Khi quay lại một trường để sửa, người dùng công nghệ hỗ trợ chưa được cung cấp quan hệ trực tiếp tới thông báo cụ thể. Hai alert hiện dùng cùng câu chung, không nêu tên trường trong câu lỗi. **P3, không phải blocker:** label, trạng thái required/invalid và `role=alert` đã tồn tại; chưa chạy screen reader nên không khẳng định lỗi hoàn toàn im lặng, không thể gửi form hay vi phạm WCAG cụ thể.

### Evidence
- Snapshot DOM sau form rỗng: hai error node không có ID; `describedBy=null`, `errorMessage=null` trên hai trường.
- CDP Accessibility: hai textbox có `invalid=true`, `required=true`, không có description; các lỗi vẫn có live alert. Không bỏ qua cơ chế thông báo đang hoạt động này.
- [Bằng chứng accessibility R16](review-evidence/2026-09-24/r16-contact-accessibility.json).

### Recommended solution
Tại cơ chế render lỗi hiện có của Fluent Forms, cấp ID ổn định/duy nhất cho lỗi và liên kết trường bằng `aria-describedby`, bảo toàn các ID hướng dẫn đã có. Giữ label, required/invalid và cơ chế thông báo lỗi hiện hành; đồng bộ khi lỗi thay đổi hoặc biến mất. Kết hợp bản dịch rõ nghĩa theo R2-21, ví dụ “Vui lòng nhập địa chỉ email”.

Không thêm một validation engine khác, không ép mọi lần gõ đều thông báo và không tắt validation native đang chặn email sai. Tham khảo [W3C WAI — User Notification](https://www.w3.org/WAI/tutorials/forms/notifications/) về liên kết thông báo và trường.

### Acceptance criteria
1. Khi trường lỗi, quan hệ mô tả trỏ tới thông báo hiện có, ID không trùng hoặc treo; accessible name của trường vẫn giữ đúng.
2. Khi sửa/xóa lỗi, thông báo và quan hệ accessibility cập nhật đồng bộ, không đọc lại lỗi cũ hoặc mất hướng dẫn khác.
3. Kiểm tra bằng bàn phím và ít nhất một screen reader trên staging: nhận biết trường nào lỗi, quay lại trường và tiếp cận hướng dẫn sửa; không phát thông báo lặp ngoài ý muốn.
4. Form rỗng/email sai vẫn bị chặn; không regression layout mobile hoặc validation hiện có. Gửi thành công/nhận lead chỉ nghiệm thu bằng quy trình staging riêng.

### Status
OPEN

## Bàn giao R16

- Thêm **1 P3**, giữ lịch sử và status issue cũ: **32 OPEN — 7 P1, 21 P2, 4 P3**. Các P1 về giá/biến thể, nội dung an toàn, sitemap và Mua ngay vẫn ưu tiên trước polish form.
- Bổ sung Q-CONTACT-CLIENT = DONE trong hàng đợi. Chưa kiểm tra gửi form hợp lệ, email đến hộp nhận, lưu lead, validation server hoặc handler B2B non-JS; không đóng mục Coder 6.
- Không sửa code/config/database, không đặt đơn/gọi điện/nhắn Zalo. Đã tháo interception và đóng Chrome riêng; lưu 2 JSON + 2 ảnh, không tạo watcher hoặc script thường trực.

---

<a id="round-r17"></a>

# Vòng R17 — Breadcrumb và bảo toàn query khi redirect

Ngày kiểm tra: **24/09/2026**; từng GET có UTC trong evidence, đối chứng browser cuối lúc **13:14:34 UTC**. Hash `ASSISTANT_REPLY.md` vẫn `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, chưa có nội dung mới để nghiệm thu bản sửa.

Hai nhánh scout đọc-only chạy song song: breadcrumb/schema và redirect/query. Công cụ của scout không xuất HTTP/Location/UTC; reviewer chính đã bổ sung GET có metadata và browser độc lập, không dùng nội dung HTML nhận được để mặc định status 200.

## Breadcrumb: kết quả nên bảo toàn

| Mẫu | HTML / JSON-LD quan sát |
|---|---|
| `/cua-hang/` | Breadcrumb Trang chủ → Cửa Hàng; hai BreadcrumbList JSON-LD cùng cấp đường dẫn. |
| `/cua-hang/page/2/` | Breadcrumb cấp cửa hàng; canonical vẫn tự tham chiếu trang 2. Không bắt buộc thêm crumb “Trang 2” chỉ để giống URL. |
| Category Noel | HTML có cấp Trang Trí Theo Mùa; JSON-LD có một đường rút gọn và một đường cùng phân cấp HTML. |
| PDP Tháp nhũ điện | HTML có 5 cấp; JSON-LD rút gọn còn Trang chủ → Phụ Kiện Treo Cây Noel → sản phẩm. Đích cha trực tiếp và sản phẩm tương ứng. |
| Bài chọn size cây thông | Không thấy breadcrumb HTML; JSON-LD đi qua category Hướng Dẫn. Không suy segment `/noel/` là cha duy nhất hợp lệ. |
| `/lien-he/` | Không thấy breadcrumb HTML; JSON-LD Trang chủ → Liên Hệ. Không coi thiếu breadcrumb UI ở trang này tự động là lỗi. |

- Sáu URL mẫu và bốn URL cha bổ sung trả **HTTP 200** trong lần GET độc lập. Mọi dãy `position` JSON-LD đã trích liên tục từ 1; không kết luận đã qua validator hoặc đủ điều kiện/được hiển thị rich result.
- Không tạo issue chỉ vì hai BreadcrumbList, Home/Trang chủ hoặc số cấp khác nhau. Một số tên JSON còn literal HTML entity; ghi nhận nhưng chưa nâng thành lỗi hiển thị Google đã được chứng minh.
- **Mobile 375 × 812:** bấm crumb cha của PDP tới đúng “Phụ Kiện Treo Cây Noel”; tiếp tục đặt focus công cụ vào crumb Noel rồi nhấn Enter tới đúng category Noel. URL/H1/current item khớp; hai trang đích có `scrollWidth=innerWidth=375`.
- Lượt click PDP bị công cụ `waitForNavigation` timeout 30s; lần đọc kế tiếp xác nhận browser đã tới đúng category, Navigation Timing ghi responseStatus 200. Không biến timeout chờ công cụ thành lỗi website hoặc tuyên bố thời gian điều hướng đã đạt. Lượt Enter được ghi riêng; không đại diện toàn hành trình Tab hay screen reader.

Bằng chứng: [HTTP/HTML/schema sáu trang và URL cha](review-evidence/2026-09-24/r17-breadcrumb-http-schema.json) · [Đối chiếu position](review-evidence/2026-09-24/r17-breadcrumb-summary.json) · [Điều hướng PDP và giới hạn công cụ](review-evidence/2026-09-24/r17-pdp-breadcrumb-navigation.json) · [Điều hướng bằng Enter](review-evidence/2026-09-24/r17-category-breadcrumb-navigation.json) · [PDP mobile](review-evidence/2026-09-24/r17-pdp-breadcrumb-mobile.webp) · [Category mobile](review-evidence/2026-09-24/r17-category-breadcrumb-mobile.webp).

## [P2] R17-01 — Redirect URL cũ bỏ tham số sắp xếp và UTM

### Location
Alias `/shop/`, `/cart/`, `/checkout/`, `/cach-chon-size-cay-thong-noel/`, `/du-toan-chi-phi-trang-tri-noel/`; đặc biệt `/shop/?orderby=price-desc`.

### Problem
Các redirect 301 tới đúng pathname nhưng không bảo toàn query đã thử. Khi truy cập `/shop/?orderby=price-desc`, browser tới `/cua-hang/` và hiển thị sort mặc định, không phải thứ tự giá giảm dần được yêu cầu. Hai key `utm_source`/`utm_medium` bị bỏ trên cả năm alias.

### Why it matters
URL yêu cầu một thứ tự sản phẩm nhưng trang đích hiển thị thứ tự khác. [INFERENCE] Link cũ/bookmark có sort sẽ mất ngữ cảnh; mất UTM có thể làm thiếu thông tin nguồn chiến dịch ở landing nếu hệ thống đo lường dùng các key này. Chưa kiểm chứng có chiến dịch đang chạy, analytics cụ thể hoặc mất doanh thu. Đây không phải mất canonical/SEO ranking đã được đo, cũng không phải toàn bộ cửa hàng không sort được.

### Evidence
GET với `allow_redirects=False`, **13:11:45–13:11:54 UTC**:

| Alias | HTTP / Location không query | Khi thêm `?utm_source=review_audit&utm_medium=referral` |
|---|---|---|
| `/shop/` | 301 → `/cua-hang/` | 301, Location vẫn không query |
| `/cart/` | 301 → `/gio-hang/` | 301, Location vẫn không query |
| `/checkout/` | 301 → `/thanh-toan/` | 301, Location vẫn không query |
| `/cach-chon-size-cay-thong-noel/` | 301 → `/y-tuong-trang-tri/noel/cach-chon-size-cay-thong-noel/` | 301, Location vẫn không query |
| `/du-toan-chi-phi-trang-tri-noel/` | 301 → `/y-tuong-trang-tri/noel/du-toan-chi-phi-trang-tri-noel/` | 301, Location vẫn không query |

GET thứ 11: `/shop/?orderby=price-desc` trả **301**, `Location: https://trangtri4mua.com/cua-hang/`.

Đối chứng browser cùng phiên:
- Qua alias: URL cuối không query, select `menu_order`; ba ID đầu **292, 233, 275**.
- Tới trực tiếp `/cua-hang/?orderby=price-desc`: select `price-desc`; ba ID đầu **285, 177, 223**.
- Cả hai trang đích trả 200. Canonical của cả hai cùng là `/cua-hang/`; canonical bỏ query **không phải nguyên nhân làm mất lựa chọn sort**, vì URL trực tiếp vẫn hoạt động.

Bằng chứng: [11 response HTTP/Location](review-evidence/2026-09-24/r17-redirect-headers.json) · [URL, option và 16 ID hai trường hợp](review-evidence/2026-09-24/r17-sort-alias-browser.json) · [Qua alias](review-evidence/2026-09-24/r17-sort-alias.webp) · [Đích trực tiếp](review-evidence/2026-09-24/r17-sort-direct.webp).

### Recommended solution
Sửa cơ chế redirect alias hiện có để dựng URL đích cố định, bảo toàn **các key/giá trị được phép** phù hợp từng route: `orderby` hợp lệ cho shop và các key UTM dự án chấp nhận. Dùng cơ chế xử lý query/URL chuẩn, xác thực kiểu/giá trị và mã hóa đúng; giữ 301, pathname đích và canonical đã hoạt động.

Không sao chép mù toàn bộ query: không tự chuyển tiếp `add-to-cart`, nonce/token, tham số hành động/giao dịch hoặc URL redirect do client cung cấp. Không thêm một lớp redirect thứ hai, không đổi canonical sang URL UTM để chữa lỗi này.

### Acceptance criteria
1. `/shop/?orderby=price-desc` trả 301 tới đúng đích còn sort hợp lệ; browser cho option và thứ tự ID giống truy cập đích trực tiếp cùng thời điểm.
2. Năm alias giữ các UTM được chấp nhận, gồm hai key đã thử; ký tự được mã hóa đúng, không tạo vòng lặp/đổi host. Chính sách cố ý loại key phải được ghi rõ thay vì bỏ mọi query.
3. URL không query vẫn 301 đúng đích; query không được phép không kích hoạt hành động hoặc biến thành open redirect. Các phép thử tham số giao dịch/handler thực hiện trên staging, không tạo tác dụng phụ production.
4. Dropdown/phân trang hiện có, canonical sạch và hành vi checkout giỏ trống vẫn đúng. Không dùng bảng ID cố định trong báo cáo làm yêu cầu tồn kho/thứ tự sản phẩm vĩnh viễn.

### Status
OPEN

## Bàn giao R17

- Thêm **1 P2**, tổng **33 OPEN — 7 P1, 22 P2, 4 P3**. R17-01 là phần query chưa đạt của mục Coder 5; không đếm mục Coder này thêm một lần nữa. Kết quả đạt của năm redirect không query được giữ.
- Không có issue breadcrumb mới đủ bằng chứng. Không đóng R2-17, R6-01 hoặc các issue khác từ kết quả độc lập này.
- Hai mục kiểm chứng mới đã DONE trong hàng đợi; DONE của phép kiểm tra không có nghĩa issue đã FIXED. Các mục source/staging/bản sửa còn BLOCKED như trước.
- Lưu **6 JSON + 4 ảnh**; đã đóng Chrome riêng. Không sửa website, thêm giỏ, đặt đơn, gửi form hoặc liên hệ ngoài. Không cài watcher.

---

<a id="round-r18"></a>

# Vòng R18 — Kiểm chứng CTA khảo sát và combo bằng thao tác thật

Ngày kiểm tra: **24/09/2026**, các bản ghi tương tác **13:20–13:22 UTC**. Chrome riêng, mobile mô phỏng **375 × 812 CSS px, DPR 1**. `ASSISTANT_REPLY.md` vẫn có SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`; đây là tái kiểm tra issue còn tồn đọng, không phải nghiệm thu một deployment được Coder báo mới.

## R2-07 — CTA khảo sát: OPEN, bổ sung bằng chứng tương tác

Đã tìm CTA **“Khảo Sát Mặt Bằng 24h”** trong giao diện thật và bấm từ hai nguồn:

| Nguồn | Kết quả sau click |
|---|---|
| `/cua-hang/` | Homepage `/#b2b-consultation`, HTTP 200, `scrollY=0`, focus ở BODY; không có target ID/named anchor tương ứng. |
| `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/` | Cùng kết quả: homepage đầu trang, không được đưa tới khu vực tư vấn. |

- Trước click ở shop, CTA nhìn thấy được, kích thước **296 × 44 CSS px**; hit-test tại tâm trỏ đúng href. Không quy lỗi này thành nút không bấm được hoặc touch target quá nhỏ.
- Sau click, màn hình đầu hiển thị hero **“Combo Cây Thông & Phụ Kiện Trọn Gói Sẵn Sàng”**, không phải điểm khảo sát.
- Khối `.tt4m-home-b2b-box` có nội dung dự án và CTA Zalo/tel vẫn tồn tại, nhưng top khoảng **3.486px** ở `scrollY=0`, ngoài viewport 812px. Homepage chỉ có form tìm kiếm trong DOM đã thu, không có form khảo sát tại anchor.
- **Giữ hướng xử lý R2-07:** dẫn tới form/điểm tư vấn thật phù hợp lời hứa; hoặc dùng section B2B hiện có với target thật và nhãn đúng hành động. Không thêm một anchor rỗng ở đầu trang để chỉ làm selector tồn tại.
- Nghiệm thu lại **cả hai nguồn** sau sửa: điểm tư vấn nhìn thấy được, nội dung/hành động khớp nhãn và focus hợp lý. Chưa gửi form, gọi điện hoặc nhắn Zalo; không nghiệm thu dịch vụ khảo sát “24h”.

Bằng chứng: [Hai luồng điều hướng và DOM đích](review-evidence/2026-09-24/r18-survey-navigation.json) · [CTA trước click](review-evidence/2026-09-24/r18-shop-survey-before.webp) · [Sau click từ shop](review-evidence/2026-09-24/r18-shop-survey-after.webp) · [Sau click từ category](review-evidence/2026-09-24/r18-category-survey-after.webp).

## R2-04 — CTA “8+ Set Combo”: OPEN, bổ sung kết quả sau click

Từ homepage vừa tới ở luồng khảo sát, bấm **“Xem 8+ Set Combo”**:

- Browser tới `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/combo-trang-tri-noel/`, HTTP 200; H1 **“Combo Trang Trí Noel”**.
- Không có card trong `ul.products`; chip Combo ghi **0**. Khu vực rỗng hiển thị **“Đang Cập Nhật Mẫu Mã Cho Mùa Lễ Hội 2026”** và đề nghị xem category khác/nhắn Zalo.
- Meta robots là **`nofollow, noindex`**. Không đổi yêu cầu thành index danh mục rỗng; lỗi nằm ở thông điệp/đích chuyển đổi.
- Trang vẫn cung cấp các category có hàng, **“Xem tất cả sản phẩm”**, tư vấn Zalo và số điện thoại. Sau đặt focus vào “Xem tất cả sản phẩm” rồi Enter, browser về `/cua-hang/`, H1 **“Cửa Hàng”**, HTTP 200, **16 card** ở trang đầu. Giữ các lối tiếp tục này.
- Lượt chờ tự động khi quay lại shop timeout 20s; lần đọc kế tiếp xác nhận URL/DOM đã tới đúng shop. Giới hạn công cụ đã lưu và báo lại cho harness; không lấy timeout này làm issue website hoặc số đo hiệu năng. Không tuyên bố đã kiểm tra toàn bộ hành trình Tab.

**Tiêu chí R2-04 vẫn chưa đạt:** xem sản phẩm khác hoặc tự tìm tư vấn không chứng minh có “8+ set combo sẵn sàng”. Cần xuất bản combo có dữ liệu thật, hoặc đổi lời hứa và CTA thành luồng tư vấn đúng thực tế; không bịa SKU/giá/chiết khấu để đủ số lượng.

Bằng chứng: [Click CTA combo và DOM đích](review-evidence/2026-09-24/r18-combo-navigation.json) · [Khu vực rỗng và link tiếp tục](review-evidence/2026-09-24/r18-combo-empty-view.json) · [Ảnh trạng thái rỗng](review-evidence/2026-09-24/r18-combo-empty-state.webp) · [Quay lại shop và giới hạn công cụ](review-evidence/2026-09-24/r18-empty-category-recovery.json).

## Bàn giao R18

- **Không có issue mới hoặc được đóng.** Tổng giữ **33 OPEN — 7 P1, 22 P2, 4 P3**; R2-04/R2-07 giữ priority và trạng thái cũ, bổ sung bằng chứng chứ không nhân đôi issue.
- Q-CONVERSION-CTA = DONE là hoàn tất phép kiểm tra, không phải FIXED của website. Các mục cần source/staging/bản sửa vẫn giữ giới hạn trước.
- Phạm vi gồm shop, category Noel, homepage, category Combo và lối quay lại shop trên mobile mô phỏng; không nghiệm thu mọi CTA/template/thiết bị hoặc khả năng nhận lead thực tế.
- Lưu **4 JSON + 4 ảnh**; giỏ cuối phiên **0 / 0đ**, đã đóng Chrome riêng. Không sửa code/config/database, thêm giỏ, đặt đơn, gửi lead hoặc liên hệ ngoài; không tạo watcher.

---

<a id="round-r19"></a>

# Vòng R19 — FAQ và mục lục bài viết

Ngày kiểm tra: **24/09/2026, 13:25–13:28 UTC**. Chrome riêng, mobile mô phỏng **375 × 812 CSS px, DPR 1**. Hash `ASSISTANT_REPLY.md` vẫn `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`; không có giải trình sửa mới. Vòng này kiểm tra tương tác còn thiếu của baseline, không lặp toàn site.

## FAQ homepage: giữ cơ chế native đang hoạt động

- Có năm `<details class="tt4m-faq-item">` với `<summary>` tương ứng. Trạng thái đầu: mục 1 mở, mục 2–5 đóng.
- Đặt focus công cụ vào lần lượt từng summary rồi nhấn **Enter**: cả năm đổi trạng thái. Nhấn **Space**: cả năm trở về trạng thái trước thử; focus vẫn ở summary.
- DOM `innerText` tương ứng có/không có phần trả lời theo trạng thái. Ảnh câu hỏi vận chuyển xác nhận phần trả lời nhìn thấy khi mở và thu lại khi đóng.
- Trong các trạng thái đã đo, `document.scrollWidth=innerWidth=375`. Không có căn cứ yêu cầu thay native details bằng accordion JavaScript khác hoặc bắt buộc chỉ được mở một mục.
- Lần thử bằng ElementHandle của công cụ lỗi trước khi đổi trạng thái; đã đọc lại trạng thái, báo lỗi harness và chạy phép thử hợp lệ bằng DOM focus + phím thật. Không coi lỗi công cụ là lỗi website.

Bằng chứng: [Trạng thái của cả năm FAQ trước/sau Enter/Space](review-evidence/2026-09-24/r19-faq-keyboard.json) · [FAQ vận chuyển mở](review-evidence/2026-09-24/r19-faq-shipping-open.webp) · [FAQ vận chuyển đóng](review-evidence/2026-09-24/r19-faq-shipping-closed.webp).

## Mục lục: đích nội dung và điều hướng

Thu các URL bài từ hub `/y-tuong-trang-tri/`, GET ba bài HTTP 200 rồi đối chiếu từng liên kết trong `.editorial-toc`:

| Bài | Số anchor | Kết quả HTML | Phép thử browser đại diện |
|---|---:|---|---|
| Chọn size cây thông | 8 | Mỗi anchor trỏ đúng một heading, nhãn khớp heading | Click `#bang-tra-cuu-kich-thuoc` tới H2 bảng kích thước. |
| Dự toán chi phí | 11 | Mỗi anchor trỏ đúng một heading H2/H3, nhãn khớp | Focus link rồi Enter tới H3 `#goi-quan-cafe`. |
| Trang trí quán cafe | 7 | Mỗi anchor trỏ đúng một heading, nhãn khớp | Click `#4-vi-tri-trong-tam` tới H2 bốn vị trí trọng tâm. |

- **26/26 anchor** trong mẫu không thiếu hoặc trùng ID đích. Đây là kiểm tra HTML của cả 26, không phải 26 lần click trong browser.
- Ba lần thao tác đều cập nhật URL hash đúng; heading đích xuất hiện trong viewport và hit-test tại điểm đo trên heading không bị phần tử khác che.
- Vị trí top heading lần lượt khoảng **0,06px / 67,72px / 0,31px**; document không tràn ngang trong ba trạng thái đo. Đây không phải đo CLS hoặc nghiệm thu khả năng cuộn ngang các bảng trong bài.
- Không bắt buộc thêm breadcrumb/mục lục mới hoặc thay đổi layout chỉ vì một bài dùng wrapper `div`, hai bài dùng `nav`; chưa có bằng chứng lỗi tương tác từ khác biệt đó.

Bằng chứng: [Đích và nhãn của 26 anchor](review-evidence/2026-09-24/r19-post-toc-targets.json) · [Ba tương tác browser](review-evidence/2026-09-24/r19-toc-browser.json) · [Bài chọn size](review-evidence/2026-09-24/r19-toc-size.webp) · [Bài dự toán](review-evidence/2026-09-24/r19-toc-budget.webp) · [Bài cafe](review-evidence/2026-09-24/r19-toc-cafe.webp).

## Bàn giao R19

- **Không có issue mới hoặc được đóng**; giữ **33 OPEN — 7 P1, 22 P2, 4 P3**. Giữ FAQ native và mục lục đang hoạt động khi biên tập/sửa template.
- Kết quả tương tác không nghiệm thu **R2-05** (nội dung an toàn), **R2-10** (lời hứa dịch vụ không nhất quán) hoặc **R2-13** (tổng dự toán). Những issue này vẫn theo bằng chứng/tiêu chí nội dung đã ghi, không được đóng vì mở FAQ/nhảy mục thành công.
- Focus khởi đầu đặt bằng công cụ; chưa thử toàn bộ hành trình Tab, screen reader, thiết bị vật lý, zoom hoặc mọi vị trí trong bài. Không chứng nhận WCAG toàn website.
- Q-FAQ-KEYBOARD và Q-EDITORIAL-TOC đã DONE; các mục cần source/staging/bản sửa vẫn BLOCKED. Lưu **3 JSON + 5 ảnh**, đã đóng Chrome riêng; không sửa website, gửi form, thêm giỏ, đặt đơn hoặc liên hệ ngoài, không cài watcher.

---

<a id="round-r20"></a>

# Vòng R20 — Bảng bài viết trên mobile và tablet

Ngày kiểm tra: **24/09/2026**, bộ phép thử vuốt chính trong **13:34 UTC**. `ASSISTANT_REPLY.md` vẫn có SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`; không có báo cáo sửa mới. Vòng này bổ sung giới hạn về bảng đã ghi ở R19, không audit lại nội dung toàn bộ bài.

## Phạm vi và phương pháp

- Chrome riêng, thiết bị cảm ứng mô phỏng, DPR 1; viewport **375 × 812** và **768 × 1024 CSS px**.
- Ba bài: [chọn size cây thông](https://trangtri4mua.com/y-tuong-trang-tri/noel/cach-chon-size-cay-thong-noel/), [dự toán chi phí](https://trangtri4mua.com/y-tuong-trang-tri/noel/du-toan-chi-phi-trang-tri-noel/), [trang trí quán cafe](https://trangtri4mua.com/y-tuong-trang-tri/noel/trang-tri-noel-quan-cafe/).
- Đo cả table và wrapper, đưa từng bảng vào viewport rồi phát chuỗi **touchStart/touchMove/touchEnd** qua CDP để vuốt trái. Đo `scrollLeft` trước/sau, giới hạn cuộn và hình học header cột cuối. **Không gán `scrollLeft` để giả lập kết quả thành công.**
- Ở **375px**, chính `<table>` là vùng cuộn (`display:block; overflow-x:auto`); wrapper không tràn. Ở **768px**, wrapper là vùng cuộn khi cần. Chỉ đo wrapper ở mobile sẽ bỏ sót overflow thật của table; bộ evidence cuối đã đo đúng cả hai.

## Kết quả

| Bài | Số bảng | 375px | 768px |
|---|---:|---|---|
| Chọn size cây thông | 3 | Cả 3 cần cuộn; tới cuối ở `scrollLeft` **570 / 524 / 680px** | Cả 3 cần cuộn; tới cuối ở **193 / 147 / 303px** |
| Dự toán chi phí | 7 | Cả 7 cần cuộn; tới cuối ở **545 / 566 / 558 / 530 / 332 / 332 / 332px** | 4 bảng đầu cuộn tới **168 / 189 / 181 / 153px**; 3 bảng còn lại vừa khung |
| Trang trí quán cafe | 1 | Cuộn tới cuối ở **294px** | Vừa khung, không cần vuốt ngang |

- Tổng **11 bảng / 22 trạng thái viewport**: **18 trạng thái overflow** đã vuốt tới cuối, **4 trạng thái vừa khung** không bị tính thành ca vuốt thành công.
- Header cột cuối nằm đầy đủ trong biên ngang vùng cuộn ở cả 22 trạng thái cuối. Các ảnh minh họa cho thấy cột “Vị trí & Không gian phù hợp”, “Thành tiền (VNĐ)” và “Chi phí dự toán” có thể tiếp cận.
- `document.scrollWidth` bằng đúng **375/768px** tương ứng trong các trạng thái đo; không thấy bảng đẩy toàn trang tràn ngang.
- **Không có căn cứ viết lại bảng hoặc thống nhất phần tử cuộn chỉ vì hai breakpoint dùng cách khác nhau.** Giữ hành vi cuộn hiện tại khi sửa nội dung/giá.

## Bằng chứng

- [Hình học table/wrapper trước vuốt](review-evidence/2026-09-24/r20-table-layouts.json).
- [Trước/sau từng bảng, số lượt vuốt và đích cuối](review-evidence/2026-09-24/r20-table-touch.json).
- [Tổng hợp 22 trạng thái](review-evidence/2026-09-24/r20-table-summary.json).
- Chọn size: [375px trước vuốt](review-evidence/2026-09-24/r20-size-375-before.webp) · [375px tới cuối](review-evidence/2026-09-24/r20-size-375-table-0-end.webp) · [768px tới cuối](review-evidence/2026-09-24/r20-size-768-table-0-end.webp).
- Dự toán: [bảng đầu 375px](review-evidence/2026-09-24/r20-budget-375-table-0-end.webp) · [cột thành tiền gói cafe 375px](review-evidence/2026-09-24/r20-budget-375-table-5-end.webp) · [bảng đầu 768px](review-evidence/2026-09-24/r20-budget-768-table-0-end.webp).
- Cafe: [375px tới cột cuối](review-evidence/2026-09-24/r20-cafe-375-table-0-end.webp) · [768px vừa khung](review-evidence/2026-09-24/r20-cafe-768-table-0-end.webp).

## Bàn giao và giới hạn R20

- **Không có issue mới hoặc được đóng. Tổng giữ 33 OPEN — 7 P1, 22 P2, 4 P3.** Đọc được cột giá không chứng minh phép tính/giá/thông số đúng; không đóng R2-13 hoặc các issue nội dung/an toàn từ vòng này.
- Kết quả chỉ nghiệm thu khả năng tiếp cận ngang tới cột cuối trong mẫu. Chưa kiểm tra từng ô ở mọi vị trí cuộn, bàn phím/screen reader, liên kết header–cell, zoom hoặc thiết bị cảm ứng vật lý; không đóng issue floating R13-01 hoặc chứng nhận WCAG.
- Q-EDITORIAL-TABLES = DONE; các mục cần source/staging/bản sửa vẫn giữ trạng thái trước. Lưu **3 JSON + 8 ảnh**.
- Đã detach các CDP session và đóng Chrome riêng. Không sửa code/config/database, gửi lead, thêm giỏ, tạo đơn hoặc liên hệ ngoài; không cài watcher.

---

<a id="round-r21"></a>

# Vòng R21 — Gallery sản phẩm một ảnh và nhiều ảnh

Ngày kiểm tra: **24/09/2026, 13:40–13:45 UTC**. Chrome riêng: mobile mô phỏng **375 × 812**, desktop **1440 × 1000**, DPR 1. `ASSISTANT_REPLY.md` vẫn hash `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`; chưa có báo cáo sửa mới.

Hai PDP mẫu:
- [Lính chì Nutcracker](https://trangtri4mua.com/san-pham/linh-chi-nutcracker/), gallery ba ảnh.
- [Tháp nhũ điện](https://trangtri4mua.com/san-pham/thap-nhu-dien/), một ảnh làm đối chứng.

## Hành vi đã kiểm chứng và nên giữ

- Nutcracker mobile: click thumbnail 2/3 đổi active index lần lượt 1/2 và hiển thị ảnh tương ứng. Ảnh 3 tải hoàn tất khi được chọn; ảnh chưa tải khi ngoài slide không bị tính là ảnh hỏng.
- Desktop: Next đưa từ ảnh 1 sang ảnh 2; chọn thumbnail 3 rồi Previous trở lại ảnh 2. Previous ở đầu gallery không đổi ảnh, không coi đây là lỗi.
- Click ảnh chính Nutcracker không mở lightbox; cursor là `grab`, không thấy nút/link mở ảnh lớn trong gallery. Không kết luận tính năng zoom bị hỏng khi chưa có affordance hoặc cam kết rằng website cung cấp nó.
- Tháp nhũ có một ảnh, không có thumbnail/mũi tên dư thừa. Ảnh nguồn 900×1200 vốn cùng tỷ lệ 3:4, hiển thị toàn hình trong mẫu mobile/desktop sau khi tải xong. Snapshot desktop sớm có placeholder đã được chụp lại sau `complete=true`; không dùng ảnh tải dở để báo hỏng.

Bằng chứng tương tác: [Mobile đổi thumbnail](review-evidence/2026-09-24/r21-mobile-gallery.json) · [Click ảnh chính](review-evidence/2026-09-24/r21-image-click.json) · [Desktop và luồng Tab](review-evidence/2026-09-24/r21-desktop-gallery-keyboard.json) · [Chọn ảnh 3 rồi Previous](review-evidence/2026-09-24/r21-desktop-image3.json).

## [P2] R21-01 — Khung ảnh chính 3:4 cắt mất đầu/chân mẫu Nutcracker

### Location
`/san-pham/linh-chi-nutcracker/`, ảnh thứ ba trong `.woocommerce-product-gallery .flexy-items`; mobile và desktop.

### Problem
Ảnh nguồn dạng dọc có đầy đủ hai mẫu tượng, nhưng ảnh chính được ép `aspect-ratio: 3 / 4` cùng `object-fit: cover`. Khung hiển thị cắt phần trên của mẫu thứ nhất và phần dưới của mẫu thứ hai. Đây là crop ở ảnh chính, không chỉ thumbnail.

### Why it matters
Khách xem sản phẩm không thấy đầy đủ hình dáng các mẫu trong ảnh đã chọn. Không quan sát đường mở ảnh lớn qua thao tác click thông thường trong gallery để bù phần mất này. Chưa đo tác động doanh thu; không coi mọi ảnh/PDP đều bị crop sai vì ảnh đúng tỷ lệ như Tháp nhũ vẫn phù hợp.

### Evidence
- [Ảnh gốc Nutcracker 3](review-evidence/2026-09-24/r21-nutcracker-original-image3.webp): **532 × 1200**, có đầy đủ đầu và chân của cả hai mẫu; HTTP 200, SHA-256 lưu trong [metadata nguồn](review-evidence/2026-09-24/r21-original-image-metadata.json).
- Mobile: ảnh 3 đã tải hoàn tất, box **324 × 432px**, computed `object-fit: cover`, `aspect-ratio: 3 / 4`; xem [DOM](review-evidence/2026-09-24/r21-mobile-image3.json) và [ảnh hiển thị](review-evidence/2026-09-24/r21-nutcracker-mobile-image3.webp).
- Desktop: thumbnail 3 active, box khoảng **619,03 × 825,38px**; [screenshot](review-evidence/2026-09-24/r21-nutcracker-desktop-image3.webp) tái hiện crop tương tự.
- Đối chứng: [Tháp nhũ desktop](review-evidence/2026-09-24/r21-thap-single-desktop.webp) · [Tháp nhũ mobile](review-evidence/2026-09-24/r21-thap-single-mobile.webp).

### Recommended solution
Sửa chính sách fit/aspect của **ảnh chính PDP** tại component hiện có để toàn bộ ảnh sản phẩm quan trọng nằm trong khung, ví dụ `object-fit: contain` trong một khung ổn định, hoặc bố cục theo tỷ lệ nguồn có dự trữ kích thước đúng. Không áp dụng crop đồng loạt để ép mọi ảnh về 3:4.

Có thể giữ thumbnail dạng crop nếu cần nhận diện nhanh, nhưng ảnh chính phải cung cấp toàn nội dung. Không bắt buộc thêm lightbox chỉ để chữa lỗi fit; nếu đã có viewer ở cấu hình khác, kiểm tra nó riêng. Giữ `srcset`, kích thước dự trữ và chính sách tải phù hợp; không xóa kích thước khiến layout nhảy hoặc bật tải eager cho mọi ảnh.

### Acceptance criteria
1. Chọn ảnh Nutcracker 3 ở 375px và 1440px thấy đủ hai mẫu từ đầu tới chân như ảnh gốc, không kéo méo.
2. Kiểm tra ảnh vuông, ngang, dọc và Tháp nhũ 3:4; không làm crop mới hoặc méo hình ở ảnh chính.
3. Thumbnail/Previous/Next tiếp tục tới đúng ảnh; gallery không tràn trang và giữ không gian ổn định khi ảnh tải/chuyển.
4. Không đóng R5-01 chỉ từ ảnh nhìn đúng: hiệu năng tải/LCP vẫn phải kiểm tra theo tiêu chí riêng.

### Status
OPEN

## [P2] R21-02 — Control đổi ảnh gallery không tiếp cận được bằng Tab

### Location
Gallery nhiều ảnh trên `/san-pham/linh-chi-nutcracker/`; kiểm chứng bàn phím ở desktop 1440×1000.

### Problem
Previous/Next là `span`, thumbnail là `li > span`; không có native button/link, `tabindex` hoặc role điều khiển tương ứng trong gallery đã render. Các control dùng được bằng chuột nhưng không xuất hiện trong luồng Tab đã thử.

### Why it matters
Người dùng bàn phím không có lối thông thường để kích hoạt cùng chức năng đổi ảnh, dù chuột có thể chọn các mẫu ảnh khác nhau. Có `aria-label="Trượt 2"` trên span thumbnail không tự biến nó thành nút focus/Enter/Space được. Không khẳng định mọi screen reader hoặc toàn website không sử dụng được.

### Evidence
- DOM gallery không có `a`, `button` hoặc phần tử mang `tabindex`; hai mũi tên là span, ba thumbnail là li/span.
- Đặt focus vào link cuối breadcrumb ngay trước nội dung PDP, nhấn Tab: đi thẳng tới **select kích thước**, rồi **số lượng → Thêm vào giỏ hàng → Mua ngay → Zalo → Hotline → liên kết category**. Tám bước không vào gallery.
- Đối chứng pointer: thumbnail và Next/Previous đổi được active image như phần hành vi ở trên.
- [DOM control và trace tám bước Tab](review-evidence/2026-09-24/r21-desktop-gallery-keyboard.json). Chỉ Tab qua nút mua/liên hệ, không kích hoạt chúng.

### Recommended solution
Dùng control native tại gallery đang có, ví dụ `<button type="button">` cho Previous/Next và chọn thumbnail, có tên truy cập rõ, focus nhìn thấy và trạng thái ảnh đang chọn phù hợp. Nối các control này vào cùng cơ chế đổi slide hiện tại; giữ hành vi pointer.

Không chỉ thêm `tabindex` lên span rồi bỏ qua Enter/Space hoặc tên điều khiển; cũng không gắn mô hình ARIA tabs/combobox nếu không triển khai đủ hành vi tương ứng. Không viết lại cả slider khi có thể sửa đúng lớp control.

### Acceptance criteria
1. Từ breadcrumb, Tab tới được control gallery và tiếp tục thoát ra chọn kích thước; không tạo focus trap.
2. Enter/Space trên control đổi đúng ảnh như chuột; Previous/Next tại biên có trạng thái/hành vi rõ, không nhảy focus bất ngờ.
3. Tên control, focus và trạng thái ảnh chọn nhận biết được; kiểm tra thêm bằng ít nhất một screen reader, không chỉ DOM có ARIA.
4. Regression mobile pointer và desktop; PDP một ảnh như Tháp nhũ không xuất hiện control thừa hoặc làm thay đổi giỏ/biến thể ngoài ý muốn.

### Status
OPEN

## Bàn giao R21

- Thêm **2 P2**, tổng **35 OPEN — 7 P1, 24 P2, 4 P3**. Không đóng issue cũ; hai lỗi mới khác nguyên nhân với R5-01 (tải ảnh lazy), không nhân đôi lỗi LCP.
- Phạm vi chứng minh lỗi là Nutcracker; Tháp nhũ là đối chứng một ảnh. Chưa nghiệm thu mọi PDP nhiều ảnh, liên kết ảnh theo từng biến thể, pinch zoom hoặc thiết bị vật lý.
- Q-PRODUCT-GALLERY = DONE; các mục source/staging/bản sửa vẫn giữ giới hạn trước. Bằng chứng gồm **8 JSON, 6 screenshot và 1 ảnh nguồn**; [DOM ảnh đơn desktop](review-evidence/2026-09-24/r21-single-image-control.json), [DOM ảnh đơn mobile](review-evidence/2026-09-24/r21-single-image-mobile.json), [thumbnail 2 mobile](review-evidence/2026-09-24/r21-nutcracker-mobile-image2.webp), [sau click ảnh chính](review-evidence/2026-09-24/r21-mobile-image-click.webp).
- Đã đóng Chrome riêng. Không sửa website, chọn mua biến thể, thêm giỏ, đặt đơn, gửi lead hoặc liên hệ ngoài; không cài watcher.

---

<a id="round-r22"></a>

# Vòng R22 — ALT theo ngữ cảnh và liên kết thương mại trong bài tư vấn

Ngày kiểm tra: **24/09/2026, 13:50–13:57 UTC**. Hai scout chỉ đọc chia nhánh ALT và liên kết nội dung; Main tự GET lưu HTTP/timestamp, đối chiếu cây accessibility và thao tác browser trước khi chấp nhận phát hiện. Chrome desktop riêng **1440 × 1000, DPR 1**. Không thực hiện lại baseline toàn site.

`ASSISTANT_REPLY.md` vẫn 161 dòng, SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`; chưa có bàn giao sửa mới. Các giới hạn source/staging tiếp tục giữ nguyên.

## A. Inventory ảnh và tên truy cập

[Inventory HTML](review-evidence/2026-09-24/r22-html-image-inventory.json) lấy một response cho mỗi URL, tất cả HTTP 200:

| Trang | Vị trí `main img` ngoài template |
|---|---:|
| Homepage | 18 |
| Cửa hàng, trang 1 | 16 |
| Category Noel, trang 1 | 16 |
| PDP Nutcracker | 10 |
| PDP Tháp nhũ điện | 5 |
| PDP Kẹo sọc | 8 |
| Bài chọn size | 5 |
| Bài dự toán | 5 |
| Bài cafe | 5 |
| **Tổng** | **88** |

- **Không có ALT thiếu hoặc rỗng trong 88 vị trí mẫu.** Đây là số phần tử, không phải 88 ảnh nguồn khác nhau hay chứng nhận mọi ALT đúng nghĩa. Tính cả thumbnail, avatar và related-product; loại riêng **11 ảnh trong `<template>` bất hoạt**. Không gọi bản sao template là ảnh hiển thị trùng.
- [DOM và cây accessibility runtime](review-evidence/2026-09-24/r22-runtime-image-context.json) trên homepage, Nutcracker và bài chọn size xác nhận tên ảnh/tên link thực tế trong Chrome. Không tương đương kiểm thử bằng screen reader. Related-product có thể thay đổi giữa request; không yêu cầu danh sách gợi ý cố định.
- Link ảnh sản phẩm riêng trên homepage có ALT để nhận diện đích; shop/category có ALT và `aria-label` trên anchor. Không xóa tên truy cập của link chỉ vì tiêu đề sản phẩm nằm trong một anchor khác bên cạnh.
- Ảnh cùng link với tiêu đề/card text có thể dùng ALT rỗng nếu chỉ bổ trợ và tên link vẫn đủ; không bắt ALT nào cũng có keyword hoặc toàn bộ chữ trên ảnh. Áp dụng [cây quyết định ALT của W3C WAI](https://www.w3.org/WAI/tutorials/images/decision-tree/) theo ngữ cảnh, không theo bộ đếm máy móc.
- Gallery Nutcracker/Kẹo sọc có fallback ALT trong HTML; trường ALT rỗng ở dữ liệu catalog cũ không đủ kết luận HTML hiện tại thiếu ALT. Không thêm issue chỉ vì các ảnh cùng sản phẩm lặp tên.
- **R2-11 vẫn OPEN:** hero có ALT “Combo trang trí cây thông Noel trọn gói” nhưng ảnh là phụ kiện kẹo lẻ. Đã đính chính cặp giá/kích thước đọc nhầm trong evidence cũ; điều này không thay đổi kết luận ảnh/offer sai ngữ cảnh.

## B. Liên kết từ nội dung tới mua hàng

Lấy các anchor nội bộ khác trang trong `.entry-content`, gồm card/CTA và đoạn liên kết bài liên quan; không tính menu/footer, TOC cùng trang hoặc tel/Zalo.

| Bài nguồn | Lượt link | Đích duy nhất trong bài |
|---|---:|---:|
| Chọn size cây thông | 8 | 8 |
| Dự toán chi phí | 8 | 7 |
| Trang trí cafe | 16 | 13 |
| **Toàn tập, khử trùng giữa bài** | **32** | **21** |

**21 URL đích đều HTTP 200, không có redirect trong các GET này:** 13 PDP, 5 category, 3 bài. Không có query/fragment khác trang trong tập; không dùng kết quả này đóng R17-01. Sáu liên kết chéo kết nối đủ ba bài với nhau bằng URL hiện tại. Các bài đã có đường vào sản phẩm/catalogue; không kết luận nội dung hoàn toàn tách rời luồng mua hàng.

Bằng chứng: [anchor và ngữ cảnh](review-evidence/2026-09-24/r22-editorial-links.json) · [HTTP, H1, nội dung đích](review-evidence/2026-09-24/r22-editorial-destinations.json).

### Bổ sung R2-04, không cộng issue mới
- Bài chọn size: “bộ sưu tập cây thông Noel” → category Cây thông; đoạn trước hứa “thoải mái chọn lựa các mẫu cây tán đẹp, đủ size”.
- Bài cafe: “cây thông Noel”, “decal dán kính Noel”, “vòng nguyệt quế” → ba category tương ứng.
- Bốn lượt này tới **ba category 0 sản phẩm**, có `nofollow, noindex` và empty-state. Đã click link mua cây từ bài chọn size: [ngữ cảnh nguồn](review-evidence/2026-09-24/r22-size-commercial-link.webp) → [đích rỗng](review-evidence/2026-09-24/r22-tree-category-empty.webp), [trace thao tác](review-evidence/2026-09-24/r22-editorial-click.json).
- Giữ đường hồi phục đang có; sửa lời hứa/tình trạng hàng hoặc cung cấp listing thật. Không ép index category rỗng, không đổi mọi link category sang PDP.
- `waitForNavigation` timeout sau click, nhưng `observe` kế tiếp và DOM xác nhận đã tới URL đích đúng. Ghi hạn chế công cụ, không báo website điều hướng thất bại hoặc suy thời gian tải từ timeout.

## [P2] R22-01 — Card “set treo cây” dẫn tới PDP mô tả mô hình dựng cỡ lớn

### Location
Bài [Dự toán chi phí Noel](https://trangtri4mua.com/y-tuong-trang-tri/noel/du-toan-chi-phi-trang-tri-noel/), khối “Vật tư decor Noel chọn lọc sẵn kho”; `.tt4m-product-mini-name a[href="/san-pham/keo-gay-trang-tri-noel/"]`.

### Problem
Tên card là **“Set Kẹo Gậy Xoắn Treo Cây Thông”**, nhưng đích [Kẹo gậy trang trí Noel](https://trangtri4mua.com/san-pham/keo-gay-trang-tri-noel/), SKU **TT4M-074**, mô tả mô hình lớn dùng dựng cổng/sảnh/sân khấu. Hai trang không thống nhất loại hàng/công dụng và chưa làm rõ “set” gồm những gì.

### Why it matters
Người đang chọn phụ kiện treo cây nhận một lời hứa khác khi mở chi tiết, phải tự phân biệt đồ treo với mô hình dựng trước khi dự toán/mua. Đây là mâu thuẫn nội dung có thể gây nhầm lựa chọn, chưa đo tác động conversion. Không phải broken link: URL mở được đúng trang kỹ thuật.

### Evidence
- [Card thực tế](review-evidence/2026-09-24/r22-candy-editorial-card.webp); tiêu đề đầy đủ trong DOM là “Set Kẹo Gậy Xoắn Treo Cây Thông”, ảnh là `keo-gay-trang-tri-noel.webp`. Tiêu đề bị rút gọn bằng ellipsis trên screenshot nhưng DOM lưu đầy đủ.
- Main click tiêu đề card, mở PDP đúng URL. Mô tả ngắn: **“Mô hình kẹo gậy và kẹo tròn khổng lồ cao 1m2 – 2m5, dựng cổng, sảnh hay sân khấu đều hoành tráng.”**
- Mô tả dài nói “mô hình kẹo cỡ lớn dùng dựng trang trí ngoài trời, sảnh, cổng hay sân khấu” và “hàng cồng kềnh đóng kiện kỹ”. [Ảnh trang đích](review-evidence/2026-09-24/r22-candy-destination.webp) cho thấy mô hình có chân đế; [DOM trước/sau click](review-evidence/2026-09-24/r22-candy-card-click.json) lưu cả SKU và mô tả.
- Giá, term kích thước và thông số PDP vốn có vấn đề ở R2-01/R2-02/R2-03. Không tự lấy một bảng giá/kích thước làm dữ liệu chuẩn, không nhân đôi các lỗi đó trong R22-01. Bằng chứng ở đây là hai lời mô tả công dụng mâu thuẫn.

### Recommended solution
Owner xác nhận SKU và quy cách bán thật; Coder/content editor sửa card và trang đích cho thống nhất:
1. Nếu đề xuất mô hình dựng, đặt tên card đúng công dụng, làm rõ bán lẻ hay bộ và thành phần nếu gọi “set”.
2. Nếu thực sự đề xuất phụ kiện treo cây, chọn đúng SKU/link/ảnh của mặt hàng đó; không tự chuyển sang một sản phẩm “gần giống” chỉ để giữ tiêu đề.
3. Rà các card viết tay cùng khối và hai bài liên quan để tránh phóng đại tính năng. Giữ liên kết chéo/catalogue đang đúng; không cần thay toàn bộ template hoặc thêm framework.

### Acceptance criteria
1. Tên, ảnh, link và công dụng của card kẹo khớp SKU owner xác nhận; không còn “treo cây” ở card đối lập với “mô hình dựng” tại PDP.
2. Nếu giữ chữ “set”, số lượng/thành phần và đơn vị bán được giải thích nhất quán tại nơi chọn hàng.
3. Click card trên desktop/mobile mở đúng trang, còn đường tư vấn; không làm mất các liên kết bài liên quan hoặc đổi sang URL lỗi.
4. Kiểm riêng giá/kích thước/thông số theo các issue P1 đã có; sửa nhãn card không đủ đóng R2-01/R2-02/R2-03.

### Status
OPEN

## Bàn giao và giới hạn R22

- **Thêm 1 P2: tổng 36 OPEN — 7 P1, 25 P2, 4 P3.** Không đóng issue cũ. Q-IMAGE-ALT-CONTEXT và Q-EDITORIAL-COMMERCE-LINKS = DONE cho phạm vi mẫu, không đồng nghĩa lỗi đã FIXED.
- Card nai ở bài cafe dùng chữ “Phát Sáng”, trong khi phần mô tả PDP đã đọc chưa xác nhận đèn. Chưa đủ chứng cứ kết luận hàng thực không có đèn; không cộng issue riêng. Owner cần xác nhận trước khi dùng tuyên bố tính năng này trong nội dung thương mại.
- Không chứng nhận toàn bộ ALT, screen reader, schema/CWV hay tính đúng của mọi thông số sản phẩm. Chỉ thử hai luồng click không gây giao dịch; các đích còn lại được GET đọc, không giả định đều đã thao tác bằng browser.
- [Tổng hợp số mẫu/trạng thái](review-evidence/2026-09-24/r22-summary.json). Bằng chứng lưu **8 JSON + 5 screenshot + 1 ảnh nguồn**.
- Đã đóng hai phiên Chrome riêng. Không sửa code/config/database của website, gửi form, thêm giỏ, đặt đơn hoặc liên hệ ngoài; không cài watcher.

---

<a id="round-r23"></a>

# Vòng R23 — Skip link và vị trí focus bàn phím

Ngày kiểm tra: **24/09/2026, 14:02–14:04 UTC**. `ASSISTANT_REPLY.md` vẫn SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, chưa có bàn giao sửa mới.

Vòng này kiểm chứng hành vi của skip link shared header, không audit lại toàn website. Một reviewer chạy trực tiếp Chrome riêng, không chia agent cho cùng một phép thử.

## Phương pháp

- Bảy URL trên desktop **1440×1000**, thêm ba URL ở mobile mô phỏng **375×812**, DPR 1: **10 trường hợp**.
- Mỗi lượt tải lại trang, xác nhận focus ban đầu ở `BODY`, nhấn **Tab → Enter trên skip link → Tab**. Không dùng JavaScript để ép focus vào link hoặc main.
- Chỉ nhấn Enter khi phần tử active có `href="#main"`; không kích hoạt CTA mua, tel/Zalo hoặc form khi chúng nhận Tab sau đó.
- Ghi tên/rect của skip link, số đích `#main`, phần tử active trước/sau và quan hệ thuộc main. Tham chiếu cách kiểm tra [W3C Technique G1](https://www.w3.org/WAI/WCAG22/Techniques/general/G1), không coi một kỹ thuật đạt trong mẫu là chứng nhận WCAG toàn site.

## Kết quả

| URL/template | Viewport đã thử | Điểm nhận Tab ngay sau khi bỏ qua header |
|---|---|---|
| `/` | Desktop + mobile | “Xem 8+ Set Combo” trong hero |
| `/cua-hang/` | Desktop | “Trang chủ” trong breadcrumb, không phải header |
| `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/` | Desktop | “Trang chủ” trong breadcrumb |
| `/san-pham/thap-nhu-dien/` | Desktop + mobile | “Trang chủ” trong breadcrumb |
| `/y-tuong-trang-tri/noel/cach-chon-size-cay-thong-noel/` | Desktop | Link tác giả `ED4F7B` trong metadata bài |
| `/chinh-sach-bao-mat/` | Desktop + mobile | “Chính Sách Đổi Trả” trong sidebar policy |
| `/lien-he/` | Desktop | Link số hotline trong nội dung trang; không gọi |

**10/10 trường hợp:**
1. Có đúng một skip link và một đích mang ID `main`.
2. Tab đầu tiên tới **“Chuyển đến phần nội dung”**. Link hiện ở góc trên trái `x=4, y=4`, khoảng **230,8×47px**, điểm giữa hit đúng link; ảnh chụp cho thấy chữ và viền focus rõ trong các mẫu lưu ảnh.
3. Enter đổi URL sang fragment `#main` và `document.activeElement` thực sự là `MAIN#main`; không chỉ thay hash.
4. Tab kế tiếp nằm trong main, không bắt đi lại các link header.

Không đề xuất thay component đang thực hiện đúng chức năng này. Khi Coder sửa header/layout, giữ link sớm trong thứ tự bàn phím, đích ID duy nhất và khả năng nhận/chuyển focus; chạy lại chuỗi trên các template chịu ảnh hưởng.

## Giới hạn và issue cũ

- Policy vẫn có **hai `main`**, mặc dù chỉ một phần tử có ID `main`; **R2-20 vẫn OPEN**. Skip link chỉ bỏ qua header, không chứng minh landmark đã đúng.
- Policy mobile vẫn đi qua sidebar trước bài chính; **R2-15 vẫn OPEN**. Không diễn giải “Tab ở trong main” thành “đã tới ngay nội dung chính sách”.
- Breadcrumb, metadata tác giả hoặc hotline có thể là phần tử tương tác đầu tiên trong main. Không bắt mọi template phải bắt đầu bằng cùng loại control hoặc nhảy thẳng vào form.
- Focus vào CTA combo không nghiệm thu đích/offer R2-04; vào main của PDP không nghiệm thu gallery R21-02. Không đóng các issue nội dung/tương tác khác từ phép thử này.
- Chưa thử screen reader, Safari/Firefox, phóng to, thiết bị mobile vật lý hoặc toàn bộ luồng Tab qua trang. Các phép đo ngay sau phím không dùng để kết luận thời gian cuộn mượt hay hiệu năng.

## Bằng chứng và bàn giao

- [Trace đầy đủ mười lượt](review-evidence/2026-09-24/r23-skip-link-keyboard.json) · [Tổng hợp kết quả](review-evidence/2026-09-24/r23-summary.json).
- Skip link có focus: [Homepage desktop](review-evidence/2026-09-24/r23-home-desktop-focused.webp) · [Homepage mobile](review-evidence/2026-09-24/r23-home-mobile-focused.webp) · [Contact desktop](review-evidence/2026-09-24/r23-contact-desktop-focused.webp) · [PDP mobile](review-evidence/2026-09-24/r23-product-mobile-focused.webp) · [Policy mobile](review-evidence/2026-09-24/r23-policy-mobile-focused.webp).
- Lượt Tab sau: [Homepage desktop](review-evidence/2026-09-24/r23-home-desktop-after.webp) · [Homepage mobile](review-evidence/2026-09-24/r23-home-mobile-after.webp) · [Contact desktop](review-evidence/2026-09-24/r23-contact-desktop-after.webp) · [PDP mobile](review-evidence/2026-09-24/r23-product-mobile-after.webp) · [Policy mobile](review-evidence/2026-09-24/r23-policy-mobile-after.webp).
- Lưu **2 JSON + 10 screenshot**. Q-SKIP-LINK-FOCUS = DONE cho phạm vi trên; **không có issue mới/được đóng, tổng giữ 36 OPEN — 7 P1, 25 P2, 4 P3**.
- Đã đóng Chrome riêng. Không sửa website, gửi form, thêm giỏ, đặt đơn hoặc liên hệ ngoài; không cài watcher.

---

<a id="round-r24"></a>

# Vòng R24 — Điều hướng Mô tả, Thông số và Đánh giá trên PDP

Ngày kiểm tra: **24/09/2026**; timestamp từng lượt nằm trong JSON. `ASSISTANT_REPLY.md` vẫn SHA-256 `81e73edf3d0abb9f7f052fcc6009b00d77255704286a45c814fbb69a5e7d9e96`, chưa có bàn giao sửa mới.

Hai PDP: [Tháp nhũ điện](https://trangtri4mua.com/san-pham/thap-nhu-dien/) có biến thể và [Bờm kính](https://trangtri4mua.com/san-pham/bom-kinh/) sản phẩm đơn. Mỗi trang thử desktop **1440×1000** và mobile mô phỏng **375×812**, DPR 1. Chỉ thao tác điều hướng nội dung; không điền/gửi đánh giá hoặc kích hoạt nút mua/liên hệ.

## Các phần hoạt động và cần giữ

- Đây là **tabs thật**, không phải mục lục nhảy section: có `tablist`, `tab`, `tabpanel`, `aria-controls`, `aria-selected`; chỉ một panel hiển thị mỗi lần.
- Cả bốn trạng thái đều chuyển đúng panel qua click **Thông số → Đánh giá → Mô tả**. Các snapshot có đúng một tab selected và một panel hiển thị. Chiều rộng document bằng viewport trong mẫu.
- Desktop: Left/Right đổi focus, có vòng lại ở biên; Home/End tới đầu/cuối. Panel chưa đổi khi chỉ di chuyển focus vì đây là **manual activation**, không phải lỗi.
- Enter kích hoạt tab đang focus và đồng bộ panel/`aria-selected`. Mobile Up/Down đổi focus, Enter kích hoạt được.
- Thứ tự tab khác giữa hai loại PDP: Tháp nhũ là Mô tả/Thông số/Đánh giá; Bờm kính là Mô tả/Đánh giá/Thông số. Thử theo các ID thực tế, không coi khác thứ tự là lỗi nếu tên và đích đúng.
- Cây accessibility Chrome có tên cho tab và panel đang mở. Không tự yêu cầu đổi `aria-labelledby` chỉ vì nó tham chiếu ID trên phần tử bao quanh thay vì anchor; tên panel thực tế vẫn được tính đúng.

Bằng chứng: [Trace bốn trạng thái và AX](review-evidence/2026-09-24/r24-product-tabs.json) · [Tổng hợp](review-evidence/2026-09-24/r24-summary.json) · [Thông số desktop](review-evidence/2026-09-24/r24-thap-desktop-additional_information.webp) · [Thông số mobile](review-evidence/2026-09-24/r24-thap-mobile-additional_information.webp) · [Đánh giá mobile](review-evidence/2026-09-24/r24-bom-mobile-reviews.webp).

## [P3] R24-01 — Ngữ nghĩa hướng và phím kích hoạt của tabs chưa đồng bộ

### Location
`.woocommerce-tabs .wc-tabs` trên hai PDP Tháp nhũ điện và Bờm kính. Lệch orientation được xác nhận ở mobile 375px; Space không kích hoạt tab khác trong các mẫu desktop/mobile.

### Problem
1. Mobile xếp tab thành cột và xử lý phím Up/Down; Right không chuyển focus. Tuy nhiên, tablist không có `aria-orientation`, nên Chrome accessibility tree vẫn công bố **horizontal**.
2. Sau khi đổi focus sang tab chưa selected, Space không đổi panel; Enter thì đổi đúng. Mô hình manual activation hiện chỉ có một trong hai phím kích hoạt thông dụng hoạt động.

### Why it matters
Hướng được cung cấp cho công nghệ hỗ trợ không khớp bố cục/phím thực tế; người dùng dựa vào ngữ nghĩa đó có thể chọn sai phím. Space không hoạt động như kỳ vọng của tabs tạo thêm thao tác thử. Mức P3 vì click và Enter vẫn là đường sử dụng được; chưa thử thông báo bằng screen reader nên không khẳng định phần mềm cụ thể đọc sai hoặc toàn bộ nội dung không truy cập được.

### Evidence
- Tháp nhũ và Bờm kính ở 375px: `flex-direction: column`, `aria-orientation=null`; AX tablist `orientation=horizontal`. Ảnh chụp cho thấy ba tab xếp dọc.
- Tháp nhũ: focus ở Mô tả → Right không đổi → Down tới Thông số → Enter hiển thị bảng thông số → Up về Mô tả → Space vẫn giữ bảng thông số → Enter mới trở lại Mô tả.
- Bờm kính: chuỗi tương tự, Down từ Mô tả tới Đánh giá theo thứ tự thực tế. [Trace Bờm kính và AX](review-evidence/2026-09-24/r24-mobile-orientation-keys.json), [trace Tháp nhũ](review-evidence/2026-09-24/r24-thap-mobile-orientation.json).
- Trace Tháp nhũ ghi keydown thật `key=" "`, `code="Space"`, `keyCode=32` tại `role=tab`; không suy lỗi từ tên phím sai của công cụ. Trường `events` trong probe Bờm kính rỗng, không dùng nó làm bằng chứng sự kiện.
- Đối chiếu [W3C APG Tabs Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/tabs/): hướng mặc định là ngang; tabs dọc khai báo vertical, dùng Up/Down; manual activation hỗ trợ Space/Enter. Đây là căn cứ hành vi khuyến nghị, không phải tuyên bố audit toàn bộ WCAG.

### Recommended solution
Sửa tại bộ điều khiển tabs hiện có, không viết lại component:
1. Đồng bộ `aria-orientation="vertical"` khi layout/phím chuyển sang dọc, trở lại horizontal khi bố cục ngang; dùng cùng điều kiện responsive đang điều khiển layout, tránh một breakpoint độc lập dễ lệch.
2. Với Space trên tab, kích hoạt cùng đường xử lý như click/Enter và ngăn hành vi cuộn mặc định khi phù hợp. Không gắn handler toàn trang hoặc gây submit form đánh giá.
3. Giữ manual activation, nhãn panel và quy tắc một panel mở đang hoạt động; không ép tự động chuyển panel chỉ để thay đổi cách tương tác.

### Acceptance criteria
1. 375px: AX công bố vertical, Up/Down đúng thứ tự; desktop: horizontal và Left/Right đúng thứ tự. Resize qua breakpoint không để hướng ARIA cũ.
2. Di chuyển focus sang tab chưa selected rồi nhấn Space hoặc Enter đều mở đúng panel; `aria-selected` khớp panel hiển thị.
3. Hai PDP vẫn dùng được bằng click; không xuất hiện hai panel cùng mở, không kích hoạt form/mua hàng ngoài ý muốn.
4. Kiểm tra bổ sung bằng một screen reader và bàn phím; không nghiệm thu chỉ vì đã thêm attribute.

### Status
OPEN

## Giới hạn và bàn giao R24

- Thêm **1 P3**, tổng **37 OPEN — 7 P1, 25 P2, 5 P3**. Không đóng issue cũ. Bảng thông số nhìn thấy được không chứng minh dữ liệu đúng; **R2-03 vẫn OPEN**.
- Không gửi đánh giá, kiểm backend moderation hoặc gọi điện. Những bước Tab tới link `tel:` chỉ ghi focus, không nhấn Enter. Chưa nghiệm thu toàn bộ trình tự Tab, screen reader, trình duyệt khác, thiết bị thật hoặc mọi PDP.
- Lần probe đầu dùng cú pháp không hợp lệ `keyboard.press('Shift+Tab')`; đã sửa thao tác công cụ thành giữ Shift/nhấn Tab/thả Shift trước khi lấy trace hoàn chỉnh. Không quy lỗi công cụ thành lỗi website. [Probe desktop ban đầu hoàn chỉnh](review-evidence/2026-09-24/r24-initial-desktop-probe.json) được giữ riêng.
- Lưu **5 JSON + 8 screenshot**, Q-PDP-CONTENT-TABS = DONE trong phạm vi mẫu. Đã đóng Chrome riêng; không sửa code/config/database website hoặc cài watcher.
- Theo yêu cầu mới của người dùng, bàn giao báo cáo và bằng chứng qua commit/push Git; chỉ xác nhận push trong lời bàn giao sau khi remote nhận thành công.

## Bổ sung R24 — Đối chiếu bàn giao mới trong lúc đồng bộ Git

Push đầu tiên bị từ chối vì remote đã có `f1e2db8` (chuẩn hóa hai báo cáo) và `cf8a7fe` (thêm `watch_feedback.sh`). Reviewer fetch, đọc bản trả lời mới và hợp nhất lịch sử, không force push. Việc trước đó ghi “chưa có bàn giao mới” mô tả trạng thái local lúc bắt đầu R24; sau fetch đã có bản mới.

`ASSISTANT_REPLY.md` mới có tiêu đề **Implementation Report / Batch 1**, 15 mục; SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**. Không đánh đồng số thứ tự 1–15 này với 14 mục của bản cũ hoặc các ID R2/R4/... hiện hành.

| Mục trong bàn giao mới | Đối chiếu của Reviewer |
|---|---|
| 1, 3, 4, 7, 14, 15 | Giữ các kết quả đạt có giới hạn đã ghi cho layout policy, bảng, chặn double-click, hai CTA hero, touch target và footer. Không mở rộng thành bảo đảm mọi thiết bị, đơn hàng thật hoặc “không regression” toàn site. |
| 2 — Biến thể | Không nghiệm thu toàn bộ catalog từ việc Tháp nhũ đủ ba lựa chọn; R2-01/R2-02 và tiêu chí riêng vẫn OPEN. |
| 5 — Redirect | URL không query đã đạt; R17-01 mất query vẫn OPEN, không đóng từ tuyên bố 301 chung. |
| 6, 11, 12 — Handler B2B, title hook, enqueue | Vẫn thiếu source/diff để chứng minh phía server. Không gửi POST lead production để kiểm. |
| 8 — Floating | Không coi giá trị `bottom` là bằng chứng hết che phủ; R13-01 còn OPEN, giữ các mẫu PDP đã đạt riêng. |
| 9 — Bỏ marquee | Đạt trong phạm vi GET mới: homepage không có `.tt4m-marquee-strip`; public `home-sections.css` hiện không còn selector này. Chưa xác minh toàn bộ cleanup tại nguồn. |
| 10 — Đổi hero thành combo | Có đúng một H1 combo và một `section.tt4m-combo-hero`. Đây là phần bố cục đã quan sát, không chứng minh tăng AOV hoặc offer đúng; ảnh kẹo lẻ vẫn hiện, R2-04/R2-11 còn OPEN. |
| 13 — Timer 4000ms | Không đủ nghiệm thu: tăng timer không đồng nghĩa chờ thêm giỏ thành công. Giữ R4-01/R9 và tiêu chí lỗi/chậm mạng, không chấp nhận lại chỉ từ diễn giải “chốt chặn an toàn”. |

Kiểm tra homepage/public CSS ngày **24/09/2026** (GET homepage ghi lúc **14:17:54 UTC**): [HTTP, H1, selector, ảnh hero và hash CSS](review-evidence/2026-09-24/r24-remote-reply-check.json). Không có bằng chứng deploy mới xử lý các ID đang OPEN; không chạy lại baseline một cách máy móc chỉ vì tài liệu được đổi định dạng.

- Giữ bản `ASSISTANT_REPLY.md` mới và script `watch_feedback.sh` từ remote; không sửa nội dung Coder trả lời, không chạy/cài watcher và không xác nhận watcher đang hoạt động trên server.
- Giữ nguyên toàn bộ nội dung R2–R24 khi giải quyết xung đột; nhận phần chuẩn hóa lịch sử Issue 1–15 nhưng gắn nhãn rõ để không ghi đè kết luận hiện hành.
- Không đề xuất thêm khối showroom trong vòng này. Những yêu cầu bằng chứng doanh nghiệp/nội dung thật ở các trang đang có vẫn theo R2-22.
- Sau bổ sung có **6 JSON + 8 screenshot** của R24. **Tổng giữ 37 OPEN — 7 P1, 25 P2, 5 P3**; không đóng issue đang mở chỉ từ bàn giao mới.

---

<a id="round-r25"></a>

# Vòng R25 — Chuyển biến thể, xóa lựa chọn và số lượng

Ngày kiểm tra: **24/09/2026**, các lượt xác nhận **14:26–14:30 UTC**; timestamp chi tiết trong JSON. Đã fetch Git trước vòng kiểm tra và trước khi chốt; chưa có bàn giao Coder mới hơn bản Batch 1 được đối chiếu ở cuối R24. `ASSISTANT_REPLY.md` giữ SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**.

Phạm vi: [Tháp nhũ điện](https://trangtri4mua.com/san-pham/thap-nhu-dien/) có biến thể và [Bờm kính](https://trangtri4mua.com/san-pham/bom-kinh/) sản phẩm đơn; Chrome riêng, desktop **1440×1000**, mobile mô phỏng **375×812**, DPR 1. Chỉ đổi lựa chọn, xóa và thao tác số lượng; không thêm giỏ, bấm mua hoặc gửi form.

## Các phần hoạt động và cần giữ

- **Bốn ca / 44 snapshot ổn định**: trên Tháp nhũ, chọn lần lượt `1m2 → 8 → 5`, chờ ID, giá và class nút cập nhật xong trước khi đánh giá.
- Nhãn/ID/giá khớp dữ liệu đang công bố: **1m2 / 296 / 550.000₫**, **1m8 / 298 / 895.000₫**, **1m5 / 297 / 755.000₫**. Đây là kiểm đồng bộ UI, không xác nhận giá kinh doanh hoặc hợp thức hóa taxonomy dùng chung; R2-01/R2-02 giữ riêng.
- Bấm **Xóa sau khi render ổn định**: select về placeholder, ID rỗng, panel giá biến thể bị ẩn và nút thêm giỏ có lại `disabled wc-variation-selection-needed`. Giá cũ còn trong DOM của panel ẩn không phải lỗi hiển thị.
- Trên cả hai PDP và hai viewport: nút `+,+,−,−,−` cho chuỗi **1→2→3→2→1→1**; ArrowUp/ArrowDown trong input cho **1→2→1→1**. Giới hạn min=1 hoạt động trong các thao tác này.
- Không suy ra giới hạn tồn kho/max hoặc server validation từ input không khai báo `max`; các đường đó chưa được thử.

Bằng chứng: [44 snapshot](review-evidence/2026-09-24/r25-selection-quantity.json) · [Tổng hợp](review-evidence/2026-09-24/r25-summary.json) · [Chọn biến thể mobile](review-evidence/2026-09-24/r25-thap-mobile-selected.webp) · [Reset ổn định mobile](review-evidence/2026-09-24/r25-thap-mobile-reset.webp) · [Số lượng sản phẩm đơn](review-evidence/2026-09-24/r25-bom-mobile-quantity.webp).

## [P2] R25-01 — Giá biến thể cũ xuất hiện lại sau khi xóa nhanh

### Location
`form.variations_form` trên PDP Tháp nhũ điện: `#pa_kich-thuoc`, `.reset_variations`, `input.variation_id`, `.single_variation` và `.single_add_to_cart_button`. Xác nhận tại desktop 1440px và mobile mô phỏng 375px.

### Problem
Khi chọn **1m8** rồi xóa trước callback hiển thị hoàn tất, select và ID đã được xóa đúng nhưng callback cũ vẫn hiển thị lại **895.000₫**. Nút thêm giỏ đồng thời mất class `disabled wc-variation-selection-needed`, dù không còn lựa chọn hợp lệ. Trạng thái sai vẫn hiện sau khi chờ **1,2 giây**, không chỉ là một frame chuyển tiếp.

### Why it matters
Giá và vẻ ngoài trạng thái có thể mua không còn khớp lựa chọn hiện tại, gây nhầm biến thể/giá ngay trước bước thêm giỏ. Xếp **P2** vì đây là lỗi đồng bộ UI tái hiện được; chưa có bằng chứng server chấp nhận biến thể rỗng hoặc tạo sai đơn hàng, không nâng mức dựa trên giả định đó.

### Evidence
1. Chọn 1m8, xóa nhanh bằng Enter ở mobile hoặc chuột ở desktop: panel ban đầu ẩn sau reset, sau đó hiện lại 895.000₫; select/ID vẫn rỗng, nút thêm giỏ mất class chờ chọn. Timeline DOM desktop ghi reset tại khoảng 1407ms và render giá cũ tại 1711ms trong cùng lượt.
2. Lặp lại sau khi đã chọn 1m2 và reset ổn định để loại trừ việc script chưa khởi tạo: chọn 1m8, chờ 150ms rồi thao tác xóa thật. Khoảng từ `change` đến click thực tế là **205,4ms với touchscreen tap** và **184,8ms với chuột desktop**; cả hai đều tái hiện cùng trạng thái sai sau 1,2 giây.
3. [Trace bốn lần tái hiện, timing và trạng thái panel](review-evidence/2026-09-24/r25-reset-race.json); [ảnh sau chạm mobile](review-evidence/2026-09-24/r25-reset-race-mobile-touch.webp) và [ảnh desktop](review-evidence/2026-09-24/r25-reset-race-desktop-150ms.webp) cho thấy đồng thời placeholder **“Chọn một tùy chọn”**, giá **895.000₫** và nút thêm giỏ không còn mờ như đối chứng reset ổn định.
4. JS công khai đang tải `woocommerce/assets/js/frontend/add-to-cart-variation.min.js?ver=11.1.2` có `setTimeout(...,300)` đưa HTML biến thể vào panel rồi gọi `show_variation`. [URL, HTTP 200, SHA-256 và đoạn callback](review-evidence/2026-09-24/r25-public-variation-script.json). **[INFERENCE]** Timeline phù hợp với callback cũ không bị vô hiệu sau reset; cần Coder đối chiếu controller/plugin/theme tại nguồn trước khi chọn cách sửa.

### Recommended solution
1. Đảm bảo reset hoặc thay lựa chọn làm mất hiệu lực mọi công việc render của lựa chọn trước. Trước khi áp dụng kết quả chậm, kiểm tra nó vẫn thuộc lựa chọn/ID hiện tại; callback cũ không được tự mở panel hoặc bật trạng thái mua.
2. Giữ một đường điều khiển trạng thái biến thể, đồng bộ giá, ID và trạng thái CTA từ cùng lựa chọn hợp lệ. Không thêm renderer song song hoặc chỉ che giá bằng CSS.
3. Đối chiếu bản sửa upstream và integration WooCommerce/theme đang dùng; tránh sửa trực tiếp file minified của plugin sẽ bị cập nhật ghi đè. Không tăng/giảm timer để che race.

### Acceptance criteria
1. Chọn 1m8 rồi reset ngay, sau khoảng 150–250ms và sau khi render ổn định, bằng chuột/chạm/Enter: sau ít nhất 1 giây select/ID vẫn rỗng, panel giá biến thể ẩn, trạng thái cần chọn biến thể không bị callback cũ gỡ.
2. Chọn nhanh nhiều biến thể rồi reset, hoặc reset rồi chọn lại: chỉ lựa chọn cuối cùng được render; không xuất hiện giá/CTA của lựa chọn đã hủy.
3. Chọn ổn định lại ba biến thể vẫn ra đúng ID/giá công bố; các chuỗi tăng/giảm và min=1 ở sản phẩm biến thể/đơn vẫn hoạt động trên desktop/mobile.
4. Trên staging an toàn, xác nhận mọi CTA mua/thêm giỏ kiểm tra lựa chọn hợp lệ và không gửi thêm giỏ với ID rỗng. Không dùng production để tạo đơn thử.

### Status
OPEN

## Giới hạn và bàn giao R25

- Thêm **1 P2**, tổng **38 OPEN — 7 P1, 26 P2, 5 P3**. Không đóng issue cũ; chưa có thay đổi Coder để nghiệm thu sau sửa.
- [Probe ban đầu](review-evidence/2026-09-24/r25-initial-timing-probe.json) lấy snapshot quá sớm: ID cập nhật trước callback giá và thao tác số lượng cần chờ kết quả. Không dùng các snapshot này để báo lỗi “giá luôn chậm một lựa chọn” hoặc “nút +/− không hoạt động”. Đã thay bằng phép đợi trạng thái thực tế và đối chứng hoàn chỉnh.
- [Quan sát tiếp sau probe](review-evidence/2026-09-24/r25-rapid-reset-followup.json) là đầu mối của race, không phải bằng chứng duy nhất; bốn lần tái hiện và screenshot mới là cơ sở issue. Các lần probe không truy cập được global `jQuery` qua công cụ không được tính là lỗi website.
- Chỉ nghiệm thu UI trong mẫu Chrome mô phỏng, chưa kiểm thiết bị thật, trình duyệt khác, mọi PDP, nhập tay số lượng bất hợp lệ hoặc backend tồn kho. Không kết luận mua hàng thành công/thất bại từ class CSS.
- Lưu **6 JSON + 11 screenshot**; Q-PDP-VARIANT-RESET-QTY = DONE trong phạm vi đã nêu. Đã đóng Chrome riêng. Không sửa code/config/database website, không chạy watcher.
- Bàn giao báo cáo và bằng chứng bằng commit/push Git theo yêu cầu; chỉ xác nhận push trong lời bàn giao khi remote đã nhận thành công.

---

<a id="round-r26"></a>

# Vòng R26 — Focus modal và thay đổi catalog quan sát trực tiếp

Ngày kiểm tra: **24/09/2026**, timestamp từng lượt trong JSON. Đã fetch remote đầu vòng và trước khi chốt. `ASSISTANT_REPLY.md` vẫn bản Batch 1, SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**. Tuy nhiên website đã xuất hiện năm SKU mới: **không coi tài liệu chưa đổi là bằng chứng website chưa đổi**.

Phân trang/canonical của URL sort đã có bằng chứng R6/R14, nên không chạy lại baseline. Phạm vi mới: modal tìm kiếm desktop **1440×1000** và menu offcanvas mobile mô phỏng **375×812**, mỗi loại trên homepage và PDP Tháp nhũ điện; sau đó đối chiếu năm SKU mới và hai danh mục liên quan. Chỉ GET, mở/đóng giao diện, Tab/Shift+Tab/Escape, click CTA điều hướng; không mua, gửi form hoặc gọi hotline.

## Các phần hoạt động và cần giữ

- **Modal tìm kiếm, hai URL:** Enter ở trigger đưa focus vào input sau khi mở; Tab/Shift+Tab không thoát panel trong mẫu; Escape và nút đóng đều đưa focus trở lại trigger. Tab tiếp theo tiếp tục được ngoài modal.
- **Cả hai loại modal:** mở có `role="dialog"`, tên truy cập và `aria-modal="true"`; Chrome AX công bố `modal=true`. Đóng thì panel nhận lại `inert`, bỏ `aria-modal`, không còn dialog unignored trong tập AX thu được; trigger chuyển `aria-expanded` từ true về false.
- **Menu mobile:** sau Tab đầu tiên vào nút đóng, vòng Tab/Shift+Tab vẫn nằm trong menu; Escape và nút đóng vẫn đóng được. Không mở rộng lỗi focus bên dưới thành “menu không dùng được” hoặc “Escape hỏng”.
- Tổng bốn ca có **128 snapshot**, trong đó **104 bước Tab/Shift+Tab** khi panel mở. Hai lượt tái hiện menu bổ sung dùng chuỗi Tab tự nhiên, không đặt focus trigger bằng script.
- Nền không có DOM `inert`/`aria-hidden` trong mẫu, nhưng dialog đã khai báo `aria-modal=true`. Không tạo issue chỉ vì cây AX thô còn node nền hoặc thiếu một attribute cụ thể; chưa thử chế độ đọc của screen reader.

Bằng chứng: [Trace bốn ca và AX](review-evidence/2026-09-24/r26-modal-interactions.json) · [Markup ban đầu](review-evidence/2026-09-24/r26-public-markup.json) · [Modal tìm kiếm](review-evidence/2026-09-24/r26-search-home-open.webp) · [Menu mobile](review-evidence/2026-09-24/r26-offcanvas-product-open.webp) · [Tổng hợp](review-evidence/2026-09-24/r26-summary.json).

## [P3] R26-01 — Menu mobile chưa chuyển và khôi phục focus đúng vòng đời modal

### Location
`#offcanvas`, trigger `[data-toggle-panel="#offcanvas"]` và `.ct-toggle-close` trên homepage/PDP Tháp nhũ điện, viewport 375×812.

### Problem
1. Sau khi mở menu bằng Enter hoặc tap, focus vẫn ở nút **Menu bên ngoài dialog**, không tự chuyển vào panel.
2. Sau khi đã Tab vào bên trong rồi đóng bằng Escape hoặc nút đóng, focus về **`body`**, không trở lại nút Menu.
3. Tab sau khi đóng đi tới link hotline đầu trang, khiến người dùng phải đi lại một đoạn header.

### Why it matters
Người dùng bàn phím hoặc điều khiển thay thế mất vị trí thao tác khi đóng menu; focus lúc mở không khớp dialog đang được công bố là modal. Xếp **P3** vì Tab vẫn đưa vào menu, vòng focus và đường đóng vẫn hoạt động; không có bằng chứng toàn bộ navigation bị chặn hoặc screen reader cụ thể đọc sai.

### Evidence
- Hai template cho cùng kết quả ở trace chính: `keyboard open settled` và `pointer reopen settled` có `focusInside=false`; `Escape closed settled` và `close button settled` có `focusOnTrigger=false`, activeElement là BODY.
- [Tái hiện bằng Tab tự nhiên](review-evidence/2026-09-24/r26-offcanvas-focus-repro.json): Tab tới Menu → Enter → chờ **1.500ms**, focus vẫn ở trigger; Tab hai lần tới link thương hiệu trong drawer → Escape → chờ **1.500ms**, focus ở BODY; Tab tiếp theo tới hotline. Không kích hoạt link hotline.
- Phép thử ban đầu đã chờ/render ổn định 700ms; lượt 1.500ms xác nhận đây không chỉ là snapshot lấy trước khi animation xong.
- [W3C APG Dialog Modal](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/) khuyến nghị focus vào dialog khi mở và quay lại phần tử gọi khi đóng, trừ trường hợp workflow có lý do khác. Trigger ở hai trang vẫn tồn tại; không có bước điều hướng hay tác vụ mới cần chuyển focus sang nơi khác.
- Đây là lỗi vòng đời focus, **khác R2-09** về nút X trắng trên nền trắng. Không thay đổi kết quả focus trap/Escape cơ bản đã đạt trước đây.

### Recommended solution
Sửa đường điều khiển drawer hiện có: lưu trigger mở thực tế; khi panel đã hiển thị, focus vào nút đóng hoặc phần tử đầu phù hợp; khi đóng, trả focus về trigger còn tồn tại và hiển thị. Dùng cùng cơ chế cho Escape/nút đóng/backdrop, giữ vòng Tab và `inert`/ARIA hiện có. Tham khảo hành vi modal tìm kiếm đang hoạt động, không gắn thêm một focus trap toàn trang cạnh controller cũ.

### Acceptance criteria
1. Trên homepage/PDP ở mobile, mở bằng Enter hoặc tap đưa focus vào drawer sau animation; không giữ focus ở nền bị che.
2. Tab/Shift+Tab tiếp tục nằm trong drawer. Đóng bằng Escape/nút đóng/backdrop trả focus về đúng trigger; Tab tiếp tục từ vị trí đó, không khởi động lại header.
3. Mở/đóng lặp lại không giữ `inert` sai, không mất focus, không tạo hai handler cạnh tranh. Nếu trigger bị gỡ khỏi DOM, có điểm focus dự phòng phù hợp.
4. Modal tìm kiếm desktop vẫn giữ hành vi đã đạt. Kiểm bổ sung một screen reader trước khi nghiệm thu hỗ trợ AT đầy đủ.

### Status
OPEN

## Catalog mới — ghi nhận cải thiện, không nghiệm thu ảnh thay thế

Đã GET **5 PDP + 2 category**, tất cả HTTP 200, và xem năm PDP trong Chrome desktop. Năm SKU xuất hiện trên homepage có ID **381, 382, 383, 372, 377**; không coi đây là đổi tên năm SKU cũ. Dữ liệu công khai chưa đủ chứng minh tồn kho hoặc giao hàng thực tế.

| SKU / ID | Nội dung và giá đang công bố | Ảnh hiển thị đã đối chiếu |
|---|---|---|
| COMBO-GD-50 / 381 | Combo 50 món + LED + sao, 750.000₫ | [Hộp quả trầu lẻ, nhãn 95k](review-evidence/2026-09-24/r26-new-product-1.webp), không thấy toàn bộ set. |
| SET-HG-70 / 382 | Set 70 món tone đỏ–vàng, 1.250.000₫ | [Hộp quả châu cườm, nhãn 95k](review-evidence/2026-09-24/r26-new-product-2.webp), ảnh chính có quả xanh/trắng, chưa đại diện bộ đỏ–vàng 70 món. |
| COMBO-B2B-CAFE / 383 | Combo cây 2m1 + phụ kiện + hàng rào + đèn, 3.850.000₫ | [Gói hàng rào rời](review-evidence/2026-09-24/r26-new-product-3.webp); cây phía sau không phải ảnh thể hiện đầy đủ combo. |
| CT-PE-SNOW / 372 | Cây PE phủ tuyết, 850.000–2.650.000₫ | [Một cành PE cầm tay, nhãn 45k](review-evidence/2026-09-24/r26-new-product-4.webp), không phải cây đầy đủ như tên/mô tả. |
| CT-CUOC-PINE / 377 | Cây cước gắn trái thông/đầu tuyết, 750.000–1.650.000₫ | [Dây quả 1,8m, nhãn 255k](review-evidence/2026-09-24/r26-new-product-5.webp), khác loại hàng. |

- **R2-04 cải thiện một phần:** Combo hiện có **3 card**, Cây thông **2 card**, không còn rỗng. Đã bấm CTA hero “Xem 8+ Set Combo” tới danh mục ba card: [ảnh đích](review-evidence/2026-09-24/r26-combo-category-after-cta.webp), [trace browser](review-evidence/2026-09-24/r26-catalog-browser.json). Nhãn “8+” chưa được số hàng hiển thị chứng minh, nên giữ OPEN; không tạo thêm SKU không có hàng thật chỉ để khớp số.
- **R2-11 mở rộng phạm vi:** năm ảnh mới không đại diện đúng offer. Cần ảnh bộ/cây thực bán và thành phần; không chữa bằng đổi ALT hoặc che giá đồ lẻ. Các nhãn 95k/45k/255k là chữ trên ảnh, **không phải đề xuất sửa giá bán về các số đó**.
- [HTTP, canonical, robots, tên/giá/mô tả/schema và URL năm PDP/hai category](review-evidence/2026-09-24/r26-catalog-delta.json). Trường `cards` ở PDP là sản phẩm liên quan, không phải số sản phẩm trong danh mục; không dùng parser HTML đếm ảnh trong template inert thành gallery nhìn thấy.
- Chưa nghiệm thu giá nguồn, đầy đủ thành phần/tồn kho, mọi biến thể, schema mới hoặc checkout của năm SKU. Không kết luận hàng giả hay không tồn tại chỉ từ ảnh không khớp. Không đóng các issue catalog/schema khác từ việc đã có năm trang mới.

## Giới hạn và bàn giao R26

- Thêm **1 P3**, tổng **39 OPEN — 7 P1, 26 P2, 6 P3**. R2-04 và R2-11 có cập nhật hiện hành ngay trong issue gốc; giữ lịch sử các vòng trước.
- Hai nhánh scout đã được giao độc lập nhưng không có browser/CDP; Main thực hiện toàn bộ phép thử runtime. Không tính nhánh bị chặn là đã kiểm tra đạt.
- Một probe đợi focus gặp timeout; đã đọc trạng thái thực tế, lấy trace sau animation và tái hiện bằng Tab tự nhiên. Một click chọn nhầm link trong drawer ẩn đã được đổi sang CTA hero nhìn thấy; lỗi `evaluateHandle` sau điều hướng được phục hồi bằng URL/DOM và screenshot, không coi là website điều hướng thất bại.
- Ảnh SET-HG-70 đầu tiên chụp trước paint hoàn tất; đã chờ và chụp lại ảnh hiển thị. Không mở issue ảnh hỏng từ screenshot tạm thời.
- Bộ bằng chứng gồm **6 JSON + 14 screenshot**. Đã đóng các tab Chrome riêng; không sửa code/config/database website, không chạy watcher hoặc giao dịch thật.
- Báo cáo và bằng chứng được bàn giao qua commit/push; xác nhận remote nhận thành công trong lời bàn giao.

---

<a id="round-r27"></a>

# Vòng R27 — Nội dung, SEO và biến thể của năm SKU mới

Ngày kiểm tra: **24/09/2026**, timestamp từng request/lượt browser trong JSON. Đã fetch Git đầu vòng; `main` bằng `origin/main`, `ASSISTANT_REPLY.md` vẫn SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**. Vì website đã đổi mà tài liệu Coder chưa đổi, R27 kiểm trực tiếp năm PDP quan sát ở R26 thay vì chờ lời bàn giao.

Phạm vi: raw HTML/HTTP, metadata, JSON-LD, product sitemap và bảng thông số của năm SKU; chọn toàn bộ size của `CT-PE-SNOW` và `CT-CUOC-PINE` trên desktop **1440×1000** và mobile mô phỏng **375×812**; dùng Tháp nhũ điện làm đối chứng cùng component. Không bấm thêm giỏ/mua hoặc gửi request thay đổi dữ liệu.

## Các phần hoạt động và cần giữ

- Cả năm PDP trả HTTP 200, có một H1, `index, follow`, self-canonical, meta description và `og:url` khớp URL.
- Ba combo simple có một Product + một Offer; giá Offer khớp giá đang công bố: `COMBO-GD-50` 750.000₫, `SET-HG-70` 1.250.000₫, `COMBO-B2B-CAFE` 3.850.000₫. Không yêu cầu đổi simple product thành ProductGroup.
- Mô tả chi tiết `COMBO-GD-50` liệt kê **24 + 6 + 10 + 1 + 4 + 5 = 50 món**; giữ việc định lượng cụ thể này. `SET-HG-70` có mô tả nhóm thành phần nhưng chưa định lượng; không mở issue riêng khi chưa có nguồn owner xác định cơ cấu 70 món.
- Tháp nhũ đối chứng vẫn đổi đúng **296/550.000₫, 297/755.000₫, 298/895.000₫** ở hai viewport. Sau reset ổn định, panel giá ẩn; giá cũ còn trong DOM ẩn không tính là lỗi mới.

Bằng chứng: [HTTP, metadata, JSON-LD, variations và thông số](review-evidence/2026-09-24/r27-product-http.json) · [32 snapshot browser](review-evidence/2026-09-24/r27-variation-browser.json) · [tổng hợp](review-evidence/2026-09-24/r27-summary.json) · [Tháp nhũ đối chứng desktop](review-evidence/2026-09-24/r27-tt4m-089-1440-selected.webp).

## [P1] R27-01 — Mọi kích thước của hai cây thông mới đều chọn biến thể thấp nhất

### Location
- `/san-pham/cay-thong-noel-pe-phu-tuyet-cao-cap-tan-xoe-tu-nhien/` — product 372, SKU `CT-PE-SNOW`.
- `/san-pham/cay-thong-noel-cuoc-dau-tron-gan-trai-thong-rung-dau-tuyet/` — product 377, SKU `CT-CUOC-PINE`.
- Form `variations_form`, select `attribute_kich-thuoc`, hidden `variation_id` và giá biến thể.

### Problem
Mọi option size đều khớp biến thể đầu tiên vì cả bốn variation của cây PE và cả ba variation của cây cước công bố `attribute_kich-thuoc=""`. Kết quả:
- Cây PE: chọn **1m5, 1m8, 2m1 hoặc 2m4** đều ra ID **373**, giá **850.000₫**.
- Cây cước: chọn **1m5, 1m8 hoặc 2m1** đều ra ID **378**, giá **750.000₫**.

Nút thêm giỏ mất trạng thái chờ chọn và FormData chứa size người dùng chọn nhưng `variation_id` thấp nhất. Không gửi form để kiểm backend có chấp nhận tổ hợp mâu thuẫn hay không.

### Why it matters
Người dùng không thấy giá/identity tương ứng size đã chọn ngay trước CTA mua. Nếu tổ hợp được backend nhận, có rủi ro chọn sai hàng/giá; nếu bị từ chối, luồng mua thất bại. Xếp **P1** vì lỗi có trên toàn bộ lựa chọn lớn hơn ở hai sản phẩm mới và trực tiếp nằm trong conversion flow; không nâng P0 khi chưa có giao dịch sai được xác nhận.

### Evidence
1. Raw `data-product_variations`:
   - Cây PE có ID/giá **373/850000, 374/1250000, 375/1850000, 376/2650000**, nhưng attribute của cả bốn là chuỗi rỗng.
   - Cây cước có **378/750000, 379/1100000, 380/1650000**, cũng đều attribute rỗng.
2. Browser chọn tuần tự mọi option, chờ 700ms và chụp sau render: hai viewport cho cùng ID/giá đầu tiên. [Trace và FormData](review-evidence/2026-09-24/r27-variation-browser.json).
3. Ảnh: [PE chọn 2m4 vẫn 850.000₫](review-evidence/2026-09-24/r27-ct-pe-snow-375-selected.webp) · [cây cước chọn 2m1 vẫn 750.000₫](review-evidence/2026-09-24/r27-ct-cuoc-pine-1440-selected.webp).
4. Tháp nhũ dùng taxonomy attribute có value khác nhau và đổi đúng ID/giá trong cùng probe, nên không quy lỗi cho thao tác `select` hoặc cho toàn bộ controller WooCommerce.

### Recommended solution
1. Xác nhận với owner mapping size ↔ variation ↔ giá/SKU/tồn kho cho từng cây. Không mặc định thứ tự ID là dữ liệu kinh doanh đúng chỉ vì nó đang tăng dần.
2. Gán giá trị `attribute_kich-thuoc` chính xác cho từng child variation và bảo đảm parent product dùng cùng attribute/options. Không để wildcard rỗng khi các child có giá khác nhau.
3. Sau khi dữ liệu UI đúng, cập nhật schema theo R6-01 từ cùng nguồn dữ liệu đã được duyệt; không hard-code một mapping riêng trong JavaScript/schema.

### Acceptance criteria
1. Mỗi option size trên hai PDP chọn đúng một variation ID/giá đã được owner duyệt; không option nào ngoài size nhỏ nhất trả ID đầu tiên.
2. DOM giá, hidden `variation_id`, FormData attribute và trạng thái CTA cùng biểu diễn một biến thể. Reset đưa ID/attribute về rỗng và khóa trạng thái cần chọn.
3. Desktop/mobile, chọn qua lại mọi size và reset không tái diễn giá/ID cũ; R25-01 cũng không xuất hiện.
4. Trên staging, submit từng size vào cart và xác nhận line item/giá/size đúng; không tạo đơn production. Tháp nhũ và sản phẩm đơn không regression.
5. JSON-LD/Offer của từng size chỉ được nghiệm thu sau khi mapping nguồn đúng; không lấy wildcard hiện tại làm chuẩn.

### Status
OPEN

## Cập nhật issue hiện có

### R2-03 — thông số mẫu

Cả năm SKU mới dùng fallback “Khung hợp kim chống gỉ…” và xuất xứ chung. Ba combo simple còn bảo người dùng xem “tùy chọn phân loại bên trên” dù không có select; cây PE lặp hai hàng Kích thước. [Ảnh bảng combo](review-evidence/2026-09-24/r27-combo-gd-50-additional_information.webp) · [ảnh bảng cây PE](review-evidence/2026-09-24/r27-ct-pe-snow-additional_information.webp). Giữ **OPEN — P1**; yêu cầu dữ liệu từng SKU, không chỉ sửa câu chữ.

### R2-06 — sitemap

Năm PDP indexable mới vắng trong product sitemap động khi đọc lại không cache; sitemap index không có product sitemap phân mảnh khác. Giữ **OPEN — P1** và bổ sung tiêu chí mọi PDP canonical/indexable đang xuất bản phải được khám phá từ sitemap. [Bằng chứng sitemap](review-evidence/2026-09-24/r27-product-sitemap.json).

### R6-01 — schema biến thể

Hai cây mới tiếp tục Product + AggregateOffer, không ProductGroup/Offer theo size. Dữ liệu child attribute hiện còn sai nên phải sửa R27-01 trước hoặc đồng thời; không tạo schema đẹp trên mapping sai. Ba combo simple có Offer đơn phù hợp kiểu sản phẩm và cần giữ. R6-01 giữ **OPEN — P2**.

## Giới hạn và bàn giao R27

- Thêm **1 P1**, tổng **40 OPEN — 8 P1, 26 P2, 6 P3**. Không đóng issue cũ.
- Không xác nhận tồn kho, nguồn gốc, chất liệu, thành phần hoặc giá kinh doanh là thật; chỉ đối chiếu tính nhất quán dữ liệu công bố. Không dùng ba Offer simple parse được để hứa rich result; chưa chạy Rich Results Test, GSC hoặc Merchant Center.
- Không mở issue riêng cho `SET-HG-70` chưa định lượng từng nhóm vì thiếu nguồn owner về cơ cấu đúng. Ảnh/nội dung sản phẩm vẫn theo R2-11.
- Không thêm giỏ, mua hàng hoặc gửi lead. Rủi ro backend của R27-01 là điều cần staging xác minh, không phải kết quả đã quan sát trên production.
- Bộ bằng chứng gồm **5 JSON + 9 screenshot**. Đã đóng Chrome riêng; không sửa code/config/database website hoặc chạy watcher.
- Báo cáo và bằng chứng được bàn giao qua commit/push; chỉ xác nhận thành công sau khi remote nhận commit.

---

<a id="round-r28"></a>

# Vòng R28 — Khả năng tìm thấy sản phẩm mới

Ngày kiểm tra: **24/09/2026**, timestamp từng lượt trong JSON. Đầu vòng `main` bằng `origin/main`; `ASSISTANT_REPLY.md` vẫn SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**. Không có bàn giao Coder mới để nghiệm thu.

Mẫu hữu hạn gồm bảy query:
- Exact SKU: `COMBO-GD-50`, `SET-HG-70`, `CT-PE-SNOW`.
- Tên/thuộc tính: `cây thông phủ tuyết`, `combo 50 món`.
- Intent hỗn hợp/kiến thức: `trang trí quán cafe`, `cách chọn size cây thông`.

Đã gọi read-only live search API và full search cho cả bảy; thao tác modal → full search cho năm query ở desktop **1440×1000**; đọc hai full search ở mobile mô phỏng **375×812**; mở một live result bằng Tab/Enter. Không bấm CTA thương mại hoặc thêm giỏ.

## Kết quả hoạt động và cần giữ

- Tìm theo tên hoạt động: cây PE và combo 50 món đứng đầu live/full result. `cây thông phủ tuyết` có sáu gợi ý + “Xem thêm”; `combo 50 món` có bốn gợi ý.
- Tab từ input → nút tìm → gợi ý đầu, Enter mở đúng URL/H1/SKU `CT-PE-SNOW`. [Trace](review-evidence/2026-09-24/r28-open-live-result.json) · [ảnh đích](review-evidence/2026-09-24/r28-live-result-opened.webp).
- Intent kiến thức: “cách chọn size cây thông” xếp ba bài cẩm nang trước product/page. Intent quán cafe đưa bài hướng dẫn đầu, combo B2B thứ hai, bài dự toán thứ ba. Đây là kết quả hữu ích; không yêu cầu đổi thành product-only.
- Full search tiếp tục `noindex`; trạng thái rỗng toàn trang có thông báo nhìn thấy và ô thử lại. Hai mẫu mobile có `documentWidth=viewportWidth=375`, không overflow ngang.
- Không mở issue mới cho semantics/empty state modal: exact SKU rỗng vẫn tái hiện phạm vi R11-01; live options vẫn dùng đường Tab/Enter đã biết trong R12-01. Không chạy lại ArrowDown nên không tuyên bố R12-01 thay đổi.

## R2-14 — bổ sung bằng chứng hiện hành

### Exact SKU không tìm thấy

Ba mã đang in trên PDP đều không được live/full search tìm thấy:

| Query | Live API | Full search |
|---|---:|---:|
| `COMBO-GD-50` | 200, 0 kết quả | HTTP 200, 0 article |
| `SET-HG-70` | 200, 0 kết quả | HTTP 200, 0 article |
| `CT-PE-SNOW` | 200, 0 kết quả | HTTP 200, 0 article |

[HTTP/API và DOM parse](review-evidence/2026-09-24/r28-search-http.json) · [modal SKU không gợi ý](review-evidence/2026-09-24/r28-sku-tree-modal.webp) · [full search mobile rỗng](review-evidence/2026-09-24/r28-sku-tree-mobile-page.webp).

Không yêu cầu fuzzy search cho mọi mã nhập sai; tiêu chí là exact SKU đang công bố phải tìm được đúng sản phẩm. Đây là phần acceptance R2-14 chưa đạt, không phải issue mới.

### Product card vẫn là card bài viết

Các query tên/intent tìm thấy product, nhưng mỗi card chỉ có category, title, ảnh, excerpt và ngày. DOM không có `.price`, nút/link “xem/chọn mẫu” hoặc hành động thương mại. [Desktop query tên cây](review-evidence/2026-09-24/r28-name-tree-page.webp) · [mobile cùng query](review-evidence/2026-09-24/r28-name-tree-mobile-page.webp).

Không bắt live suggestion ngắn phải chứa giá; yêu cầu giá/action áp dụng cho full search nơi người dùng đang so sánh kết quả. Ảnh sai loại hàng vẫn thuộc R2-11, không nhân đôi trong search.

### Status

**R2-14 giữ OPEN — P2.** Không có issue mới trong R28.

## Giới hạn và bàn giao R28

- Tổng giữ **40 OPEN — 8 P1, 26 P2, 6 P3**. Không đóng issue cũ.
- Bảy query không đại diện toàn bộ relevance/catalog. Không kiểm typo, không dấu, từ đồng nghĩa, tải lớn, lỗi mạng hoặc screen reader.
- Không kiểm trigger search mobile vì việc thiếu search ở mobile đã là R2-08; R28 chỉ đọc trực tiếp full search mobile, không dùng URL trực tiếp để tuyên bố trigger tồn tại.
- Không coi live suggestion thiếu giá là lỗi riêng. Không thêm giỏ/mua hàng hoặc gửi form ngoài GET search.
- Bộ bằng chứng gồm **5 JSON + 13 screenshot**. Đã đóng Chrome riêng; không sửa code/config/database website hoặc chạy watcher.
- Báo cáo và bằng chứng được bàn giao qua commit/push; chỉ xác nhận thành công sau khi remote nhận commit.

---

<a id="round-r29"></a>

# Vòng R29 — Indexability category mới có hàng

Ngày kiểm tra: **24/09/2026**, timestamp chi tiết trong JSON. Đầu vòng `main` bằng `origin/main`; `ASSISTANT_REPLY.md` vẫn SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**, không có bàn giao Coder mới.

## Phạm vi và phương pháp

- Hai category từng rỗng nhưng R26 đã ghi nhận có hàng: Combo và Cây thông. Mẫu đối chứng: category Noel cha.
- GET trực tiếp với `Cache-Control: no-cache` để đọc status, robots, canonical, title/H1, header và `product_cat-sitemap.xml`; đối chiếu internal link từ homepage, shop và bài chọn size.
- Browser thật: hai category ở desktop **1440×1000**; category Cây thông ở mobile mô phỏng **375×812**. Đọc DOM, schema, product count và overflow; không thêm giỏ, không gửi form, không mở Zalo/tel.

## Phần đang hoạt động đúng — giữ nguyên

- Hai URL HTTP 200, H1/title/meta description riêng và đúng intent; Combo có 3 sản phẩm, Cây thông có 2.
- JSON-LD parse được `CollectionPage` và `BreadcrumbList`. Category Noel cha tiếp tục `index, follow`, self-canonical và có trong sitemap.
- Các category có internal link từ homepage/shop; bài chọn size cũng liên kết tới Cây thông. Mẫu mobile Cây thông có `scrollWidth=innerWidth=375`, không overflow ngang.
- Không yêu cầu index mọi taxonomy. Các category rỗng vẫn nên noindex cho tới khi có listing hoặc giá trị landing page đủ rõ.

## Phát hiện R29-01 — P1 OPEN

Cả hai category có hàng vẫn phát **`nofollow, noindex`** và không có self-canonical. Việc chúng vắng `product_cat-sitemap.xml` là hệ quả dự kiến của `noindex`, không phải lỗi sitemap độc lập. Đây không còn là trạng thái hợp lý cho trang rỗng như R18/R22: mỗi trang nay có listing mua hàng, nội dung mô tả riêng và internal link rõ.

Mẫu đối chứng category Noel cha phát `index, follow`, self-canonical và có trong sitemap. Sai khác cho thấy cần chuyển trạng thái SEO theo term đã sẵn sàng, không phải bật index toàn bộ taxonomy.

[Bằng chứng tổng hợp](review-evidence/2026-09-24/r29-summary.json) · [HTTP/meta/sitemap/internal link](review-evidence/2026-09-24/r29-http-seo.json) · [Combo desktop](review-evidence/2026-09-24/r29-combo-category-desktop.webp) · [Cây thông desktop](review-evidence/2026-09-24/r29-tree-category-desktop.webp) · [Cây thông mobile](review-evidence/2026-09-24/r29-tree-category-mobile.webp).

### Phân ranh issue

- **R29-01** sở hữu robots/canonical của hai category có hàng.
- Hai URL vắng `product_cat-sitemap.xml` đúng với cơ chế Rank Math khi term đang `noindex`; đây là **hệ quả của R29-01**, không phải bằng chứng lỗi R2-06 độc lập. Sau khi đổi sang indexable, nếu purge cache mà URL vẫn thiếu thì mới chuyển phần đó sang R2-06.
- **R2-04/R2-11/R27-01** tiếp tục sở hữu lời hứa số lượng, ảnh sai loại hàng và mapping biến thể. Không gọi indexability là cách sửa những lỗi catalog đó.

## Giới hạn và bàn giao R29

- Thêm **1 P1**, tổng hiện hành **41 OPEN — 9 P1, 26 P2, 6 P3**. Không đóng issue cũ.
- Không có GSC nên không tuyên bố URL đang/không đang nằm trong chỉ mục Google; bằng chứng chỉ kết luận directive công khai và sitemap hiện hành.
- Không chạy crawler toàn bộ taxonomy; phạm vi là hai category đã đổi trạng thái hàng và một mẫu đối chứng. Không kiểm ranking, impression, cache Google hoặc Core Web Vitals.
- Bộ bằng chứng gồm **3 JSON + 3 screenshot**. Đã đóng Chrome riêng; không sửa code/config/database website hoặc chạy watcher.
- Báo cáo và bằng chứng được bàn giao qua commit/push; chỉ xác nhận thành công sau khi remote nhận commit.

---

<a id="round-r30"></a>

# Vòng R30 — Chủ thể doanh nghiệp, tác giả và tín hiệu tin cậy

Ngày kiểm tra: **24/09/2026**, timestamp chi tiết trong JSON. Đầu vòng `main` bằng `origin/main`; `ASSISTANT_REPLY.md` vẫn SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**, không có bàn giao Coder mới.

Hai scout đọc độc lập nhánh thông tin doanh nghiệp/chính sách và nhánh author/entity schema; Main kiểm lại bằng browser thật, parse DOM/JSON-LD và quyết định phân ranh. Subagent không sửa file/website và kết luận của họ không được dùng thay bằng chứng runtime.

## Phạm vi và phương pháp

- Tám trang: homepage, Giới thiệu, Showroom, Liên hệ, Vận chuyển, Đổi trả, Thanh toán, Bảo mật.
- Ba bề mặt editorial: hub, bài chọn size và `/author/ed4f7b/`.
- Browser desktop **1440×1000**: đọc nội dung chính, footer, tel/mail link, iframe, robots và JSON-LD; chụp Contact, About, Showroom, author profile và vùng chính sách nhận chuyển khoản.
- Không gửi form, gọi điện, mở Zalo/bản đồ ngoài, chuyển khoản, thêm giỏ hoặc đặt hàng. Thông tin website là tự khai; không gọi nó là đã được xác minh ngoài đời.

## Phần đang hoạt động đúng — giữ nguyên

- Tên thương hiệu **Trang Trí 4 Mùa**, địa chỉ `123 Đường Xuân Thủy`, hotline `0901.234.567` và email `cskh@trangtri4mua.com` hiển thị nhất quán ở các trang đã đọc. Không gắn nhãn “placeholder” chỉ vì dãy số/địa chỉ trông giống dữ liệu mẫu.
- Homepage có link thật tới About, Showroom và bốn chính sách; Contact được truy cập từ navigation. Chính sách vận chuyển/đổi trả/thanh toán/bảo mật có cấu trúc chi tiết hơn một footer trust badge.
- Graph giữ cùng `Organization @id`; `WebSite.publisher`, Article/BlogPosting publisher liên kết được. Hub dùng `CollectionPage`, bài thật dùng `BlogPosting`, author archive dùng `ProfilePage`.
- Email bảo vệ Cloudflare render thành `cskh@trangtri4mua.com` trong browser; không báo chuỗi reader-mode `[email protected]` thành lỗi.

## R2-22 — nâng P2 → P1, giữ OPEN

Chính sách thanh toán hướng dẫn người mua chuyển vào tài khoản MB **0901234567**, tên **TRANG TRI 4 MUA**, gọi đây là tài khoản chính thức; cùng trang cam kết hợp đồng dự án và hóa đơn VAT hợp lệ. Tuy nhiên Contact/About/footer/privacy và Organization schema chưa nêu chủ thể đăng ký/MST của **bên bán**. Trường “Tên công ty, Mã số thuế” trong policy là dữ liệu khách phải cung cấp, không phải định danh shop.

Vì khoảng trống nay nằm ngay trước một hành động chuyển tiền và quan hệ B2B, R2-22 được nâng lên **P1**. Không có bằng chứng tài khoản/showroom/claim là giả; yêu cầu là owner xác nhận, công bố và đồng bộ chủ thể thật. Các claim “1.200 khách hàng”, testimonial có tick, “hàng trăm mẫu/công trình”, ảnh thực tế 100% vẫn thiếu nguồn/case study công khai.

[Ảnh vùng thanh toán](review-evidence/2026-09-24/r30-payment-beneficiary.webp) · [ma trận tin cậy](review-evidence/2026-09-24/r30-trust-matrix.json) · [About](review-evidence/2026-09-24/r30-about-desktop.webp) · [Showroom](review-evidence/2026-09-24/r30-showroom-desktop.webp).

## Ba issue P2 tiếp tục OPEN

### R2-10 — giờ phục vụ

Contact ghi **24/7**, cùng màn hình lại ghi showroom **08:00–21:00** và phản hồi Zalo **15 phút**; topbar ghi **08:00–21:30**. Cần phân biệt kênh nhận tin tự động, giờ nhân viên phản hồi và giờ showroom. [Ảnh Contact](review-evidence/2026-09-24/r30-contact-desktop.webp).

### R2-12 — tác giả

Byline/BlogPosting/Person vẫn là `ed4f7b`; profile chỉ có mã tài khoản, avatar mặc định, ngày tham gia và ba bài. Hub/box cuối bài dùng Ban Biên Tập. Quan hệ schema nối được nhưng danh tính/chuyên môn chưa nhất quán. [DOM/schema](review-evidence/2026-09-24/r30-editorial-schema.json) · [profile](review-evidence/2026-09-24/r30-author-desktop.webp).

### R2-16 — schema page template

Homepage và bảy static page đều có `Article` + Person không tên; Organization chỉ có name/logo trong tập đọc. Giữ liên kết Organization/WebSite hiện có, nhưng chuyển static page sang loại phù hợp và không phá `CollectionPage`/`BlogPosting` đang đúng. [Tám trang browser](review-evidence/2026-09-24/r30-pages-browser.json).

## Đính chính phân ranh R29

Theo [hướng dẫn chính thức của Rank Math](https://rankmath.com/kb/url-not-in-sitemap/#the-page-is-set-as-noindex), URL đặt `noindex` không xuất hiện trong sitemap. Vì vậy hai category R29 vắng `product_cat-sitemap.xml` là hệ quả đúng của R29-01, **không** phải bằng chứng lỗi R2-06. Chỉ kiểm R2-06 nếu URL vẫn thiếu sau khi term đã `index, follow`, có canonical và cache đã purge.

## Giới hạn và bàn giao R30

- Không thêm issue; nâng R2-22 từ P2 lên P1. Tổng giữ **41 OPEN — 10 P1, 25 P2, 6 P3**.
- Không kiểm hồ sơ đăng ký doanh nghiệp, MST, quyền sở hữu showroom/tài khoản, khả năng xuất VAT, số khách hàng hoặc hoạt động hotline/email. Đây là khoảng trống cần owner cung cấp nguồn xác nhận, không phải kết luận gian dối.
- Không audit lại toàn bộ pháp lý/nội dung chính sách; không đưa ý kiến pháp lý. R30 kiểm sự nhất quán, khả năng nhận diện chủ thể và mối liên kết nội dung/schema.
- Bộ bằng chứng gồm **4 JSON + 5 screenshot**. Đã đóng Chrome riêng; không sửa code/config/database website hoặc chạy watcher.
- Báo cáo và bằng chứng được bàn giao qua commit/push; chỉ xác nhận thành công sau khi remote nhận commit.

---

<a id="round-r31"></a>

# Vòng R31 — Luồng dữ liệu cá nhân, cookie và thông báo tại điểm thu thập

Ngày kiểm tra: **24/09/2026**, timestamp chi tiết trong JSON. Đầu vòng `main` bằng `origin/main`; `ASSISTANT_REPLY.md` vẫn SHA-256 **`efa000f67c95ccaf46855b2ae71686d6e5e0a9b9abe84443e5ff65b66e090c16`**, không có bàn giao Coder mới.

Hai scout đọc độc lập HTML form và mã WooCommerce liên quan; Main kiểm lại bằng Chromium thật, cookie jar, DOM sau hydrate và chính sách công khai. Kết luận dưới đây dựa trên bằng chứng runtime của Main; kết quả scout chỉ hỗ trợ kiểm tra chéo.

## Phạm vi và phương pháp

- Fresh visit homepage sau khi xóa cookie, `localStorage` và `sessionStorage`; lặp lại lần hai để xác nhận.
- Form Liên hệ, bình luận bài chọn size, Tài khoản và checkout. Không gửi form, bình luận, đăng nhập hoặc đặt đơn.
- Để đọc checkout thật, thêm **Bờm kính Noel** vào giỏ trong browser cô lập, không nhập dữ liệu và không đặt hàng; sau đó xóa sản phẩm, quay lại `/gio-hang/` và xác nhận link giỏ hiển thị **0 ₫**.
- Đọc nội dung policy, script/config `sourcebuster` + `wc-order-attribution`, tài nguyên runtime và link notice trong từng form. Không suy diễn nghĩa vụ pháp lý từ checklist kỹ thuật.

## Phần đang hoạt động đúng — giữ nguyên

- Checkout đặt notice ngay trong form: “Thông tin đặt hàng ... chỉ sử dụng cho mục đích xác nhận, giao hàng”, kèm link **Chính sách bảo mật** trước bước đặt hàng.
- Form bình luận nói email không hiển thị công khai; checkbox lưu tên/email/website trong trình duyệt tồn tại, **không được chọn sẵn**. Giữ lựa chọn này tách biệt, không biến nó thành consent tổng quát.
- Form đăng nhập dùng `autocomplete="username"` và `autocomplete="current-password"`; policy vẫn truy cập được từ footer.
- Fresh visit chưa ghi `localStorage`/`sessionStorage` trong snapshot đầu. Không gộp mọi storage vào một kết luận thiếu consent và không yêu cầu banner cho dữ liệu thiết yếu chỉ vì có cookie.

## R31-01 — P1 OPEN: Policy và notice chưa bao phủ các luồng dữ liệu đang chạy

### Problem

Policy hiện tuyên bố dữ liệu cá nhân “chỉ” dùng cho xử lý đơn hàng, giao nhận và chăm sóc khách hàng; phạm vi/thời hạn cũng chỉ mô tả dữ liệu đơn hàng. Trong khi đó:

1. Fresh visit homepage, trước bất kỳ thao tác đồng ý nào, browser ghi **7 cookie `sbjs_*`**. Giá trị quan sát chứa entry page/referrer, source/campaign mặc định, số trang/lượt truy cập và user agent. Config runtime đặt `allowTracking: true`; hai lần tải sạch đều không tìm thấy UI cookie/consent đang hiển thị.
2. Form Liên hệ thu thập tên, email bắt buộc, điện thoại/Zalo tùy chọn và nội dung yêu cầu; form bình luận thu thập tên, email, website tùy chọn và nội dung. Hai form không có notice/link policy trong chính form. Policy chưa phân biệt tư vấn trước mua, bình luận công khai/lưu phía server, attribution hoặc dữ liệu trình duyệt.

Đây là khoảng trống minh bạch và khả năng kiểm soát quan sát được, **không phải kết luận website vi phạm pháp luật**. Không khẳng định IP thực được lưu: snapshot `sbjs_udata` ghi `uip=(none)`.

### Why it matters

Khách chỉ đọc nội dung đã phát sinh dữ liệu attribution nhưng policy không giúp nhận diện mục đích, nhóm dữ liệu, thời hạn hoặc cách quản lý. Người gửi Contact/comment khó nối dữ liệu của luồng đang dùng với phạm vi xử lý và thời hạn công bố; checkbox “lưu trong trình duyệt” của comment có thể bị hiểu nhầm là lựa chọn dữ liệu duy nhất dù không điều khiển attribution toàn site hay xử lý bình luận phía server.

### Evidence

[Cookie/policy runtime](review-evidence/2026-09-24/r31-cookie-policy-runtime.json) · [ma trận form](review-evidence/2026-09-24/r31-public-forms.json) · [first visit không có consent UI](review-evidence/2026-09-24/r31-home-first-visit.webp) · [Contact](review-evidence/2026-09-24/r31-contact-form.webp) · [comment](review-evidence/2026-09-24/r31-comment-form.webp) · [checkout đối chứng](review-evidence/2026-09-24/r31-checkout-privacy.webp) · [Tài khoản](review-evidence/2026-09-24/r31-account-page.webp).

### Recommended solution

Owner lập inventory thực tế cho từng luồng: Contact, comment, tài khoản/checkout, WooCommerce attribution, cart/storage và dịch vụ ngoài; xác nhận mục đích, trường dữ liệu, bên tiếp cận, thời hạn/điều kiện xóa và cơ chế kiểm soát. Cập nhật policy theo inventory đã xác nhận, rồi:

- đặt notice ngắn + link policy sát nút gửi Contact/comment; nói rõ phần bình luận nào công khai và giữ checkbox lưu trình duyệt không chọn sẵn;
- phân loại attribution/storage theo mục đích thật. Nếu là tùy chọn, không ghi trước lựa chọn và nối control nhìn thấy với `allowTracking`; nếu owner xác định là thiết yếu, giải thích cụ thể thay vì dựng checkbox hình thức;
- nêu nhóm cookie/storage, dữ liệu nguồn truy cập/trình duyệt, thời hạn thực và cách thay đổi/xóa; không tái dùng thời hạn 2 năm của đơn hàng cho lead/comment khi chưa xác nhận.

Không bắt buộc một banner cho mọi cookie và không coi việc thêm checkbox consent vào từng form là đủ nếu policy/inventory vẫn sai phạm vi.

### Acceptance criteria

1. Trên profile sạch, hành vi cookie/storage trước và sau lựa chọn khớp phân loại đã công bố; control tùy chọn thực sự bật/tắt cơ chế tracking, giữ trạng thái và có thể đổi lại.
2. Policy liệt kê đúng các luồng quan sát được, nhóm dữ liệu, mục đích, bên tiếp cận, thời hạn/điều kiện xóa và kênh thực thi quyền; không còn dùng câu “chỉ” theo phạm vi đơn hàng nếu hệ thống vẫn xử lý attribution/lead/comment.
3. Contact và comment có notice/link ngay tại điểm gửi. Comment nói rõ dữ liệu nào công khai/lưu server; checkbox lưu trình duyệt vẫn không chọn sẵn và không đại diện cho consent toàn site.
4. Checkout notice/link hiện có vẫn hoạt động; login/checkout regression test không làm hỏng autocomplete, tạo phiên, giỏ hoặc đặt hàng.
5. Browser test trên profile mới chứng minh trạng thái default, accept/reject/change choice (nếu áp dụng), cookie jar và storage; lưu ảnh + JSON/network evidence. Không nghiệm thu chỉ từ nội dung banner hoặc cấu hình admin.

### Phân ranh

- **R2-21** tiếp tục sở hữu ngôn ngữ demo/validation của Contact; **R16-01** sở hữu liên kết lỗi với trường; **R2-22** sở hữu định danh chủ thể doanh nghiệp. R31-01 chỉ sở hữu inventory, policy, notice và control của luồng dữ liệu.
- Tài nguyên Google Fonts/Maps/Cloudflare được đưa vào bước inventory, nhưng R31 không tự kết luận mỗi tài nguyên đặt cookie hay chia sẻ một trường dữ liệu cụ thể khi chưa có network/policy của nhà cung cấp.
- Cookie giỏ hàng phát sinh trong ca checkout không phải bằng chứng first visit; sản phẩm thử đã được xóa. Không mở issue riêng cho cart storage trong vòng này.

### Status

OPEN

## Giới hạn và bàn giao R31

- Thêm **1 P1**, tổng hiện hành **42 OPEN — 11 P1, 25 P2, 6 P3**. Không đóng hoặc đổi mức issue cũ.
- Đây là review kỹ thuật minh bạch dữ liệu, không phải tư vấn pháp lý, kiểm toán bảo mật hay kiểm kê backend hoàn chỉnh. Không kiểm database, log, email, retention thực, request body của dịch vụ ngoài hoặc mọi `Set-Cookie`.
- Không gửi dữ liệu cá nhân, form, bình luận hay đơn hàng. Chỉ thêm/xóa một sản phẩm trong browser cô lập để đọc notice checkout; đã xác nhận giỏ trở về 0 ₫.
- Bộ bằng chứng gồm **2 JSON + 5 screenshot**. Đã đóng Chrome riêng; không sửa code/config/database website.
- Báo cáo và bằng chứng được bàn giao qua commit/push; chỉ xác nhận thành công sau khi remote nhận commit.

---

<a id="round-r32"></a>

# Vòng R32 — Nghiệm thu độc lập Batch 2

Ngày kiểm tra: **24/09/2026**. Watcher phát hiện và pull commit Coder **`10b0bf13d9e2b2f78cf578f0586fead943e00040`**; `ASSISTANT_REPLY.md` mới có SHA-256 **`6ea13ef3d58c1915e1ae396f9041dc6c084e30bd84c17e067f1abc83c5108161`**.

Coder công bố `FIXED` cho 10 P1. Năm scout đọc độc lập catalog/specs, SEO, privacy/identity và editorial/CTA; Main đối chiếu acceptance gốc bằng Store API, GET no-cache và Chromium thật. Kết quả: **R29-01 CLOSED; 9 issue còn lại giữ OPEN**. `DONE` trong bảng kiểm là đã kiểm xong, không thay cho trạng thái issue.

## Phạm vi và phương pháp

- Product 372/377: chọn tuần tự mọi size desktop, reset, một ca mobile, thêm size lớn nhất của từng cây vào giỏ và xác nhận line item/giá; sau đó xóa.
- Product 269: chọn đủ năm size, reset, đưa `2m5` tới checkout và xác nhận **1.650.000₫**; không nhập dữ liệu hoặc đặt đơn. Đọc Store API cho chín product được bàn giao.
- GET no-cache có ghi status/header cho hai category và năm sitemap; kiểm cart/checkout/account bằng redirect manual.
- Profile sạch cho privacy: xóa cookie/storage, tải homepage, đọc cookie jar/config/runtime, policy và notice Contact/comment.
- Đọc DOM/schema identity trên homepage, Contact, About, payment, privacy; đọc ba bài an toàn và click CTA hero thật tới category Combo.
- Không gửi form/bình luận, đăng nhập, gọi/Zalo, đặt đơn hoặc xác minh hồ sơ doanh nghiệp offline. Mọi sản phẩm thử đã xóa; giỏ trở về **0 ₫**.

## Ma trận nghiệm thu 10 claim

| Issue | Kết quả R32 | Trạng thái hiện hành | Bằng chứng quyết định |
|---|---|---|---|
| R27-01 | **PARTIAL** | OPEN | Bảy option của hai cây nay đổi đúng ID/giá, reset khóa CTA; size lớn nhất vào giỏ đúng trên hai viewport mẫu. Chưa submit từng size trên staging, chưa chạy toàn bộ đổi qua lại mobile/R25-01 hoặc nghiệm thu Offer theo size. |
| R2-01 | **PARTIAL** | OPEN | Năm giá lỗi hệ số đã sửa trong payload/schema; mọi selector 269 đúng và checkout `2m5` là 1.650.000₫. Chưa có bảng giá owner duyệt và chưa kiểm cart/checkout cho toàn bộ 261/280. |
| R2-02 | **FAIL** | OPEN | Nhãn/trùng size đã cải thiện, nhưng product 269 bán **kẹo gậy** và **kẹo tròn** cùng các size trùng mà chỉ có một thuộc tính `Kích thước`; khách vẫn không chọn được kiểu. Không xác minh bảo toàn đơn lịch sử. |
| R2-03 | **FAIL** | OPEN | Fallback hợp kim đã đổi, nhưng grouping mới vẫn gắn sai thông số: COMBO-GD-50 mô tả đúng 50 phụ kiện không có cây, bảng lại ghi “Trọn bộ đầy đủ cây thông” và vật liệu cây PE/cước. |
| R29-01 | **PASS** | **CLOSED** | Combo/Cây thông trả 200, `index, follow`, canonical tự tham chiếu, listing 3/2 sản phẩm và có trong `product_cat-sitemap.xml`. |
| R2-06 | **FAIL** | OPEN | Post sitemap, hai cây và hai category đã vào sitemap. `page-sitemap.xml` vẫn chứa `/gio-hang/` và `/tai-khoan/` đang `noindex`, cùng `/thanh-toan/` trả 302 về cart khi giỏ rỗng. |
| R31-01 | **PARTIAL** | OPEN | Notice/link Contact/comment đã thêm và checkbox comment vẫn không chọn sẵn. Fresh visit vẫn ghi 7 `sbjs_*` không có control nhìn thấy; retention policy 6 tháng không khớp config/runtime session/30 phút; inventory comment/account/dịch vụ ngoài chưa đủ. |
| R2-22 | **PARTIAL** | OPEN | Payment và Organization schema có legalName/MST/address. Contact/About/footer chỉ hiện MST, privacy body chưa nêu chủ thể; claim 1.200 khách, “đã mua”, case study/chuyên môn chưa có căn cứ công khai. |
| R2-05 | **FAIL** | OPEN | Bốn cụm Coder quét đã mất, nhưng bài cafe còn “loại bỏ hoàn toàn rủi ro”; hướng dẫn neo/tải chưa gắn model/bề mặt/gió. Bài dự toán vẫn gán 12V 2A–5A cho 30–50m LED mà không có công suất dây. |
| R2-04 | **PARTIAL** | OPEN | CTA đã đổi thành “Xem Set Combo”, click tới category có ba sản phẩm. Hero vẫn nói các set đều có cây + 45–80 phụ kiện + chiếu sáng và “Tiết Kiệm 20%”, trong khi hai card là set phụ kiện không gồm cây và mức giảm quan sát không đồng nhất 20%. |

## Phần sửa đúng cần giữ

### Mapping hai cây và giá lỗi hệ số

- Cây PE: `1m5→373/850.000`, `1m8→374/1.250.000`, `2m1→375/1.850.000`, `2m4→376/2.650.000`.
- Cây cước: `1m5→378/750.000`, `1m8→379/1.100.000`, `2m1→380/1.650.000`.
- Reset hai form trả hidden ID/attribute rỗng và khóa CTA. Mobile 375×812 của cây cước chọn `2m1` ra ID 380/1.650.000₫. Hai line item size lớn nhất vào giỏ đúng tên/giá rồi được xóa.
- Kẹo gậy 269 nay lần lượt `1m2 750.000`, `1m5 950.000`, `1m8 1.150.000`, `2m 1.450.000`, `2m5 1.650.000`; không còn giá 1.150/1.450/1.650 đồng trong dữ liệu công khai.

Đây là bằng chứng remediation thực, nhưng không thay owner approval, staging all-size cart hoặc tiêu chí chọn **kiểu** của R2-02.

### SEO category

GET no-cache của cả hai category trả **200**, `cf-cache-status: DYNAMIC`, `index, follow` và canonical đúng. `product_cat-sitemap.xml` trả 200/no-store và chứa hai URL; category đối chứng rỗng không bị bật index đại trà trong mẫu scout. R29-01 đủ điều kiện **CLOSED**.

## Acceptance còn thất bại

### R2-06 — inventory sitemap chưa sạch

Sitemap index nay có `post-sitemap.xml`; hub và ba bài đều hiện diện. `product-sitemap.xml` cũng đã có product 372/377. Tuy nhiên page sitemap vẫn gửi ba URL commerce không dự định index: cart/account phát `noindex, follow`; checkout giỏ rỗng trả **302** về cart. Claim purge cache không giải quyết phần acceptance này.

### R31-01 — policy mới không khớp runtime

Policy mới ghi Sourcebuster có thời hạn tối đa **6 tháng**. Production vẫn phát:

- `allowTracking: true`, `lifetime: 1.0e-5`, `session: 30`;
- sáu cookie attribution là session cookie; `sbjs_session` hết hạn sau khoảng **30 phút**;
- fresh profile không có UI accept/reject/change choice đang hiển thị;
- `localStorage/sessionStorage` cart-fragments cũng được tạo khi tải trang.

Contact notice cách đáy form 14px và link policy đúng; comment notice nằm trước nút gửi, nói rõ kiểm duyệt/email và checkbox lưu trình duyệt vẫn unchecked. Giữ các cải thiện này. R31-01 chưa đóng vì retention công bố sai hành vi quan sát, policy còn câu dữ liệu “chỉ” dùng cho đơn hàng/chăm sóc và chưa bao phủ comment/account/dịch vụ ngoài.

### R2-03 — grouping thông số tạo regression mới trong cùng issue

COMBO-GD-50 mô tả: 24 quả châu + 6 kẹo + 10 nơ + sao + 4 dây LED + 5 mô hình, đủ 50 phụ kiện và **không có cây**. Bảng mới lại ghi:

- Kích thước: “Trọn bộ đầy đủ cây thông và phụ kiện decor”;
- Chất liệu: “Lá PE đúc nguyên cành / cước cao cấp, thân lõi thép & chân kim loại chịu lực”.

Set Hoàng Gia 70 món có cùng dạng mâu thuẫn. Kẹo gậy mô tả composite sơn màu nhưng bảng ghi ABS/nhũ/sequin; Lính đánh trống có chiều cao 38cm trong mô tả nhưng bảng vẫn dùng “kích thước tiêu chuẩn”. Đây là cùng root cause fallback theo nhóm, không mở issue mới.

### R2-05 và R2-04 — sửa regex/nhãn chưa sửa toàn acceptance

- Bài cafe còn câu timer “**loại bỏ hoàn toàn rủi ro** nhân viên quên tắt đèn”, neo cây bằng cước 25–30kg/móc dán và bao cát 15–20kg mà chưa nêu model, bề mặt, tải hệ neo hoặc điều kiện gió.
- Bài dự toán còn “12V 2A–5A chịu tải 30m–50m LED” và “1 củ dùng cho toàn bộ hệ thống” mà không nêu công suất dây tương ứng.
- Hero hiện có ba card đích, nhưng lời hứa chung vẫn bao gồm cây, 45–80 món, đèn “chống chập cháy” và tiết kiệm 20%. Hai card là bộ phụ kiện không gồm cây; giá card quan sát cho mức giảm khác nhau.

## R2-22 — cải thiện trust nhưng chưa đồng bộ chủ thể

Organization schema đã có `legalName="Hộ Kinh Doanh Trang Trí 4 Mùa"`, `taxID/vatID="0318294567"` và địa chỉ; payment hiển thị tên chủ quản, MST và tài khoản `TRANG TRI 4 MUA`. Contact/About/footer chỉ thêm MST, không kèm tên đăng ký; privacy body không xác định đơn vị xử lý dữ liệu. Claim homepage **1.200 khách**, testimonial “Đã mua” và chuyên môn/case study vẫn thiếu căn cứ công khai. Không xác minh MST hoặc câu “UBND TP. Thủ Đức cấp” từ schema/nội dung tự khai.

## Bằng chứng R32

[JSON tổng hợp](review-evidence/2026-09-24/r32-batch2-verification.json) · [cây cước mobile 2m1](review-evidence/2026-09-24/r32-tree377-mobile-2m1.webp) · [first visit](review-evidence/2026-09-24/r32-home-first-visit.webp) · [notice Contact](review-evidence/2026-09-24/r32-contact-privacy-notice.webp) · [notice comment](review-evidence/2026-09-24/r32-comment-privacy-notice.webp) · [hero](review-evidence/2026-09-24/r32-home-hero.webp) · [bảng sai COMBO-GD-50](review-evidence/2026-09-24/r32-combo-gd50-specs.webp) · [identity payment](review-evidence/2026-09-24/r32-payment-identity.webp).

## Giới hạn và bàn giao R32

- Đóng **1 P1** (R29-01); tổng hiện hành **41 OPEN — 10 P1, 25 P2, 6 P3**. Không thêm issue mới.
- Không xác minh bảng giá owner, vật liệu/nhãn nhà cung cấp, đơn lịch sử, giấy đăng ký/MST, tồn kho, database, email hoặc retention backend. Schema/nội dung tự khai không phải xác minh pháp lý.
- Không gửi form/bình luận, đăng nhập, gọi/Zalo hoặc đặt đơn. Ba sản phẩm thêm giỏ chỉ phục vụ đọc cart/checkout; tất cả đã xóa và giỏ trở về 0 ₫.
- Bộ bằng chứng gồm **1 JSON + 7 screenshot**. Browser riêng đã đóng; không sửa code/config/database website.
- Báo cáo và bằng chứng chỉ được coi đã bàn giao sau khi commit/push thành công.

---

<a id="round-r33"></a>

# Vòng R33 — Nghiệm thu độc lập Batch 3

Ngày kiểm tra: **24/09/2026**. Watcher phát hiện và pull commit Coder **`963c6d3`**; `ASSISTANT_REPLY.md` mới có SHA-256 **`555f5a228649a9e469d22c9ac84b43e617741ce70e46113f58be223f80aa3665`**.

Coder công bố `FIXED` cho tám P2 về CTA B2B, search/mobile drawer, tác giả, phép tính dự toán, thứ tự policy, 404 và landmarks. Bốn scout đọc độc lập implementation/acceptance; Main kiểm lại production bằng Chromium ở 375/768/1440px và GET HTTP. Kết quả: **5 issue CLOSED; 3 issue giữ OPEN**. `DONE` trong bảng kiểm chỉ nghĩa là đã kiểm xong.

## Phạm vi và phương pháp

- Mở/tắt drawer bằng pointer và bàn phím; tìm kiếm có kết quả/không kết quả từ homepage, PDP và category; kiểm Escape/click, focus return, kích thước và màu thực của nút đóng. Mở/tắt search modal desktop để bắt regression.
- Đọc bốn policy ở 375/768px: landmark, vị trí article/sidebar, DOM order, keyboard order, table overflow và link. Đọc Contact/Showroom cho iframe name và heading tree.
- Đọc author archive, byline và JSON-LD của ba bài; tính lại 37 dòng và ba tổng ngân sách.
- Gọi một URL ngẫu nhiên không tồn tại và một asset không tồn tại; click CTA B2B thật từ Shop và category Noel. Không kích hoạt tel/Zalo hoặc gửi form.

## Ma trận nghiệm thu tám claim

| Issue | Kết quả R33 | Trạng thái hiện hành | Bằng chứng quyết định |
|---|---|---|---|
| R2-07 | **PARTIAL** | OPEN | CTA từ Shop và category đều tới section B2B thật, target nằm đúng đầu viewport. Section không focusable; sau điều hướng `activeElement` là `BODY`, nên vị trí bàn phím không theo nội dung. |
| R2-08 | **PASS** | **CLOSED** | Search trong drawer hiển thị, có accessible name và cao 44px ở mobile/tablet; submit từ homepage/PDP/category cho cả kết quả có dữ liệu và empty state. Header search riêng vẫn ẩn ở 768px nhưng không còn chặn luồng tìm kiếm. |
| R2-09 | **PASS** | **CLOSED** | Nút đóng 44×44; icon `#1F2937` trên `#F9FAFB`, contrast tính lại khoảng **14,05:1**. Escape và click đều đóng rồi trả focus về Menu; search modal desktop vẫn mở/focus/đóng đúng. |
| R2-12 | **PASS** | **CLOSED** | Profile, byline và Person/BlogPosting của ba bài cùng dùng **Ban Biên Tập Trang Trí 4 Mùa** và nối đúng author archive. |
| R2-13 | **PASS** | **CLOSED** | Tính lại 37/37 dòng: ba tổng công bố khớp tổng dòng, lần lượt **2.340.000₫**, **6.220.000₫**, **19.240.000₫**. |
| R2-15 | **PARTIAL** | OPEN | Ở 375/768px, article đã hiển thị trước sidebar và bảng cuộn ngang. DOM vẫn là `ASIDE` rồi `ARTICLE`; sau skip-link, Tab đầu tiên vào link sidebar ở cuối trang nhìn thấy. |
| R2-19 | **PASS** | **CLOSED** | URL ngẫu nhiên trả HTTP **404** và template WordPress đầy đủ header/footer, giải thích, search, Home/Shop/Zalo/category recovery; asset thiếu vẫn trả 404. |
| R2-20 | **FAIL** | OPEN | Nested `<main>` của policy đã sửa và map Contact có title. Map Showroom vẫn không có `title`/`aria-label`; heading Contact/Showroom vẫn có bước nhảy **H2→H4**. |

## Năm issue đủ điều kiện CLOSED

### R2-08 và R2-09 — search mobile và close control

Drawer search dùng GET `s`, có nhãn **“Tìm kiếm sản phẩm”** và hiển thị 239,59×44px. Từ homepage, query “cây thông phủ tuyết” mở full search có sản phẩm; query vô nghĩa mở H1 **“Không có kết quả”**. PDP tablet tìm “tháp nhũ”; category mobile tìm “ông già noel”; cả hai có kết quả đúng ngữ nghĩa.

Drawer mở với focus ở nút **“Đóng ngăn”**. Escape và click nút đóng trả focus về trigger Menu trong automation đã chạy. Search modal desktop đối chứng vẫn focus input khi mở và trả focus về nút **“Tìm kiếm”** khi Escape. R2-08/R2-09 đủ acceptance riêng.

R26-01 vẫn là P3 OPEN: vòng này không mô phỏng đầy đủ nhánh touch/screen reader của Blocksy, nên kết quả width-mobile không được dùng để đóng regression focus riêng đó.

### R2-12 — định danh tác giả

Author archive có H1, bio, ba bài và Person schema cùng tên **Ban Biên Tập Trang Trí 4 Mùa**. Byline đầu bài nối đúng `/author/ed4f7b/`; BlogPosting/Person dùng cùng identity. Đây là tính nhất quán nội bộ, không phải xác minh chuyên môn hoặc nhân thân ngoài website.

### R2-13 — phép tính bảng dự toán

Ba bảng cần sửa nay có chênh lệch bằng 0:

- căn hộ: 10 dòng, tổng **2.340.000₫**;
- quán cafe: 14 dòng, tổng **6.220.000₫**;
- showroom: 13 dòng, tổng **19.240.000₫**.

### R2-19 — custom 404

`/reviewer-r33-963c6d3-probe/` trả status thật 404, H1 **“Không Tìm Thấy Trang Bạn Yêu Cầu”**, search và các lối về Home/Shop/danh mục. Response giữ WordPress header/footer; một file ảnh giả vẫn trả 404 ở tầng server, không bị rewrite thành trang 200.

## Ba issue chưa đủ điều kiện đóng

### R2-07 — anchor đúng nhưng focus vẫn mất

Cả CTA Shop và category Noel có href `/#b2b-consultation`; click thật tải homepage, cuộn tới section B2B với `top=0`. Section có nội dung khảo sát/báo giá/VAT/thi công và CTA tel/Zalo dùng được về mặt liên kết.

Sau điều hướng, section có `tabIndex=-1` mặc định nhưng không nhận focus; `activeElement` là `BODY`. Bàn phím tiếp tục từ đầu tài liệu thay vì vùng vừa mở. Cần cho target/heading nhận focus có quản lý sau navigation; không chỉ thêm fragment đúng.

### R2-15 — sửa visual order nhưng chưa sửa reading/focus order

Ở cả 375 và 768px, article bắt đầu khoảng `y=194`, sidebar xuống sau toàn bộ nội dung; không có tràn viewport. Wrapper bảng có `clientWidth=341`, `scrollWidth=580`, nên horizontal scroll hoạt động; link sidebar vẫn hiện.

Source order vẫn là `ASIDE` trước `ARTICLE`, chỉ đổi bằng CSS `order`. Sau khi kích hoạt skip-link, Tab kế tiếp nhảy vào **“Chính Sách Đổi Trả”** trong sidebar ở khoảng `y=3191`, bỏ qua chuỗi link nội dung đang hiển thị trước đó. Cần đổi DOM/source order, không chỉ visual order.

### R2-20 — Showroom map và heading hierarchy còn lỗi

Bốn policy nay mỗi trang chỉ có một `<main>`, không còn nested main. Contact map có title **“Bản đồ chỉ đường đến showroom Trang Trí 4 Mùa Thảo Điền”**.

Showroom iframe vẫn có `title=""`, không `aria-label`/`aria-labelledby` dù nhận Tab. Heading tree Showroom có nhiều bước **H2→H4**; Contact cũng còn cấu trúc `H1, H4, H3, H2`. Vì acceptance yêu cầu map có tên và hierarchy hợp lệ trên các template liên quan, R2-20 vẫn OPEN.

## Bằng chứng R33

[JSON tổng hợp](review-evidence/2026-09-24/r33-batch3-verification.json) · [drawer mobile](review-evidence/2026-09-24/r33-mobile-drawer.webp) · [policy mobile article trước sidebar](review-evidence/2026-09-24/r33-policy-mobile-main-first.webp) · [Showroom map](review-evidence/2026-09-24/r33-showroom-map.webp) · [author archive](review-evidence/2026-09-24/r33-author-profile.webp) · [custom 404](review-evidence/2026-09-24/r33-404-page.webp) · [CTA B2B sau click](review-evidence/2026-09-24/r33-b2b-anchor-after-click.webp).

## Giới hạn và bàn giao R33

- Đóng **5 P2**: R2-08, R2-09, R2-12, R2-13, R2-19. Tổng hiện hành **36 OPEN — 10 P1, 20 P2, 6 P3**. Không thêm issue mới.
- Không xác minh chuyên môn tác giả, giá thị trường, database/backend hoặc mọi route. Focus drawer được thử trong Chromium mobile-width, không thay cho touch screen reader; R26-01 không đổi trạng thái.
- Không gửi form, gọi/Zalo, đặt hàng hoặc thêm giỏ. Bộ bằng chứng gồm **1 JSON + 6 screenshot**; browser riêng đã đóng; không sửa code/config/database website.
- Báo cáo và bằng chứng chỉ được coi đã bàn giao sau khi commit/push thành công.

---

<a id="round-r34"></a>

# Vòng R34 — Nghiệm thu độc lập Batch 4

Ngày kiểm tra: **24/09/2026**. Watcher phát hiện và pull commit Coder **`cfb3e83`**; snapshot `ASSISTANT_REPLY.md` của Batch 4 có SHA-256 **`e392037c7c58ad665363e21df3fc82b66df926fb9f2d183b1f2b70dc9a58d`**.

Coder công bố `FIXED` cho năm issue conversion/search/performance/content. Năm scout đọc độc lập implementation public và acceptance; Main kiểm production bằng GET manual, Chromium và network throttling. Kết quả: **không issue nào đủ điều kiện CLOSED; cả năm giữ OPEN**. Trong lúc kiểm, watcher nhận thêm Batch 5/6; hai bàn giao đó được tách sang vòng sau, không được dùng để thay verdict Batch 4.

## Phạm vi và phương pháp

- Giữ POST thêm giỏ của nút Mua ngay hơn 6 giây rồi abort trước khi server xử lý; ghi timeline navigation và trạng thái giỏ. Không đặt đơn.
- Gọi no-follow năm alias với/không UTM, `orderby` và query inert; đối chiếu sort qua alias với URL đích trong browser.
- Kiểm exact SKU ở live/full search, Tab/Enter, card desktop, layout/empty state mobile.
- Đo ba lượt PDP cùng cấu hình R5: 375×812, DPR 1, latency 150ms, download 200.000 B/s, upload 93.750 B/s, CPU 4×, cache browser tắt; đọc Resource Timing và LCP observer.
- Đối chiếu giờ, giao hàng và hoàn tiền trên Contact, homepage, hub, policy, listing, PDP và footer. Không gọi/Zalo hoặc gửi form.

## Ma trận nghiệm thu năm claim

| Issue | Kết quả R34 | Trạng thái hiện hành | Bằng chứng quyết định |
|---|---|---|---|
| R4-01 | **FAIL** | OPEN | JS production vẫn có timer 4 giây. Khi giữ đúng POST thêm giỏ, browser yêu cầu checkout trước khi POST thành công, rồi rơi vào giỏ trống. |
| R17-01 | **PARTIAL** | OPEN | Năm alias giữ UTM; sort alias khớp đích trực tiếp. Implementation vẫn chuyển tiếp mọi key, gồm `redirect_to`/key lạ; chưa có staging proof cho tham số action/handler bị cấm. |
| R2-14 | **PARTIAL** | OPEN | Ba exact SKU nay tìm đúng product; keyboard/mobile/empty/noindex còn hoạt động. Full-search product card vẫn không có giá hoặc CTA xem/chọn mẫu rõ. |
| R5-01 | **PARTIAL** | OPEN | Ảnh chính đã eager/high và bắt đầu request sớm hơn. Ba lượt chưa chứng minh LCP giảm; bốn ảnh related đang ẩn cũng bị eager/high và được browser request. |
| R2-10 | **FAIL** | OPEN | Contact phân biệt giờ tốt hơn, nhưng footer/listing/PDP vẫn hứa Zalo 24/7, listing Tết nói hotline tới 22:00; giao hàng/hoàn tiền vẫn mâu thuẫn. |

## R4-01 — timer client vẫn tái hiện race condition

Source production đúng version đã có hidden input `tt4m_buy_now=1`, nhưng cùng `handleInstantCheckout()` vẫn:

- nghe `added_to_cart`;
- click nút add-to-cart AJAX;
- gọi `goToCheckout()` bằng fallback `setTimeout(..., 4000)`.

Phép thử bắt đầu với giỏ trống, chọn 1m8 → variation **298**, giá **895.000₫**. POST thực chứa product 295, variation 298, quantity 1 và cờ `tt4m_buy_now=1`; request được giữ rồi abort sau 6,5 giây:

| Mốc sau click | Quan sát |
|---:|---|
| ~71ms | POST add-to-cart bị giữ. |
| ~4,85s | `/thanh-toan/` đã trả 302 tới `/gio-hang/`, khi POST chưa được thả. |
| ~5,94s | Browser tới giỏ 200. |
| ~6,57s | POST mới bị abort. |

Trang đích ghi **“Chưa có sản phẩm nào trong giỏ hàng”**; cuối vòng cart vẫn 0₫ và không có WooCommerce session cookie. Server-side filter không loại được race khi client vẫn tự điều hướng bằng timer. Đây là cùng lỗi R4-01, không mở issue mới.

## R17-01 — query hữu ích đã giữ, query policy chưa an toàn

Năm alias không query vẫn 301 đúng pathname. Với `utm_source=review%20r34&utm_medium=referral%2Femail`, cả năm trả 301 và giữ đúng encoding ở Location. `/shop/?orderby=price-desc&utm_campaign=winter` tới đúng URL cửa hàng; dropdown là `price-desc`, 16 product ID đầu khớp URL đích trực tiếp cùng thời điểm, canonical vẫn sạch `/cua-hang/`.

Checkout giỏ trống giữ UTM ở hop alias 301 tới `/thanh-toan/`, sau đó flow WooCommerce 302 về `/gio-hang/` như trước.

Tuy nhiên `/shop/?redirect_to=https%3A%2F%2Fevil.example&foo=bar` cũng sao chép nguyên hai key sang URL đích. Mẫu này không tạo open redirect, nhưng chứng minh implementation chuyển tiếp mù toàn bộ query thay vì allowlist. Không thử `add-to-cart`, nonce hoặc handler trên production. Acceptance yêu cầu chứng minh các tham số action không gây tác dụng phụ trên staging; Coder chưa cung cấp staging/diff đủ để nghiệm thu phần đó.

## R2-14 — exact SKU đã sửa, product card chưa sửa

Ba mã **COMBO-GD-50**, **SET-HG-70**, **CT-PE-SNOW** nay đều có đúng một product ở live search và full search. Với CT-PE-SNOW, Tab tới link gợi ý và Enter mở đúng PDP cây PE. Query tên hàng, kiến thức và intent hỗn hợp vẫn giữ product/bài hữu ích; empty state mobile có ô tìm lại, search page tiếp tục `noindex`, không tràn ngang.

Full search vẫn dùng card bài viết: category, title, ảnh, excerpt, ngày. Card exact SKU không có `.price`; các action chỉ là link category/title, không có CTA xem/chọn mẫu rõ theo product type. Sửa matching không hoàn thành yêu cầu merchandising của R2-14.

## R5-01 — ưu tiên ảnh chính đúng hơn nhưng filter quá rộng

Ảnh chính Tháp nhũ trong viewport có `loading="eager"`, `fetchpriority="high"`, responsive source và hiển thị đúng tỷ lệ 3:4. Ba lượt sau sửa:

| Lượt | TTFB | Bắt đầu ảnh chính | Kết thúc ảnh | LCP |
|---|---:|---:|---:|---:|
| 1 | 1.126ms | 1.309ms | 5.306ms | 5.372ms |
| 2 | 1.158ms | 1.312ms | 5.113ms | 5.172ms |
| 3 | 1.109ms | 1.282ms | 5.115ms | 5.168ms |

Median LCP là **5.172ms**, so với baseline R5 **4.756ms**. Request ảnh bắt đầu sớm hơn baseline mẫu đầu (2.317ms), nhưng response chậm hơn trong ba lượt này; không được tuyên bố cải thiện LCP chỉ từ attribute, cũng không diễn giải mẫu nhỏ thành regression toàn site.

Quan trọng hơn, mỗi lượt có bốn ảnh product related đang ẩn (`0×0`) cũng mang eager/high; Resource Timing xác nhận browser đã request các URL đó. Acceptance yêu cầu không làm ảnh ngoài viewport đồng loạt tải sớm. Cần giới hạn filter đúng ảnh hero/main gallery đầu, giữ related và slide/thumbnail ngoài viewport lazy/priority mặc định, rồi đo lại.

## R2-10 — chỉ sửa một phần giờ hỗ trợ

Contact nay giải thích trực tiếp tư vấn **08:00–21:30**, showroom **08:00–21:00** và Zalo chỉ **tiếp nhận yêu cầu 24/7**. Topbar/footer widget hotline dùng 21:30. Đây là cải thiện đúng cần giữ.

Các xung đột public còn lại:

- footer menu và listing Cây thông vẫn ghi **“Tư vấn Zalo 24/7”**;
- PDP cây PE ghi **“Hỗ trợ nhanh 24/7”**;
- listing Tết ghi Zalo 24/7 và hotline **8h00–22h00**;
- returns ghi CSKH tới **21:00**, khác 21:30 mà không giải thích kênh;
- homepage/hub nói tỉnh khác **1–3 ngày**, shipping policy nói **2–4 ngày**, vùng xa **3–5 ngày**;
- homepage hứa lỗi vận chuyển được hoàn tiền **ngay trong ngày**, returns công bố hoàn tiền **1–2 ngày**.

Batch 4 chỉ sửa Contact và một footer widget, chưa bao phủ acceptance toàn issue.

## Bằng chứng R34

[JSON tổng hợp](review-evidence/2026-09-24/r34-batch4-verification.json) · [sort qua alias](review-evidence/2026-09-24/r34-redirect-sort-preserved.webp) · [exact SKU card thiếu giá/CTA](review-evidence/2026-09-24/r34-sku-search-card.webp) · [ảnh chính PDP](review-evidence/2026-09-24/r34-pdp-main-eager.webp) · [Contact hours](review-evidence/2026-09-24/r34-contact-hours.webp) · [listing vẫn Zalo 24/7](review-evidence/2026-09-24/r34-listing-zalo-24-7.webp).

## Giới hạn và bàn giao R34

- Không đóng issue; tổng giữ nguyên **36 OPEN — 10 P1, 20 P2, 6 P3**. Không thêm issue mới.
- Không test tham số giao dịch/handler của redirect trên production. LCP là lab local ba lượt, không phải CrUX/RUM và không chứng minh ảnh hưởng kinh doanh.
- Một POST Mua ngay bị giữ rồi abort trước khi server xử lý; không thêm sản phẩm, gửi form, gọi/Zalo hoặc đặt đơn. Cuối vòng giỏ 0₫; browser riêng đã đóng.
- Bộ bằng chứng gồm **1 JSON + 5 screenshot**. Báo cáo và bằng chứng chỉ được coi đã bàn giao sau khi commit/push thành công.

---

<a id="round-r35"></a>

# Vòng R35 — Nghiệm thu độc lập Batch 5 và Batch 6

Ngày kiểm tra: **24/09/2026**. Watcher pull hai commit Coder: Batch 5 **`693c80e`**, Batch 6 **`fef8ec3`**; `ASSISTANT_REPLY.md` hiện có SHA-256 **`0d324d8a00a401db5d44f36e1768f3552ce354c27c96a0f0f63e3e0c01370c82`**.

Hai bàn giao công bố `FIXED` cho 10 issue. Năm scout đọc độc lập SEO/specs, variations, privacy/identity, safety/hero và accessibility; Main kiểm production bằng crawl HTTP, profile browser sạch và Chromium ở 375/768/1440px. Kết quả: **R2-06, R2-15, R2-07 CLOSED; bảy issue còn lại giữ OPEN**.

## Ma trận nghiệm thu

| Issue | Kết quả R35 | Trạng thái hiện hành | Bằng chứng quyết định |
|---|---|---|---|
| R2-06 | **PASS** | **CLOSED** | Ba URL commerce đã khỏi page sitemap; crawl toàn bộ 113 URL sitemap đều direct 200, self-canonical, indexable; 94 product API khớp 94 PDP + shop archive. |
| R2-03 | **FAIL** | OPEN | SET-HG-70 còn lệch `1m8–2m4` với bảng `1m8–2m1`; Kẹo gậy mô tả bảy tổ hợp nhưng bảng/selector có năm; chưa có owner/source approval. |
| R2-02 | **PARTIAL** | OPEN | Năm option nay phân biệt kiểu + size và map đúng ID/SKU/giá; mô tả/ảnh vẫn quảng bá quy cách/giá khác selector, chưa cart từng option hoặc chứng minh đơn lịch sử. |
| R31-01 | **PARTIAL** | OPEN | Policy khớp session/30 phút và mở rộng Contact/B2B/comment; profile sạch vẫn ghi 7 `sbjs_*` không có control nhìn thấy, inventory còn thiếu field/dịch vụ ngoài. |
| R2-22 | **PARTIAL** | OPEN | Identity tự công bố đã đồng bộ Contact/About/footer/privacy/payment/schema; testimonial “thực tế”, “hàng trăm công trình” và claim ảnh thật/chuyên môn vẫn thiếu căn cứ công khai. |
| R2-05 | **FAIL** | OPEN | Bỏ nhiều từ tuyệt đối, nhưng hướng dẫn bao cát/cước/móc, công suất LED và tuyết bọt vẫn thiếu model/nguồn/owner approval, có số liệu chưa khớp. |
| R2-04 | **PARTIAL** | OPEN | Hero đã phân biệt set phụ kiện và combo có cây; listing có ba sản phẩm. Lời hứa thành phần/size, metadata listing và hai card category rỗng vẫn không khớp offer. |
| R2-15 | **PASS** | **CLOSED** | 4/4 policy có source order `ARTICLE → ASIDE` ở 375/768; Tab sau skip-link vào link trong article, bảng cuộn, không overflow, một main. |
| R2-20 | **PARTIAL** | OPEN | Contact/Showroom đã có map title, Tab vào/ra và heading đúng. Policy vẫn có nhiều bước `H1→H4`/`H2→H4`. |
| R2-07 | **PASS** | **CLOSED** | Click từ Shop và category đặt focus vào `SECTION#b2b-consultation` ở đầu viewport; Tab kế tiếp tới Zalo CTA. |

## Ba issue CLOSED

### R2-06 — inventory sitemap sạch trong crawl hiện hành

Sitemap index có post, page, product, category và product-category. Page sitemap còn chín URL nội dung; `/gio-hang/`, `/thanh-toan/`, `/tai-khoan/` đã bị loại mà cart/account vẫn `noindex`.

Main hợp nhất 113 URL duy nhất từ bốn sitemap nội dung rồi GET no-cache/manual redirect:

- **113/113 HTTP 200**;
- **0 redirect**, **0 noindex/X-Robots noindex**;
- **0 canonical mismatch**, **0 thiếu canonical**, **0 lỗi fetch**.

Store API báo 94 product published; product sitemap có 95 loc gồm đúng 94 PDP và `/cua-hang/`. Post sitemap có hub + ba bài; product-category sitemap giữ sáu category indexable, gồm Combo/Cây thông. Với bằng chứng delta R27/R29/R32 và crawl toàn inventory hiện hành, R2-06 đủ CLOSED. Việc submit GSC chỉ thực hiện khi owner có quyền, không phải điều kiện để gọi một XML đang sạch là lỗi.

### R2-15 — source order và keyboard order đã khớp

Cả bốn policy tại 375/768 đều có một main, không nested main, và `.tt4m-page-layout` chứa `ARTICLE` trước `ASIDE`. Article bắt đầu khoảng y=194, sidebar nằm sau toàn nội dung trên mobile. Ba bảng giữ wrapper ngang; 375px có `clientWidth=341`, `scrollWidth=580`, không làm document overflow.

Trên Privacy, skip-link focus `main#main`; Tab tiếp theo vào email trong article tại cuối nội dung, không vào sidebar. Source/reading/focus order nay cùng visual order nên R2-15 CLOSED.

### R2-07 — focus sau cross-page fragment đã đúng

Từ Shop và category Noel, CTA tới `/#b2b-consultation`; target có `tabindex="-1"`, nằm tại top≈0 sau navigation và trở thành `document.activeElement`. Tab kế tiếp tới **“Nhắn Zalo Tư Vấn”**. Luồng không còn trả focus về `BODY`, đủ CLOSED.

## Bảy issue còn OPEN

### R2-03 và R2-02 — selector rõ hơn nhưng catalog kẹo vẫn tự mâu thuẫn

Product 269 nay có năm lựa chọn hợp lệ:

| Option | Variation | SKU | Giá |
|---|---:|---|---:|
| Kẹo gậy 1m8 | 271 | TT4M-074-80 | 1.150.000₫ |
| Kẹo gậy 2m | 272 | TT4M-074-2M | 1.450.000₫ |
| Kẹo gậy 2m5 | 273 | TT4M-074-50 | 1.650.000₫ |
| Kẹo tròn 1m2 | 274 | TT4M-074-20 | 750.000₫ |
| Kẹo tròn 1m5 | 270 | TT4M-074-1M50 | 950.000₫ |

Mỗi option đổi đúng hidden variation ID/SKU/price và mở CTA. Tuy nhiên mô tả còn liệt kê Kẹo tròn 1m8/2m không tồn tại trong selector. Ảnh chung in quy cách/giá khác data bán, gồm gậy 1m50 và giá cao hơn. Chưa thêm từng option vào giỏ hoặc có bằng chứng bảo toàn đơn lịch sử.

Bảng COMBO-GD-50, lính 38cm và vật liệu kẹo đã sửa đúng lỗi R32. SET-HG-70 vẫn mô tả dùng cây **1m8–2m4** nhưng bảng ghi **1m8–2m1**; bảng thêm LED trong khi mô tả thành phần chưa làm rõ. Vì vậy R2-03 FAIL và R2-02 PARTIAL, đều OPEN.

### R31-01 — runtime thời hạn đã khớp nhưng inventory/control chưa đủ

Sau clear toàn bộ cookie/storage, homepage ghi sáu cookie Sourcebuster session và `sbjs_session` hết hạn khoảng 30 phút; sessionStorage tạo `wc_cart_hash`/`wc_fragments_*`. Policy nay công bố đúng các thời hạn này, nêu Contact/B2B/comment, đơn hàng 2 năm, lead 12 tháng, quyền xóa và giữ notice Contact/comment.

Profile sạch không có UI accept/reject/change choice; policy gọi attribution phục vụ phân bổ truyền thông nhưng không phân loại rõ essential/tùy chọn hoặc cung cấp control first-party. Inventory chưa nêu đủ `comment`/URL form, entry/referrer/page/user-agent, account/login và các tài nguyên Google Maps/Fonts, Cloudflare Insights, Gravatar; thời hạn từng HTML5 key cũng chưa rõ. R31-01 giữ PARTIAL/OPEN.

### R2-22 — identity đồng bộ, trust evidence chưa đạt

Contact, About, privacy, footer, Organization schema và payment cùng công bố **Hộ Kinh Doanh Trang Trí 4 Mùa**, MST/ĐKKD **0318294567**, địa chỉ/hotline/email; payment đặt thông tin chủ thể ngay trước tài khoản thụ hưởng `TRANG TRI 4 MUA`. Homepage đã bỏ “1.200 khách” và badge “Đã mua”.

Homepage vẫn gọi ba testimonial 5 sao là **“Đánh Giá Thực Tế”** nhưng không có nguồn/ngày/link/consent. Bài dự toán vẫn nói **“kinh nghiệm thi công hàng trăm công trình thực tế”**; About/FAQ còn claim ảnh chụp thực tế 100% và hơn 200 mẫu mà không có hồ sơ đối chứng. Identity mới là self-declared; không xác minh giấy đăng ký/tài khoản ngân hàng. R2-22 PARTIAL/OPEN.

### R2-05 — công thức an toàn vẫn không có căn cứ áp dụng

Bài cafe vẫn hướng dẫn cây ngoài trời dùng bao cát 15–20kg; cây ≥2m1 dùng cước 25–30kg neo vào móc dán tường 3M hoặc điểm tựa. Câu bổ sung về loại sàn/gió không nêu model cây/đế/móc, nền dán, giới hạn gió hay tải toàn hệ.

Bài dự toán ghi 3–5W/cuộn, 24W cho 30–40m và 60W cho 50–80m, nhưng bảng khác lại ghi 30m khoảng 15–18W; không có model/datasheet. FAQ còn hướng dẫn phun tuyết bọt theo phiên không gắn sản phẩm/NSX. R2-05 FAIL/OPEN.

### R2-04 — hero tốt hơn, đích và phạm vi offer chưa đồng bộ

Hero đã bỏ “8+”/“Tiết Kiệm 20%”, phân biệt set phụ kiện 50–70 món với combo có cây; **Xem Set Combo** tới listing ba sản phẩm có giá. Tuy nhiên:

- bullet chung liệt kê châu/kẹo/nơ/sao/LED cho mọi set 50–70, trong khi SET-HG-70 không công bố đầy đủ thành phần đó;
- metadata listing vẫn nói mọi combo có cây và “Tiết kiệm 15%–20%”, trong khi hai set không có cây và COMBO-GD-50 giảm khoảng 21%;
- card Cây ghi đủ size 1m2–2m4 nhưng hai PDP không có 1m2;
- card Đèn/Quà vẫn dẫn category 0 sản phẩm mà nguồn không báo “đang cập nhật/tư vấn”.

R2-04 PARTIAL/OPEN.

### R2-20 — policy heading tree chưa được sửa

Contact và Showroom đều có một main; hai iframe có title cụ thể, nhận focus và Tab tiếp sang control kế tiếp. Heading hai trang nay đi H1→H2→H3.

Policy vẫn dùng H4 để lấy cỡ chữ:

- Privacy và Shipping mở H1 rồi H4;
- Shipping/Returns có H4 trực tiếp dưới H2;
- Payment có H4 dưới H3, sidebar cũng dùng H4.

Vì location gốc gồm policy template và acceptance yêu cầu heading tree trên mỗi page, R2-20 giữ PARTIAL/OPEN.

## Ghi nhận current-state sau R34 — R4-01 chưa đổi trạng thái

Asset `theme-scripts.js?ver=1790267299` sau Batch 6 không còn timer 4 giây trong `handleInstantCheckout()`. Một phép giữ/abort POST 6,5 giây mới ở nút PDP không tự điều hướng, giỏ vẫn 0. Đây là cải thiện so snapshot Batch 4 của R34.

Chưa kiểm đủ success path, sticky, double-click, giỏ đã có hàng và retry/error UI nên không dùng phép recheck ngoài phạm vi này để đóng R4-01. Trạng thái vẫn OPEN; Coder nên bàn giao riêng theo toàn acceptance.

## Bằng chứng R35

[JSON tổng hợp](review-evidence/2026-09-24/r35-batch5-6-verification.json) · [B2B focus](review-evidence/2026-09-24/r35-b2b-focused.webp) · [policy DOM order](review-evidence/2026-09-24/r35-policy-dom-order.webp) · [Showroom map/heading](review-evidence/2026-09-24/r35-showroom-map-heading.webp) · [hero](review-evidence/2026-09-24/r35-home-hero.webp) · [5 option kẹo](review-evidence/2026-09-24/r35-candy-options.webp) · [SET-HG-70 mismatch](review-evidence/2026-09-24/r35-set70-spec-mismatch.webp) · [hướng dẫn neo](review-evidence/2026-09-24/r35-safety-anchor-guidance.webp) · [privacy storage](review-evidence/2026-09-24/r35-privacy-storage-policy.webp).

## Giới hạn và bàn giao R35

- Đóng **1 P1** (R2-06) và **2 P2** (R2-15, R2-07). Tổng hiện hành **33 OPEN — 9 P1, 18 P2, 6 P3**. Không thêm issue mới.
- Không xác minh đơn lịch sử, owner approval, nhãn/vật liệu, giấy đăng ký/MST, tài khoản thụ hưởng, review/case study, retention backend hoặc quyền GSC.
- Không gửi form/bình luận, gọi/Zalo, thêm giỏ hoặc đặt đơn. Cuối vòng giỏ 0₫; browser riêng đã đóng.
- Bộ bằng chứng gồm **1 JSON + 8 screenshot**. Báo cáo và bằng chứng chỉ được coi đã bàn giao sau khi commit/push thành công.
