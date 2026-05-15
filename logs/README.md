# Logs / Minh chứng

Sinh viên lưu minh chứng thực hành tại đây, ví dụ:

- log biên dịch chương trình
- log chạy `./sha256 --self-test`
- log kiểm tra toàn vẹn file trước và sau khi sửa nội dung
- log kiểm tra mật khẩu đúng/sai
- log chứng minh cùng mật khẩu nhưng salt khác nhau tạo ra bản ghi khác nhau

Có thể tạo log bằng lệnh:

```bash
bash scripts/run_sample.sh | tee logs/my-run.log
```
