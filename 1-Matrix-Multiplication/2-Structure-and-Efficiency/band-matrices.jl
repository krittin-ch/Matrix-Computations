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

A = Matrix{Float64}([
    1 2 3 0 0;
    4 5 6 7 0;
    0 8 9 10 11;
    0 0 12 13 14;
    0 0 0 15 16;
    0 0 0 0 17;
    0 0 0 0 0;
    0 0 0 0 0;
])

lower_band, upper_band = band_matrix_widths(A)

println("Lower Bandwidth = $lower_band")
println("Upper Bandwidth = $upper_band")


A = Matrix{Float64}([
    1 2 3 0 0 0;
    4 5 6 7 0 0;
    0 8 9 10 11 0;
    0 0 12 13 14 15;
    0 0 0 16 17 18;
    0 0 0 0 19 20;
])

bandwidth_2 = band_matrix_widths(A)

println("Lower Bandwidth = ", bandwidth_2[1])
println("Upper Bandwidth = ", bandwidth_2[2])

function transform_band_matrix(A::Matrix{Float64})
    m, n = size(A)
    B = zeros(Float64, 4, 6)

    # Filling the new matrix B with specific bands from A
    for i in 1:m
        for j in 1:n
            if 0 <= i - j + 1 <= 3  # Adjust according to the band placement
                B[4 - (i - j + 1), j] = A[i, j]
            end
        end
    end

    return B
end

B = transform_band_matrix(A)
println("Transformed Matrix B: ")
display(B)
