# Row-Oriented Gaxpy
# If `A` is a matrix of dimension (m, n), vector `x` with size `n`, vector `y` with size `m`,
# then this algorithm overwrites `y` with `A * x + y`

m = 3
n = 5
A = rand(0:0.4:10, m, n)

x = rand(-2:0.1:2, n)
y = rand(-2:0.1:2, m)

function row_oriented_gaxpy(A::Matrix, x::Vector, y::Vector)
    m, n = size(A)

    res = deepcopy(y)

    for i in 1:m
        for j in 1:n
            res[i] += A[i, j] * x[j]
        end
    end

    return res
end

y1 = row_oriented_gaxpy(A, x, y)  # same as y .+ A * x

println("Matrix A : ")
display(A)

println("Vector x : ")
display(x)

println("Previous Vector y : ")
display(y)

println("Gaxpy Output : ")
display(y1)
# display(y .+ A * x)
println()

function row_partitioned_row_oriented_gaxpy(A::Matrix, x::Vector, y::Vector)
    m = size(A, 1)

    res = deepcopy(y)

    for i in 1:m
        res[i] += transpose(A[i, :]) * x    
    end
    
    return res
end

y2 = row_partitioned_row_oriented_gaxpy(A, x, y)

println("Gaxpy Output : ")
display(y2)
println()