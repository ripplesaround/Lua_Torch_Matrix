
function Khatri_Rao(x,y)
    local basic = require("matrix_basic")
    x = x:transpose(1,2)
    y = y:transpose(1,2)
    local x1 = x:size()[2]
    local row = x:size()[1]
    local y1 = y:size()[2]
    local temp = torch.zeros(x1*y1,1)
    for i=1,row,1 do
        if i ==1 then
            temp = temp + basic.Kronecker(torch.reshape(x[i],x1,1),torch.reshape(y[i],y1,1))
        else
            temp = torch.cat(temp,basic.Kronecker(torch.reshape(x[i],x1,1),torch.reshape(y[i],y1,1)),2)
        end
    end
    return temp
end




local A = torch.ceil(10*torch.rand(2, 3))
local B = torch.ceil(10*torch.rand(3, 3))
local C = torch.ceil(10*torch.rand(4, 3))
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
print("Khatri_Rao(A,B)")
print(Khatri_Rao(A,B))
print("Khatri_Rao(B,A)")
print(Khatri_Rao(B,A))
print("-----------")

print("problem 3")
print("associative laws")
print("Khatri_Rao (A,Khatri_Rao(B,C))")
print(Khatri_Rao(A,Khatri_Rao(B,C)))
print("Khatri_Rao(Khatri_Rao(A,B),C)")
print(Khatri_Rao(Khatri_Rao(A,B),C))

print("law of distribution: left")
print("Khatri_Rao(aA+bB,C)")
A = torch.ceil(10*torch.rand(2, 3))
B = torch.ceil(10*torch.rand(2, 3))
C = torch.ceil(10*torch.rand(2, 3))
print(Khatri_Rao(a*A+b*B,C))
print("a*Khatri_Rao(A,C)+b*Khatri_Rao(B,C)")
print(a*Khatri_Rao(A,C)+b*Khatri_Rao(B,C))

print("law of distribution: right")
print("Khatri_Rao(A,bB+cC)")
print(Khatri_Rao(c*C+b*B,A))
print("b*Khatri_Rao(A,B)+c*Khatri_Rao(A,C)")
print(b*Khatri_Rao(A,B)+c*Khatri_Rao(A,C))
print("-----------")

print("problem 4")
print("output: Khatri_Rao(f(A),f(B)), f(Khatri_Rao(A,B))")
print("f = transpose")
A = torch.ceil(10*torch.rand(3,3))
B = torch.ceil(10*torch.rand(3,3))
local At = A:transpose(1,2)
local Bt = B:transpose(1,2)
print(Khatri_Rao(At,Bt),(Khatri_Rao(A,B)):transpose(1,2))
print("f = inverse")
print("nothing")
--A = torch.ceil(10*torch.rand(3,3))
--B = torch.ceil(10*torch.rand(3,3))
--local Ain = torch.inverse(A)
--local Bin = torch.inverse(B)
--print(Khatri_Rao(Ain,Bin),torch.inverse(Khatri_Rao(A,B)))
print("f = trace")
print(torch.trace(A)*torch.trace(B) , torch.trace(Khatri_Rao(A,B)))
print("f = rank")
print(basic.rank(A)*basic.rank(B),basic.rank(Khatri_Rao(A,B)))
print("f = det")
print("nothing")
--print(basic.det(A)*basic.det(B),basic.det(Khatri_Rao(A,B)))


