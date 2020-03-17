--print("Hello World!")
function checkout(i)
    local i1 = math.modf(i^3)
    local i2 = math.modf(i^4)
    local temp1 = 0
    temp1 = math.modf(i1/1000)
    local temp2 = i2/100000
    -- 判断位数
    if temp1 >= 10 or temp2 >= 10
    then
        return false
    end
    -- 判断
    local i3 = tostring(i1)..tostring(i2)
    for j = 0,10,1 do
        i3=string.gsub(i3,tostring(j),"",1)
    end
    --print(string.len(i3))
    --print(i3)
    if string.len(i3)==0
    then
        return true
    else
        return false
    end
    --return true
end


for i=10,30,1 do
    --print(checkout(i))
    if checkout(i)==true
        then
        print("年龄为",i)
        break
    end
end
