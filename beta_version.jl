function regressao_polinomial(x, y, p)
    m = length(x)
    A = ones(m, p + 1)
    for i=1:m
        for j=2:p+1
            A[i,j] = x[i]^(j-1)
        end
    end

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
        Treinox = X[cjto_treino]
        Treinoy = Y[cjto_treino]
        for p = 1:max_p
            β = regressao_polinomial(Treinox, Treinoy, p)
            xlin = range(0, stop=2pi, length=100)
            
            y_pred = [β[1] + sum(β[j + 1] * xi^j for j = 1:p) for xi = xlin]
    
            E_teste = 1/2
            scatter(X, Y, leg=false)
            ylims!(4.9, 8.1)
            png("test_$p")
        end
    end
end
