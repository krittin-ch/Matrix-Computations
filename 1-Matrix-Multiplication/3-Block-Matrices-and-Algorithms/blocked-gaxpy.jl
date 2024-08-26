# Blocked Gaxpy

#=
    To operate gaxpy operation with block matrix (vector)

    Row-Blocked Gaxpy :
        
        A = [A_1; A_2; . . .; A_n]

        y = [y_1; y_2; . . .; y_n]

        Gaxpy Operation : y = y + A * x

        `y[idx] = y[idx] + A[idx] * x`

    Column-Blocked Gaxpy :

        A = [A_1 A_2 . . . A_r]
        
        x = [x_1; x_2; . . .; x_r]

        Gaxpy Operation : y = y + A * x

        `y = y + A[jdx] * x[jdx]`
=#


A = Matrix(reshape(1:36, 6, 6))

block_rows = 3

x = Vector(1:6)
y = Vector(-6:2:4)

function row_blocked_gaxpy(A::Matrix, block_rows::Int, x::Vector, y::Vector)
    n = size(A, 1)
    
    q = convert(Int, n/block_rows)
    res = deepcopy(y)
    
    alpha = 0
    for i in 1:q
        idx = (alpha + 1):(alpha + block_rows)
        res[idx] += A[idx, :] * x
        alpha += block_rows
    end
    
    return res
end

y1 = row_blocked_gaxpy(A, block_rows, x, y)

println("The Row-Blocked Gaxpy Result : ")
display(y1)

block_cols = 2

function col_blocked_gaxpy(A::Matrix, block_cols::Int, x::Vector, y::Vector)
    n = size(A, 1)
    
    q = convert(Int, n/block_cols)
    res = deepcopy(y)
    
    beta = 0
    for i in 1:q
        jdx = (beta + 1):(beta+ block_cols)
        res += A[:, idx] * x[jdx]
        beta += block_cols
    end
    
    return res
end

y2 = row_blocked_gaxpy(A, block_cols, x, y)

println("The Column-Blocked Gaxpy Result : ")
display(y2)