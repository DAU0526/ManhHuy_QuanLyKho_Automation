"""Locators — Trang Đăng nhập (/login).

Khai báo dạng biến cấp module, được Robot import bằng `Variables`.
Truy cập trong .robot qua cú pháp scalar, ví dụ ${LOGIN_EMAIL}.
"""

LOGIN_EMAIL = "css:input[type=email]"
LOGIN_PASSWORD = "css:input[type=password]"
LOGIN_SUBMIT = "xpath=//button[@type='submit']"
LOGIN_HEADING = "xpath=//h1[normalize-space()='Quản Lý Kho']"
