*** Settings ***
Documentation    PAGE OBJECT — Trang Quản lý Xuất kho (/stock-out) và modal tạo phiếu xuất.
...              Tái sử dụng keyword thao tác dòng hàng / picker từ StockInPage.
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Resource         StockInPage.resource
Variables        ../locators/StockOutPageLocators.py

*** Keywords ***
Mở Trang Xuất Kho Trực Tiếp
    Go To    ${BASE_URL}/stock-out
    Trang Xuất Kho Phải Mở

Trang Xuất Kho Phải Mở
    Wait Until Element Is Visible    ${OUT_HEADING}    timeout=${TIMEOUT}

Mở Modal Tạo Phiếu Xuất
    Click Element    ${OUT_CREATE_BTN}
    Wait Until Element Is Visible    ${OUT_SUBMIT}    timeout=${TIMEOUT}

Chọn Lý Do Xuất
    [Arguments]    ${reason}
    Chọn Trong Dropdown    ${OUT_REASON_SELECT}    ${reason}

Gửi Tạo Phiếu Xuất
    Click Phần Tử JS    ${OUT_SUBMIT}

Tạo Phiếu Xuất Một Sản Phẩm
    [Arguments]    ${quantity}=1    ${keyword}=${EMPTY}
    [Documentation]    Lý do mặc định "Bán hàng"; chọn sản phẩm còn tồn đầu tiên trong picker.
    Mở Modal Tạo Phiếu Xuất
    Thêm Dòng Sản Phẩm
    Chọn Sản Phẩm Cho Dòng Đầu    ${keyword}
    Nhập Số Lượng Dòng Đầu    ${quantity}
    Gửi Tạo Phiếu Xuất

Xác Nhận Phiếu Xuất Đầu Tiên
    Click Phần Tử JS    ${OUT_CONFIRM_FIRST}
    Xác Nhận Hộp Thoại    Xác nhận

Huỷ Phiếu Xuất Đầu Tiên
    Click Phần Tử JS    ${OUT_CANCEL_FIRST}
    Xác Nhận Hộp Thoại    Huỷ phiếu
