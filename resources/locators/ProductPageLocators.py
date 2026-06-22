"""Locators — Trang Quản lý Sản phẩm (/products)."""

PROD_HEADING = "xpath=//h2[normalize-space()='Quản lý Sản phẩm']"
PROD_ADD_BTN = "xpath=//button[normalize-space()='Thêm sản phẩm mới']"
PROD_SEARCH = "css:input[placeholder='Tìm theo Mã hoặc Tên...']"
# Modal thêm/sửa
PROD_CODE_INPUT = "css:input[placeholder='VD: SP001']"
PROD_NAME_INPUT = "css:input[placeholder='Nhập tên sản phẩm đầy đủ']"
PROD_DESC_INPUT = "css:textarea[placeholder='Nhập mô tả sản phẩm']"
PROD_SAVE_BTN = "xpath=//button[normalize-space()='Lưu sản phẩm']"
PROD_CANCEL_BTN = "xpath=(//button[normalize-space()='Huỷ bỏ'])[last()]"
PROD_TABLE = "xpath=//table"
# Mẫu locator động (Format String)
PROD_ROW_TPL = "xpath=//table//tr[td[normalize-space()='{}']]"
