#  Block Matrix

#=
    A = [
        A_11 . . . A_1s     m_1 rows
         .          .
         .          .
         .          .
        A_q1 . . . A_qs     m_q rows
    ]
        n_1        n_q
        cols       cols

    A_ij = A(tau + 1:tau + m_i, mu + 1:mu + n_j)

    `tau` = m_1 + m_2 + ... + m_{i-1}
    `mu` = n_1 + n_2 + ... + n_{j-1}
=#

function get_block_matrix(A::Matrix, row::Int, col::Int, m::Int, n::Int)
    m -= 1
    n -= 1
    start_row = row * m + 1
    end_row = (start_row - 1) + row

    start_col = col * n + 1
    end_col = (start_col - 1) + col

    return A[start_row:end_row, start_col:end_col]

end

dim1 = 9
dim2 = 8

A = Matrix(reshape(1:dim1*dim2, dim1, dim2))

println("Original Matrix : ")
display(A)
row = 3
col = 2
m = 2
n = 3

block1 = get_block_matrix(A, row, col, m, n)

println("Block Matrix at m = $m and n = $n : ")
display(block1)

println("Other Block Matrices : ")
for i in 1:convert(Int, dim1/row)
    for j in 1:convert(Int, dim2/col)
        println("i = $i, j = $j")
        display(get_block_matrix(A, row, col, i, j))
    end
end

