#I
function simpsonrep(f::Function, a::Real, b::Real; m = 101)
    m % 2 == 0 && (m += 1)
    h = (b - a) / (m - 1)
    I = I1 = I2 = 0.0
    xi = a + h
    xj = a + 2h
    for i=2:2:m-1
        I1 += f(xi)
        xi += 2h
    end
    for j=3:2:m-2
        I2 += f(xj)
        xj += 2h
    end
    I = h/3 * (f(a) + 4 * I1 + 2 * I2 + f(b))
    return I
    return 0.0
end


function simpsoneps(f, a, b, ϵ; M = 1.0)
    h = (((180 * ϵ )/((b - a) * M))^(0.25))
    m = ceil(Int, (h / (b - a)) - 1)
    return simpsonrep(f, a, b, m)
end

# II
function simpson(f::Function, a::Real, b::Real)
    h = (b - a) / 2
    return h * (f(a) + 4 * f(a + h) + f(b)) / 3
end

function simpson_adaptivo(f::Function, a::Real, b::Real, ϵ::Real)
    I = simpson(f, a, b)
    return simpson_adaptivo_recursivo(f, a, b, ϵ, I)
end

function simpson_adaptivo_recursivo(f::Function, a::Real, b::Real, ϵ::Real, I::Real)
    c = (a + b) / 2
    esquerda = simpson(f, a, c)
    direita = simpson(f, c, b)
    if abs(I - esquerda - direita) <= (15 * ϵ) 
        return (esquerda + direita)
    end
    return (simpson_adaptivo_recursivo(f, a, b, ϵ/2, esquerda) + simpson_adaptivo_recursivo(f, a, b, ϵ/2, direita))
end
