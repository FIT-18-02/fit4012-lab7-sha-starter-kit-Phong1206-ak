CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -pedantic

SHA_TARGET := sha256
FILE_TARGET := file_integrity
PASS_TARGET := password_hash
SALT_TARGET := salted_password_hash

.PHONY: all clean run test hash-sample file-sample password-sample salted-sample

all: $(SHA_TARGET) $(FILE_TARGET) $(PASS_TARGET) $(SALT_TARGET)

$(SHA_TARGET): sha_procedure.cpp sha256_lib.h structure.h
	$(CXX) $(CXXFLAGS) sha_procedure.cpp -o $(SHA_TARGET)

$(FILE_TARGET): file_integrity.cpp sha256_lib.h structure.h
	$(CXX) $(CXXFLAGS) file_integrity.cpp -o $(FILE_TARGET)

$(PASS_TARGET): password_hash.cpp sha256_lib.h structure.h
	$(CXX) $(CXXFLAGS) password_hash.cpp -o $(PASS_TARGET)

$(SALT_TARGET): salted_password_hash.cpp sha256_lib.h structure.h
	$(CXX) $(CXXFLAGS) salted_password_hash.cpp -o $(SALT_TARGET)

run: all
	bash scripts/run_sample.sh

hash-sample: $(SHA_TARGET)
	./$(SHA_TARGET) --hash-string "hello FIT4012 SHA"

file-sample: $(SHA_TARGET) $(FILE_TARGET)
	printf "FIT4012 SHA file integrity sample\n" > sample.txt
	./$(SHA_TARGET) --hash-file sample.txt
	./$(FILE_TARGET) sample.txt $$(./$(SHA_TARGET) --hash-file sample.txt)

password-sample: $(PASS_TARGET)
	./$(PASS_TARGET) register "fit4012-demo-password"
	./$(PASS_TARGET) login "fit4012-demo-password"

salted-sample: $(SALT_TARGET)
	./$(SALT_TARGET) register "fit4012-demo-password"
	./$(SALT_TARGET) login "fit4012-demo-password"

test: all
	bash tests/test_sha_compile.sh
	bash tests/test_known_vectors.sh
	bash tests/test_file_integrity_tamper.sh
	bash tests/test_password_hash.sh
	bash tests/test_salted_password.sh

clean:
	rm -f $(SHA_TARGET) $(FILE_TARGET) $(PASS_TARGET) $(SALT_TARGET)
	rm -f sample.txt password.hash test_password.hash test_password_salted_1.hash test_password_salted_2.hash
	rm -rf build
