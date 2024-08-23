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
