using Plots
gr(size=(600, 400))
default(fmt = :png)

data = readcsv("dados.csv")
x, y = data[:,1], data[:,2]

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

function regressao_polinomial(x, y, p)
    m = length(x)
    A = [ones(m) [x[i]^j for i = 1:m, j = 1:p]]
    β = (A' * A) \ (A' * y)
    return β
end


#Vamos supor que nossos dados sejam esses:
x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
y = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

function kfold(x, y; num_folds = 5, max_p=15)
    num_folds = 2
    max_p = 15
    m = length(x)
    I = randperm(m)
    fold_size = div(m, num_folds)
    traine_size = m - fold_size

    E_teste = zeros(num_folds, max_p)
    E_treino = zeros(num_folds, max_p)

    i_fold = 1

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
        println("E_teste = ", E_teste)
        println("E_treino = ", E_treino)
        png("kfold-$fold")
        i_fold += 1
    end
end
println()

kfold(x,y)

E_teste

#=for fold=1:fold_size:m
    cjto_teste = fold
    cjto_treino = setdiff(1:m, fold)
    for k=fold:fold + fold_size - 1 #Separa os valores de treino
        E_teste = [x[k], y[k]]
    end
end=#
