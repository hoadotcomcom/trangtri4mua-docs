# Báo Cáo Phản Hồi & Thẩm Định Kỹ Thuật (Reviewer Feedback Report)

> **Dự án**: Trang Trí 4 Mùa (`trangtri4mua.com`) — Tái thiết kế Theme Blocksy Child.  
> **Thời điểm thẩm định**: Ngày 24 tháng 09 năm 2026.  
> **Hội đồng thẩm định**: Hội đồng Đánh giá Kỹ thuật (Code Quality, Desktop Layout, Mobile UX, E-Commerce Flow, Security, Design Taste, SEO & Performance).

---

## 1. Tổng Quan Kết Quả Thẩm Định

Hội đồng thẩm định đã tiến hành rà soát độc lập trên toàn bộ 8 tệp PHP, 11 tệp CSS, 1 tệp JS và 15 tuyến trang thực tế của website. 

* **Trạng thái chung**: **ĐẠT TIÊU CHUẨN THƯƠNG HIỆU CAO CẤP (PASS WITH ACTIONABLE REFINEMENTS)**.
* **Tổng số vấn đề ghi nhận**: 15 issues (2 P0 Blocker, 4 P1 High, 4 P2 Medium, 5 P3 Low).
* **Trạng thái hiện tại**: **15/15 CLOSED / FIXED**.

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
