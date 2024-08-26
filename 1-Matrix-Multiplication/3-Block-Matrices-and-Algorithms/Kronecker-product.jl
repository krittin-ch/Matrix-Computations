# The Kronecker Product

#=
    B = [
        b_11 b_12
        b_21 b_22
        b_31 b_32
    ]

    C = [
        c_11 c_12 c_13
        c_21 c_22 c_23
        c_31 c_32 c_33
    ]

    A = B ⊗ C = [
        b_11*C b_12*C
        b_21*C b_22*C
        b_31*C b_32*C
    ]

    `B` Dimension : m1 x n1
    `C` Dimension : m2 x n2

    Then `A` Dimension : (m1*m2) x (n1*n2)
=#

function Kronecker_product(B::Matrix, C::Matrix) 
    m1, n1 = size(B)
    m2, n2 = size(C)

    A = zeros(m1*m2, n1*n2)

    for i in 1:m1
        for j in 1:n1
            idx = (i-1)*m2 + 1:i*m2 
            jdx = (j-1)*n2 + 1:j*n2
            A[idx, jdx] = B[i, j] * C
        end
    end

    return A
end

B = Matrix(reshape(1:6, 2, 3)')
C = Matrix(reshape(-4:4, 3, 3)')

m1, n1 = size(B)
m2, n2 = size(C)

# println("Matrix B : ")
# display(B)

# println("Matrix C : ")
# display(C)

A = Kronecker_product(B, C)
# println("Kronecker Product Result : ")
# display(A)

x = Vector([])

for i in 1:n1       # The number of x: x_1, x_2, . . ., x_n1 
    for j in 1:n2   # The number of dimension of each x
        push!(x, i*j)
    end
end

y1 = A*x

println("y = (B ⊗ C)*x : ")     
# `x` is a column vector
#=
    x = [
        x_1
        x_2
         .
         .
         .
        x_n1
    ]

    And x_1, x_2, . . ., x_n1 are column vectors

    This result in the output y to be constructed in the column of column vectors

    y = [
        y_1
        y_2
         .
         .
         .
        y_m2
    ]
=#
display(y1)

x2 = Matrix{Float64}(reshape(x, n2, n1))
# `x` is structed in row
#=
    x = [x_1 x_2 . . . x_n1]

    while x_1, x_2, . . ., x_n1 are column vectors

    This result in the output y to be constructed in the row of column vectors

    y = [y_1 y_2 . . . y_m2]
=#
y2 = C * x2 * transpose(B)
println("y = C*x*B^T : ")
display(y2)
println("Rehshape y : ")
display(reshape(y2, size(y1, 1)))