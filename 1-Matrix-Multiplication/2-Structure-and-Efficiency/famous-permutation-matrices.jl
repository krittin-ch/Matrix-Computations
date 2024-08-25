# Famous Permutation

#=
    Exchange Permutation :

        x = [x_1; x_2; x_3; x_4]
        
        epsilon_4 = [
            0 0 0 1
            0 0 1 0
            0 1 0 0
            1 0 0 0
            ]
            
        Then epsilon_4 * x = [x_4; x_3; x_2; x_1]
            
    Dowwnshift Permutation :
            
        x = [x_1; x_2; x_3; x_4]
        
        D_4 = [
            0 0 0 1
            1 0 0 0
            0 1 0 0
            0 0 1 0
        ]

        Then D_4 * x = [x_4; x_1; x_2; x_3]

    Upshift Permutation :

        x = [x_1; x_2; x_3; x_4]
        
        U_4 = [
            0 1 0 0
            0 0 1 0
            0 0 0 1
            1 0 0 0
        ] = transpose(D_4)

        Then U_4 * x = [x_2; x_3; x_4; x_1]

    Mod-p Perfect Shuffle Permutation :

        x = [x_1; x_2; . . .; x_n] Then n = p * r

        If p = 3 and r = 4 then P_{3,4} = I_{pr}([1 5 9 2 6 10 3 7 11 4 8 12])
        
        Hence, P_{p,r} = I_n([ (1:r:n) (2:r:n) . . . (r:r:n) ])
=#

using LinearAlgebra
function create_permutation(vec::Vector)
    n = size(vec, 1)

    return Matrix{Float64}(I, n, n)[vec, :]
end

exchange_permutation = Vector([4; 3; 2; 1])

y1 = create_permutation(exchange_permutation)

println("Exchange Permutation Matrix : ")
display(y1)

downshift_permutation = Vector([4; 1; 2; 3])

y2 = create_permutation(downshift_permutation)

println("Downshift Permutation Matrix : ")
display(y2)

y3 = y2'

println("Upshift Permutation Matrix : ")
display(y3)

function mod_p_perfect_shuffle_permutation(p::Int, r::Int)
    vec = [i:r:p*r for i in 1:r]

    return vcat(vec...)
end

P_p_r = mod_p_perfect_shuffle_permutation(3, 4)

x = collect(-6:5)

y4 = create_permutation(P_p_r)

println("Mod-p Perfect Shuffle Permutation P_p,r : ")
display(y4)
