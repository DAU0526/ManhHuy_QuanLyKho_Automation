*** Settings ***
Documentation    Kiểm thử Đăng nhập. Ánh xạ TC-AUTH-01..06, 08.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/NavigationPage.resource
Suite Setup      Mở Trình Duyệt WareFlow
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Đặt Lại Phiên Đăng Nhập
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       auth    login

*** Test Cases ***
TC-AUTH-01 Đăng nhập thành công với Admin
    [Tags]    smoke    positive
    Đăng Nhập Với    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Đăng Nhập Thành Công
    Menu Phải Hiển Thị    Người dùng

TC-AUTH-02 Đăng nhập sai mật khẩu
    [Tags]    negative
    Đăng Nhập Với    ${ADMIN_EMAIL}    saimatkhau1
    Đăng Nhập Phải Bị Từ Chối

TC-AUTH-03 Đăng nhập với email không tồn tại
    [Tags]    negative
    Đăng Nhập Với    nobody@wareflow.com    ${ADMIN_PASSWORD}
    Đăng Nhập Phải Bị Từ Chối

TC-AUTH-04 Bỏ trống email
    [Tags]    negative
    Mở Trang Đăng Nhập
    Input Text    ${LOGIN_PASSWORD}    ${ADMIN_PASSWORD}
    Bấm Nút Đăng Nhập
    Đăng Nhập Thất Bại Với Thông Báo    Vui lòng nhập email

TC-AUTH-05 Mật khẩu ngắn hơn 8 ký tự
    [Tags]    negative
    Đăng Nhập Với    ${ADMIN_EMAIL}    123
    Đăng Nhập Thất Bại Với Thông Báo    Mật khẩu tối thiểu 8 ký tự

TC-AUTH-06 Tài khoản bị vô hiệu hoá không đăng nhập được
    [Tags]    negative
    Đăng Nhập Với    ${DISABLED_EMAIL}    ${DISABLED_PASSWORD}
    Đăng Nhập Phải Bị Từ Chối

TC-AUTH-08 Chặn truy cập trang nội bộ khi chưa đăng nhập
    [Tags]    negative
    Go To    ${BASE_URL}/products
    Wait Until Location Contains    /login    timeout=${TIMEOUT}
