# I
function simpsonrep(f, a, b; m = 101)
    m % 2 == 0 && (m += 1)
    h = (b - a) / (m - 1)
    # Seu código de Simpson repetido
    return 0.0
end

function simpsoneps(f, a, b, ϵ; M = 1.0)
    # Calcule h, m e use a função simpsonrep
end

# II
function simpson(f, a, b)
    # Simpson sem repetição
end

function simpson_adaptivo(f, a, b, ϵ)
    I = simpson(f, a, b)
    return simpson_adaptivo_recursivo(f, a, b, ϵ, I)
end

function simpson_adaptivo_recursivo(f, a, b, ϵ, I)
    # Implementação de Simpson adaptativo
end
