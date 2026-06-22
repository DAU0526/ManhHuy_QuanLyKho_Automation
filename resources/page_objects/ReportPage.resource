*** Settings ***
Documentation    PAGE OBJECT — Trang Báo cáo & Thống kê (/reports).
Library          SeleniumLibrary
Resource         ../common_keywords.resource
Variables        ../locators/ReportPageLocators.py

*** Keywords ***
Mở Lại Trang Báo Cáo Sạch
    [Documentation]    Tải lại /reports để các control về trạng thái mặc định (không phụ
    ...                thuộc test trước). Yêu cầu đang đăng nhập (admin/kế toán).
    Go To    ${BASE_URL}/reports
    Trang Báo Cáo Phải Mở

Trang Báo Cáo Phải Mở
    Wait Until Element Is Visible    ${REP_EXPORT_EXCEL}    timeout=${TIMEOUT}
    Wait Until Page Contains Element    ${REP_TYPE_SELECT}    timeout=${TIMEOUT}
    Wait Until Page Contains Element    ${REP_PERIOD_SELECT}    timeout=${TIMEOUT}

Chọn Kỳ Báo Cáo
    [Arguments]    ${period}
    Chọn Trong Dropdown    ${REP_PERIOD_SELECT}    ${period}
    Sleep    1s

Chọn Loại Báo Cáo
    [Arguments]    ${type_label}
    [Documentation]    Nhãn: 'Tổng hợp tồn kho' | 'Top 10 xuất kho' | 'Top 10 nhập kho'.
    Chọn Trong Dropdown    ${REP_TYPE_SELECT}    ${type_label}
    Sleep    1s

Xem Báo Cáo Top Xuất Kho
    Chọn Loại Báo Cáo    Top 10 xuất kho
    Wait Until Page Contains    Top 10 sản phẩm xuất kho nhiều nhất    timeout=${TIMEOUT}
