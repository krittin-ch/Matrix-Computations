# Matrix-Matrix Multiplication

#=
    A = [
        a_11 a_12
        a_21 a_22
    ]

    B = [
        b_11 b_12
        b_21 b_22
    ]

    General Matrix-Matrix Multiplication :

        A * B = [
            a_11 * b_11 + a_12 * b_21  ,  a_11 * b_21 + a_12 * b_22   
            a_21 * b_11 + a_22 * b_21  ,  a_21 * b_21 + a_22 * b_22   
        ]

    Saxpy Version : 
        
        A * B = [
            5 * [1; 3] + 7 * [2; 4]  ,  6 * [1; 3] + 8 * [2; 4]
        ]

    Outer Product Version :

        A * B = [1; 3] * [5 6] + [2; 4] * [7 8]
=#

using LinearAlgebra

A = Matrix([
    1 2;
    3 4
])

B = Matrix([
    5 6;
    7 8
])

function matrixMultiplication(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)

    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end

    C = zeros(m, n)

    for i in 1:m
        for j in 1:n
            for k in 1:r
                C[i, j] += A[i, k]*B[k, j]
            end
        end
    end

    return C
end

C1 = matrixMultiplication(A, B)

println("Matrix Multiplication Output : ")
display(C1)

# There are 6 possibilities of computing matrix multiplication
# ijk, jik, ikj, jki, kij, kji
function matrixMultiplicationV2(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)

    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end

    C = zeros(m, n)

    for j in 1:n
        for k in 1:r
            for i in 1:m
                C[i, j] += A[i, k]*B[k, j]
            end
        end
    end

    return C
end

C2 = matrixMultiplicationV2(A, B)

println("Matrix Multiplication Version II Output : ")
display(C2)

function dotProductMatrixMultiplication(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)
    
    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end
    
    C = zeros(m, n)
    
    for i in 1:m
        for j in 1:n
            C[i, j] += dot(A[i, :], B[:, j])
        end
    end
    
    return C
end

C3 = dotProductMatrixMultiplication(A, B)

println("Dot Product Matrix Multiplication Output : ")
display(C3)

function gaxpyMatrixMultiplication(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)
    
    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end
    
    C = zeros(m, n)
    
    for i in 1:m
        C[i, :] += transpose(transpose(A[i, :]) * B)
        # This should be `C[i, :] += A[i, :] * B` since `C[i, :]` and `A[i, :]` should be row vectors not column vectors
    end
    
    return C
end

C4 = gaxpyMatrixMultiplication(A, B)

println("Gaxpy Matrix Multiplication Output : ")
display(C4)

function saxpyMatrixMultiplication(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)
    
    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end
    
    C = zeros(m, n)
    
    for j in 1:n
        for k in 1:r
            C[:, j] += A[:, k] * B[k, j]     
        end
    end
    
    return C
end

C5 = saxpyMatrixMultiplication(A, B)

println("Saxpy Matrix Multiplication Output : ")
display(C5)

function saxpyWithGaxpyMatrixMultiplication(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)
    
    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end
    
    C = zeros(m, n)
    
    for j in 1:n
        C[:, j] += A * B[:, j]     
    end
    
    return C
end

C6 = saxpyWithGaxpyMatrixMultiplication(A, B)

println("Saxpy with Gaxpy Matrix Multiplication Output : ")
display(C6)

function outerProductMatrixMultiplication(A::Matrix, B::Matrix)
    m, r = size(A)
    r_b, n =size(B)
    
    if r != r_b
        println("Matrix Dimension Not Align")
        return 0
    end
    
    C = zeros(m, n)

    for k in 1:r
        C += A[:, k] * transpose(B[k, :])   
    end
    
    return C
end

C7 = saxpyWithGaxpyMatrixMultiplication(A, B)

println("Outer Product Matrix Multiplication Output : ")
display(C7)