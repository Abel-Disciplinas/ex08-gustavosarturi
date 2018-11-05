function regressao_polinomial(x::Array, y::Array, p::Integer)
    m = length(x)
    A = ones(m, p+1)
    for i=1:m
        for j=2:p+1
            A[i,j] = x[i]^(j-1)
        end
    end
    β = (A' * A) \ (A' * y)
    return β
end

function main()

    data = readcsv("dados.csv")
    x, y = data[:,1], data[:,2]

    kfold(x, y)
    p = 8 ####### Sua escolha
    xlin = linspace(extrema(x)..., 100)
    β = regressao_polinomial(x, y, p)
    ylin = β[1] * ones(100)
    for j = 1:p
        ylin .+= β[j+1] * xlin.^j
    end
    scatter(x, y, ms=3, c=:blue)
    plot!(xlin, ylin, c=:red, lw=2)
    png("ajuste")

    m = length(x)
    y_pred = zeros(1,m)
    for i=1:m
        y_pred[1,i] = β[1]
        for j=2:p+1
            y_pred[1,i] = y_pred[1,i] + β[j] * x[i]^(j-1)
        end
    end
    S1 = S2 = 0
    y_med = mean(y)
    for i=1:m
        S1 += (y_pred[1,i] - y_med)^2
        S2 += (y[i] - y_pred[1,i])^2
    end

    R = 1 - S2/S1
    println("R² = ", R)
end

function kfold(x, y; num_folds = 5, max_p=15)
    num_folds = 5
    max_p = 15
    m = length(x)
    I = randperm(m)
    fold_size = div(m, num_folds)
    traine_size = m - fold_size

    E_teste = zeros(num_folds, max_p)
    E_treino = zeros(num_folds, max_p)

    i_fold = 1

    plot()
    for fold=1:fold_size:m
        #println("i_fold é = ", i_fold)
        cjto_teste = fold:fold + fold_size - 1
        cjto_treino = setdiff(1:m, cjto_teste)

        Testex = x[cjto_teste]
        Testey = y[cjto_teste]
        Treinox = x[cjto_treino]
        Treinoy = y[cjto_treino]

        for p = 1:max_p
            β = regressao_polinomial(Treinox, Treinoy, p)
            y_pred = [β[1] + sum(β[j+1] * xi^j for j = 1:p) for xi = x]
            E_teste[i_fold,p] = norm(y[cjto_teste] - y_pred[cjto_teste])^2
            E_treino[i_fold,p] = norm(y[cjto_treino] - y_pred[cjto_treino])^2
        end

        plot!(1:max_p, E_treino[i_fold,:], ms=3  )
        png("test_$i_fold")
        i_fold += 1
    end
end

println()
main()

