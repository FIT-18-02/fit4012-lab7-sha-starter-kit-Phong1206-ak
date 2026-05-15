# FIT4012 Lab 7 - Báo cáo 1 trang: SHA-256

## 1. Mục tiêu / Objective

Mô tả ngắn gọn mục tiêu của bài thực hành: phân tích thuật toán SHA-256, chạy chương trình băm chuỗi, kiểm tra toàn vẹn file, băm mật khẩu và cải tiến bằng salt.

## 2. Cách làm / Approach

Tóm tắt cách nhóm/cá nhân đã thực hiện:

- Biên dịch và chạy `sha_procedure.cpp`.
- Kiểm thử SHA-256 bằng known answer test vector.
- Viết/chạy chương trình kiểm tra toàn vẹn file.
- Viết/chạy chương trình băm mật khẩu.
- Bổ sung salt để tránh việc hai người có cùng mật khẩu tạo ra cùng hash.

## 3. Kết quả / Result

Điền minh chứng chính:

- Hash của chuỗi `abc`:
- Hash của file mẫu trước khi sửa:
- Kết quả kiểm tra file sau khi sửa nội dung:
- Kết quả đăng nhập với mật khẩu đúng:
- Kết quả đăng nhập với mật khẩu sai:
- Hai bản ghi `salt:hash` của cùng một mật khẩu có giống nhau không?

## 4. Kết luận / Conclusion

Nêu ngắn gọn điều rút ra:

- SHA-256 giúp phát hiện thay đổi dữ liệu như thế nào?
- Vì sao cần salt khi lưu hash mật khẩu?
- Vì sao SHA-256 demo trong lab chưa nên dùng trực tiếp cho hệ thống xác thực thật?
