# KẾ HOẠCH KIỂM THỬ (TEST PLAN) — Hệ thống WareFlow

| Mục | Nội dung |
| --- | --- |
| Dự án | WareFlow — Hệ thống quản lý kho |
| Phiên bản tài liệu | 1.0 |
| Loại kiểm thử | Kiểm thử chức năng tự động |
| Công cụ | Robot Framework + SeleniumLibrary (kiến trúc Page Object Model) |
| Môi trường | `https://wm.huy-vu.uk` |

---

## 1. Giới thiệu

Tài liệu mô tả phạm vi, cách tiếp cận, tài nguyên và lịch trình cho hoạt động kiểm
thử chức năng của hệ thống WareFlow. Hệ thống gồm:

- **Frontend**: React + TypeScript (SPA), giao diện tiếng Việt.
- **Backend**: Node.js + Express, REST API, xác thực JWT.
- **Database**: PostgreSQL.

Mục tiêu là kiểm chứng các chức năng nghiệp vụ chính hoạt động đúng theo
[Tài liệu API WareFlow v4](https://github.com/Hbest1804/Dev_ops_quanlykho/blob/main/docs/API_WareFlow_v4.md) và đặc tả giao diện.

## 2. Mục tiêu kiểm thử

1. Xác nhận luồng **xác thực & phân quyền** (login, logout, RBAC theo 3 vai trò).
2. Xác nhận **CRUD sản phẩm** và ràng buộc nghiệp vụ (mã trùng, xoá khi còn tồn).
3. Xác nhận luồng **phiếu nhập kho** (tạo → xác nhận → cập nhật tồn / huỷ).
4. Xác nhận luồng **phiếu xuất kho** (tạo, kiểm tra tồn, xác nhận, huỷ).
5. Xác nhận **báo cáo & thống kê** (tổng hợp, top sản phẩm, xuất file).
6. Xác nhận **quản lý người dùng** (tạo, sửa, khoá/mở khoá, reset mật khẩu).
7. Xác nhận **kiểm soát truy cập theo vai trò** trên UI (ẩn/hiện menu, chặn route).

## 3. Phạm vi

### 3.1. Trong phạm vi (In-scope)

| Module | Chức năng được kiểm thử |
| --- | --- |
| Authentication | Đăng nhập đúng/sai, validate input, tài khoản bị khoá, đăng xuất |
| Phân quyền (RBAC) | Hiển thị menu theo vai trò, chặn truy cập trang không có quyền |
| Sản phẩm | Xem danh sách, tìm kiếm, lọc, thêm, sửa, xoá, xem lịch sử giao dịch |
| Nhập kho | Danh sách, lọc theo trạng thái/ngày, tạo phiếu, xác nhận, huỷ |
| Xuất kho | Danh sách, tạo phiếu, kiểm tra tồn kho, xác nhận, huỷ |
| Báo cáo | Báo cáo tổng hợp, top sản phẩm, đổi kỳ, xuất Excel/PDF |
| Người dùng | Danh sách, tìm kiếm, thêm, sửa, đổi vai trò, khoá/mở khoá, reset mật khẩu |

### 3.2. Ngoài phạm vi (Out-of-scope)

- Kiểm thử hiệu năng / tải (performance, load, stress).
- Kiểm thử bảo mật chuyên sâu (pentest), kiểm thử token rotation ở tầng cookie.
- Kiểm thử tương thích đa trình duyệt sâu (chỉ chạy Chromium).
- Kiểm thử nội dung file PDF/Excel sinh ra (chỉ xác minh việc tải file khởi chạy).
- Unit test backend/frontend (đã có sẵn trong `backend/src/tests` và CI [tại đây](https://github.com/Hbest1804/Dev_ops_quanlykho)).

## 4. Cách tiếp cận kiểm thử

- **Kiểu**: kiểm thử hộp đen, tự động hoá ở mức UI.
- **Kiến trúc**: Page Object Model (POM) — mỗi trang là một resource chứa locator
  và keyword nghiệp vụ; test case chỉ gọi keyword, không thao tác locator trực tiếp.
- **Dữ liệu test**: dữ liệu động (gắn timestamp) để mỗi lần chạy không phụ thuộc trạng
  thái trước đó; dọn dẹp (teardown) dữ liệu tạo ra khi có thể.
- **Phân loại bằng tag**: `smoke`, `regression`, `auth`, `products`, `stockin`,
  `stockout`, `reports`, `users`, `rbac`, `negative`.

## 5. Môi trường & công cụ

| Hạng mục | Giá trị |
| --- | --- |
| URL hệ thống | `https://wm.huy-vu.uk` |
| Trình duyệt | Google Chrome / Chromium (mặc định headless) |
| Ngôn ngữ | Python 3.9+ |
| Thư viện | robotframework, robotframework-seleniumlibrary, webdriver-manager |
| Báo cáo | `log.html`, `report.html`, `output.xml` (chuẩn Robot Framework) |

## 6. Tài khoản kiểm thử

| Vai trò | Email | Mật khẩu |
| --- | --- | --- |
| Quản trị viên (admin) | `admin@wareflow.com` | `123456789` |
| Thủ kho (warehouse_staff) | `staff@wareflow.com` | `123456789` |
| Kế toán (accountant) | `accountant@wareflow.com` | `123456789` |
| Tài khoản bị vô hiệu hoá | `disabled@wareflow.com` | `123456789` |

## 7. Ma trận phân quyền (cơ sở cho test RBAC)

| Trang / Chức năng | admin | warehouse_staff | accountant |
| --- | :---: | :---: | :---: |
| Bảng điều khiển | ✅ | ✅ | ✅ |
| Sản phẩm | ✅ | ✅ | ❌ |
| Nhập kho | ✅ | ✅ | ❌ |
| Xuất kho | ✅ | ✅ | ❌ |
| Báo cáo | ✅ | ❌ | ✅ |
| Người dùng | ✅ | ❌ | ❌ |

## 8. Tiêu chí Vào / Ra

**Tiêu chí bắt đầu (Entry):**
- Hệ thống tại `https://wm.huy-vu.uk` truy cập được, các tài khoản test đã được seed.
- Môi trường Robot Framework + driver đã cài đặt và chạy thử `smoke` thành công.

**Tiêu chí kết thúc (Exit):**
- 100% test case đã được thực thi.
- ≥ 95% test case PASS; không còn lỗi mức Nghiêm trọng (Critical) / Cao (High) chưa xử lý.
- Báo cáo kết quả (`report.html`)

## 9. Tiêu chí Pass/Fail

- **Pass**: hành vi thực tế trùng khớp kết quả mong đợi của test case.
- **Fail**: lệch kết quả mong đợi; mở defect kèm log, ảnh chụp màn hình, các bước tái hiện.

## 10. Mức độ ưu tiên & rủi ro

| Mức | Module | Lý do |
| --- | --- | --- |
| Cao | Auth, Nhập kho, Xuất kho | Ảnh hưởng trực tiếp số liệu tồn kho |
| Trung bình | Sản phẩm, Người dùng | Dữ liệu nền, phân quyền |
| Thấp | Báo cáo (xuất file) | Phụ thuộc nội dung file, ngoài phạm vi xác minh chi tiết |

**Rủi ro chính:**
- Locator dựa trên text tiếng Việt → nhạy cảm khi UI đổi nhãn. Giảm thiểu bằng POM tập trung.
- Chạy trên môi trường production → cần dọn dữ liệu test, tránh tạo rác.
- Toast thông báo hiển thị ngắn → dùng `Wait Until` để bắt kịp.

## 11. Sản phẩm bàn giao (Deliverables)

- Kế hoạch kiểm thử (tài liệu này).
- Bộ test case chi tiết: [`TestCases.md`](./TestCases.md).
- Mã nguồn tự động hoá theo POM: [`../tests`](../tests), [`../resources`](../resources), [`../resources/locators`](../resources/locators).
- Báo cáo thực thi: `log.html`, `report.html`, `output.xml`.

## 12. Cấu trúc bộ kiểm thử

```text
ManhHuy_QuanLyKho_Automation/
├── tests/                       # TEST SUITES (chỉ gọi keyword nghiệp vụ)
│   ├── LoginTests.robot              LogoutTests.robot
│   ├── ProductCreateTests.robot      ProductSearchTests.robot
│   ├── ProductUpdateTests.robot      ProductDeleteTests.robot
│   ├── StockInTests.robot            StockOutTests.robot
│   ├── ReportTests.robot             UserTests.robot
│   └── AuthorizationTests.robot
├── resources/
│   ├── common_keywords.resource     # keyword chung (browser, toast, dropdown, dialog)
│   ├── page_objects/                # PAGE OBJECTS (keyword nghiệp vụ, import locators)
│   │   ├── LoginPage.resource        NavigationPage.resource
│   │   ├── ProductPage.resource      StockInPage.resource
│   │   ├── StockOutPage.resource     ReportPage.resource
│   │   └── UserPage.resource
│   ├── locators/                    # TẦNG LOCATOR — file Python (.py), chỉ định danh phần tử
│   │   ├── LoginPageLocators.py      NavigationPageLocators.py
│   │   ├── ProductPageLocators.py    StockInPageLocators.py
│   │   ├── StockOutPageLocators.py   ReportPageLocators.py
│   │   └── UserPageLocators.py
│   └── environment.variables.yml    # URL, trình duyệt, tài khoản — nạp qua --variablefile
├── docs/
│   ├── TestPlan.md          # tài liệu này
│   └── TestCases.md         # đặc tả test case chi tiết
├── requirements.txt
├── README.md
└── results/                     # kết quả khi chạy (tự sinh)
```
