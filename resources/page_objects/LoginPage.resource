*** Settings ***
Documentation    PAGE OBJECT — Trang Đăng nhập (/login).
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Variables        ../locators/LoginPageLocators.py

*** Keywords ***
Mở Trang Đăng Nhập
    Go To    ${BASE_URL}/login
    Wait Until Element Is Visible    ${LOGIN_EMAIL}    timeout=${TIMEOUT}

Nhập Thông Tin Đăng Nhập
    [Arguments]    ${email}    ${password}
    Nhập Text Ổn Định    ${LOGIN_EMAIL}       ${email}
    Nhập Text Ổn Định    ${LOGIN_PASSWORD}    ${password}
    # Chờ React xử lý state (onChange chạy bất đồng bộ) trước khi submit
    Sleep    0.5s

Bấm Nút Đăng Nhập
    Click Button    ${LOGIN_SUBMIT}

Đăng Nhập Với
    [Arguments]    ${email}    ${password}
    Mở Trang Đăng Nhập
    Nhập Thông Tin Đăng Nhập    ${email}    ${password}
    Bấm Nút Đăng Nhập

Đăng Nhập Bằng Admin
    Đăng Nhập Với    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Đăng Nhập Thành Công

Đăng Nhập Bằng Thủ Kho
    Đăng Nhập Với    ${STAFF_EMAIL}    ${STAFF_PASSWORD}
    Đăng Nhập Thành Công

Đăng Nhập Bằng Kế Toán
    Đăng Nhập Với    ${ACCOUNTANT_EMAIL}    ${ACCOUNTANT_PASSWORD}
    Đăng Nhập Thành Công

Đăng Nhập Thành Công
    [Documentation]    Sau khi đăng nhập, sidebar (nút Đăng xuất) phải xuất hiện.
    Wait Until Element Is Visible    xpath=//aside//button[normalize-space()='Đăng xuất']    timeout=${TIMEOUT}

Đăng Nhập Thất Bại Với Thông Báo
    [Arguments]    ${message}
    Thông Báo Hiển Thị    ${message}
    Location Should Contain    /login

Đăng Nhập Phải Bị Từ Chối
    [Documentation]    Không phụ thuộc nội dung toast: vẫn ở /login và chưa vào hệ thống.
    Sleep    1s
    Location Should Contain    /login
    Page Should Not Contain Element    xpath=//aside//button[normalize-space()='Đăng xuất']
