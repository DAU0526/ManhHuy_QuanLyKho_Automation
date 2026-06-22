*** Settings ***
Documentation    Kiểm thử Cập nhật sản phẩm. Ánh xạ TC-PROD-06.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/ProductPage.resource
Suite Setup      Khởi Tạo Phiên
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       products    update

*** Keywords ***
Khởi Tạo Phiên
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${PCODE}    QU${suffix}
    Mở Trang Sản Phẩm Trực Tiếp
    Tạo Sản Phẩm    ${PCODE}    San pham can sua ${suffix}    Du lieu cho test cap nhat
    Thông Báo Hiển Thị    Đã thêm sản phẩm mới

*** Test Cases ***
TC-PROD-06 Cập nhật tên sản phẩm
    [Tags]    positive
    Mở Trang Sản Phẩm Trực Tiếp
    Tìm Kiếm Sản Phẩm    ${PCODE}
    Sửa Tên Sản Phẩm    ${PCODE}    San pham da sua ten
    Thông Báo Hiển Thị    Đã cập nhật sản phẩm
