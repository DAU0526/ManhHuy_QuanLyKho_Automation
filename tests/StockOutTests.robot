*** Settings ***
Documentation    Kiểm thử Xuất kho. Ánh xạ TC-OUT-01..06.
...              Suite Setup tự cấp tồn kho: tạo 1 sản phẩm rồi nhập + xác nhận để có tồn,
...              nhờ vậy test xuất không phụ thuộc dữ liệu sẵn có trên hệ thống.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/ProductPage.resource
Resource         ../resources/page_objects/StockInPage.resource
Resource         ../resources/page_objects/StockOutPage.resource
Suite Setup      Khởi Tạo Phiên Có Tồn Kho
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Mở Trang Xuất Kho Trực Tiếp
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       stockout

*** Keywords ***
Khởi Tạo Phiên Có Tồn Kho
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${PXCODE}    PX${suffix}
    Set Suite Variable    ${PXSUP}     NCC PX ${suffix}
    # 1) Tạo sản phẩm mới (tồn 0)
    Mở Trang Sản Phẩm Trực Tiếp
    Tạo Sản Phẩm    ${PXCODE}    San pham xuat kho ${suffix}    Du lieu test xuat kho
    Thông Báo Hiển Thị    Đã thêm sản phẩm mới
    # 2) Nhập 100 cho sản phẩm này và xác nhận → có tồn để xuất
    Mở Trang Nhập Kho Trực Tiếp
    Tạo Phiếu Nhập Một Sản Phẩm    ${PXSUP}    100    ${PXCODE}
    Thông Báo Hiển Thị    Đã tạo phiếu nhập mới
    Mở Trang Nhập Kho Trực Tiếp
    Xác Nhận Phiếu Nhập Theo Nhà Cung Cấp    ${PXSUP}
    Thông Báo Hiển Thị    Đã xác nhận phiếu nhập

*** Test Cases ***
TC-OUT-01 Mở trang danh sách phiếu xuất
    [Tags]    smoke
    Trang Xuất Kho Phải Mở

TC-OUT-02 Tạo phiếu xuất hợp lệ
    [Tags]    positive
    Tạo Phiếu Xuất Một Sản Phẩm    1    ${PXCODE}
    Thông Báo Hiển Thị    Đã tạo phiếu xuất mới

TC-OUT-03 Xuất vượt tồn kho báo lỗi
    [Tags]    negative
    Mở Modal Tạo Phiếu Xuất
    Thêm Dòng Sản Phẩm
    Chọn Sản Phẩm Cho Dòng Đầu    ${PXCODE}
    Nhập Số Lượng Dòng Đầu    9999999
    Gửi Tạo Phiếu Xuất
    Thông Báo Hiển Thị    Không đủ tồn kho

TC-OUT-04 Tạo phiếu xuất không có sản phẩm
    [Tags]    negative
    Mở Modal Tạo Phiếu Xuất
    Gửi Tạo Phiếu Xuất
    Thông Báo Hiển Thị    Danh sách sản phẩm không được rỗng

TC-OUT-05 Xác nhận phiếu xuất
    [Tags]    positive
    Tạo Phiếu Xuất Một Sản Phẩm    1    ${PXCODE}
    Thông Báo Hiển Thị    Đã tạo phiếu xuất mới
    Mở Trang Xuất Kho Trực Tiếp
    Xác Nhận Phiếu Xuất Đầu Tiên
    Thông Báo Hiển Thị    Đã xác nhận phiếu xuất

TC-OUT-06 Huỷ phiếu xuất
    [Tags]    positive
    Tạo Phiếu Xuất Một Sản Phẩm    1    ${PXCODE}
    Thông Báo Hiển Thị    Đã tạo phiếu xuất mới
    Mở Trang Xuất Kho Trực Tiếp
    Huỷ Phiếu Xuất Đầu Tiên
    Thông Báo Hiển Thị    Đã huỷ phiếu xuất
