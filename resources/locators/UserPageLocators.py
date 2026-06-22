"""Locators — Trang Quản lý Người dùng (/users)."""

USER_HEADING = "xpath=//h2[normalize-space()='Quản lý Người dùng']"
USER_ADD_BTN = "xpath=//button[normalize-space()='Thêm người dùng mới']"
USER_SEARCH = "css:input[placeholder='Tìm người dùng...']"
# Modal thêm người dùng
USER_NAME_INPUT = "css:input[placeholder='Nhập họ và tên đầy đủ']"
USER_EMAIL_INPUT = "css:input[placeholder='example@congty.com']"
USER_PWD_INPUT = "css:input[placeholder='Tối thiểu 8 ký tự']"
USER_ROLE_SELECT = "xpath=//button[.//span[normalize-space()='Thủ kho']]"
USER_SUBMIT = "xpath=//button[normalize-space()='Thêm người dùng']"
USER_LOCK_BTN = "xpath=//button[normalize-space()='Khóa']"
USER_TOGGLE_BTN = "xpath=//button[normalize-space()='Khóa' or normalize-space()='Mở khóa']"
# Mẫu locator động (Format String)
USER_ROW_TPL = "xpath=//table//tr[.//p[normalize-space()='{}']]"
