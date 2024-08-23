# Row-Oriented Gaxpy
# If `A` is a matrix of dimension (m, n), vector `x` with size `n`, vector `y` with size `m`,
# then this algorithm overwrites `y` with `A * x + y`

m = 3
n = 5
A = rand(0:0.4:10, m, n)

x = rand(-2:0.1:2, n)
y = rand(-2:0.1:2, m)

function columnOrientedGaxpy(A::Matrix, x::Vector, y::Vector)
    m, n = size(A)

    res = deepcopy(y)

    for j in 1:n
        for i in 1:m
            res[i] += A[i, j] * x[j]
        end
    end

    return res
end

y1 = columnOrientedGaxpy(A, x, y)  # same as y .+ A * x

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

function columnPartitionedColumnOrientedGaxpy(A::Matrix, x::Vector, y::Vector)
    n = size(A, 2)

    res = deepcopy(y)

    for j in 1:n
        res .+= x[j] * A[:, j]
    end
    
    return res
end

y2 = columnPartitionedColumnOrientedGaxpy(A, x, y)

println("Gaxpy Output : ")
display(y2)
println()