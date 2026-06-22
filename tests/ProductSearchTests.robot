*** Settings ***
Documentation    Kiểm thử Xem danh sách / Tìm kiếm / Lịch sử sản phẩm. Ánh xạ TC-PROD-01, 05, 08.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/ProductPage.resource
Suite Setup      Khởi Tạo Phiên
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Mở Trang Sản Phẩm Trực Tiếp
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       products    search

*** Keywords ***
Khởi Tạo Phiên
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${PCODE}    QS${suffix}
    Set Suite Variable    ${PNAME}    San pham tim kiem ${suffix}
    # Tạo sẵn 1 sản phẩm để tìm kiếm / xem chi tiết
    Mở Trang Sản Phẩm Trực Tiếp
    Tạo Sản Phẩm    ${PCODE}    ${PNAME}    Du lieu cho test tim kiem
    Thông Báo Hiển Thị    Đã thêm sản phẩm mới

*** Test Cases ***
TC-PROD-01 Mở trang danh sách sản phẩm
    [Tags]    smoke
    Trang Sản Phẩm Phải Mở

TC-PROD-05 Tìm kiếm sản phẩm theo mã
    [Tags]    positive
    Tìm Kiếm Sản Phẩm    ${PCODE}
    Dòng Sản Phẩm Phải Tồn Tại    ${PCODE}

TC-PROD-08 Xem lịch sử giao dịch của sản phẩm
    [Tags]    positive
    Tìm Kiếm Sản Phẩm    ${PCODE}
    Mở Chi Tiết Sản Phẩm    ${PCODE}
    Mở Tab Lịch Sử Giao Dịch
    Wait Until Page Contains    giao dịch    timeout=${TIMEOUT}
