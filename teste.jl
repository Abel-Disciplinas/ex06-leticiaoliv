using Plots, Base.Test
gr(size=(600,400))

include("integral.jl")

function teste()
    # Simpson com ϵ
    k = 1
    for (f, a, b, Iexato, M) in [(x -> exp(4x), 0, 2, (exp(8) - 1)/4, 4^4 * exp(8)),
                                 (x -> 2*sin(2x), 0, π/2, 2, 32*sin(π)),
                                 (x -> exp(3x) + 27x, 0, 1, (2*exp(6) - 2*exp(3) + 243)/6, 81 * exp(3))]
        @testset "Função $k" begin
            @test abs(Iexato - simpsoneps(f, a, b, 1e-8, M=M)) < 1e-8
            @test abs(Iexato - simpson_adaptivo(f, a, b, 1e-8)) < 1e-8
        end

        ϵ_array, ES_array, EA_array = [], [], []
        ϵ = 1.0
        while ϵ > 1e-12 * max(M, 1.0)
            I = simpsoneps(f, a, b, ϵ, M = M)
            E = max(abs(Iexato - I), 1e-20)
            push!(ϵ_array, ϵ)
            push!(ES_array, E)

            I = simpson_adaptivo(f, a, b, ϵ)
            E = max(abs(Iexato - I), 1e-20)
            push!(EA_array, E)
            ϵ /= 2
        end
        scatter(ϵ_array, ES_array, ms=3, c=:blue, lab="SR")
        scatter!(ϵ_array, EA_array, ms=3, c=:red, lab="SA")
        plot!(ϵ_array, ϵ_array, ms=3, c=:green, lab="", xaxis=:log, yaxis=:log,
              leg=:topleft)

        title!("Simpson repetido e adaptivo")
        png("compara$k")
        k += 1
    end
end

teste()
