*** Settings ***
Documentation    Kiểm thử Phân quyền theo vai trò (RBAC). Ánh xạ TC-RBAC-01..06.
...              Mỗi test mở TRÌNH DUYỆT MỚI rồi đăng nhập 1 lần. Lý do: hệ thống không
...              xử lý ổn định nhiều lần đăng nhập-mới liên tiếp trong cùng một phiên trình
...              duyệt (edge case auth/refresh phía app) → dùng browser sạch cho mỗi vai trò.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/NavigationPage.resource
Test Setup       Mở Trình Duyệt WareFlow
Test Teardown    Dọn Dẹp Sau Test
Force Tags       rbac

*** Keywords ***
Dọn Dẹp Sau Test
    Chụp Màn Hình Khi Lỗi
    Đóng Trình Duyệt WareFlow

*** Test Cases ***
TC-RBAC-01 Menu của Admin hiển thị đầy đủ
    Đăng Nhập Bằng Admin
    Menu Phải Hiển Thị    Sản phẩm
    Menu Phải Hiển Thị    Nhập kho
    Menu Phải Hiển Thị    Xuất kho
    Menu Phải Hiển Thị    Báo cáo
    Menu Phải Hiển Thị    Người dùng

TC-RBAC-02 Menu của Thủ kho giới hạn đúng
    Đăng Nhập Bằng Thủ Kho
    Menu Phải Hiển Thị    Sản phẩm
    Menu Phải Hiển Thị    Nhập kho
    Menu Phải Hiển Thị    Xuất kho
    Menu Không Được Hiển Thị    Báo cáo
    Menu Không Được Hiển Thị    Người dùng

TC-RBAC-03 Menu của Kế toán giới hạn đúng
    Đăng Nhập Bằng Kế Toán
    Menu Phải Hiển Thị    Báo cáo
    Menu Không Được Hiển Thị    Sản phẩm
    Menu Không Được Hiển Thị    Nhập kho
    Menu Không Được Hiển Thị    Xuất kho
    Menu Không Được Hiển Thị    Người dùng

TC-RBAC-04 Kế toán bị chặn vào trang Sản phẩm
    [Tags]    negative
    Đăng Nhập Bằng Kế Toán
    Truy Cập Trực Tiếp Và Bị Chặn    /products

TC-RBAC-05 Thủ kho bị chặn vào trang Người dùng
    [Tags]    negative
    Đăng Nhập Bằng Thủ Kho
    Truy Cập Trực Tiếp Và Bị Chặn    /users

TC-RBAC-06 Thủ kho bị chặn vào trang Báo cáo
    [Tags]    negative
    Đăng Nhập Bằng Thủ Kho
    Truy Cập Trực Tiếp Và Bị Chặn    /reports
