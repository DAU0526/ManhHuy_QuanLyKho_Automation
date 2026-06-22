*** Settings ***
Documentation    PAGE OBJECT — Khung điều hướng / Trang chủ (Layout, sidebar) sau đăng nhập.
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Variables        ../locators/NavigationPageLocators.py

*** Keywords ***
_Nav Link
    [Arguments]    ${label}
    ${locator}=    Format String    ${NAV_LINK_TPL}    ${label}
    RETURN    ${locator}

Mở Menu
    [Arguments]    ${label}
    ${link}=    _Nav Link    ${label}
    Wait Until Element Is Visible    ${link}    timeout=${TIMEOUT}
    Click Element    ${link}

Mở Trang Sản Phẩm
    Mở Menu    Sản phẩm
    Wait Until Page Contains    Quản lý Sản phẩm    timeout=${TIMEOUT}

Mở Trang Nhập Kho
    Mở Menu    Nhập kho
    Wait Until Page Contains    Quản lý Nhập kho    timeout=${TIMEOUT}

Mở Trang Xuất Kho
    Mở Menu    Xuất kho
    Wait Until Page Contains    Quản lý Xuất kho    timeout=${TIMEOUT}

Mở Trang Báo Cáo
    Mở Menu    Báo cáo
    Wait Until Page Contains    Báo cáo    timeout=${TIMEOUT}

Mở Trang Người Dùng
    Mở Menu    Người dùng
    Wait Until Page Contains    Quản lý Người dùng    timeout=${TIMEOUT}

Đăng Xuất
    Click Phần Tử JS    ${NAV_LOGOUT}
    Wait Until Location Contains    /login    timeout=${TIMEOUT}

# ── Kiểm tra hiển thị menu theo vai trò (RBAC) ───────────────────────────────
Menu Phải Hiển Thị
    [Arguments]    ${label}
    ${link}=    _Nav Link    ${label}
    Wait Until Element Is Visible    ${link}    timeout=${TIMEOUT}

Menu Không Được Hiển Thị
    [Arguments]    ${label}
    ${link}=    _Nav Link    ${label}
    Wait Until Element Is Not Visible    ${link}    timeout=${SHORT_TIMEOUT}

Truy Cập Trực Tiếp Và Bị Chặn
    [Arguments]    ${path}
    [Documentation]    Mở thẳng một route không có quyền; hệ thống điều hướng về trang chủ.
    Go To    ${BASE_URL}${path}
    Wait Until Location Does Not Contain    ${path}    timeout=${TIMEOUT}
