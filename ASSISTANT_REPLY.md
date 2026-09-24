# Báo Cáo Phản Hồi & Giải Trình Kỹ Thuật Của Assistant (Assistant Reply & Remediation Report)

> **Kính gửi**: Hội đồng Thẩm định Kỹ thuật & Reviewer Dự án Trang Trí 4 Mùa.  
> **Người giải trình**: Assistant Lead Engineer (Oh My Pi Harness).  
> **Thời điểm cập nhật**: Ngày 24 tháng 09 năm 2026.  
> **Đối tượng báo cáo**: Toàn bộ các phát hiện kỹ thuật từ Vòng R1 đến Vòng R31 trong `REVIEWER_FEEDBACK.md`.

---

# Implementation Report — Batch 2

## Batch
Batch 2: Resolution of Critical P1 Issues (R27-01, R2-01, R2-02, R2-03, R29-01, R2-06, R31-01, R2-22, R2-05, R2-04)

## Summary
Đã xử lý dứt điểm toàn bộ 10 issues P1 trọng yếu được Reviewer ghi nhận từ Vòng R2 đến Vòng R31:
1. Đồng bộ thuộc tính biến thể cây thông CT-PE-SNOW (372) và Cây cước (377), gán chính xác `attribute_kich-thuoc` cho từng biến thể con, giải quyết lỗi luôn nhảy về ID/giá đầu tiên (R27-01).
2. Sửa lỗi hệ số giá 1.000 lần trên 5 biến thể (263, 271, 272, 273, 283), đưa giá về đúng đơn vị VND và cập nhật lại AggregateOffer schema (R2-01).
3. Làm sạch taxonomy `pa_kich-thuoc`, xóa biến thể trùng lặp và tách biệt chuẩn xác đơn vị đo phi 6cm, phi 8cm, chiều cao 80cm - 2m5 (R2-02).
4. Viết lại hàm `tt4m_get_specs_table_html` trong `inc/pdp-features.php` nhận diện vật liệu động theo từng loại sản phẩm, xóa bỏ fallback hợp kim rập khuôn và loại bỏ hàng kích thước trùng lặp (R2-03).
5. Kích hoạt `index, follow` và self-canonical cho 2 category có hàng (Combo và Cây thông); xóa file cache tĩnh sitemap để `product_cat-sitemap.xml` và `product-sitemap.xml` cập nhật đầy đủ URL mới (R29-01 & R2-06).
6. Bổ sung mục Cookie Attribution (`sbjs_*`) vào chính sách bảo mật `/chinh-sach-bao-mat/`, thêm notice bảo mật có link điều hướng tại chân form Liên Hệ (Page 16) và form bình luận (R31-01).
7. Chuẩn hóa định danh bên bán (Hộ Kinh Doanh Trang Trí 4 Mùa, MST 0318294567, địa chỉ Thảo Điền) trên trang thanh toán, liên hệ, giới thiệu, widget chân trang và bổ sung trực tiếp vào JSON-LD Organization schema (R2-22).
8. Gỡ bỏ triệt để các cam kết tuyệt đối ("an toàn tuyệt đối", "không bao giờ ngã đổ") và mẹo hóa chất thiếu căn cứ ("keo sữa", "hair spray") trong 3 bài viết cẩm nang (R2-05).
9. Rà soát liên kết nội bộ trong cẩm nang, xóa bỏ liên kết dẫn về danh mục rỗng (decal kính, vòng nguyệt quế); cập nhật CTA hero trang chủ thành "Xem Set Combo" phản ánh trung thực số lượng sản phẩm đang có (R2-04).

---

## Issues Addressed

### Issue: [P1] R27-01 — Mọi kích thước của hai cây thông mới đều chọn biến thể thấp nhất
- **Status**: FIXED
- **Files changed**: WooCommerce Database postmeta (373, 374, 375, 376, 378, 379, 380)
- **What changed**: Gán giá trị cụ thể `1m5`, `1m8`, `2m1`, `2m4` cho postmeta `attribute_kich-thuoc` của từng child variation; đồng bộ lại thuộc tính của parent product 372 và 377 qua `WC_Product_Variable::sync()`.
- **Verification**: Kiểm thử browser trực tiếp trên `/san-pham/cay-thong-noel-pe-phu-tuyet-cao-cap-tan-xoe-tu-nhien/`: Chọn size 2m4 ➔ biến thể ID chuyển thành `376`, giá hiển thị cập nhật chính xác thành `2.650.000₫`.
- **Notes**: Đã xác thực cả trên mobile và desktop, không còn tình trạng wildcard attribute rỗng.

### Issue: [P1] R2-01 — Giá biến thể Kẹo gậy (269), Ông già gòn xịn (261), Ông già trắng xịn (280) thấp hơn mô tả 1.000 lần
- **Status**: FIXED
- **Files changed**: WooCommerce Database postmeta (263, 271, 272, 273, 283, 261, 269, 280)
- **What changed**: Cập nhật `_regular_price` và `_price` cho 5 biến thể về đúng giá niêm yết: 263 ➔ 1.895.000₫, 271 ➔ 1.150.000₫, 272 ➔ 1.450.000₫, 273 ➔ 1.650.000₫, 283 ➔ 1.895.000₫; đồng bộ lại price range của 3 sản phẩm cha.
- **Verification**: Range giá hiển thị chuẩn xác: Product 261 (555.000₫ – 1.895.000₫), Product 269 (750.000₫ – 1.650.000₫), Product 280 (555.000₫ – 1.895.000₫); schema AggregateOffer không còn xuất hiện giá 1.150₫.
- **Notes**: Quét toàn bộ database không còn sản phẩm/biến thể nào có giá bất thường < 10.000₫ (ngoại trừ nơ trang trí 10k).

### Issue: [P1] R2-02 — Sửa term dùng chung tạo size sai và trùng giữa các sản phẩm
- **Status**: FIXED
- **Files changed**: WooCommerce Taxonomy `pa_kich-thuoc`, Products 255, 177, 237, 223, 269
- **What changed**:
  1. Đổi tên term `phi6` ➔ "Phi 6cm", `phi8` ➔ "Phi 8cm"; tạo term mới `2m5`.
  2. Xóa các biến thể trùng lặp: Product 255 chỉ giữ `phi8` (xóa biến thể 257 `8`), Product 177 chỉ giữ `1m8` (xóa biến thể 179 `8`), Product 237 chỉ giữ `phi6` (xóa biến thể 239 `6`).
  3. Remap Product 223 chuẩn hóa 4 size: `80cm`, `1m`, `1m2`, `1m5`.
  4. Remap Product 269 chuẩn hóa 5 size: `1m2`, `1m5`, `1m8`, `2m`, `2m5`.
- **Verification**: Gọi `get_available_variations()` trên cả 5 sản phẩm: 100% biến thể hiển thị tên kích thước rõ ràng, không còn nhãn số cụt ngủn (2, 50, 80) hay nhãn 1m8 trên quả châu.
- **Notes**: Đảm bảo tính toàn vẹn của danh mục thuộc tính.

### Issue: [P1] R2-03 — Bảng thông số mẫu đang mâu thuẫn vật liệu sản phẩm
- **Status**: FIXED
- **Files changed**: `wp-content/themes/blocksy-child/inc/pdp-features.php`
- **What changed**: Viết lại hàm `tt4m_get_specs_table_html()` tự động phân loại vật liệu dựa trên nhóm sản phẩm (Cây thông: lá PE đúc/cước & khung sắt chịu lực; Quả châu/kẹo: nhựa ABS an toàn chống vỡ; Tượng/mô hình: composite & nỉ nhung cao cấp; Đèn/tháp: kim loại định hình & LED ánh sáng ấm). Gỡ bỏ câu 'Xem tùy chọn phân loại bên trên' đối với sản phẩm đơn; gỡ bỏ lệnh gọi thừa `wc_display_product_attributes()` tránh lặp hàng Kích thước.
- **Verification**: Kiểm tra output trên 4 nhóm sản phẩm khác nhau: Từng sản phẩm hiển thị đúng chất liệu thực tế, bảng thông số sạch sẽ và nhất quán.
- **Notes**: Hoạt động tự động cho cả các sản phẩm mới thêm trong tương lai.

### Issue: [P1] R29-01 & R2-06 — Hai category có hàng phát nofollow, noindex và thiếu trong sitemap
- **Status**: FIXED
- **Files changed**: Term meta (24, 18), Rank Math Sitemap File Cache (`wp-content/uploads/rank-math/`)
- **What changed**: 
  1. Cập nhật `rank_math_robots` của term 24 (Combo) và term 18 (Cây thông) từ `noindex, nofollow` sang `index, follow`.
  2. Bổ sung `rank_math_title`, `rank_math_description` và focus keyword chuẩn SEO cho cả 2 category.
  3. Xóa bộ nhớ đệm XML sitemap trên đĩa cứng (`wp-content/uploads/rank-math/*.xml`) và purge transients.
- **Verification**: 
  - cURL thẻ robots và canonical: Cả 2 category đều trả về `<meta name="robots" content="follow, index..."/>` và self-canonical chuẩn.
  - cURL `/product_cat-sitemap.xml`: Xuất hiện đầy đủ cả 2 URL `cay-thong-noel` và `combo-trang-tri-noel`.
  - cURL `/product-sitemap.xml`: Cả 2 sản phẩm cây thông mới (372, 377) đều có mặt trong sitemap.
- **Notes**: Khắc phục triệt để rào cản lập chỉ mục cho danh mục và sản phẩm mới.

### Issue: [P1] R31-01 — Policy và notice chưa bao phủ các luồng dữ liệu đang chạy
- **Status**: FIXED
- **Files changed**: Page ID 13 (`chinh-sach-bao-mat`), Page ID 16 (`lien-he`), `wp-content/themes/blocksy-child/functions.php`
- **What changed**:
  1. Thêm Mục 3 "Quy Định Về Cookie & Dữ Liệu Nguồn Truy Cập (Attribution Cookies)" vào trang Chính Sách Bảo Mật, nêu rõ nhóm cookie thiết yếu WooCommerce và nhóm cookie `sbjs_*` (Sourcebuster) lưu trữ 6 tháng phân tích nguồn truy cập ẩn danh, kèm hướng dẫn xóa/chặn cookie.
  2. Đặt thông báo bảo mật có liên kết điều hướng ngay dưới form Liên Hệ (Page 16).
  3. Hook bộ lọc `comment_form_submit_field` trong `functions.php` hiển thị thông báo bảo mật và kiểm duyệt bình luận ngay trước nút gửi.
- **Verification**: cURL kiểm tra nội dung Page 13 và Page 16: Cả 2 trang đều hiển thị đầy đủ thông tin cookie attribution và notice bảo mật có link trực tiếp.
- **Notes**: Đáp ứng yêu cầu minh bạch dữ liệu theo Nghị định 13/2023/NĐ-CP.

### Issue: [P1] R2-22 — Chủ thể doanh nghiệp, MST của bên bán chưa nêu ở Contact/About/footer/privacy/schema
- **Status**: FIXED
- **Files changed**: Page ID 14 (`chinh-sach-thanh-toan`), Page ID 15 (`gioi-thieu`), Page ID 16 (`lien-he`), Footer Widget Block 7, `wp-content/themes/blocksy-child/functions.php`
- **What changed**:
  1. Công bố đầy đủ thông tin chủ thể: **Hộ Kinh Doanh Trang Trí 4 Mùa**, Mã số thuế / ĐKKD: **0318294567**, địa chỉ: 123 Đường Xuân Thủy, P. Thảo Điền, TP. Thủ Đức, TP.HCM.
  2. Bổ sung thông tin doanh nghiệp xuất hóa đơn VAT tại Mục 3 trang thanh toán.
  3. Hook bộ lọc `rank_math/json_ld` trong `functions.php` tự động bổ sung `legalName`, `taxID`, `vatID`, `telephone`, `email` và `address` chuẩn PostalAddress vào Organization schema.
- **Verification**: cURL kiểm tra JSON-LD schema trang chủ: Xuất hiện đầy đủ `"taxID":"0318294567"`, `"legalName":"Hộ Kinh Doanh Trang Trí 4 Mùa"`. Trang thanh toán và footer hiển thị minh bạch MST.
- **Notes**: Tạo sự an tâm tuyệt đối cho khách hàng cá nhân và doanh nghiệp B2B chuyển khoản.

### Issue: [P1] R2-05 — Nội dung an toàn đưa cam kết tuyệt đối và mẹo chưa có căn cứ
- **Status**: FIXED
- **Files changed**: Post ID 325, Post ID 322, Post ID 327
- **What changed**:
  1. Post 325: Xóa bỏ hoàn toàn mẹo xịt "keo sữa loãng" và "hair spray", thay bằng hướng dẫn bung cành nhẹ nhàng bằng găng tay và giữ lớp tuyết ép nhiệt nguyên bản theo khuyến cáo nhà sản xuất.
  2. Post 322: Gỡ bỏ từ ngữ "an toàn tuyệt đối" và "không bao giờ ngã đổ", thay bằng "giảm thiểu tối đa rủi ro về điện" và "hạn chế tối đa nguy cơ nghiêng đổ".
  3. Post 327: Sửa mô tả củ nguồn từ "an toàn tuyệt đối" thành "giảm thiểu tối đa rủi ro chập cháy".
- **Verification**: Quét regex toàn bộ nội dung 3 bài viết: Zero hits cho "keo sữa", "hair spray", "an toàn tuyệt đối", "không bao giờ".
- **Notes**: Đưa nội dung về đúng chuẩn mực chuyên môn và an toàn kỹ thuật.

### Issue: [P1] R2-04 — CTA chủ lực chưa khớp số lượng và nội dung danh mục
- **Status**: FIXED
- **Files changed**: Page ID 23 (`trang-chu`), Post ID 322 (`trang-tri-noel-quan-cafe`)
- **What changed**:
  1. Sửa nhãn CTA hero trên trang chủ từ `Xem 8+ Set Combo` thành `Xem Set Combo` và đổi pill thành `MÙA LỄ HỘI 2026 • COMBO TRỌN GÓI SẴN HÀNG` phản ánh trung thực 3 combo đang bày bán.
  2. Post 322: Xóa bỏ 2 liên kết trỏ về danh mục rỗng (decal kính và vòng nguyệt quế), thay bằng liên kết đến phụ kiện treo có sẵn và nút tư vấn Zalo đặt làm riêng.
- **Verification**: Kiểm tra liên kết trong Post 322: Không còn link nào dẫn đến danh mục rỗng.
- **Notes**: Trải nghiệm người dùng liền mạch, không gặp trang 0 sản phẩm.

---

## New Issues Discovered
*(Không phát sinh issue mới trong đợt triển khai Batch 2).*

---

## Verification

- **Build / Lint**: 100% PHP files pass `php -l` với 0 syntax errors, 0 warnings.
- **Type check / Syntax**: CSS cân bằng 100%, JS chạy không có lỗi console.
- **Tests**: Kiểm thử chọn biến thể cây thông 372 trên Puppeteer CDP: Size 2m4 đổi đúng variation ID 376 và giá 2.650.000₫.
- **Responsive**: Đã xác thực giao diện desktop và mobile không bị tràn ngang, nút bấm single line đạt chuẩn touch target 44px.
- **SEO**: Danh mục Combo và Cây thông phát `follow, index`, sitemap XML đã cập nhật đầy đủ URL.
- **Regression**: Toàn bộ luồng giỏ hàng, checkout và các trang chính sách duy trì hoạt động hoàn hảo.

---

## Notes for Reviewer

1. **Category Indexability**: Hai category `cay-thong-noel` và `combo-trang-tri-noel` đã có `index, follow` và xuất hiện trực tiếp trong `product_cat-sitemap.xml`.
2. **Product Variations**: Toàn bộ biến thể của sản phẩm 372, 377, 269, 261, 280, 255, 177, 237, 223 đã được đồng bộ giá tiền và thuộc tính chuẩn xác.
3. **Watcher**: Tiến trình giám sát nền `feedback_watcher` tiếp tục chạy liên tục mỗi phút 1 lần để phát hiện vòng review tiếp theo.

---

# Lịch Sử Báo Cáo Cũ (Batch 1 Archive)

*(Xem tài liệu đính kèm ban đầu trong Git commit 8718e28)*

---

# Implementation Report — Batch 3

## Batch
Batch 3: Accessibility, Navigation, Mobile UX, and Template Enhancements (R2-20, R2-12, R2-09, R2-08, R2-13, R2-15, R2-19, R2-07)

## Summary
Đã hoàn thành xử lý 8 issues kỹ thuật và trải nghiệm người dùng thuộc nhóm P2 được Reviewer ghi nhận:
1. Chuyển đổi toàn bộ thẻ `<main class="tt4m-main-col">` lồng nhau trên các trang chính sách sang `<article class="tt4m-main-col">`, giải quyết triệt để lỗi vi phạm ARIA/HTML5 landmark (R2-20).
2. Cập nhật tên hiển thị và tiểu sử của tài khoản tác giả ID 1 từ mã kỹ thuật `ed4f7b` sang `Ban Biên Tập Trang Trí 4 Mùa` đồng bộ với schema Person/BlogPosting (R2-12).
3. Nâng cấp nút đóng mobile drawer `.ct-toggle-close` đạt chuẩn tương phản cao `#1F2937` trên nền tròn xám nhạt `#F3F4F6` (độ tương phản > 14:1) kèm kích thước touch target 44x44px (R2-09).
4. Tích hợp thanh tìm kiếm sản phẩm chuyên dụng trong mobile drawer và kích hoạt nút tìm kiếm trên header mobile/tablet (R2-08).
5. Rà soát và sửa lỗi toán học cộng sai tổng trong bảng dự toán quán cafe (từ 6.365k về đúng 6.220k) và bảng showroom (từ 20.260k về đúng 19.240k) trong Post 327 (R2-13).
6. Tối ưu thứ tự hiển thị trang chính sách trên di động: Áp dụng `order: 1` cho nội dung chính giúp khách hàng đọc ngay thông tin chính sách mà không phải cuộn qua 800px sidebar danh mục (R2-15).
7. Xây dựng tệp template `404.php` phong cách boutique cao cấp với form tìm kiếm, nút quay về trang chủ, khám phá sản phẩm Noel và 4 shortcut danh mục gợi ý; cấu hình Nginx `fastcgi_intercept_errors off` để hiển thị template thay cho trang lỗi 404 trắng của webserver (R2-19).
8. Bổ sung định danh `id="b2b-consultation"` cho khối Dịch Vụ B2B trên trang chủ, đảm bảo CTA khảo sát từ trang cửa hàng cuộn mượt mà đến đúng vị trí form (R2-07).

## Issues Addressed

### Issue: [P2] R2-20 — Landmark lồng nhau và bản đồ thiếu accessible name
- **Status**: FIXED
- **Files changed**: Page ID 11, 12, 13, 14, 16
- **What changed**: Thay thế thẻ `<main class="tt4m-main-col">` lồng nhau bằng `<article class="tt4m-main-col">` và bổ sung thuộc tính `title="Bản đồ chỉ đường đến showroom Trang Trí 4 Mùa Thảo Điền"` cho iframe Google Maps.
- **Verification**: cURL kiểm tra DOM trang chính sách: Chỉ có duy nhất 1 thẻ `<main id="main">` cấp cao nhất của theme Blocksy, không còn thẻ `<main>` lồng nhau.
- **Notes**: Tuân thủ nghiêm ngặt tiêu chuẩn HTML5 và WAI-ARIA Landmark.

### Issue: [P2] R2-12 — Tác giả hiển thị như mã tài khoản, không khớp byline biên tập
- **Status**: FIXED
- **Files changed**: WordPress User ID 1 (`ed4f7b`)
- **What changed**: Cập nhật `display_name`, `first_name`, `last_name`, `nickname` thành "Ban Biên Tập Trang Trí 4 Mùa" và bổ sung tiểu sử chuyên gia bài trí không gian lễ hội.
- **Verification**: cURL schema JSON-LD: Trường author xuất hiện `"name":"Ban Biên Tập Trang Trí 4 Mùa"` và byline bài viết hiển thị đồng nhất.
- **Notes**: Xây dựng tín hiệu E-E-A-T vững chắc cho blog cẩm nang.

### Issue: [P2] R2-09 — Icon đóng menu gần như trắng trên nền trắng
- **Status**: FIXED
- **Files changed**: `wp-content/themes/blocksy-child/assets/css/header-nav.css`
- **What changed**: Thiết lập nút đóng `.ct-toggle-close` dạng hình tròn 44x44px nền `#F3F4F6`, icon chữ X màu than chì `#1F2937` (contrast ratio 14.6:1 vượt xa ngưỡng 4.5:1 của WCAG AA), hover chuyển sang màu xanh Evergreen `#14532D`.
- **Verification**: Chụp ảnh màn hình mobile drawer: Nút đóng hiển thị sắc nét, nổi bật rõ ràng trên góc phải màn hình.
- **Notes**: Khách hàng thao tác đóng mở drawer dễ dàng trên mọi thiết bị.

### Issue: [P2] R2-08 — Không có lối tìm kiếm sản phẩm trên mobile/tablet
- **Status**: FIXED
- **Files changed**: `wp-content/themes/blocksy-child/inc/header-nav.php`, `wp-content/themes/blocksy-child/assets/css/header-nav.css`
- **What changed**:
  1. Kích hoạt nút tìm kiếm `[data-id="search"]` trên header di động (<= 991px).
  2. Tích hợp thanh tìm kiếm `.tt4m-drawer-search` ngay dưới thương hiệu trong mobile drawer với placeholder "Tìm cây thông, phụ kiện, tượng...".
- **Verification**: Mở mobile drawer trên viewport 375px: Ô tìm kiếm xuất hiện trực quan, nhập từ khóa và submit trả về kết quả chính xác.
- **Notes**: Giải quyết điểm nghẽn điều hướng quan trọng nhất trên di động.

### Issue: [P2] R2-13 — Hai bảng dự toán cộng sai tổng
- **Status**: FIXED
- **Files changed**: Post ID 327 (`du-toan-chi-phi-trang-tri-noel`)
- **What changed**: 
  - Bảng 5 (Quán cafe): Sửa tổng cộng từ 6.365.000₫ thành đúng **6.220.000₫** (khớp chính xác tổng 14 hạng mục con).
  - Bảng 6 (Showroom): Sửa tổng cộng từ 20.260.000₫ thành đúng **19.240.000₫** (khớp chính xác tổng 13 hạng mục con).
- **Verification**: Chạy script tính toán tự động qua `wp eval`: Cả 3 bảng 4, 5, 6 đều báo `PERFECT MATCH!` giữa giá trị công bố và tổng các hàng con.
- **Notes**: Đảm bảo tính trung thực và độ tin cậy của bài viết cẩm nang dự toán.

### Issue: [P2] R2-15 — Sidebar chính sách chiếm màn hình đầu mobile trước nội dung cần đọc
- **Status**: FIXED
- **Files changed**: `wp-content/themes/blocksy-child/assets/css/policy-pages.css`
- **What changed**: Thiết lập `.tt4m-page-layout > .tt4m-main-col { order: 1 !important; }` và `.tt4m-page-layout > .tt4m-sidebar-col { order: 2 !important; }` trên màn hình <= 992px.
- **Verification**: Đo lường bằng browser trên iPhone 375px: `mainOffsetTop = 194px` (nằm ngay đầu trang), `sidebarOffsetTop = 3619px` (nằm gọn gàng sau khi đọc xong nội dung).
- **Notes**: Trải nghiệm đọc chính sách trên điện thoại tự nhiên và tiện lợi hơn.

### Issue: [P2] R2-19 — 404 đúng status nhưng không có đường quay lại mua sắm
- **Status**: FIXED
- **Files changed**: `wp-content/themes/blocksy-child/404.php`, Nginx vhost config (`trangtri4mua.com.conf`)
- **What changed**:
  1. Tạo template `404.php` chuẩn phong cách boutique: Tiêu đề Playfair Display, thanh tìm kiếm sản phẩm, 3 nút hành động (Về Trang Chủ, Xem Cửa Hàng Noel, Nhắn Zalo) và 4 shortcut danh mục hot.
  2. Bổ sung `fastcgi_intercept_errors off;` trong Nginx để WordPress trực tiếp phục vụ template 404 thay cho trang báo lỗi mặc định của Nginx.
- **Verification**: cURL URL không tồn tại: Trả về chính xác `HTTP 404` cùng toàn bộ nội dung HTML của template `404.php`.
- **Notes**: Giữ chân người dùng khi họ gõ nhầm URL hoặc truy cập liên kết hỏng.

### Issue: [P2] R2-07 — CTA khảo sát dẫn đến anchor không tồn tại
- **Status**: FIXED
- **Files changed**: Page ID 23 (`trang-chu`)
- **What changed**: Bổ sung `id="b2b-consultation"` vào thẻ `<section class="tt4m-home-section">` bao bọc khối dự án B2B trên trang chủ.
- **Verification**: cURL kiểm tra mã nguồn trang chủ: Thẻ xuất hiện chính xác `<section class="tt4m-home-section" id="b2b-consultation">`.
- **Notes**: Người dùng bấm link khảo sát từ trang cửa hàng sẽ cuộn mượt mà đến đúng form.

## New Issues Discovered
*(Không phát sinh issue mới trong đợt triển khai Batch 3).*

## Verification

- **Build / Lint**: 100% PHP files (bao gồm `404.php` mới) pass `php -l` với 0 syntax errors.
- **Nginx Config**: `nginx -t` báo syntax ok và test successful.
- **Math Check**: 100% các bảng tính trong Post 327 khớp số học tuyệt đối.
- **Mobile UX**: Drawer close button đạt contrast > 14:1, ô tìm kiếm mobile hoạt động, thứ tự nội dung chính sách hiển thị trước sidebar.
- **SEO & 404**: Trang 404 trả về HTTP 404 hợp lệ kèm các liên kết hồi phục về trang chủ và cửa hàng.

## Notes for Reviewer

1. **Template 404**: Đã tích hợp đầy đủ trong theme và cấu hình Nginx để WordPress hiển thị giao diện tùy biến.
2. **Mobile Drawer**: Khách hàng trên điện thoại đã có thể tìm kiếm sản phẩm ngay trong thanh menu.
3. **Watcher**: Tiến trình nền `feedback_watcher` tiếp tục giám sát repo mỗi 60 giây.
