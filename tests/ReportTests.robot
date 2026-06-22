*** Settings ***
Documentation    Kiểm thử Báo cáo & Thống kê. Ánh xạ TC-REP-01..04.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/NavigationPage.resource
Resource         ../resources/page_objects/ReportPage.resource
Suite Setup      Mở Trình Duyệt WareFlow
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       reports

*** Test Cases ***
TC-REP-01 Admin mở trang báo cáo
    [Tags]    smoke
    Đặt Lại Phiên Đăng Nhập
    Đăng Nhập Bằng Admin
    Mở Trang Báo Cáo
    Trang Báo Cáo Phải Mở

TC-REP-02 Kế toán xem được báo cáo
    [Tags]    positive
    Đặt Lại Phiên Đăng Nhập
    Đăng Nhập Bằng Kế Toán
    Mở Trang Báo Cáo
    Trang Báo Cáo Phải Mở

TC-REP-03 Đổi kỳ báo cáo sang Tuần này
    [Tags]    positive
    Mở Lại Trang Báo Cáo Sạch
    Chọn Kỳ Báo Cáo    Tuần này
    # Sau khi chọn, trigger kỳ phải hiển thị "Tuần này"
    Wait Until Page Contains Element    xpath=//button[.//span[normalize-space()='Tuần này']]    timeout=${TIMEOUT}

TC-REP-04 Xem báo cáo Top sản phẩm xuất kho
    [Tags]    positive
    Mở Lại Trang Báo Cáo Sạch
    Xem Báo Cáo Top Xuất Kho
