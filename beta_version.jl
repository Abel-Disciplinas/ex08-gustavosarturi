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

function KFold(x,y; num_folds = 5, max_p = 15)
    if length(x) != length(y) ##Check-out
        error("Os dados estão incompatíveis!")
    end
    
    m = length(x) ##[✓]
    I = randperm(m) ##[✓]Randomiza os índices;
    sort_data = zeros(m,2) ##Cria uma matriz auxiliar p/ embaralhar
    for i=1:m ##[✓]Embaralha a ordem dos dados
        sort_data[i,1] = x[I[i]]
        sort_data[i,2] = y[I[i]]
    end
    fold_size = div(m, num_folds) ##[✓] Tamanho do Fold
    traine_size = m - fold_size ##Tamanho do Fold Complementar
    E_treino = zeros(traine_size) ##[✓] E_treino zerada
    E_teste = zeros(fold_size) ##[✓] E_teste zerada

    for j=1:fold_size
        E_treino = 
    end    

    return ∂
end
