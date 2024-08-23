# Outer Product Update

#=
    A : Dimension (m, n)
    x : Size (m,)
    y : Size (n,)

    Outer Product Update : A = A + x * transpose(y)
=#

x = Vector([1; 2; 3])
y = Vector([4; 5])

# println("Outer Product Output")
# display(x * transpose(y))

A = rand(-2:0.3:2, size(x, 1), size(y, 1))

function outer_product_update(A::Matrix, x::Vector, y::Vector)
    m, n = size(A)

    res = deepcopy(A)

    for i in 1:m
        for j in 1:n
            res[i, j] += x[i] * y[j]
        end
    end

    return res
end

println("Original Matrix A : ")
display(A)

A1 = outer_product_update(A, x, y)

println("Outer Product Updated Matrix A : ")
display(A1)

function outer_product_update_with_row_oriented_saxpy(A::Matrix, x::Vector, y::Vector)
    m, n = size(A)

    res = deepcopy(A)

    for i in 1:m
        res[i, :] += x[i] * y   
        # should be `res[i, :] += x[i] * transpose(y)` since `y` is a column vector and res[i, :] is considered as a row vector
        # but julia makes res[i, :] as a column vector
    end

    return res
end

A2 = outer_product_update_with_row_oriented_saxpy(A, x, y)

println("Outer Product Updated Matrix A (Row-Oriented Saxpy) : ")
display(A2)

function outer_product_update_with_column_oriented_saxpy(A::Matrix, x::Vector, y::Vector)
    m, n = size(A)

    res = deepcopy(A)

    for j in 1:n
        res[:, j] += y[j] * x
    end

    return res
end

A3 = outer_product_update_with_column_oriented_saxpy(A, x, y)

println("Outer Product Updated Matrix A (column-Oriented Saxpy) : ")
display(A3)
