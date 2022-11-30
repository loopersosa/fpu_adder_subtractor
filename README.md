# fpu_adder_subtractor
In this project we have designed a hardware to calculate addition and subtraction of floating point numbers based on IEEE 754 standard (revised 2019).

IEEE 754 standard is a standard which was lastly revised in 2019 and represents a standard on single precision floating point numbers. In this standard are presented
by 32 bits; first bit is assigned to the sign of number (numbers are supposed to be in sign-magnitude format meaning they have value which can be negetive or positive).
if the corrosponding sign bit is '1' it is a negetive number and otherwise it is a positive number.
next 8 bits are assigned to the exponent part of number, so the number can range from -128 to 127 (256 differnt exponents) which is usually biased so we won't have to 
deal with negetive numbers.
the left 23 bits are representing fraction of the number.

Normalized numbers : 
(-1)^S * 1.F * 2^(E) 
S: sign, F: fraction, E: exponent

for smaller numbers that can not be presented in preceeding format we can use denormalizd version

deNormalized numbers : 
(-1)^S * 0.F * 2^(E) // E = -127 // biased to 1 --> // E* = 1
S: sign, F: fraction, E: exponent

in this project we give two 32 bit floating point numbers to the FPGA board and will obtain a result in the output.

in this process we have done this series of procedures :
- checking if it is normalize 
- concatinating with hidden bit
- obtaining the difference between exponents
- shift small number 
- addition of fractions 
- rounding 
- normalizing
- rounding 
- cheking for denormalize cases and set E = 0

