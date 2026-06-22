*** Settings ***
Documentation    Keyword dùng chung + nạp biến môi trường: khởi tạo trình duyệt, toast,
...              dropdown tuỳ biến (CustomSelect), hộp thoại xác nhận (ConfirmDialog).
Library          SeleniumLibrary
Library          String
Library          Collections
Library          DateTime

*** Keywords ***
# LƯU Ý: biến cấu hình (BASE_URL, BROWSER, HEADLESS, tài khoản...) được nạp từ
# resources/environment.variables.yml qua tham số dòng lệnh:
#     robot --variablefile resources/environment.variables.yml --outputdir results tests
# Vì vậy LUÔN chạy kèm --variablefile (hoặc -V) trỏ tới file này.
# ── Vòng đời trình duyệt ──────────────────────────────────────────────────────
Mở Trình Duyệt WareFlow
    [Documentation]    Khởi tạo Chrome (mặc định headless) và mở trang đăng nhập.
    ${opts}=    Set Variable    add_argument("--window-size=1920,1080");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-gpu")
    IF    ${HEADLESS}
        ${opts}=    Set Variable    add_argument("--headless=new");${opts}
    END
    Open Browser    ${BASE_URL}/login    ${BROWSER}    options=${opts}
    Set Selenium Timeout    ${TIMEOUT}
    Set Selenium Implicit Wait    0

Đóng Trình Duyệt WareFlow
    Close Browser

Chụp Màn Hình Khi Lỗi
    [Documentation]    Dùng trong Test Teardown để lưu ảnh khi test fail.
    Run Keyword If Test Failed    Capture Page Screenshot

Đặt Lại Phiên Đăng Nhập
    [Documentation]    Xoá token (localStorage) + TẤT CẢ cookie (kể cả HttpOnly/path-scoped
    ...                refreshToken mà Delete All Cookies không xoá được) qua Chrome DevTools Protocol.
    Go To    ${BASE_URL}/login
    Run Keyword And Ignore Error    Execute Javascript    window.localStorage.clear(); window.sessionStorage.clear();
    Xoá Toàn Bộ Cookie CDP
    Delete All Cookies
    Go To    ${BASE_URL}/login

Xoá Toàn Bộ Cookie CDP
    ${se}=    Get Library Instance    SeleniumLibrary
    ${params}=    Create Dictionary
    Run Keyword And Ignore Error    Call Method    ${se.driver}    execute_cdp_cmd    Network.clearBrowserCookies    ${params}

# ── Thông báo (toast) ─────────────────────────────────────────────────────────
Thông Báo Hiển Thị
    [Arguments]    ${text}
    [Documentation]    Chờ đến khi xuất hiện toast/thông điệp chứa đoạn ${text}.
    Wait Until Page Contains    ${text}    timeout=${TIMEOUT}

# ── Nhập text vào React controlled input (set qua native setter + dispatch) ───
Nhập Text Ổn Định
    [Arguments]    ${locator}    ${text}
    [Documentation]    Set value qua native setter của HTMLInputElement rồi dispatch
    ...                'input'/'change' để React value-tracker nhận ra thay đổi và chạy onChange.
    ...                Cách thường (Selenium Input Text) bị React tracker bỏ qua → state rỗng.
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    ${el}=    Get WebElement    ${locator}
    Execute Javascript
    ...    const el=arguments[0], val=arguments[1];
    ...    const setter=Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype,'value').set;
    ...    setter.call(el, val);
    ...    el.dispatchEvent(new Event('input',{bubbles:true}));
    ...    el.dispatchEvent(new Event('change',{bubbles:true}));
    ...    ARGUMENTS    ${el}    ${text}

# ── CustomSelect (dropdown tuỳ biến) ──────────────────────────────────────────
Chọn Trong Dropdown
    [Arguments]    ${trigger_locator}    ${option}
    [Documentation]    Mở dropdown CustomSelect rồi chọn mục theo nhãn hiển thị (JS click).
    Click Phần Tử JS    ${trigger_locator}
    Click Phần Tử JS    xpath=//ul//button[normalize-space()='${option}']

# ── ConfirmDialog (hộp thoại xác nhận) ────────────────────────────────────────
Xác Nhận Hộp Thoại
    [Arguments]    ${confirm_label}
    [Documentation]    Bấm nút có nhãn ${confirm_label} trong hộp thoại xác nhận đang hiển thị.
    ${btn}=    Set Variable    xpath=(//button[normalize-space()='${confirm_label}'])[last()]
    Wait Until Element Is Visible    ${btn}    timeout=${TIMEOUT}
    Click Element    ${btn}

# ── Click an toàn cho SPA ─────────────────────────────────────────────────────
Click Phần Tử JS
    [Arguments]    ${locator}
    [Documentation]    Click bằng JavaScript: tránh ElementClickInterceptedException (khi
    ...                điểm click bị phần tử con chồng lên) và click được cả nút ẩn opacity-0
    ...                (nút hiện khi hover). Chỉ chờ phần tử HIỆN DIỆN trong DOM, không cần visible.
    Wait Until Page Contains Element    ${locator}    timeout=${TIMEOUT}
    ${el}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].scrollIntoView({block: 'center'}); arguments[0].click();    ARGUMENTS    ${el}

# ── Tiện ích dữ liệu test ─────────────────────────────────────────────────────
Tạo Hậu Tố Duy Nhất
    [Documentation]    Sinh chuỗi hậu tố theo thời gian để tạo dữ liệu không trùng.
    ${ts}=    Get Current Date    result_format=%H%M%S
    RETURN    ${ts}
