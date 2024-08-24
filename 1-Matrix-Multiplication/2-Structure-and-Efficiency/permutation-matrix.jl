#=
    Identity Matrix :

        I_4 = [
            1 0 0 0
            0 1 0 0
            0 0 1 0
            0 0 0 1
        ]

    Permutation Matrix (underlying vector `v = [2 4 3 1]`) :

        P = [
            0 1 0 0
            0 0 0 1
            0 0 1 0
            1 0 0 0
        ]

    Also, `P * P^T = I`
=#

using LinearAlgebra

function create_permutation_matrix(v::Vector)
    n = size(v, 1)
    I_n = Matrix{Float64}(I, n, n)

    return I_n[v, :]
end

v = Vector([2; 4; 3; 1])
P = create_permutation_matrix(v)

println("Permutation Matrix : ")
display(P)

#=
    If y = Px then y = x(v) --> This means that `x` is permuted according to `v`
    
    If y = P^T x then y(v) = x --> This means that `y` is permuted according to `v`
=#

x = Vector([1; 2; 3; 4])

y = P*x

println("x : ")
display(x)

println("y = Px : ")
display(y)

println("y = P^T x --> x = Py : ")
display(transpose(P) * y)