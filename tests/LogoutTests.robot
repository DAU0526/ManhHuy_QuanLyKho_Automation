*** Settings ***
Documentation    Kiểm thử Đăng xuất. Ánh xạ TC-AUTH-07.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/NavigationPage.resource
Suite Setup      Mở Trình Duyệt WareFlow
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Đặt Lại Phiên Đăng Nhập
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       auth    logout

*** Test Cases ***
TC-AUTH-07 Đăng xuất khỏi hệ thống
    [Tags]    positive
    Đăng Nhập Bằng Admin
    Đăng Xuất
    Location Should Contain    /login
