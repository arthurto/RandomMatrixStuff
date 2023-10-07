# This program will use linear algebra to find the eigenvalues
# of a 6x6 complex matrix

using LinearAlgebra
using Plots 

function matrix(x,t1,t2)
    # this function simply returns the defined matrix
    # as a function of x,t1 and t2
    return [-im 0+0*im t1 0+0*im 0+0*im t2;
            0+0*im 0+0*im x x 0+0*im x;
            im 0+0*im 0 x 0+0*im im; 
            0+0*im 0+0*im 0+0*im -im -im im;
            -im x 0+0*im 0+0*im -im x;
            -im x 0+0*im 0+0*im 0+0*im -im]
end

function random_m(x)
    # this function generates two random phases 
    # for the imaginary numbers t1 and t2 so they
    # lie in the unitary circle 

    t1 = exp(im*rand()*2π)
    t2 = exp(im*rand()*2π)
    return matrix(x,t1,t2)
end

function dots(N,x)
    # This function returns a 2x6*N array 
    # with the real and imaginary part of the eigenvalues of 
    # the random matrix generated by random_m(x)

    a_real = zeros(6*N)
    a_im = zeros(6*N)
    for i in 0:(N-1)
        eig = eigvals(random_m(x))
        for j in 1:6
            a_real[i*6 + j] = real(eig[j])
            a_im[i*6 + j] = imag(eig[j])
        end
    end
    return a_real,a_im
end

# dots(1,0.0)

begin
    plot(showaxis = false,ticks=false,aspect_ratio = :equal,
    xaxis=(-1,0),yaxis=(-1,0))
    scatter!(dots(5_000,1.2),ms=0.1,label=nothing)
end

begin
    n = 120
    x = LinRange(0.0,2.0,n)

    anim = @animate for i ∈ 1:n
        plot(showaxis = false,ticks=false,aspect_ratio = :equal,
    xaxis=(-1,0),yaxis=(-1,0))
        scatter!(dots(10_000,x[i]),ms=0.1,label=nothing)
    end 

    gif(anim,"anim360.gif",fps=30)
end
