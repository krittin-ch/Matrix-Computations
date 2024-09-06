C = Vector{ComplexF64}([1e10; 10; 35; 50; 100; 150; 200; 250; 1e20])*1e-6

zc = (1im*100*pi.*C).^-1

L = 50e-3 + 0im

zl = 1im*100*pi*L

r = 10 + 0im

z = ((r + zl)^-1 .+ zc.^-1).^-1

display(z)

v = 12/sqrt(2) + 0im

i = v ./ z

display(abs.(i))
display(real.(i) * v)