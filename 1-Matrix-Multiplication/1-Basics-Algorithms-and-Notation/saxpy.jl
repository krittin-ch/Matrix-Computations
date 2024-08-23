# Saxpy
# If `x` and `y` are vector with the same size and `a` is a real number, then saxpy operation overwrites `y` with `y + a * x`

x = Vector(0:6)
y = Vector(-2:0.5:1)
a = 2

function saxpy(y::Vector, x::Vector, a)
    res = deepcopy(y)

    x_size = size(x, 1)
    y_size = size(y, 1)

    if x_size != y_size 
        println("Dimension Not Align")
        return -1
    end

    for i in 1:x_size
        res[i] += a*x[i]
    end

    return res
end

new_y = saxpy(y, x, a)  # same as y .+ a.*x

println("Vector x :")
display(x)

println("Vector y :")
display(y)


println("Saxpy Output : ")
display(new_y)
# display(y .+ a.*x)