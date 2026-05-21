# FIT4012 Lab 7 - Báo cáo 1 trang: SHA-256

## 1. Mục tiêu / Objective

Mục tiêu của bài thực hành là tìm hiểu nguyên lý hoạt động của thuật toán băm mật mã SHA-256 và các ứng dụng thực tế của nó trong an toàn thông tin. Bài thực hành tập trung vào việc hiện thực/phân tích quá trình băm chuỗi ký tự, ứng dụng tính toán kiểm tra toàn vẹn dữ liệu (file integrity), mô phỏng cơ chế lưu trữ mật khẩu an toàn và nâng cao biểu thức bảo mật bằng kỹ thuật thêm muối (salt) để chống lại các hình thức tấn công dò tìm dựa trên bảng băm có sẵn.

## 2. Cách làm / Approach
Quá trình thực hành được triển khai tuần tự thông qua các bước sau:
- **Biên dịch hệ thống:** Sử dụng `Makefile` (hoặc CMake) để biên dịch đồng thời 4 chương trình thực thi: `sha256`, `file_integrity`, `password_hash`, và `salted_password_hash`.
- **Kiểm thử thuật toán (Self-test):** Chạy `sha_procedure.cpp` với cờ `--self-test` để đối chiếu kết quả băm với các Known Answer Test (KAT) vectors chuẩn quốc tế (như chuỗi rỗng, chuỗi "abc").
- **Kiểm tra tính toàn vẹn:** Sử dụng `file_integrity.cpp` để tạo hash cho một file dữ liệu mẫu (`sample.txt`), tiến hành thay đổi nội dung file và chạy lại chương trình nhằm xác minh khả năng phát hiện sửa đổi (tamper detection).
- **Quản lý mật khẩu cơ bản:** Chạy `password_hash.cpp` dưới hai chế độ `register` (băm mật khẩu và lưu vào file) và `login` (băm mật khẩu vừa nhập để so sánh với file) để hiểu cách lưu mật khẩu dạng không đảo ngược.
- **Tăng cường bảo mật với Salt:** Sử dụng `salted_password_hash.cpp` để tự động tạo một chuỗi ngẫu nhiên (salt) 16-byte cho mỗi lần đăng ký, nối salt với mật khẩu trước khi băm, và lưu theo định dạng `salt:hash`.

## 3. Kết quả / Result

**Hash của chuỗi `abc`:** `ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad` (Trùng khớp hoàn toàn với KAT vector).
- **Hash của file mẫu trước khi sửa:** Chạy lệnh sinh file mẫu từ `Makefile` tạo ra chuỗi hash cho nội dung `"FIT4012 SHA file integrity sample\n"` là: `6370be0e59990b79313460e5fa3f06fa7048a176840777fa093cf1a95e003102`.
- **Kết quả kiểm tra file sau khi sửa nội dung:** Chương trình trả về trạng thái lỗi và in ra thông báo: `[FAIL] File was changed or expected hash is incorrect`.
- **Kết quả đăng nhập với mật khẩu đúng:** Hệ thống xác thực thành công và in ra thông báo: `[PASS] Login success`.
- **Kết quả đăng nhập với mật khẩu sai:** Hệ thống từ chối quyền truy cập và in ra thông báo: `[FAIL] Login failed: wrong password`.
- **Hai bản ghi `salt:hash` của cùng một mật khẩu có giống nhau không?** **KHÔNG**. Do mỗi lần chạy `register`, hàm `random_salt_hex()` sinh ra một chuỗi salt ngẫu nhiên khác nhau, dẫn đến chuỗi đầu vào của hàm băm khác nhau, tạo ra hai bản ghi hoàn toàn khác biệt về cả phần salt lẫn phần hash.

## 4. Kết luận / Conclusion

**SHA-256 giúp phát hiện thay đổi dữ liệu như thế nào?** Nhờ vào **hiệu ứng tuyết rơi (Avalanche Effect)**, chỉ cần một thay đổi cực kỳ nhỏ ở đầu vào (dù chỉ là 1 bit hoặc 1 dấu cách), giá trị băm SHA-256 ở đầu ra sẽ thay đổi hoàn toàn và ngẫu nhiên. Bằng cách so sánh hash hiện tại với hash gốc được công bố công khai, ta có thể biết chính xác dữ liệu có bị can thiệp hay không.
- **Vì sao cần salt khi lưu hash mật khẩu?** Nếu không dùng salt, hai người dùng có cùng mật khẩu sẽ có cùng một chuỗi hash trong cơ sở dữ liệu, giúp kẻ tấn công dễ dàng nhận biết. Hơn nữa, kẻ tấn công có thể dùng **Rainbow Tables** (bảng tính sẵn hash của hàng triệu mật khẩu phổ biến) để tra ngược ra mật khẩu gốc. Salt ngẫu nhiên giúp biến đổi không gian băm, đảm bảo cùng một mật khẩu sẽ tạo ra các hash khác nhau, vô hiệu hóa hoàn toàn Rainbow Tables.
- **Vì sao SHA-256 demo trong lab chưa nên dùng trực tiếp cho hệ thống xác thực thật?** Thuật toán SHA-256 được thiết kế để tính toán **rất nhanh** bằng phần cứng (phục vụ kiểm tra file, blockchain). Nếu áp dụng trực tiếp để lưu mật khẩu, kẻ tấn công có thể thực hiện hàng tỷ phép thử hash mỗi giây trên các hệ thống GPU/ASIC để bẻ khóa bằng phương pháp vét cạn (Brute-force). Các hệ thống thật đòi hỏi các thuật toán chuyên dụng có cơ chế làm chậm bằng cách tiêu tốn tài nguyên bộ nhớ và thời gian CPU như **Argon2id, bcrypt, hoặc scrypt**