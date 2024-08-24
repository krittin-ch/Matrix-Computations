#=
    If A is construct with real number.
    A is symmetric if A^T = A and skew-symmetric if A^T = -A

    If A is constructed with complex number.
    A is Hermitian if A^H = A and skew-Hermitian if A^H = -A

    Symmetric Matrices can be stored in a vector with a half size of the matrix

    A = [
        1 2 3
        2 4 5
        3 5 6
    ]

    A.vec = [1 2 3 4 5 6]

    A.vec[(n - j/2)(j - 1) + i] = A[i, j]
=#

function symmetric_storage(A::Matrix)
    n = size(A, 1)
    vec_size = floor(Int, (n - n/2)*(n - 1) + n)
    vec = zeros(vec_size)

    for j in 1:n
        for i in j:n
            vec[floor(Int, (n - j/2)*(j - 1) + i)] = A[i, j]
        end
    end

    return vec
end

A = Matrix{Float64}([
    1 2 3;
    2 4 5;
    3 5 6;
])

A_vec = symmetric_storage(A)

println("Original Matrix : ")
display(A)

println("Symmetric Storage : ")
display(A_vec)

function symmetric_storage_gaxpy(x::Vector, y::Vector, A::Matrix)
    n = size(A, 1)
    A_vec = symmetric_storage(A)

    res = deepcopy(y)

    for j in 1:n
        for i in 1:j-1
            res[i] += A_vec[floor(Int, (i - 1)*n - i*(i - 1)/2 + j)] * x[j]
        end
        
        for i in j:n
            res[i] += A_vec[floor(Int, (j - 1)*n - j*(j - 1)/2 + i)] * x[j]
        end
    end

    return res
end

x = Vector{Float64}([1; 2; 3])
y = Vector{Float64}([-1; 0; 1])

y1 = symmetric_storage_gaxpy(x, y, A)

println("Symmetric Storage Gaxpy : ")
display(y1)
