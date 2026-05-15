# Ghi chú đọc code SHA-256

## 1. File `structure.h`

File này chứa các thành phần nền tảng của SHA-256:

- `H0_INITIAL`: 8 giá trị băm khởi tạo.
- `K256`: 64 hằng số vòng.
- `ROTR`, `SHR`: xoay phải và dịch phải.
- `Ch`, `Maj`: hai hàm logic chính trong vòng nén.
- `Sigma0_256`, `Sigma1_256`, `sigma0_256`, `sigma1_256`: các hàm trộn bit.

## 2. File `sha256_lib.h`

File này gom phần xử lý cốt lõi thành các hàm có thể tái sử dụng:

- `bytes_to_word_be()`: chuyển 4 byte thành 1 word 32-bit Big Endian.
- `word_to_bytes_be()`: chuyển 1 word 32-bit thành 4 byte Big Endian.
- `sha256_transform()`: xử lý 1 block 512 bit.
- `calculate_sha256_bytes()`: padding, chia block, gọi transform, trả về 32 byte hash.
- `calculate_sha256_string()`: băm một chuỗi.
- `calculate_sha256_file()`: băm nội dung một file.

## 3. File `sha_procedure.cpp`

Đây là chương trình chính để sinh viên chạy nhanh SHA-256:

```bash
./sha256 --self-test
./sha256 --hash-string "abc"
./sha256 --hash-file sample.txt
```

## 4. Các bài ứng dụng

- `file_integrity.cpp`: kiểm tra toàn vẹn file bằng cách so sánh hash hiện tại với hash mong muốn.
- `password_hash.cpp`: minh họa băm mật khẩu đơn giản.
- `salted_password_hash.cpp`: thêm salt để cùng một mật khẩu không tạo cùng một hash.

## 5. Câu hỏi gợi ý cho sinh viên

1. Vì sao SHA-256 xử lý dữ liệu theo block 512 bit?
2. Vì sao kết quả SHA-256 luôn dài 256 bit dù input dài/ngắn khác nhau?
3. Nếu sửa 1 ký tự trong file, hash thay đổi như thế nào?
4. Vì sao không nên lưu mật khẩu plaintext?
5. Vì sao chỉ hash mật khẩu bằng SHA-256 vẫn chưa đủ an toàn cho hệ thống thật?
