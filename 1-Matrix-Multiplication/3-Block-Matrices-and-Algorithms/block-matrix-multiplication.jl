# Block Matrix Multiplication

#=
    If A, B, and C are N-by-N block matrices

    C(a, b) = C(a, b) + Sigma_{r=1 to N} A(a, r) * B(r, b)

    for a = 1:N and b = 1:N     
=#

function block_matrix_multiplication(A::Matrix, B::Matrix, l::Int)
    n = size(A, 1)
    N = convert(Int, n/l)

    C = zeros(n, n)

    for a in 1:N
        i = ((a - 1)*l + 1):(a*l)
        for b in 1:N
            j = ((b - 1)*l + 1):(b*l)
            for r in 1:N
                k = ((r - 1)*l + 1):(r*l)
                C[i, j] += A[i, k]*B[k, j]
            end
        end
    end

    return C
end

A = Matrix(reshape(-6:9, 4, 4))
B = Matrix(reshape(1:16, 4, 4))

C = block_matrix_multiplication(A, B, 2)

println("Block Matrix Multiplication Result : ")
display(C)