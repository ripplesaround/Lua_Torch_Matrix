
local _M = {}
local Graph = require'graphviz'
graph = Graph()

graph.nodes.style:update{
    fontname = "Inconsolata Regular",
    --shape = "rectangle"
    shape = "circle"
}



function _M.graph_plot(matrix)
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
function _M.digraph_plot(matrix)

end
return _M