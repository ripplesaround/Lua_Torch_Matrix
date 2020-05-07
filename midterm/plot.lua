--require 'nngraph'
--
--h1 = nn.Linear(20, 10)()
--h2 = nn.Linear(10, 1)(nn.Tanh()(nn.Linear(10, 10)(nn.Tanh()(h1))))
--mlp = nn.gModule({h1}, {h2})
--
--x = torch.rand(20)
--dx = torch.rand(1)
--mlp:updateOutput(x)
--mlp:updateGradInput(x, dx)
--mlp:accGradParameters(x, dx)
--graph.dot(mlp.fg, 'MLP', 'myMLP')
--print('hello')
--

local Graph = require'graphviz'
graph = Graph()

graph.nodes.style:update{
    fontname = "Inconsolata Regular",
    --shape = "rectangle"
    shape = "circle"
}

--graph:node("a", "h")
--graph:node("b", "huga")
--
--graph:edge("b", "a")


--print(graph:source("graph"))


local G = torch.Tensor(3, 3)
G[1] = torch.Tensor{ 0,1,1 }
G[2] = torch.Tensor{ 1,1,0 }
G[3] = torch.Tensor{ 1,0,0 }

function graph_plot(matrix)
    -- 输入一个邻接矩阵 输出连接的图
    for i=1,matrix:size()[1],1 do
        graph:node("x"..i, "x"..i)
    end
    for i=1,matrix:size()[1],1 do
        for j=i,matrix:size()[1],1 do
            if matrix[i][j] == 1 then
                graph:edge("x"..i, "x"..j)
            end
        end
    end
    graph:render("test","graph","png")
end
function digraph_plot(matrix)

end
graph_plot(G)