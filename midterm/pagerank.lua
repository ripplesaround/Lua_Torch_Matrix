---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ginne.
--- DateTime: 2020/5/2 10:38
---

N = 6
local d = 0.85

function init()
    -- create graph
    local P = torch.zeros(N,N)
    for i = 1,N,1 do
        for j = 1,N,1 do
            if math.random() >=0.5 then
                P[i][j] = 1
            end
        end
    end
    return P
end
function tran_matrix(G)
    local y = torch.cumsum(G)
    for i = 1,N,1 do
        for j = 1,N,1 do
            if G[i][j]==1 then
                G[i][j] = 1/y[N][j]
            end
        end
    end
    return G
end
function cal_pagerank_al(G,d)
    I = torch.eye(N)
    R = torch.inverse(I-d*G) * (1-d) / N * torch.ones(N)
    return R
end
function cal_pagerank(G,d)
    G = torch.mul(G,d)
    local R_t = torch.mul(torch.ones(N),1/N)
    local smooth = (1-d) / N * torch.ones(N)
    local  err = 1e-5
    local R_p = G * R_t + smooth
    while(torch.sum(torch.abs(R_p-R_t))>err)
    do
        R_t = R_p
        R_p = G * R_t + smooth
    end
    return R_t
end

local G = init(N)
print(G)
G = tran_matrix(G)
print(G)
--local G = torch.Tensor(3, 3)
--G[1] = torch.Tensor{ 0,0,1 }
--G[2] = torch.Tensor{ 0.5,0,0 }
--G[3] = torch.Tensor{ 0.5,1,0 }
local R = cal_pagerank(G,1)
print(R)
R = cal_pagerank(G,d)
--local R1 = cal_pagerank_al(G,d)
print(R)
print("---------------------")
local d_set = torch.Tensor{ 0,0.25,0.5,0.75,1 }
for i=1,d_set:size()[1],1 do
    local R = cal_pagerank(G,d_set[i])
    print(R)
end


