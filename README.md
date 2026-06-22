# WareFlow - QA Automation Framework

**Author:** WareFlow QA

---

# Project Overview

Automation Testing Framework cho hệ thống:

**WareFlow - Hệ thống quản lý kho**

Framework được xây dựng để tự động kiểm thử Web Application bằng Robot Framework.

Mục tiêu:

- Automation UI Testing
- Functional Testing
- Regression Testing
- Role-Based Access Control (RBAC) Testing
- Form Validation Testing
- Generate Test Report
- Maintainable Test Automation Architecture

---

# Technology Stack

| Technology | Usage |
|-|-|
| Python 3.10+ | Programming Language |
| Robot Framework 7.x | Automation Framework |
| SeleniumLibrary | Web Automation |
| ChromeDriver | Browser Driver |
| YAML | Environment Configuration |
| Page Object Model | Test Design Pattern |

---

# Requirements

## Required Software

| Tool | Version |
|-|-|
| Python | 3.10+ |
| Google Chrome | Latest |
| Robot Framework | 7.x |

Check installation:

```bash
python --version

robot --version
```

---

# Installation

## Clone Repository

```bash
git clone https://github.com/DAU0526/ManhHuy_QuanLyKho_Automation
```

Go to test folder:

```bash
cd ManhHuy_QuanLyKho_Automation
```

---

# Create Virtual Environment

Linux / Mac:

```bash
python3 -m venv .venv

source .venv/bin/activate
```

Windows:

```bash
python -m venv .venv

.venv\Scripts\activate
```

---

# Install Dependencies

```bash
pip install -r requirements.txt
```

ChromeDriver được Selenium Manager tự tải (không cần cài tay).

---

# Project Structure

```
ManhHuy_QuanLyKho_Automation

│
├── tests
│   ├── LoginTests.robot
│   ├── LogoutTests.robot
│   ├── ProductCreateTests.robot
│   ├── ProductSearchTests.robot
│   ├── ProductUpdateTests.robot
│   ├── ProductDeleteTests.robot
│   ├── StockInTests.robot
│   ├── StockOutTests.robot
│   ├── ReportTests.robot
│   ├── UserTests.robot
│   └── AuthorizationTests.robot
│
├── resources
│   ├── common_keywords.resource
│   ├── environment.variables.yml
│   │
│   ├── page_objects
│   │   ├── LoginPage.resource
│   │   ├── NavigationPage.resource
│   │   ├── ProductPage.resource
│   │   ├── StockInPage.resource
│   │   ├── StockOutPage.resource
│   │   ├── ReportPage.resource
│   │   └── UserPage.resource
│   │
│   └── locators
│       ├── LoginPageLocators.py
│       ├── NavigationPageLocators.py
│       ├── ProductPageLocators.py
│       ├── StockInPageLocators.py
│       ├── StockOutPageLocators.py
│       ├── ReportPageLocators.py
│       └── UserPageLocators.py
│
├── docs
│   ├── TestPlan.md
│   └── TestCases.md
│
├── requirements.txt
└── README.md
```

---

# Automation Architecture

```
Test Cases (.robot)

        |

        v

Common Keywords

        |

        v

Page Objects

        |

        v

Locators

        |

        v

WareFlow Application
```

---

# Test Coverage

# Authentication Testing

## Login Testing

File:

```
tests/LoginTests.robot
```

| ID | Test Case |
|-|-|
| TC-AUTH-01 | Login Success (Admin) |
| TC-AUTH-02 | Wrong Password |
| TC-AUTH-03 | Email Not Exist |
| TC-AUTH-04 | Empty Email |
| TC-AUTH-05 | Password < 8 chars |
| TC-AUTH-06 | Disabled Account |
| TC-AUTH-08 | Block Access Without Login |

---

## Logout Testing

File:

```
tests/LogoutTests.robot
```

| ID | Test Case |
|-|-|
| TC-AUTH-07 | Logout Success |

---

# Product Management Testing

## Create Product

File:

```
tests/ProductCreateTests.robot
```

| ID | Test Case |
|-|-|
| TC-PROD-02 | Create Success |
| TC-PROD-03 | Empty Name |
| TC-PROD-04 | Duplicate Code |

---

## Search Product

File:

```
tests/ProductSearchTests.robot
```

| ID | Test Case |
|-|-|
| TC-PROD-01 | Open Product List |
| TC-PROD-05 | Search By Code |
| TC-PROD-08 | View Transaction History |

---

## Update Product

File:

```
tests/ProductUpdateTests.robot
```

| ID | Test Case |
|-|-|
| TC-PROD-06 | Update Name Success |

---

## Delete Product

File:

```
tests/ProductDeleteTests.robot
```

| ID | Test Case |
|-|-|
| TC-PROD-07 | Delete Product (stock = 0) |

---

# Warehouse Testing

## Stock In (Import)

File:

```
tests/StockInTests.robot
```

| ID | Test Case |
|-|-|
| TC-IN-01 | Open Import List |
| TC-IN-02 | Create Import Success |
| TC-IN-03 | Missing Supplier |
| TC-IN-04 | No Product |
| TC-IN-05 | Invalid Quantity |
| TC-IN-06 | Confirm Import |
| TC-IN-07 | Cancel Import |
| TC-IN-08 | Filter By Status |

---

## Stock Out (Export)

File:

```
tests/StockOutTests.robot
```

| ID | Test Case |
|-|-|
| TC-OUT-01 | Open Export List |
| TC-OUT-02 | Create Export Success |
| TC-OUT-03 | Quantity Over Stock |
| TC-OUT-04 | No Product |
| TC-OUT-05 | Confirm Export |
| TC-OUT-06 | Cancel Export |

---

# Reports & Users Testing

## Reports

File:

```
tests/ReportTests.robot
```

| ID | Test Case |
|-|-|
| TC-REP-01 | Admin Open Report |
| TC-REP-02 | Accountant View Report |
| TC-REP-03 | Change Period |
| TC-REP-04 | Top Products |

---

## User Management

File:

```
tests/UserTests.robot
```

| ID | Test Case |
|-|-|
| TC-USER-01 | Open User List |
| TC-USER-02 | Create User |
| TC-USER-03 | Password Too Short |
| TC-USER-04 | Duplicate Email |
| TC-USER-05 | Search User |
| TC-USER-06 | Lock Account |

---

## Authorization (RBAC)

File:

```
tests/AuthorizationTests.robot
```

| ID | Test Case |
|-|-|
| TC-RBAC-01 | Admin Menu Full |
| TC-RBAC-02 | Warehouse Staff Menu |
| TC-RBAC-03 | Accountant Menu |
| TC-RBAC-04 | Accountant Blocked Products |
| TC-RBAC-05 | Staff Blocked Users |
| TC-RBAC-06 | Staff Blocked Reports |

---

# Total Test Cases

```

Login              7
Logout             1

Product Create     3
Product Search     3
Product Update     1
Product Delete     1

Stock In           8
Stock Out          6

Reports            4
Users              6
Authorization      6


====================
TOTAL: 46 TESTS
====================

```

---

# Running Tests

> Bắt buộc truyền `--variablefile resources/environment.variables.yml` (viết tắt `-V`)
> để nạp URL, trình duyệt và tài khoản test.

## Run All Tests

```bash
robot -V resources/environment.variables.yml -d results tests
```

---

## Run Login

```bash
robot -V resources/environment.variables.yml -d results tests/LoginTests.robot
```

---

## Run Product Tests

```bash
robot -V resources/environment.variables.yml -d results tests/Product*.robot
```

---

## Run By Tag (smoke / module)

```bash
robot -V resources/environment.variables.yml --include smoke -d results tests
robot -V resources/environment.variables.yml --include products -d results tests
```

---

## Show Browser (non-headless)

```bash
robot -V resources/environment.variables.yml -v HEADLESS:False -d results tests/LoginTests.robot
```

> Lưu ý: đừng chạy 2 lệnh `robot` cùng ghi vào một `-d results` cùng lúc (làm hỏng
> `output.xml`). Muốn chạy song song thì tách thư mục: `-d results/run1`, `-d results/run2`.

---

# Test Report

Sau khi chạy:

```
results/

├── output.xml

├── log.html

└── report.html
```

Mở report:

Linux:

```bash
xdg-open results/report.html
```

Windows:

```bash
start results/report.html
```

---

# Page Object Model

Kiến trúc 3 lớp: locator tách khỏi hành vi, test chỉ gọi keyword nghiệp vụ.

## Locator Layer

`resources/locators/*.py` — chỉ chứa định danh phần tử (XPath / CSS) dạng biến Python.

Example:

```python
LOGIN_EMAIL = "css:input[type=email]"
LOGIN_SUBMIT = "xpath=//button[@type='submit']"
```

---

## Page Object Layer

`resources/page_objects/*.resource` — keyword nghiệp vụ, import locators bằng `Variables`.

Example:

```robot
Đăng Nhập Với    ${email}    ${password}
Tạo Sản Phẩm     ${code}     ${name}    ${desc}
```

---

## Test Layer

`tests/*.robot` — chỉ chứa kịch bản và kết quả mong đợi, không chạm locator.

Example:

```robot
Đăng Nhập Bằng Admin
Tạo Sản Phẩm    ${PCODE}    ${PNAME}    Hàng kiểm thử
Thông Báo Hiển Thị    Đã thêm sản phẩm mới
```

---

# Environment Configuration

File:

```
resources/environment.variables.yml
```

Example:

```yaml
BASE_URL: https://wm.huy-vu.uk
BROWSER: chrome
HEADLESS: true

ADMIN_EMAIL: admin@wareflow.com
ADMIN_PASSWORD: "123456789"
```

Tài khoản test (mật khẩu chung `123456789`):

| Role | Email |
|-|-|
| Admin | admin@wareflow.com |
| Thủ kho | staff@wareflow.com |
| Kế toán | accountant@wareflow.com |
| Disabled | disabled@wareflow.com |

Ghi đè khi chạy: `-v HEADLESS:False` hoặc đổi cả file `-V <file>.yml`.

---

# Troubleshooting

## Element Not Found

Nguyên nhân:

- Sai XPath
- Page load chậm

Fix:

```robot
Wait Until Element Is Visible
```

---

## Click Bị Chặn / React Không Nhận

Nguyên nhân:

- Click `<tr>` bị `<td>` con chồng (ElementClickInterceptedException)
- React controlled input bỏ qua giá trị Selenium nhập

Fix:

```robot
Click Phần Tử JS       # JS click, bỏ qua interception
Nhập Text Ổn Định      # set value qua native setter + dispatch input
```

---

## Browser Error

Kiểm tra:

```robot
Suite Setup
Suite Teardown
```

---

# Git Workflow

Check:

```bash
git status
```

Add:

```bash
git add .
```

Commit:

```bash
git commit -m "Update automation framework"
```

Push:

```bash
git push origin main
```

---

# Future Improvements

- GitHub Actions CI/CD
- Allure Report
- Parallel Execution (Pabot)
- Data Driven Testing
- API Testing Integration
- Auto cleanup dữ liệu test trên môi trường

---

# Author

WareFlow QA

DevOps - Quản lý kho Automation Project
