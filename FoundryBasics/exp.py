import sys
import math
import struct

# python exp.py 18446744073709551616
# 2.718...

x = float(sys.argv[1]) / 2**64
y = math.exp(x)

# Debug
print(y)

# Check y < 2**64
assert y < 2**64, f"x = {x}"
y = int(y * 2**64)

# Encode manually using unsigned 64-bit integer
y = "0x" + struct.pack('>Q', y).hex()
print(y)