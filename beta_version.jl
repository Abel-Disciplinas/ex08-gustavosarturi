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

    for fold=1:fold_size
        cjto_teste = fold
        cjto_treino = setdiff(1:m, fold)
        
    end
end 

fold_size = 5

X = [1,2,3,4,5,6,7,8,9,10]
Y = [11,12,13,14,15,16,17,18,19,20]
m = length(X)
for fold=1:m
    cjto_teste = fold
    cjto_treino = setdiff(1:m, fold)
    Teste = X[cjto_teste]
    Treino = Y[cjto_treino]
    for p = 1:max_p
        
    end
    println(cjto_teste, cjto_treino, Treino, Teste)
end

Treino
println()

I = randperm(5)

