*** Settings ***
Documentation    Kiểm thử Thêm sản phẩm. Ánh xạ TC-PROD-02, 03, 04.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/ProductPage.resource
Suite Setup      Khởi Tạo Phiên
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Mở Trang Sản Phẩm Trực Tiếp
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       products    create

*** Keywords ***
Khởi Tạo Phiên
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${PCODE}    QA${suffix}
    Set Suite Variable    ${PNAME}    San pham QA ${suffix}

*** Test Cases ***
TC-PROD-02 Thêm sản phẩm mới hợp lệ
    [Tags]    positive
    Tạo Sản Phẩm    ${PCODE}    ${PNAME}    Hàng kiểm thử tự động
    Thông Báo Hiển Thị    Đã thêm sản phẩm mới
    Tìm Kiếm Sản Phẩm    ${PCODE}
    Dòng Sản Phẩm Phải Tồn Tại    ${PCODE}

TC-PROD-03 Thêm sản phẩm thiếu tên báo lỗi
    [Tags]    negative
    Mở Modal Thêm Sản Phẩm
    Input Text    ${PROD_CODE_INPUT}    ${PCODE}X
    Input Text    ${PROD_DESC_INPUT}    Mô tả
    Lưu Sản Phẩm
    Thông Báo Hiển Thị    Vui lòng nhập tên sản phẩm
    Đóng Modal Sản Phẩm

TC-PROD-04 Thêm sản phẩm trùng mã báo lỗi
    [Tags]    negative
    Mở Modal Thêm Sản Phẩm
    Điền Form Sản Phẩm    ${PCODE}    ${PNAME} trùng    Mô tả trùng mã
    Lưu Sản Phẩm
    Thông Báo Hiển Thị    Mã sản phẩm đã tồn tại
    Đóng Modal Sản Phẩm
