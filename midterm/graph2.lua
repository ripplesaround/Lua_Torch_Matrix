---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ginne.
--- DateTime: 2020/5/9 13:20
--- no dir
---
local plt = require('plot')

N = 6
num = 0
num_test = 0
function init()
    -- create graph
    local P = torch.zeros(N,N)
    for i = 1,N,1 do
        for j = 1,N,1 do
            if math.random() >=0.5 then
                P[i][j] = 1
                P[j][i] = 1
            end
        end
    end
    return P
end
function inc(matrix)
    num = torch.sum(matrix)
    for i=1,N,1 do
        if matrix[i][i] == 1 then
            num = num + 1
        end
    end
    print(num)
    num = num/2
    local P = torch.zeros(N,num)
    local flag = 1
    for i = 1,N,1 do
        for j = i,N,1 do
            if matrix[i][j] == 1 then
                P[i][flag] = 1
                P[j][flag] = 1
                if i==j then
                    P[i][flag] = 2
                end
                flag = flag + 1
            end
        end
    end
    return P
end
function lap(matrix)
    ---- no dir
    --y = torch.sum(matrix, 1)
    -- degree
    --local D = torch.zeros(N,N)
    --for i=1,N,1 do
    --    D[i][i] = y[1][i]
    --end
    --print(D)
    --local L = D - matrix
    --return L

    ---- dir
    return matrix * matrix:t()
end

edge_check = torch.zeros(N,N)
trail_table = {}
flag_eular_half = false
flag_eular = false
flag_hamilton_half = false
flag_hamilton = false
flag_tree = true
flag_forest = false
con_set = torch.zeros(N)
con_set_num = torch.sum(con_set)
function check_edge(current,matrix)
    -- dfs的边界条件
    for i=1,N,1 do
        if matrix[current][i] == 1 and edge_check[current][i] == 0 then
            return false
        end
    end
    return true
end
function max(i,j)
    if i>j then
        return i
    end
    return j
end
function find_trail_point(current,matrix)
    -- dfs
    -- 当前这个点没有边了
    local temp = "trail: "
    local start_point
    local hamilton_array = torch.zeros(N)
    local flag_temp = 0
    local con_set_local = torch.zeros(N)
    for i, v in ipairs(trail_table) do
        if i==1 then
            start_point = v[1]
            hamilton_array[v[1]] = hamilton_array[v[1]] + 1
            con_set_local[v[1]] = 1
        end
        temp = temp.."("
        temp = temp..v[1]
        temp = temp..","
        temp = temp..v[2]
        temp = temp..")"
        con_set_local[v[2]] = 1

        if i == num then
            flag_eular_half =true
            if v[2] == start_point then
                flag_eular = true
            end
        end

        if i>N and flag_temp>0 then
            flag_temp = -1
        end
        if flag_temp>=0 then
            hamilton_array[v[2]] = hamilton_array[v[2]] + 1
            flag_temp = flag_temp+1
        end
        if flag_tree then
            if hamilton_array[v[2]] > 1 then
                flag_tree = false
                flag_forest = false
            end
        end
    end
    -- con_set
    if torch.sum(con_set_local) > con_set_num then
        con_set = con_set_local
        con_set_num = torch.sum(con_set)
    end


    if flag_temp == N-1 then
        --num_test = flag_temp
        --num_test = temp
        --if hamilton_array == ("trail: (1,3)(3,2)(2,4)(4,5)(5,6)") then
        --    num_test = "yes"
        --end
        flag_temp = 0
        for i=1,N,1 do
            if hamilton_array[i] == 0 or hamilton_array[i] >1 then
                break
            end
            --if not (hamilton_array[i] == 2 and i == start_point) then
            --    break
            --end
            flag_temp = i
        end
        if flag_temp == N then
            flag_hamilton_half = true
            --if hamilton_array[start_point] == 2 then
            --    flag_hamilton = true
            --end
        end
    end
    if flag_temp == N then
        --hamilton_array = {2,1,1,1,1,1}
        --num_test = flag_temp
        --num_test = start_point
        --if temp == ("trail: (1,3)(3,2)(2,4)(4,5)(5,6)(6,1)") then
        --    num_test = "yes"
        --end
        flag_temp = 0
        for i=1,N,1 do
            if hamilton_array[i] == 0 or hamilton_array[i] >2 then
                break
            end
            if (not (hamilton_array[i] == 2 and i == start_point)) and hamilton_array[i] > 1  then
                break
            end
            flag_temp = i
        end
        if flag_temp == N then
            if hamilton_array[start_point] == 2 then
                flag_hamilton = true
            end
        end
    end
    print(temp)


    if check_edge(current,matrix) then
        table.remove(trail_table)
        return
    end
    for i=1,N,1 do
        if matrix[current][i] == 1 and edge_check[current][i] == 0 then
            --print("i ",i)
            table.insert(trail_table,{current,i})
            edge_check[current][i] = 1
            edge_check[i][current] = 1
            find_trail_point(i,matrix)
            edge_check[current][i] = 0
            edge_check[i][current] = 0
        end
    end
    table.remove(trail_table)
end
function find_trail(A)
    print("All trails\n--------------------")
    for i=1,N,1 do
        edge_check = torch.zeros(N,N)
        trail_table = {}
        find_trail_point(i,A)
        print("--------------------")
    end
end
function check_eular()
    print("eular_check")
    if flag_eular_half then
        print("half eular graph")
    else
        print("not half eular graph")
    end
    if flag_eular then
        print("eular graph")
    else
        print("not eular graph")
    end
    print("--------------------")
end
function check_hamilton()
    print("hamilton_check")
    if flag_hamilton_half then
        print("half hamilton graph")
    else
        print("not half hamilton graph")
    end
    if flag_hamilton then
        print("hamilton graph")
    else
        print("not hamilton graph")
    end
    print("--------------------")
end
function check_tree(A)
    print("tree_check")
    -- check if it is a forest
    if not flag_tree then
        local y1 = torch.sum(A, 2)
        local y2 = torch.sum(A, 1)
        local y3 = y1+y2
        for i =1,N,1 do
            if y3[i] == 0 then
                flag_forest = true
                print("graoh is a forest")
            end
        end
    end
    if flag_tree and (not flag_forest) then
        print("graoh is a tree")
    else
        print("graph is not a tree / forest")
    end
end
vis = torch.zeros(N)
function creat_con_set(matrix)
    local con_set_name = {}
    print("--------------------")
    for i=1,N,1 do
        if con_set[i] == 1 then
            table.insert(con_set_name,i)
        end
    end
    print("max con subset")
    print(con_set_name)
    local cut_set,brigde_set
    cut_set, brigde_set = find_cut(matrix)

    --print("--------------------")
    --print("disconnecting set")

    print("--------------------")
    print("cut")
    print(cut_set)

    print("--------------------")
    print("brigde")
    print(brigde_set)

    --check_connect(matrix,con_set_name[1])
end
function find_cut(matrix)
    -- N = 6
    local cut_set_total = {}
    local brigde_set = {}
    for i= 2^N-2,1,-1 do
        local cut_set = {}
        local a = {}
        for j=1,N,1 do
            a[j] = 0
        end
        local temp = i
        if temp>=2^(N-1)  then
            a[1] = 1
            temp = temp-2^(N-1)
        end
        if temp>=2^(N-2)  then
            a[2] = 1
            temp = temp-2^(N-2)
        end
        if temp>=2^(N-3)  then
            a[3] = 1
            temp = temp-2^(N-3)
        end
        if temp>=2^(N-4)  then
            a[4] = 1
            temp = temp-2^(N-4)
        end
        if temp>=2^(N-5)  then
            a[5] = 1
            temp = temp-2^(N-5)
        end
        if temp>=2^(N-6)  then
            a[6] = 1
            temp = temp-2^(N-6)
        end
        for j=1,N,1 do
            if a[j] == 0 then
                for t=1,N,1 do
                    if a[t]==1 and matrix[j][t]==1 then
                        table.insert(cut_set,"("..j..","..t..")")
                    end
                end
            end
        end
        if #cut_set == 1 then
            table.insert(brigde_set,cut_set)
        end
        table.insert(cut_set_total,cut_set)
    end
    return cut_set_total,brigde_set
end

function check_connect(matrix,i)
    -- 只用检查一个点是到其他点是否是可达的即可
    vis[i] = 1
    for j=1,N,1 do
        if vis[j] == 0 and matrix[i][j] ==1 then
            check_connect(matrix,j)
        end
    end
end


function check_create_tree(current,matrix,cnt)
    if cnt>N then
        return true
    end
    --for i=1,N,1 do
    --    if matrix[current][i] == 1 and edge_check[current][i] == 0 then
    --        return false
    --    end
    --end
    --return true
end
function create_tree(current,matrix,cnt)
    --if check_create_tree(current,matrix,cnt) then
    --    table.remove(cr_tree)
    --    return
    --end
    for i=1,N,1 do
        if matrix[current][i] == 1 and edge_check[i] == 0 then
            --print("i ",i)
            table.insert(cr_tree,"("..current..","..i..")")
            edge_check[i] = 1
            if cnt<N then
                create_tree(i,matrix,cnt+1)
            else
                return
            end
        end
    end
end



local A = init()
print("adjacency Matrix")
print(A)
local incidence_matrix = inc(A)
print("incidence matrix")
print(incidence_matrix)
plt.graph_plot(A)
local laplacian_matrix = lap(incidence_matrix)
print("laplacian matrix")
print(laplacian_matrix)

find_trail(A)
check_eular()
check_hamilton()
check_tree(A)

creat_con_set(A)

edge_check = torch.zeros(N)
cr_tree = {}
edge_check[1] = 1
create_tree(1,A,1)
print("--------------------")
print("Spanning Tree")
print(cr_tree)
