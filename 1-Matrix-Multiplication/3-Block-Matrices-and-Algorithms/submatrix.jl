# Submatrix

#=
    A = [
        a_11 . . . a_1n     
         .          .
         .          .
         .          .
        a_1m . . . a_mn     
    ]

    alpha = [alpha_1, alpha_2, ..., alpha_s]    for 1 <= alpha_i <= m
    beta = [beta_1, beta_2, ..., beta_t]        for 1 <= beta_i <= n

    If A = [
        a_11 a_12 a_13
        a_21 a_22 a_23
        a_31 a_32 a_33
        a_41 a_42 a_42
    ]

    alpha = [2 4] and beta = [1 3]

    A(alpha, beta) = [
        a_21 a_23
        a_41 a_43
    ]
=#

using LinearAlgebra

function create_selection_matrix(vec::Vector, dim::Int)
    res = zeros(dim, dim)
    
    for i in vec
        res[i, i] = 1    
    end

    return res
end

function create_submatrix(A::Matrix, alpha::Vector, beta::Vector)
    m, n = size(A)

    # mat_alpha = create_selection_matrix(alpha, m)
    # mat_beta = create_selection_matrix(beta, n)

    # display(mat_alpha * A * mat_beta)

    return A[alpha, beta]
end

A = Matrix(reshape(1:48, 6, 8)')

println("Original Matrix : ")
display(A)

alpha = Vector([2; 4; 6; 8])
beta = Vector([4; 5; 6])

new_A = create_submatrix(A, alpha, beta)

display(new_A)