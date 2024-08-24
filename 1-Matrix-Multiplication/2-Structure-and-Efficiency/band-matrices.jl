# Band Matrices

#=
    A = [
        x x x 0 0
        x x x x 0
        0 x x x x
        0 0 x x x
        0 0 0 x x
        0 0 0 0 x
        0 0 0 0 0
        0 0 0 0 0
    ]

    lower bandwidth = p if a_ij = 0 whenever i > j + p
    upper bandwidth = q if a_ij = 0 whenever j > i + q
=#

function band_matrix_widths(A::AbstractMatrix)
    n, m = size(A)
    lower_band = 0
    upper_band = 0
    
    for i in 1:n
        for j in 1:m
            if A[i, j] != 0
                lower_band = max(lower_band, i - j)
                upper_band = max(upper_band, j - i)
            end
        end
    end
    
    return lower_band, upper_band
end

A1 = Matrix{Float64}([
    1 2 3 0 0;
    4 5 6 7 0;
    0 8 9 10 11;
    0 0 12 13 14;
    0 0 0 15 16;
    0 0 0 0 17;
    0 0 0 0 0;
    0 0 0 0 0;
])

lower_band, upper_band = band_matrix_widths(A1)

# println("Lower Bandwidth = $lower_band")
# println("Upper Bandwidth = $upper_band")


A2 = Matrix{Float64}([
    1 2 3 0 0 0;
    4 5 6 7 0 0;
    0 8 9 10 11 0;
    0 0 12 13 14 15;
    0 0 0 16 17 18;
    0 0 0 0 19 20;
])

bandwidth_2 = band_matrix_widths(A2)

println("Lower Bandwidth = ", bandwidth_2[1])
println("Upper Bandwidth = ", bandwidth_2[2])

#=
    For lower bandwidth `p` and upper bandwidth `q`

    A matrix A can be transform to a matrix A.band with dimension(p + q + 1)-by-n matrix
    with the convention that A[i, j] = A.band[i, -j + q + 1, j] 
=#
function transform_band_matrix(A::Matrix{Float64})
    m, n = size(A)
    p, q = band_matrix_widths(A)

    A_band = zeros(p + q + 1, n)

    for i in 1:m
        for j in 1:n
            if (p + q + 1 >= i - j + q + 1) && (i - j + q + 1 >= 1)
                A_band[i - j + q + 1, j] = A[i, j]
            end
        end
    end

    return A_band
end

B2 = transform_band_matrix(A2)
println("Transformed Matrix : ")
display(B2)

# Since A i stored column by column in A_band, obtaining column-oriented saxpy and enabling for column-oriented gaxpy calculation
function band_storage_gaxpy(x::Vector{Float64}, y::Vector{Float64}, A::Matrix{Float64}, A_band::Matrix{Float64})
    m, n = size(A)
    p, q = band_matrix_widths(A)

    res = deepcopy(y)

    for j in 1:n
        alpha_1 = max(1, j - q)
        alpha_2 = min(n, j + p)
        beta_1 = max(1, q + 2 - j)
        beta_2 = beta_1 + alpha_2 - alpha_1

        res[alpha_1:alpha_2] += A_band[beta_1:beta_2, j] * x[j]
    end

    return res
end

function column_oriented_gaxpy(x::Vector{Float64}, y::Vector{Float64}, A::Matrix{Float64})
    n  = size(A, 1)

    res = deepcopy(y)

    for j in 1:n
        res += A[:, j] * x[j]
    end

    return res
end 

x = Vector{Float64}([1; 2; 3; 4; 5; 6])
y = Vector{Float64}([-2; -1; 0; 1;  2; 3])

out1 = column_oriented_gaxpy(x, y, A2)
println("General Column Oriented Gaxpy : ")
display(out1)

out2 = band_storage_gaxpy(x, y, A2, B2)
println("Band Storage Gaxpy : ")
display(out2)