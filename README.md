# Trang Trí 4 Mùa — Luxury Festive Holiday Decor & E-Commerce Theme

> **Bản quyền**: © 2026 Trang Trí 4 Mùa (`trangtri4mua.com`).  
> **Nền tảng**: WordPress 6.x + WooCommerce 11.x + Blocksy Child Theme.  
> **Phiên bản Theme**: 2.2.0 (Boutique Edition).  
> **Kiến trúc**: Clean Modular Architecture (PSR-4 compliant, phân tách CSS/PHP theo khối chức năng).

---

## 1. Giới Thiệu & Bối Cảnh Dự Án

**Trang Trí 4 Mùa** là thương hiệu hàng đầu tại Việt Nam chuyên cung cấp phụ kiện cây thông Noel, tượng mô hình Giáng Sinh, đồ trang trí Tết Nguyên Đán và các giải pháp decor trọn gói cho tư gia, căn hộ, quán cà phê, nhà hàng, showroom và văn phòng doanh nghiệp.

Dự án này được khởi tạo nhằm **đại tu và tái thiết kế toàn diện** giao diện theme, chuyển đổi từ một website bán hàng WordPress mặc định thành một **không gian thương mại điện tử lễ hội cao cấp (Luxury Holiday Boutique)**, sánh ngang các tiêu chuẩn quốc tế như **Balsam Hill**, **Pottery Barn Holiday** và **Zara Home**, đồng thời tối ưu hóa 100% cho thói quen mua sắm của người tiêu dùng Việt Nam.

---

## 2. Các Mục Tiêu Cốt Lõi Đã Đạt Được

1. **Loại bỏ triệt để đặc trưng AI (100% De-AI Standard)**:
   - Xóa bỏ hoàn toàn chữ gradient cầu vồng, hiệu ứng viền neon chói mắt và các biểu tượng emoji lộn xộn trong tiêu đề.
   - Viết lại toàn bộ bài viết cẩm nang và trang chính sách bằng văn phong chuyên gia nội thất chân thực, bóc tách chi phí minh bạch, không dùng sáo ngữ quảng cáo sáo rỗng.
2. **Kiến trúc mô-đun hóa độc lập (Modular Separation)**:
   - Tách tệp `style.css` (2.590 dòng) và `functions.php` (412 dòng) cồng kềnh trước đây thành **10 tệp CSS chuyên biệt** và **6 tệp PHP độc lập** theo đúng trách nhiệm nghiệp vụ.
3. **Tối ưu hóa chuyển đổi mua sắm (High-Converting WooCommerce)**:
   - Đưa khối **Combo Cây Thông & Phụ Kiện Trọn Gói Sẵn Sàng (Tiết kiệm 15% – 20%)** lên làm Hero Banner trang chủ để tối ưu giá trị đơn hàng trung bình (AOV).
   - Rút gọn form thanh toán chuẩn Việt Nam (ưu tiên SĐT 10 số, Tên, Địa chỉ, Tỉnh/Thành, Phường/Xã).
   - Thanh tiến độ Miễn phí vận chuyển (500.000₫) cập nhật động qua AJAX fragments.
   - Cam kết **Đồng kiểm COD mở hộp** và hỗ trợ xuất **Hóa đơn điện tử GTGT (VAT)** cho doanh nghiệp.
4. **Trải nghiệm di động hoàn hảo (Mobile-First UX)**:
   - Nút bấm điều hướng nằm ngang trên cùng một dòng (side-by-side) đạt chuẩn touch target $\ge 44\text{px}$.
   - Thanh chốt đơn dính đáy (Sticky Purchase Bar) 60px nền kính mờ (frosted glass) hỗ trợ `env(safe-area-inset-bottom)` cho iPhone.
   - Bảng biểu chính sách cuộn ngang cảm ứng mượt mà (`overflow-x: auto`), không bị cắt mép.
5. **Hệ thống Design Tokens & Typography sang trọng**:
   - Tích hợp cặp font chuẩn biên tập tạp chí: **`Playfair Display`** (Serif tiêu đề sang trọng) và **`Be Vietnam Pro`** (Sans hình học sắc nét, tối ưu trọn vẹn dấu thanh tiếng Việt).
   - Bảng màu xanh lá thông sẫm (*Evergreen #14532D*), đỏ quả mọng (*Festive Crimson #C41E2F*), vàng champagne (*Antique Gold #D97706*) và kem ngọc trai (*Warm Ivory #FAF8F5*).

---

## 3. Cấu Trúc Thư Mục Theme (`blocksy-child`)

```
wp-content/themes/blocksy-child/
├── functions.php                    # Bộ điều phối trung tâm: Nạp Google Fonts, enqueue CSS/JS có hash, 301 redirects
├── style.css                        # Tệp định danh Child Theme, các quy tắc ghi đè nền tảng Blocksy & Print CSS
├── home.php                         # Template Tạp chí Cẩm nang & Ý tưởng Trang trí (/y-tuong-trang-tri/)
├── inc/
│   ├── header-nav.php               # Topbar thông báo thanh lịch, menu điều hướng, Drawer mobile phân cấp
│   ├── shop-features.php            # Category chips đếm sản phẩm, tính toán % giảm giá, form khảo sát B2B [tt4m_b2b_consultation_form]
│   ├── pdp-features.php             # PDP: Huy hiệu kho hàng tĩnh, thước đo Freeship, bộ đôi nút bấm, bảng thông số kỹ thuật
│   ├── cart-checkout.php            # Thanh Freeship 500k giỏ hàng, xác thực SĐT 10 số, lược bỏ trường thừa, thẻ thanh toán COD/VietQR
│   ├── floating-contact.php         # Nút liên hệ nổi tinh gọn góc phải: Gọi Hotline, Chat Zalo 24/7, Cuộn lên đầu trang
│   └── footer-trust.php             # Dải cam kết Pre-Footer 4 giá trị bằng SVG & huy hiệu thanh toán bảo mật
└── assets/
    ├── css/
    │   ├── variables.css            # Hệ thống Design Tokens: Bảng màu, độ bo góc, bóng đổ vật lý, typography scale
    │   ├── header-nav.css           # Định dạng Topbar, Header nền trắng viền mờ, menu hover tinh tế, Search modal
    │   ├── home-sections.css        # Hero Combo Banner, lưới 6 danh mục, khối B2B, bài viết cẩm nang, FAQ Accordion
    │   ├── product-cards.css        # Card sản phẩm bo góc 12px, ảnh 1:1 zoom 1.03x, nhãn -X%, nút bấm 44px
    │   ├── single-product.css       # Layout trang chi tiết sản phẩm, gallery ảnh, chọn biến thể, bảng thông số
    │   ├── mobile-optimizations.css # Tối ưu hóa di động, thanh chốt đơn dính đáy 60px, chuẩn hóa touch target >= 44px
    │   ├── cart-checkout.css        # Layout giỏ hàng & thanh toán 2 cột 60/40, form nhập 48px, sticky order review
    │   ├── editorial-hub.css        # Giao diện tạp chí 2 cột (7fr / 5fr), khối sản phẩm gợi ý trong bài viết
    │   ├── policy-pages.css         # Layout 2 cột trang chính sách (Sidebar 300px + Nội dung 950px), bảng chống vỡ mobile
    │   └── components.css           # Nút nổi Zalo/Hotline, thông báo Toast thêm giỏ động, Footer xanh thông sẫm #081C10
    └── js/
        └── theme-scripts.js         # Xử lý Mua ngay chống double-click, validate biến thể mượt mà, Toast on-demand, Back-to-Top rAF
```

---

## 4. Chi Tiết Các Khối (Blocks) & Luồng Trải Nghiệm Trang Chủ

Trang Chủ (`Page ID 23`) được thiết kế theo luồng chuyển đổi tâm lý mua hàng tự nhiên:

1. **Top Combo Hero Banner (`.tt4m-combo-hero`)**:
   - Đặt ngay trên cùng để làm nổi bật ưu đãi chủ lực: Cây thông chuẩn size kèm 45–80 món phụ kiện phối sẵn đồng bộ.
   - Tiêu đề thẻ `<h1>` font *Playfair Display* uốn lượn kết hợp *Be Vietnam Pro*.
   - Hai nút bấm đặt cạnh nhau trên cùng một hàng ngang: `Xem 8+ Set Combo` (đỏ Crimson) và `Tư Vấn Zalo` (viền mảnh).
   - Khung ảnh sắc nét 100% ánh sáng tự nhiên, kèm huy hiệu `Tiết Kiệm 20%`.
2. **Mua Sắm Theo Nhu Cầu (`.tt4m-home-categories`)**:
   - 6 thẻ hình ảnh bo góc với góc bo 12px: Phụ Kiện Treo Cây, Mô Hình & Tượng Noel, Cây Thông Noel, Combo Trọn Gói, Đèn & Nến, Quà Tặng Noel.
3. **Sản Phẩm Trang Trí Được Yêu Thích (`.wp-block-woocommerce-product-collection`)**:
   - Tiêu đề mục đi kèm nút liên kết `Xem tất cả 89+ sản phẩm Noel →` ở góc phải.
   - Thẻ sản phẩm chuẩn mực: Ảnh 1:1, tiêu đề khống chế 2 dòng, giá đỏ thắm, nút bấm full-width 42px.
4. **Giải Pháp Decor Dự Án B2B (`.tt4m-home-b2b-box`)**:
   - Dành riêng cho quán cafe, nhà hàng, khách sạn và văn phòng: Tư vấn phối cảnh 3D, thi công 24h-48h, xuất hóa đơn VAT đầy đủ.
   - Hai nút bấm liên hệ nhanh thu gọn: `Nhắn Zalo Tư Vấn` và `Gọi: 0901.234.567`.
5. **Cẩm Nang & Kinh Nghiệm Trang Trí (`.tt4m-home-editorial`)**:
   - 3 bài viết chuyên gia: Chọn size cây thông theo trần nhà, mẹo decor quán cafe tối ưu diện tích, bảng dự toán chi phí bóc tách vật tư.
6. **Đánh Giá Khách Hàng Thực Tế (`.tt4m-home-reviews`)**:
   - 3 đánh giá có huy hiệu xác thực (The Rustic Coffee TPHCM, Căn hộ chung cư Hà Nội, Shop Thời Trang Đà Nẵng).
7. **Hỏi Đáp Thường Gặp (`.tt4m-faq-accordion`)**:
   - 5 câu hỏi cốt lõi native HTML `<details>` giải tỏa lo âu: Ảnh thật kho, đóng gói chống vỡ 3 lớp, xuất hóa đơn VAT, thời gian giao hỏa tốc và tư vấn quán cafe.
8. **Pre-Footer Trust Bar & Chân Trang (`.ct-footer`)**:
   - 4 cam kết chất lượng bằng SVG đơn sắc.
   - Footer 3 cột màu **Xanh thông sẫm ban đêm (`#081C10`)** căn trái 100%, tiêu đề màu vàng champagne dịu nhẹ.

---

## 5. Danh Mục Các Đường Dẫn & Trang Chính

| Tuyến URL | Loại trang | Đặc điểm kỹ thuật |
|---|---|---|
| `/` | Trang Chủ | Hero Combo 2 cột, 0 dải marquee, không popup rác, tải nhanh |
| `/cua-hang/` | Cửa Hàng | Category chips cuộn ngang có đếm số lượng, grid 4 cột desktop / 2 cột mobile |
| `/danh-muc/trang-tri-theo-mua/giang-sinh-noel/` | Danh mục Noel | Bộ lọc mùa vụ, nhãn cam kết giao hàng hỏa tốc và freeship |
| `/san-pham/thap-nhu-dien/` | Chi Tiết Sản Phẩm | Đồng bộ 100% 3 kích thước (1m2, 1m5, 1m8), thanh Freeship 500k, Mua ngay an toàn |
| `/gio-hang/` | Giỏ Hàng | Thanh tiến trình Freeship tính toán động theo mốc 500.000₫ |
| `/thanh-toan/` | Thanh Toán | Form rút gọn chuẩn Việt Nam, xác thực SĐT 10 số, hỗ trợ VietQR Napas & COD |
| `/y-tuong-trang-tri/` | Cẩm Nang Decor | Layout tạp chí 2 cột bất đối xứng (7fr - 5fr), hộp sản phẩm mua kèm |
| `/chinh-sach-doi-tra/` | Chính Sách Đổi Trả | Layout 2 cột (Sidebar 300px + Nội dung 950px), bảng đối soát điều kiện đổi trả |
| `/chinh-sach-van-chuyen/` | Vận Chuyển | Biểu phí nội thành 30k-50k, hỏa tốc 2h-4h Ahamove/Grab, bảng trượt ngang cảm ứng |
| `/chinh-sach-thanh-toan/` | Thanh Toán | Hướng dẫn VietQR MB Bank STK 0901234567, quy trình xuất hóa đơn VAT |
| `/chinh-sach-bao-mat/` | Bảo Mật | Đã sửa dứt điểm lỗi vỡ layout, tuân thủ Nghị định 13/2023/NĐ-CP |
| `/showroom/` | Hệ Thống Showroom | Giới thiệu không gian thực tế 123 Xuân Thủy, Thảo Điền, TP. Thủ Đức |
| `/gioi-thieu/` | Giới Thiệu | Câu chuyện thương hiệu chân thực, tôn vinh thẩm mỹ lễ hội gia đình |

---

## 6. Hướng Dẫn Vận Hành & Bảo Trì Kỹ Thuật

### A. Kiểm tra cú pháp PHP & CSS
```bash
# Kiểm tra toàn bộ tệp PHP không có lỗi cú pháp
for f in wp-content/themes/blocksy-child/functions.php wp-content/themes/blocksy-child/home.php wp-content/themes/blocksy-child/inc/*.php; do
  php -l "$f"
done
```

### B. Xóa bộ nhớ đệm sau khi cập nhật mã nguồn
```bash
# Xóa sạch Object Cache WordPress và Redis
wp cache flush --allow-root
```

### C. Sử dụng Shortcode Form Tư Vấn B2B
Chèn đoạn mã sau vào bất kỳ bài viết hoặc trang nào để hiển thị form đặt lịch khảo sát decor:
```html
[tt4m_b2b_consultation_form]
```
Form sẽ tự động thu thập: Tên khách hàng, Số điện thoại Zalo, Loại không gian, Diện tích ước tính ($m^2$), Ngân sách dự kiến và chuyển hướng trực tiếp đến Zalo của chuyên viên tư vấn.
