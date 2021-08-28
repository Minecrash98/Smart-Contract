import hashlib
import time

begin = time.time()
for x in range(1, 10000000, 1):
    key = hashlib.sha256(b"Hello, World!")
end = time.time()
print("Time takes to computed SHA256 10 Mega times: ", end - begin)