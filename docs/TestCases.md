# BỘ TEST CASE CHI TIẾT — Hệ thống WareFlow

Ký hiệu mã: `TC-<MODULE>-<số>`. Trạng thái mặc định: *Chưa chạy*.

**Tiền điều kiện chung**: hệ thống `https://wm.huy-vu.uk` truy cập được; các tài khoản
test đã tồn tại (xem Test Plan §6).

Mỗi test case ánh xạ tới một `Test Case` trong các suite Robot ở [`../tests`](../tests).

---

## 1. Xác thực — `LoginTests.robot`, `LogoutTests.robot`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Dữ liệu | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- | --- |
| TC-AUTH-01 | Đăng nhập thành công (admin) | Chưa đăng nhập | 1. Mở `/login` 2. Nhập email+mật khẩu 3. Bấm Đăng Nhập | admin@wareflow.com / 123456789 | Chuyển vào trang chủ, sidebar hiển thị; menu admin đầy đủ | Positive/smoke |
| TC-AUTH-02 | Đăng nhập sai mật khẩu | Chưa đăng nhập | Nhập đúng email, sai mật khẩu, submit | admin@wareflow.com / saimatkhau1 | Hiện toast "Thông tin đăng nhập không đúng/Invalid credentials"; vẫn ở `/login` | Negative |
| TC-AUTH-03 | Đăng nhập email không tồn tại | Chưa đăng nhập | Nhập email lạ, mật khẩu hợp lệ, submit | nobody@wareflow.com / 123456789 | Thông báo lỗi đăng nhập; vẫn ở `/login` | Negative |
| TC-AUTH-04 | Bỏ trống email | Chưa đăng nhập | Để trống email, nhập mật khẩu, submit | (email rỗng) | Toast "Vui lòng nhập email"; không gọi API | Negative |
| TC-AUTH-05 | Mật khẩu < 8 ký tự | Chưa đăng nhập | Nhập email, mật khẩu 3 ký tự, submit | admin@wareflow.com / 123 | Toast "Mật khẩu tối thiểu 8 ký tự" | Negative |
| TC-AUTH-06 | Tài khoản bị vô hiệu hoá | Chưa đăng nhập | Đăng nhập bằng tài khoản disabled | disabled@wareflow.com / 123456789 | Bị từ chối, toast báo tài khoản bị khoá; vẫn ở `/login` | Negative |
| TC-AUTH-07 | Đăng xuất | Đã đăng nhập admin | Bấm nút "Đăng xuất" ở sidebar | — | Quay về `/login`; truy cập lại trang nội bộ bị chuyển hướng | Positive |
| TC-AUTH-08 | Chặn truy cập khi chưa đăng nhập | Chưa đăng nhập | Mở trực tiếp `/products` | — | Bị điều hướng về `/login` | Negative |

## 2. Sản phẩm — `ProductCreateTests` / `ProductSearchTests` / `ProductUpdateTests` / `ProductDeleteTests`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- |
| TC-PROD-01 | Mở trang danh sách sản phẩm | Đăng nhập admin | Vào menu "Sản phẩm" | Hiển thị tiêu đề "Quản lý Sản phẩm" và bảng sản phẩm | smoke |
| TC-PROD-02 | Thêm sản phẩm mới hợp lệ | Đăng nhập admin | Mở modal, nhập mã/tên/mô tả duy nhất, lưu | Toast "Đã thêm sản phẩm mới"; sản phẩm xuất hiện trong danh sách | Positive |
| TC-PROD-03 | Thêm sản phẩm thiếu tên | Đăng nhập admin | Mở modal, nhập mã, bỏ trống tên, lưu | Toast "Vui lòng nhập tên sản phẩm"; modal không đóng | Negative |
| TC-PROD-04 | Thêm sản phẩm trùng mã | Đã có sản phẩm A | Tạo sản phẩm mới cùng mã với A | Toast "Mã sản phẩm đã tồn tại" | Negative |
| TC-PROD-05 | Tìm kiếm sản phẩm theo mã | Có sản phẩm vừa tạo | Nhập mã vào ô tìm kiếm | Bảng chỉ còn các dòng khớp từ khoá | Positive |
| TC-PROD-06 | Sửa thông tin sản phẩm | Có sản phẩm vừa tạo | Mở modal sửa, đổi tên, lưu | Toast "Đã cập nhật sản phẩm"; tên mới hiển thị | Positive |
| TC-PROD-07 | Xoá sản phẩm tồn = 0 | Sản phẩm mới (tồn 0) | Bấm xoá → xác nhận | Toast "Đã xoá sản phẩm"; dòng biến mất | Positive |
| TC-PROD-08 | Xem lịch sử giao dịch | Có sản phẩm | Mở chi tiết, chuyển tab "Lịch sử giao dịch" | Hiển thị bảng giao dịch hoặc trạng thái "Chưa có giao dịch nào" | Positive |

## 3. Nhập kho — `StockInTests.robot`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- |
| TC-IN-01 | Mở danh sách phiếu nhập | Đăng nhập admin | Vào menu "Nhập kho" | Hiển thị "Quản lý Nhập kho", 3 thẻ thống kê và bảng phiếu | smoke |
| TC-IN-02 | Tạo phiếu nhập hợp lệ | Có ít nhất 1 sản phẩm | Mở modal, nhập NCC, chọn 1 sản phẩm, nhập SL>0, tạo | Toast "Đã tạo phiếu nhập mới"; phiếu mới trạng thái "Chờ xử lý" | Positive |
| TC-IN-03 | Tạo phiếu nhập thiếu nhà cung cấp | — | Mở modal, bỏ trống NCC, thêm 1 dòng, tạo | Toast "Vui lòng nhập tên nhà cung cấp" | Negative |
| TC-IN-04 | Tạo phiếu nhập không có sản phẩm | — | Mở modal, nhập NCC, không thêm dòng, tạo | Toast "Danh sách sản phẩm không được rỗng" | Negative |
| TC-IN-05 | Số lượng không hợp lệ (≤ 0) | — | Thêm 1 dòng, nhập SL = 0, tạo | Toast "Số lượng phải lớn hơn 0" | Negative |
| TC-IN-06 | Xác nhận phiếu nhập | Có phiếu trạng thái Chờ xử lý | Bấm "Xác nhận" → đồng ý | Toast "Đã xác nhận phiếu nhập!"; trạng thái → "Đã duyệt"; tồn kho tăng | Positive |
| TC-IN-07 | Huỷ phiếu nhập | Có phiếu trạng thái Chờ xử lý | Bấm "Huỷ" → đồng ý | Toast "Đã huỷ phiếu nhập"; trạng thái → "Đã huỷ" | Positive |
| TC-IN-08 | Lọc theo trạng thái | Có phiếu nhiều trạng thái | Chọn bộ lọc "Đã xác nhận" | Danh sách chỉ còn phiếu trạng thái tương ứng | Positive |

## 4. Xuất kho — `StockOutTests.robot`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- |
| TC-OUT-01 | Mở danh sách phiếu xuất | Đăng nhập admin | Vào menu "Xuất kho" | Hiển thị "Quản lý Xuất kho" và bảng phiếu | smoke |
| TC-OUT-02 | Tạo phiếu xuất hợp lệ | Có sản phẩm còn tồn | Mở modal, chọn lý do, chọn sản phẩm còn tồn, SL ≤ tồn, tạo | Toast "Đã tạo phiếu xuất mới"; phiếu trạng thái "Chờ xử lý" | Positive |
| TC-OUT-03 | Xuất vượt tồn kho | Sản phẩm tồn thấp | Tạo phiếu với SL > tồn | Toast lỗi "Số lượng xuất vượt tồn kho/Insufficient stock" | Negative |
| TC-OUT-04 | Tạo phiếu xuất không có sản phẩm | — | Mở modal, không thêm dòng, tạo | Toast "Danh sách sản phẩm không được rỗng" | Negative |
| TC-OUT-05 | Xác nhận phiếu xuất | Có phiếu Chờ xử lý | Bấm "Xác nhận" → đồng ý | Toast xác nhận; trạng thái → "Đã duyệt"; tồn kho giảm | Positive |
| TC-OUT-06 | Huỷ phiếu xuất | Có phiếu Chờ xử lý | Bấm "Huỷ" → đồng ý | Toast "Đã huỷ phiếu xuất"; trạng thái → "Đã huỷ" | Positive |

## 5. Báo cáo — `ReportTests.robot`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- |
| TC-REP-01 | Mở trang báo cáo (admin) | Đăng nhập admin | Vào menu "Báo cáo" | Hiển thị trang báo cáo tổng hợp với các chỉ số kỳ | smoke |
| TC-REP-02 | Báo cáo theo kế toán | Đăng nhập accountant | Vào menu "Báo cáo" | Hiển thị được báo cáo (accountant có quyền) | Positive |
| TC-REP-03 | Đổi kỳ báo cáo | Đang ở trang báo cáo | Chọn kỳ "Tuần này" | Dữ liệu/khoảng ngày được cập nhật, không lỗi | Positive |
| TC-REP-04 | Xem Top sản phẩm | Đang ở trang báo cáo | Chuyển sang báo cáo Top xuất/nhập | Hiển thị bảng xếp hạng sản phẩm | Positive |

## 6. Người dùng — `UserTests.robot`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- |
| TC-USER-01 | Mở danh sách người dùng | Đăng nhập admin | Vào menu "Người dùng" | Hiển thị "Quản lý Người dùng" và bảng người dùng | smoke |
| TC-USER-02 | Thêm người dùng mới | Đăng nhập admin | Mở modal, nhập tên/email duy nhất/mật khẩu, chọn vai trò, thêm | Toast "Đã thêm người dùng mới"; người dùng xuất hiện | Positive |
| TC-USER-03 | Thêm người dùng mật khẩu < 8 | Đăng nhập admin | Nhập mật khẩu 3 ký tự, thêm | Toast "Mật khẩu tối thiểu 8 ký tự" | Negative |
| TC-USER-04 | Thêm email trùng | Email đã tồn tại | Thêm người dùng với email đã có | Toast "Email đã được sử dụng" | Negative |
| TC-USER-05 | Tìm kiếm người dùng | Có người dùng | Nhập từ khoá vào ô tìm | Bảng lọc theo tên/email | Positive |
| TC-USER-06 | Khoá / mở khoá tài khoản | Có người dùng test (không phải mình) | Mở chi tiết, bấm "Khoá" → đồng ý | Toast "Đã khoá tài khoản"; trạng thái → "Vô hiệu hoá" | Positive |

## 7. Phân quyền — `AuthorizationTests.robot`

| Mã | Tiêu đề | Tiền điều kiện | Các bước | Kết quả mong đợi | Loại |
| --- | --- | --- | --- | --- | --- |
| TC-RBAC-01 | Menu của admin | Đăng nhập admin | Quan sát sidebar | Hiển thị đủ: Sản phẩm, Nhập kho, Xuất kho, Báo cáo, Người dùng | rbac |
| TC-RBAC-02 | Menu của thủ kho | Đăng nhập staff | Quan sát sidebar | Có Sản phẩm/Nhập/Xuất; KHÔNG có Báo cáo, Người dùng | rbac |
| TC-RBAC-03 | Menu của kế toán | Đăng nhập accountant | Quan sát sidebar | Có Báo cáo; KHÔNG có Sản phẩm/Nhập/Xuất/Người dùng | rbac |
| TC-RBAC-04 | Kế toán chặn vào Sản phẩm | Đăng nhập accountant | Mở trực tiếp `/products` | Bị điều hướng khỏi trang (về trang chủ) | rbac/negative |
| TC-RBAC-05 | Thủ kho chặn vào Người dùng | Đăng nhập staff | Mở trực tiếp `/users` | Bị điều hướng khỏi trang (về trang chủ) | rbac/negative |
| TC-RBAC-06 | Thủ kho chặn vào Báo cáo | Đăng nhập staff | Mở trực tiếp `/reports` | Bị điều hướng khỏi trang (về trang chủ) | rbac/negative |

---

## Truy vết yêu cầu (Traceability) — tóm tắt

| Nhóm yêu cầu (API v4) | Test case liên quan |
| --- | --- |
| §2 Auth | TC-AUTH-01 … 08 |
| §3 Products | TC-PROD-01 … 08 |
| §4 Import Orders | TC-IN-01 … 08 |
| §5 Export Orders | TC-OUT-01 … 06 |
| §6 Reports | TC-REP-01 … 04 |
| §7 Users | TC-USER-01 … 06 |
| §1.6 Phân quyền | TC-RBAC-01 … 06 |
