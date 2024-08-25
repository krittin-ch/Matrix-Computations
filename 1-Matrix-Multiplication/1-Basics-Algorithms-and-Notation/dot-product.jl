# Dot Product

# If `x` and `y` are vector with the same size, then their dot product is `c = transpose(x) * y`

x = Vector(0:6)
y = Vector(-2:0.5:1)


function dot_product(x::Vector, y::Vector)
    c = 0
    x_size = size(x, 1)
    y_size = size(y, 1)

    if x_size != y_size 
        println("Dimension Not Align")
        return -1
    end

    for i in 1:x_size
        c += x[i] * y[i]
    end

    return c
end

c = dot_product(x, y)

println("Dot Product Value = $c")