# BookStoreManage - Hệ thống quản lý cửa hàng sách

**Môn học:** Công nghệ phần mềm  
**Giảng viên:** Dương Hữu Thành  
**Học kỳ:** [VD: HK1 2026-2027]  
**Nhóm:** 3  
**Repository:** https://github.com/dao-tr/BookStoreManage

## 1. Giới thiệu

BookStoreManage là phần mềm hỗ trợ quản lý hoạt động của một cửa hàng sách, gồm quản lý sách, khách hàng, bán hàng/hóa đơn, nhập kho và thống kê doanh thu.

## 2. Thành viên nhóm

| STT | Họ và tên | MSSV | Vai trò | GitHub |
|-----|-----------|------|---------|--------|
| 1 | Trần Minh Đạo | [MSSV] | Trưởng nhóm | [@dao-tr](https://github.com/dao-tr) |
| 2 | Nguyễn Thành Trung | [MSSV] | Thành viên | [@username] |
| 3 | Trần Anh Kiệt | [MSSV] | Thành viên | [@username] |

## 3. Phân chia công việc

Công việc được chia đều cho 3 thành viên, mỗi người phụ trách trọn vẹn một nhóm chức năng (từ phân tích, thiết kế, lập trình đến kiểm thử), phần chung cả nhóm cùng làm.

### 3.1. Công việc chung (cả nhóm)

| STT | Công việc | Phụ trách | Trạng thái |
|-----|-----------|-----------|------------|
| 1 | Khảo sát, phân tích yêu cầu, viết SRS | Cả nhóm | ✅ Hoàn thành |
| 2 | Thiết kế kiến trúc hệ thống, ERD, CSDL | Cả nhóm | ✅ Hoàn thành |
| 3 | Tích hợp, kiểm thử toàn hệ thống | Cả nhóm | 🔄 Đang làm |
| 4 | Viết báo cáo, slide thuyết trình | Cả nhóm | ⏳ Chưa bắt đầu |

### 3.2. Công việc theo chức năng

| Thành viên | Chức năng phụ trách | Nội dung công việc |
|------------|---------------------|--------------------|
| **Trần Minh Đạo** | Quản lý sách & danh mục | Thiết kế use case, sơ đồ lớp; lập trình giao diện + xử lý: thêm/sửa/xóa/tìm kiếm sách, thể loại, tác giả, nhà xuất bản; viết test case |
| **Nguyễn Thành Trung** | Bán hàng & hóa đơn | Thiết kế use case, sơ đồ tuần tự; lập trình lập hóa đơn, giỏ hàng, in hóa đơn, quản lý khách hàng; viết test case |
| **Trần Anh Kiệt** | Nhập kho, tài khoản & thống kê | Thiết kế use case; lập trình nhập kho, quản lý nhà cung cấp, đăng nhập/phân quyền, báo cáo thống kê doanh thu; viết test case |

## 4. Tỷ lệ đóng góp

| Thành viên | Đóng góp |
|------------|----------|
| Trần Minh Đạo | 33.3% |
| Nguyễn Thành Trung | 33.3% |
| Trần Anh Kiệt | 33.3% |

## 5. Quy trình làm việc

- **Nhánh Git:** `main` (ổn định), `develop` (tích hợp), `feature/<tên-chức-năng>` (mỗi chức năng một nhánh)
- **Commit message:** `feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`
- **Merge:** tạo Pull Request vào `develop`, có ít nhất 1 thành viên khác review trước khi merge
- **Họp nhóm:** 1 lần/tuần, trao đổi hằng ngày qua [Zalo/Discord/Messenger]
- **Lưu ý:** mỗi người commit bằng tài khoản GitHub của mình để đối chiếu đóng góp

## 6. Công nghệ sử dụng

- Ngôn ngữ: [VD: Java / C# / Python / JavaScript]
- Cơ sở dữ liệu: [VD: MySQL / SQL Server]
- Công cụ: Git, GitHub, [IDE], [Figma/Draw.io]

## 7. Cấu trúc thư mục

```
BookStoreManage/
├── docs/        # SRS, tài liệu thiết kế, báo cáo
├── src/         # Mã nguồn
├── database/    # Script tạo CSDL
├── tests/       # Test case
└── README.md
```