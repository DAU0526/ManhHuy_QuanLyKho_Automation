*** Settings ***
Documentation    PAGE OBJECT — Trang Quản lý Người dùng (/users).
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Variables        ../locators/UserPageLocators.py

*** Keywords ***
Mở Trang Người Dùng Trực Tiếp
    Go To    ${BASE_URL}/users
    Trang Người Dùng Phải Mở

Trang Người Dùng Phải Mở
    Wait Until Element Is Visible    ${USER_HEADING}    timeout=${TIMEOUT}

Mở Modal Thêm Người Dùng
    Click Element    ${USER_ADD_BTN}
    Wait Until Element Is Visible    ${USER_NAME_INPUT}    timeout=${TIMEOUT}

Điền Form Người Dùng
    [Arguments]    ${name}    ${email}    ${password}    ${role}=Thủ kho
    Input Text    ${USER_NAME_INPUT}     ${name}
    Input Text    ${USER_EMAIL_INPUT}    ${email}
    Input Text    ${USER_PWD_INPUT}      ${password}
    Chọn Trong Dropdown    ${USER_ROLE_SELECT}    ${role}

Gửi Thêm Người Dùng
    Click Element    ${USER_SUBMIT}

Tạo Người Dùng
    [Arguments]    ${name}    ${email}    ${password}    ${role}=Thủ kho
    Mở Modal Thêm Người Dùng
    Điền Form Người Dùng    ${name}    ${email}    ${password}    ${role}
    Gửi Thêm Người Dùng

Tìm Kiếm Người Dùng
    [Arguments]    ${keyword}
    Wait Until Element Is Visible    ${USER_SEARCH}    timeout=${TIMEOUT}
    Clear Element Text    ${USER_SEARCH}
    Input Text    ${USER_SEARCH}    ${keyword}

_Dòng Người Dùng
    [Arguments]    ${email}
    ${locator}=    Format String    ${USER_ROW_TPL}    ${email}
    RETURN    ${locator}

Dòng Người Dùng Phải Tồn Tại
    [Arguments]    ${email}
    ${row}=    _Dòng Người Dùng    ${email}
    Wait Until Element Is Visible    ${row}    timeout=${TIMEOUT}

Mở Chi Tiết Người Dùng
    [Arguments]    ${email}
    ${row}=    _Dòng Người Dùng    ${email}
    Click Phần Tử JS    ${row}
    Wait Until Element Is Visible    ${USER_TOGGLE_BTN}    timeout=${TIMEOUT}

Khoá Người Dùng Đang Chọn
    Click Phần Tử JS    ${USER_LOCK_BTN}
    Xác Nhận Hộp Thoại    Khóa
