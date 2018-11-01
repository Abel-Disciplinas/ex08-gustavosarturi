using Plots
gr(size=(600,400))
default(fmt = :png)

function main()
    # Ler dados.csv

    kfold(x, y)

    p = 1 ####### Sua escolha
    xlin = linspace(extrema(x)..., 100)
    β = regressao_polinomial(x, y, p)
    ylin = β[1] * ones(100)
    for j = 1:p
        ylin .+= β[j+1] * xlin.^j
    end
    scatter(x, y, ms=3, c=:blue)
    plot!(xlin, ylin, c=:red, lw=2)
    png("ajuste")

    # Calcule a medida R²
end

function regressao_polinomial(x, y, p)
    m = length(x)
    A = [ones(m) [x[i]^j for i = 1:m, j = 1:p]]
    β = (A' * A) \ (A' * y)
    return β
end

function kfold(x::Array, y::Array; num_folds = 5, max_p = 15)
    if length(x) != length(y)
        error("Dados são incompatíveis!")
    end

    m = length(x)
    I = randperm(m)
    fold_size = div(m, num_folds)
    E_Treino(num_folds, max_p)
    E_teste(num_folds, max_p)

    for fold=1:m
        cjto_teste = fold
        cjto_treino = setdiff(1:m, fold)
        Testex = X[cjto_teste]
        Testey = Y[cjto_teste]
        Treinox = Y[cjto_treino]
        Treinoy = Y[cjto_treino]
        for p = 1:max_p
            β = regressao_polinomial(Treinox, Treinoy, p)
            xlin = range(0, stop=2pi, length=100)

            y_pred = [β[1] + sum(β[j + 1] * xi^j for j = 1:p) for xi = xlin]

            E_teste = 1/2
            scatter(X, Y, leg=false)
            ylims!(4.9, 8.1)
        end
    end
    
    png("test_$p")
end

main()
