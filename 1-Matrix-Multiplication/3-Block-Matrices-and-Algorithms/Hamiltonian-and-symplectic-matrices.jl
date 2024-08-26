# Hamiltonian and Symplectic Matrices

#=
    Hamiltonian Matrix is a 2-by-2 block matrices

        `M` is a Hamiltonian matrix with dimension 2n x 2n

            M = [
                A   G
                F   -A^T
            ]

            `A`, `F`, `G` dimension is n x n and `F` and `G` are symmetric

        Hamiltonian matrices arise in optimal control and other application areas

        With the permutation matrix `J`

            J = [
                  0    I_n
                -I_n    0
            ]

        In particular, 
            if `J*M*J^T = -M^T` , then `M` is Hamiltonian

            if `S^T*J*S = J` , then `S` is symplectic
            and `S_11^T * S_21` and `S_22^T * S_12`, also `S_11^T * S_22 = I_n + S_21^T * S_12`
=#

using LinearAlgebra

A = Matrix{Float64}([
    2.1 9.3 1.4;
    5.1 2.2 8.3;
    5.3 2.7 2.6;
])

F = Matrix{Float64}([
    1 2 3;
    2 4 5;
    3 5 6;
])

G = Matrix{Float64}([
    1.1 2.5 3.2;
    2.5 7.3 8.2;
    3.2 8.2 2.7
])

M = [
    A G;
    F -transpose(A)
]

# println("Hamiltonian Matrix : ")
# display(M)

I_n = Matrix(I, 3, 3)
Z_n = zeros(3,3)

J = [
    Z_n I_n
    -I_n Z_n    
]

println("Matrix J : ")
display(J)

# println("J*M*J^T = -M^T")   # J*M*J^T + M^T = 0
# display(J*M*transpose(J) + transpose(M))


# There are various symplectic matrix, but the author was unable to find one
S_11 = Matrix{Float64}([
    1 0 0;
    0 1 0;
    0 0 1;
])

S_12 = Matrix{Float64}([
    0 0 0;
    0 0 0;
    0 0 0;
])

S_21 = S_12
    
S_22 = S_11

# S_11^T * S_22 = I_n + S_21^T * S_12

println("S_11^T * S_22 = I_n + S_21^T * S_12 : ")   # S_11^T * S_22 - S_21^T * S_12 = I_n
display(transpose(S_11)*S_22 - transpose(S_21)*S_12)

S = [
    S_11 S_12;
    S_21 S_22
]


println("Symplectic Matrix : ")
display(S)

println("S^T*J*S = J : ")   # S^T*J*S - J = 0
display(transpose(S)*J*S - J)