*** Settings ***
Documentation    Kiểm thử Xoá sản phẩm. Ánh xạ TC-PROD-07.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/ProductPage.resource
Suite Setup      Khởi Tạo Phiên
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       products    delete

*** Keywords ***
Khởi Tạo Phiên
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${PCODE}    QD${suffix}
    Mở Trang Sản Phẩm Trực Tiếp
    Tạo Sản Phẩm    ${PCODE}    San pham can xoa ${suffix}    Du lieu cho test xoa
    Thông Báo Hiển Thị    Đã thêm sản phẩm mới

*** Test Cases ***
TC-PROD-07 Xoá sản phẩm tồn kho bằng 0
    [Tags]    positive
    Mở Trang Sản Phẩm Trực Tiếp
    Tìm Kiếm Sản Phẩm    ${PCODE}
    Xoá Sản Phẩm    ${PCODE}
    Thông Báo Hiển Thị    Đã xoá sản phẩm
    Dòng Sản Phẩm Không Còn Tồn Tại    ${PCODE}
