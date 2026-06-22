"""Locators — Khung điều hướng / Trang chủ sau đăng nhập (Layout/sidebar)."""

NAV_LOGOUT = "xpath=//aside//button[normalize-space()='Đăng xuất']"
NAV_AVATAR = "xpath=//header//button[contains(@class,'rounded-full')]"
# Mẫu link điều hướng theo nhãn — dùng với Format String trong page object.
NAV_LINK_TPL = "xpath=//aside//a[normalize-space()='{}']"
