---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ginne.
--- DateTime: 2020/2/22 10:24
---

-- 自传数 autobiographical_number
-- 1210、2020、21200、3211000、42101000、521001000、6210001000。
-- 证明在位数大于6的情况下，自传数最后三位一定是零
a0 = 0
function checkout(i)
    i = i*(1000)
    local temp = tostring(i)
    local temp2 = tostring(i)
    --print(temp[1])
    --print(temp)
    lenth = string.len(temp)
    -- 拿到第一位
    for j=1,lenth,1 do
        local cnt = string.sub(temp,j,j)
        cnt = tonumber(cnt)
        if j==1
        then
            a0 = math.modf(cnt)
        end
        if cnt>a0 or cnt==lenth-1 or cnt==lenth-2  or cnt==lenth-3
        then
            --if j==1
            --then
            --    return false,10^(string.len(temp))
            --else
            --    return false,i+(10-cnt)*10^(string.len(temp)-j)
            --end
            --print("dangqian",i,"cnt",cnt)
            --print("3----------")
            return false,(i+(10-cnt)*10^(lenth-j-1))/1000
        end
        local len1 = string.len(temp2)
        temp2 = string.gsub(temp2,tostring(j-1),"",cnt)
        local len2 = string.len(temp2)
        if cnt ~= len1-len2
        then
            --print(cnt,len1-len2,i)
            return false,i/1000
        end
    end
    if string.len(temp2)==0
    then
        --print('check',i)
        return true,i/1000
    else
        --print('2------------------')
        return false,i/1000
    end
end


function checkout2(i)
    local temp = tostring(i)
    local temp2 = tostring(i)
    --print(temp[1])
    --print(temp)
    for j=1,string.len(temp),1 do
        local cnt = string.sub(temp,j,j)
        cnt = tonumber(cnt)
        local len1 = string.len(temp2)
        temp2 = string.gsub(temp2,tostring(j-1),"",cnt)
        local len2 = string.len(temp2)
        if cnt ~= len1-len2
        then
            return false,i
        end
    end
    if string.len(temp2)==0
    then
        --print('check',i)
        return true,i
    else
        return false,i
    end
end

print("自传数有")
a = 1
local i = 1
--for i=1,10^11,1 do
--    temp,i = checkout(i)
--    --print(temp,k)
--    if temp
--        then
--        print("第",a,"个",i)
--        a = a+1
--    end
--end
for value in function()
    --print('begin',i)
    i= math.modf(i)
    temp,i = checkout2(i)
    --print(temp,i)
    if temp
    then
        print("第",a,"个",i)
        a = a+1
    end
    i=i+1
    return i
end
do
    --print("第一个数",a0 )
    --print(value)
    if value >= 10^6
    then break
    end
end
i = 1000

for value1 in function()
    --print('begin',i)
    i= math.modf(i)
    temp,i = checkout(i)
    --print(temp,i)
    if temp
    then
        print("第",a,"个",i*1000)
        a = a+1
    end
    i=i+1
    return i
end
do
    --print("第一个数",a0 )
    --print(value1)
    if value1 >= 10^7
    then break
    end
end

print('final')

