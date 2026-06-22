*** Settings ***
Documentation    PAGE OBJECT — Trang Quản lý Sản phẩm (/products).
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Variables        ../locators/ProductPageLocators.py

*** Keywords ***
Mở Trang Sản Phẩm Trực Tiếp
    Go To    ${BASE_URL}/products
    Trang Sản Phẩm Phải Mở

Trang Sản Phẩm Phải Mở
    Wait Until Element Is Visible    ${PROD_HEADING}    timeout=${TIMEOUT}
    Wait Until Element Is Visible    ${PROD_TABLE}      timeout=${TIMEOUT}

Mở Modal Thêm Sản Phẩm
    Click Element    ${PROD_ADD_BTN}
    Wait Until Element Is Visible    ${PROD_NAME_INPUT}    timeout=${TIMEOUT}

Điền Form Sản Phẩm
    [Arguments]    ${code}    ${name}    ${description}
    [Documentation]    Mã SP chỉ nhập khi tạo mới (khi sửa, ô mã bị khoá).
    Run Keyword And Ignore Error    Input Text    ${PROD_CODE_INPUT}    ${code}
    Input Text    ${PROD_NAME_INPUT}    ${name}
    Input Text    ${PROD_DESC_INPUT}    ${description}

Lưu Sản Phẩm
    Click Element    ${PROD_SAVE_BTN}

Đóng Modal Sản Phẩm
    Click Element    ${PROD_CANCEL_BTN}

Tạo Sản Phẩm
    [Arguments]    ${code}    ${name}    ${description}=Mô tả tự động cho ${code}
    Mở Modal Thêm Sản Phẩm
    Điền Form Sản Phẩm    ${code}    ${name}    ${description}
    Lưu Sản Phẩm

Tìm Kiếm Sản Phẩm
    [Arguments]    ${keyword}
    Wait Until Element Is Visible    ${PROD_SEARCH}    timeout=${TIMEOUT}
    Clear Element Text    ${PROD_SEARCH}
    Input Text    ${PROD_SEARCH}    ${keyword}
    # Trang dùng debounce 500ms trước khi gọi API
    Sleep    1s

_Dòng Sản Phẩm
    [Arguments]    ${code}
    ${locator}=    Format String    ${PROD_ROW_TPL}    ${code}
    RETURN    ${locator}

Dòng Sản Phẩm Phải Tồn Tại
    [Arguments]    ${code}
    ${row}=    _Dòng Sản Phẩm    ${code}
    Wait Until Element Is Visible    ${row}    timeout=${TIMEOUT}

Dòng Sản Phẩm Không Còn Tồn Tại
    [Arguments]    ${code}
    ${row}=    _Dòng Sản Phẩm    ${code}
    Wait Until Element Is Not Visible    ${row}    timeout=${TIMEOUT}

Mở Sửa Sản Phẩm
    [Arguments]    ${code}
    ${row}=    _Dòng Sản Phẩm    ${code}
    Click Phần Tử JS    ${row}//button[@title='Chỉnh sửa']
    Wait Until Element Is Visible    ${PROD_NAME_INPUT}    timeout=${TIMEOUT}

Sửa Tên Sản Phẩm
    [Arguments]    ${code}    ${new_name}
    Mở Sửa Sản Phẩm    ${code}
    Clear Element Text    ${PROD_NAME_INPUT}
    Input Text    ${PROD_NAME_INPUT}    ${new_name}
    Lưu Sản Phẩm

Xoá Sản Phẩm
    [Arguments]    ${code}
    ${row}=    _Dòng Sản Phẩm    ${code}
    Click Phần Tử JS    ${row}//button[@title='Xoá']
    Xác Nhận Hộp Thoại    Xoá

Mở Chi Tiết Sản Phẩm
    [Arguments]    ${code}
    ${row}=    _Dòng Sản Phẩm    ${code}
    Click Phần Tử JS    ${row}//td[1]
    Wait Until Page Contains    Thông tin    timeout=${TIMEOUT}

Mở Tab Lịch Sử Giao Dịch
    Click Element    xpath=//button[normalize-space()='Lịch sử giao dịch']
