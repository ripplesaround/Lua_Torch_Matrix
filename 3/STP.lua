---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ginne.
--- DateTime: 2020/3/17 09:44
---

local basic = require("matrixbasic")


function STP(x,y)
    local basic = require("matrixbasic")
    local x2 = x:size()[2]
    local y1 = y:size()[1]
    local t = basic.lcm(x2,y1)
    local In = torch.eye(t/x2)
    local Ip = torch.eye(t/y1)
    return (basic.Kronecker(x,In)*basic.Kronecker(y,Ip))
end

--
--local A =  torch.eye(2,3)
--A[1] = torch.Tensor{1,-1,2}
--A[2] = torch.Tensor{0,1,0}
--local B =  torch.eye(2,2)
--B[2] = torch.Tensor{1,1}
--print(STP(A,B))

--local A = torch.ceil(10*torch.rand(2, 3))
--local B = torch.ceil(10*torch.rand(2, 3))
--local C = torch.ceil(10*torch.rand(2, 3))
--local a = torch.ceil(10*torch.rand(1))[1]
--local b = torch.ceil(10*torch.rand(1))[1]
--local c = torch.ceil(10*torch.rand(1))[1]
--
--print("A")
--print(A)
--print("B")
--print(B)
--print("C")
--print(C)
--print("a",a,"b",b,"c",c)
--print("-----------")
--print("problem 2")
--print("STP(A,B)")
--print(STP(A,B))
--print("STP(B,A)")
--print(STP(B,A))
--print("-----------")
--print("problem 3")
--print("associative laws")
--print("STP(A,STP(B,C))")
--print(STP(A,STP(B,C)))
--print("STP(STP(A,B),C)")
--print(STP(STP(A,B),C))
--print("law of distribution: left")
--print("STP(aA+bB,C)")
--print(STP(a*A+b*B,C))
--print("a*STP(A,C)+b*STP(B,C)")
--print(a*STP(A,C)+b*STP(B,C))
--print("law of distribution: right")
--print("STP(A,bB+cC)")
--print(STP(A,c*C+b*B))
--print("b*STP(A,B)+c*STP(A,C)")
--print(b*STP(A,B)+c*STP(A,C))
--print("-----------")
--print("problem 4")
--print("output: STP(f(A),f(B)), f(STP(A,B))")
--print("f = transpose")
--local At = A:transpose(1,2)
--local Bt = B:transpose(1,2)
--print(STP(At,Bt),(STP(A,B)):transpose(1,2))
--print("f = inverse")
--A = torch.ceil(10*torch.rand(3,3))
--B = torch.ceil(10*torch.rand(3,3))
--local Ain = torch.inverse(A)
--local Bin = torch.inverse(B)
--print(STP(Ain,Bin),torch.inverse(STP(A,B)))
--print("f = trace")
--print(torch.trace(A)*torch.trace(B) , torch.trace(STP(A,B)))
--print("f = rank")
--print(basic.rank(A)*basic.rank(B),basic.rank(STP(A,B)))
--print("f = det")
--print(basic.det(A)*basic.det(B),basic.det(STP(A,B)))

--print("Proposition 4.2.2")
--local test1 = torch.ceil(10*torch.rand(1, 3))
--local test2 = torch.ceil(10*torch.rand(1, 2))
--print("col vector")
--print("STP(test1,test2)")
--print(STP(test1,test2))
--print("Kronecker(test2,test1)")
--print(basic.Kronecker(test2,test1))
--test1 = torch.ceil(10*torch.rand(3, 1))
--test2 = torch.ceil(10*torch.rand(2, 1))
--print("row vector")
--print("STP(test1,test2)")
--print(STP(test1,test2))
--print("Kronecker(test1,test2)")
--print(basic.Kronecker(test1,test2))

-- todo 还有一些性质可以去探究

print("Proposition 4.2.3")
local m = 12
local n = 12
local t = 2
local p = 6
local q = 8
local s = 2
local r = 3
local dim_C_col = m*basic.lcm(n,p)/n
local dim_C_row = q*basic.lcm(n,p)/p

-- todo ppt里两个t是一个t么
local col_base = m / r
local row_base = n / s
local col_base2 = p / s
local row_base2 = q / t

local A = torch.ceil(10*torch.rand(m, n))
local B = torch.ceil(10*torch.rand(p, q))


function get(A,i,j,a1,a2)
    --a1 = row_base 6
    --a2 = col_base 4
    row_temp = (j-1)*a1    --列
    col_temp = (i-1)*a2+1  --行
    x = torch.Tensor(a2,a1)
    x:apply(
            function()
                --print(row_temp,col_temp)
                --if col_temp == i*a1+1 then
                --    row_temp =
                --end
                --print(row_temp,col_temp)
                if row_temp == j*a1 then
                    row_temp = (j-1)*a1
                    col_temp = col_temp + 1
                end
                row_temp = row_temp + 1
                print(col_temp,row_temp,A[col_temp][row_temp])
                return A[col_temp][row_temp]
 end    )
    return x
end

function find_c(A,B,row_base,col_base,row_base2,col_base2)
    print(row_base,col_base)
    local temp_A = get(A,3,1,row_base,col_base)
    local temp_B = get(B,1,2,row_base2,col_base2)
    local temp_c = torch.zeros(dim_C_col/r,dim_C_row/t)
    local temp = torch.zeros(dim_C_col/r,dim_C_row/t)
    local flag = 1
    for i = 1,r,1 do
        for j = 1,t,1 do
            for k =1,s,1 do

            end
            --if flag==1 then
            --
            --else
            --
            --end
        end
    end
end

find_c(A,B,row_base,col_base,row_base2,col_base2)



print("end")




