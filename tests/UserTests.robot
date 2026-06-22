*** Settings ***
Documentation    Kiểm thử Quản lý Người dùng (chỉ admin). Ánh xạ TC-USER-01..06.
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/UserPage.resource
Suite Setup      Khởi Tạo Phiên
Suite Teardown   Đóng Trình Duyệt WareFlow
Test Setup       Mở Trang Người Dùng Trực Tiếp
Test Teardown    Chụp Màn Hình Khi Lỗi
Force Tags       users

*** Keywords ***
Khởi Tạo Phiên
    Mở Trình Duyệt WareFlow
    Đăng Nhập Bằng Admin
    ${suffix}=    Tạo Hậu Tố Duy Nhất
    Set Suite Variable    ${UEMAIL}    qa${suffix}@wareflow.com
    Set Suite Variable    ${UNAME}     Nhan vien QA ${suffix}

*** Test Cases ***
TC-USER-01 Mở trang danh sách người dùng
    [Tags]    smoke
    Trang Người Dùng Phải Mở

TC-USER-02 Thêm người dùng mới
    [Tags]    positive
    Tạo Người Dùng    ${UNAME}    ${UEMAIL}    123456789    Thủ kho
    Thông Báo Hiển Thị    Đã thêm người dùng mới
    Dòng Người Dùng Phải Tồn Tại    ${UEMAIL}

TC-USER-03 Thêm người dùng mật khẩu quá ngắn
    [Tags]    negative
    Mở Modal Thêm Người Dùng
    Điền Form Người Dùng    Nguoi dung loi    short${UEMAIL}    123    Thủ kho
    Gửi Thêm Người Dùng
    Thông Báo Hiển Thị    Mật khẩu tối thiểu 8 ký tự

TC-USER-04 Thêm người dùng email trùng
    [Tags]    negative
    Mở Modal Thêm Người Dùng
    Điền Form Người Dùng    ${UNAME} trùng    ${UEMAIL}    123456789    Thủ kho
    Gửi Thêm Người Dùng
    Thông Báo Hiển Thị    Email đã được sử dụng

TC-USER-05 Tìm kiếm người dùng
    [Tags]    positive
    Tìm Kiếm Người Dùng    ${UEMAIL}
    Dòng Người Dùng Phải Tồn Tại    ${UEMAIL}

TC-USER-06 Khoá tài khoản người dùng
    [Tags]    positive
    Tìm Kiếm Người Dùng    ${UEMAIL}
    Mở Chi Tiết Người Dùng    ${UEMAIL}
    Khoá Người Dùng Đang Chọn
    Thông Báo Hiển Thị    Đã khóa tài khoản
