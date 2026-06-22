*** Settings ***
Documentation    Kiểm thử Nhập kho. Ánh xạ TC-IN-01..08.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/StockInPage.resource
Suite Setup      Khởi Tạo Phiên
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Mở Trang Nhập Kho Trực Tiếp
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       stockin

*** Keywords ***
Khởi Tạo Phiên
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${SUPPLIER}    NCC QA ${suffix}

*** Test Cases ***
TC-IN-01 Mở trang danh sách phiếu nhập
    [Tags]    smoke
    Trang Nhập Kho Phải Mở

TC-IN-02 Tạo phiếu nhập hợp lệ
    [Tags]    positive
    Tạo Phiếu Nhập Một Sản Phẩm    ${SUPPLIER}    10
    Thông Báo Hiển Thị    Đã tạo phiếu nhập mới

TC-IN-03 Tạo phiếu nhập thiếu nhà cung cấp
    [Tags]    negative
    Mở Modal Tạo Phiếu Nhập
    Thêm Dòng Sản Phẩm
    Chọn Sản Phẩm Cho Dòng Đầu
    Nhập Số Lượng Dòng Đầu    5
    Gửi Tạo Phiếu Nhập
    Thông Báo Hiển Thị    Vui lòng nhập tên nhà cung cấp

TC-IN-04 Tạo phiếu nhập không có sản phẩm
    [Tags]    negative
    Mở Modal Tạo Phiếu Nhập
    Nhập Nhà Cung Cấp    ${SUPPLIER}
    Gửi Tạo Phiếu Nhập
    Thông Báo Hiển Thị    Danh sách sản phẩm không được rỗng

TC-IN-05 Số lượng nhập không hợp lệ
    [Tags]    negative
    Mở Modal Tạo Phiếu Nhập
    Nhập Nhà Cung Cấp    ${SUPPLIER}
    Thêm Dòng Sản Phẩm
    Chọn Sản Phẩm Cho Dòng Đầu
    Nhập Số Lượng Dòng Đầu    0
    Gửi Tạo Phiếu Nhập
    Thông Báo Hiển Thị    Số lượng phải lớn hơn 0

TC-IN-06 Xác nhận phiếu nhập
    [Tags]    positive
    Tạo Phiếu Nhập Một Sản Phẩm    ${SUPPLIER}    7
    Thông Báo Hiển Thị    Đã tạo phiếu nhập mới
    Mở Trang Nhập Kho Trực Tiếp
    Xác Nhận Phiếu Nhập Đầu Tiên
    Thông Báo Hiển Thị    Đã xác nhận phiếu nhập

TC-IN-07 Huỷ phiếu nhập
    [Tags]    positive
    Tạo Phiếu Nhập Một Sản Phẩm    ${SUPPLIER}    3
    Thông Báo Hiển Thị    Đã tạo phiếu nhập mới
    Mở Trang Nhập Kho Trực Tiếp
    Huỷ Phiếu Nhập Đầu Tiên
    Thông Báo Hiển Thị    Đã huỷ phiếu nhập

TC-IN-08 Lọc phiếu nhập theo trạng thái Đã xác nhận
    [Tags]    positive
    Lọc Phiếu Nhập Theo Trạng Thái    Đã xác nhận
    Trang Nhập Kho Phải Mở
