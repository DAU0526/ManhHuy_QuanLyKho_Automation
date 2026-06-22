*** Settings ***
Documentation    PAGE OBJECT — Trang Quản lý Nhập kho (/stock-in) và modal tạo phiếu nhập.
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Variables        ../locators/StockInPageLocators.py

*** Keywords ***
Mở Trang Nhập Kho Trực Tiếp
    Go To    ${BASE_URL}/stock-in
    Trang Nhập Kho Phải Mở

Trang Nhập Kho Phải Mở
    Wait Until Element Is Visible    ${IN_HEADING}    timeout=${TIMEOUT}

Mở Modal Tạo Phiếu Nhập
    Click Element    ${IN_CREATE_BTN}
    Wait Until Element Is Visible    ${IN_SUPPLIER}    timeout=${TIMEOUT}

Nhập Nhà Cung Cấp
    [Arguments]    ${supplier}
    Input Text    ${IN_SUPPLIER}    ${supplier}

Thêm Dòng Sản Phẩm
    Click Element    ${IN_ADD_ITEM}

Chọn Sản Phẩm Trong Picker
    [Arguments]    ${keyword}=${EMPTY}
    [Documentation]    Mở picker, (tuỳ chọn) tìm kiếm rồi chọn sản phẩm khả dụng đầu tiên.
    Wait Until Element Is Visible    ${PICKER_SEARCH}    timeout=${TIMEOUT}
    IF    '${keyword}' != '${EMPTY}'
        Input Text    ${PICKER_SEARCH}    ${keyword}
        Sleep    1s
    END
    Click Phần Tử JS    ${PICKER_FIRST_ROW}

Chọn Sản Phẩm Cho Dòng Đầu
    [Arguments]    ${keyword}=${EMPTY}
    Click Element    ${IN_ROW_CHOOSE_PRODUCT}
    Chọn Sản Phẩm Trong Picker    ${keyword}

Nhập Số Lượng Dòng Đầu
    [Arguments]    ${quantity}
    Wait Until Element Is Visible    ${IN_FIRST_QTY_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${IN_FIRST_QTY_INPUT}
    Input Text    ${IN_FIRST_QTY_INPUT}    ${quantity}

Gửi Tạo Phiếu Nhập
    Click Phần Tử JS    ${IN_SUBMIT}

Tạo Phiếu Nhập Một Sản Phẩm
    [Arguments]    ${supplier}    ${quantity}=10    ${keyword}=${EMPTY}
    [Documentation]    Luồng đầy đủ: mở modal → nhập NCC → thêm 1 dòng → chọn SP → nhập SL → gửi.
    Mở Modal Tạo Phiếu Nhập
    Nhập Nhà Cung Cấp    ${supplier}
    Thêm Dòng Sản Phẩm
    Chọn Sản Phẩm Cho Dòng Đầu    ${keyword}
    Nhập Số Lượng Dòng Đầu    ${quantity}
    Gửi Tạo Phiếu Nhập

Lọc Phiếu Nhập Theo Trạng Thái
    [Arguments]    ${status_label}
    Chọn Trong Dropdown    ${IN_STATUS_FILTER}    ${status_label}
    Sleep    1s

Xác Nhận Phiếu Nhập Đầu Tiên
    Click Phần Tử JS    ${IN_CONFIRM_FIRST}
    Xác Nhận Hộp Thoại    Xác nhận

Xác Nhận Phiếu Nhập Theo Nhà Cung Cấp
    [Arguments]    ${supplier}
    [Documentation]    Xác nhận đúng phiếu của ${supplier} (không phụ thuộc thứ tự danh sách).
    Click Phần Tử JS    xpath=//tbody/tr[td[contains(normalize-space(),'${supplier}')]]//button[@title='Xác nhận']
    Xác Nhận Hộp Thoại    Xác nhận

Huỷ Phiếu Nhập Đầu Tiên
    Click Phần Tử JS    ${IN_CANCEL_FIRST}
    Xác Nhận Hộp Thoại    Huỷ phiếu
