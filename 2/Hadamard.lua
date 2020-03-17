local A = torch.ceil(10*torch.rand(2, 3))
local B = torch.ceil(10*torch.rand(2, 3))
local C = torch.ceil(10*torch.rand(2, 3))
local a = torch.ceil(10*torch.rand(1))[1]
local b = torch.ceil(10*torch.rand(1))[1]
local c = torch.ceil(10*torch.rand(1))[1]
local basic = require("matrix_basic")


print("A")
print(A)
print("B")
print(B)
print("C")
print(C)
print("a",a,"b",b,"c",c)
print("-----------")
print("problem 2")
print("STP(A,B)")
print(STP(A,B))
print("STP(B,A)")
print(STP(B,A))
print("-----------")
print("problem 3")
print("associative laws")
print("STP(A,STP(B,C))")
print(STP(A,STP(B,C)))
print("STP(C,STP(A,B))")
print(STP(C,STP(A,B)))
print("law of distribution: left")
print("STP(aA+bB,C)")
print(STP(a*A+b*B,C))
print("a*STP(A,C)+b*STP(B,C)")
print(a*STP(A,C)+b*STP(B,C))
print("law of distribution: right")
print("STP(A,bB+cC)")
print(STP(c*C+b*B,A))
print("b*STP(A,B)+c*STP(A,C)")
print(b*STP(A,B)+c*STP(A,C))
print("-----------")
print("problem 4")
print("output: STP(f(A),f(B)), f(STP(A,B))")
print("f = transpose")
local At = A:transpose(1,2)
local Bt = B:transpose(1,2)
print(STP(At,Bt),(STP(A,B)):transpose(1,2))
print("f = inverse")
A = torch.ceil(10*torch.rand(3,3))
B = torch.ceil(10*torch.rand(3,3))
local Ain = torch.inverse(A)
local Bin = torch.inverse(B)
print(STP(Ain,Bin),torch.inverse(STP(A,B)))
print("f = trace")
print(torch.trace(A)*torch.trace(B) , torch.trace(STP(A,B)))
print("f = rank")
print(basic.rank(A)*basic.rank(B),basic.rank(STP(A,B)))
print("f = det")
print(basic.det(A)*basic.det(B),basic.det(STP(A,B)))
