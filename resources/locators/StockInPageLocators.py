"""Locators — Trang Nhập kho (/stock-in) và Product Picker (dùng chung nhập/xuất)."""

IN_HEADING = "xpath=//h1[normalize-space()='Quản lý Nhập kho']"
IN_CREATE_BTN = "xpath=//button[normalize-space()='Tạo phiếu nhập mới']"
IN_SUPPLIER = "css:input[placeholder='Nhập tên nhà cung cấp']"
IN_ADD_ITEM = "xpath=//button[normalize-space()='Thêm sản phẩm']"
IN_SUBMIT = "xpath=//button[normalize-space()='Tạo phiếu nhập']"
IN_STATUS_FILTER = "xpath=//button[.//span[contains(normalize-space(),'Trạng thái')]]"
IN_ROW_CHOOSE_PRODUCT = "xpath=//button[normalize-space()='+ Chọn sản phẩm']"
IN_FIRST_QTY_INPUT = "xpath=(//div[contains(@class,'fixed')]//input[@type='number'])[1]"
IN_CONFIRM_FIRST = "xpath=(//tbody//button[@title='Xác nhận'])[1]"
IN_CANCEL_FIRST = "xpath=(//tbody//button[@title='Huỷ'])[1]"

# Product Picker (ProductPickerModal) — dùng chung cho cả nhập và xuất.
PICKER_SEARCH = "xpath=//input[@placeholder='Tìm theo mã hoặc tên sản phẩm...']"
# Ô đầu (Mã SP) của dòng sản phẩm khả dụng đầu tiên trong picker.
# Scope theo card picker (max-w-2xl) cho khỏi nhập nhằng; click vào <td> để event
# bubble lên onClick của <tr> (React). Dùng kèm "Click Phần Tử JS".
PICKER_FIRST_ROW = (
    "xpath=(//h3[normalize-space()='Chọn sản phẩm']"
    "/ancestor::div[contains(@class,'max-w-2xl')][1]"
    "//tbody/tr[not(contains(@class,'cursor-not-allowed'))])[1]/td[1]"
)
