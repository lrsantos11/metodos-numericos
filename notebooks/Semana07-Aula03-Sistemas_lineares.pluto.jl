### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ ab7d391c-4a01-478b-bb9c-20110c3a3acc
using LinearAlgebra

# ╔═╡ 4833dd6e-5826-11ec-172b-537492fc4e68
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 07 - Aula 03
"""

# ╔═╡ e3b065ef-a425-459d-bb4d-d25b7483a049
# Funcao para resolver sistema triangular superior por retro-substituicao
function retro_subs(U,b)
	~istriu(U) && error("U não é triangular superior")
	num_rows, num_cols = size(U)
	xsol = zeros(num_cols)
	xsol[end] = b[end]/U[end,end]
	for i ∈ num_cols-1:-1:1
		xsol[i] = (b[i] - dot(U[i,i+1:end], xsol[i+1:end])) / U[i,i]
	end
	return xsol
end

# ╔═╡ 6bed0f40-75e6-4e77-9c42-8e02b51ba91f
# Funcao para resolver sistema triangular inferior por substituicao avançada
function subs(L,b)
	~istril(L) && error("L não é triangular inferior")
	num_rows, num_cols = size(L)
	xsol = zeros(num_cols)
	xsol[1] = b[1]/L[1,1]
	for i ∈ 2:num_cols
		xsol[i] = (b[i] - dot(L[i,1:i-1], xsol[1:i-1])) / L[i,i]
	end
	return xsol
end

# ╔═╡ 9f1d96d0-2d21-43ae-9b8f-f1f6a094e86f
# Fatoracao LU de uma matriz A sem pivoteamento
function preLU(A)
	m, n  = size(A)
	U = copy(A)
	L = diagm(ones(m))
	for j ∈ 1:m-1
		for i ∈ j+1:m
			ℓ = U[i,j] / U[j,j]
			L[i, j] = ℓ
			U[i,:] = U[i,:] - ℓ*U[j,:]
			U[i,j] = 0.0 
		end
	end
	return L, U
end

# ╔═╡ a23f3937-0e2f-4859-baf7-10064230ffc9
md"""
# Sistemas Lineares 
"""

# ╔═╡ 1fc543d6-27d0-4c80-a837-e393c3e25446
md"""
## Tempo de execução (complexidade)

Ao escrevermos programas de computador é importante que tenhamos uma ideia do seu tempo de execução. Muitas vezes não basta inventar um algoritmo que esteja correto, é preciso que ele seja eficiente. Isso é um pouco menos importante nos dias de hoje do que era há algumas décadas, já que os computadores estão muito mais poderosos. Mas ainda é fácil escrever programas que demoram demais para realizar as suas tarefas.

Quando falamos em programas numéricos, cujo principal objetivo é realizar longas sequencias de cálculos, podemos buscar adquirir uma ideia do tempo de execução ou complexidade de um algoritmo através da contagem do número de operações de ponto flutuantes realizadas. Isso é apenas uma aproximação da complexidade total do processo, já que outras operações que não envolvem cálculos com números reais não são contadas. Isso pode ser particularmente dramático por desprezar a movimentação de dados entre a memória e o processador, algo que é muito demorado em computadores modernos. A contagem do número de operações continua sendo usada, porém, porque geralmente uma implementação cuidadosa de um método numérico é tipicamente limitada por essas operações. 

Usaremos a sigla FLOP (de *Foating Point Operation*) para designar uma operação básica de ponto flutuante como a soma, subtração, multiplicação, divisão ou extração de raiz quadrada. Nosso objetivo nessa seção é contar a quantidade de FLOPs de cada um dos principais algoritmos implementados até agora.

### Substituição

Vamos começar pela `retro_subs`. Olhando o seu código, vemos que a maior parte do trabalho ocorre dentro do laço `for`. Para calcular o novo `x[i]` precisamos executar uma subtração, uma divisão e o produto interno 
```julia
	dot(U[i, i + 1:end], xsol[i + 1:end])
``` 
entre dois vetores de $n - (i + 1) + 1 = n - i$ elementos. Esse produto interno precisa então de $n - i$ produtos de números reais e $n - i - 1$ somas. O total de operações realizadas nessa linha é então $2 + (n - i) + (n - i - 1) = 2(n - i)+ 1$. Dessa forma, podemos calcular o trabalho total:

$$\sum_{i = 1}^{n} 2(n - i)+ 1 =  \sum_{i = 1}^{n} (2n + 1) - 2 \sum_{i = 1}^{n} i = n(2n + 1) - n(n + 1) = n^2.$$

Obs: vejam que usei o $i$ variando de $1$ até $n$, isso foi feito para contar também a primeira operação feita, para calcular o `x[n]` que está fora do laço.

Vejam que o tempo é bem razoável, afinal uma matriz triangular tem cerca de $n^2 / 2$ entradas não nulas, então fazemos cerca de duas operações de ponto flutuante (FLOPs) por entrada da matriz. É difícil imaginar algo muito melhor do que isso.

Por fim, como o algoritmo de `subs` (para frente) é apenas uma versão invertida da `retro_subs`, o número de operações será o mesmo. Faça os detalhes como exercício.

"""

# ╔═╡ 25afda0a-73f7-46d8-9bae-049d36c7cabf
md"""

### Fatoração LU

Agora vamos para algo mais desafiador. Vamos tentar avaliar o tempo gasto na rotina `preLU`. De novo ela tem um único laço. Na primeira linha desse laço são executadas $n - 1$ divisões para calcular os coeficientes. Depois na quarta linha fazemos primeiro o produto externo de dois vetores $(n - 1)$ o que precisa de $(n - i)^2$ produtos. Por fim atualizamos a matriz $U$ com $(n - i)^2$ subtrações, totalizado

$$2(n - i)^2 + (n - i)$$

FLOPs. Note que a segunda e terceira linha do laço não geram FLOPs, são realizadas apenas cópias de valores em memória. Estamos prontos para escrever a somatória que irá acumular todo o trabalho feito.

$$\begin{aligned}
\sum_{i = 1}^{n - 1} 2(n - i)^2 + (n - i) &= [2(n - 1)^2 + (n - 1)] + [2(n - 2)^2 + (n - 2)] \\& + \ldots + [2\cdot2^2 + 2] + [2\cdot1^2 + 1].
\end{aligned}$$


Note que lendo essa somatória de trás para frente chegamos a uma expressão um pouco mais simples.

$$\sum_{i = 1}^{n - 1} 2i^2 + i.$$

Aqui nos deparamos com uma dificuldade. Como calcular a soma $\sum_{i = 1}^n i^2$? Isso tem uma resposta conhecida que é

$$\sum_{i = 1}^n i^2 = \frac{n (n + 1) (2n + 1)}{6}.$$

Você pode encontrar várias demonstrações disso. Um exemplo legal é [essa](http://blog.jgc.org/2008/01/proof-that-sum-of-squares-of-first-n.html). Mas há várias outras demonstrações.

Retornando ao nosso problema queremos

$$\begin{aligned}
    \sum_{i = 1}^{n - 1} 2i^2 + i & = \frac{(n-1)n(2n - 1)}{3} + \frac{(n-1)n}{2} \\
    &= (n-1)n \left(\frac{2n - 1}{3} + \frac{1}{2} \right) \\
    &= (n - 1)n \left( \frac{2n}{3} + \frac{1}{6} \right) \\
    &= \frac{2n^3}{3} - \frac{n^2}{2} - \frac{n}{6} \\
    &\approx \frac{2n^3}{3}.
\end{aligned}$$
A aproximação final vale para $n$ grande, que é o que interessa quando o problema aumenta.

De fato, em geral nós estamos interessados apenas nos termos de maior grau, assim podemos simplificar muito as contas eliminando termos intermediários que não serão importantes (para $n$ grande). As contas acima ficariam com algo como

$$\begin{aligned}
    \sum_{i = 1}^{n - 1} 2i^2 + i &\approx \sum_{i = 1}^{n - 1} 2i^2 \\
    &= 2 \frac{(n-1)n(2n - 1)}{6} \\
    &\approx \frac{2n^3}{3}.
\end{aligned}$$

Note que o tempo de calcular uma fatoração LU é muito maior do que o tempo de resolver um sistema triangular por substituição, afinal ele cresce com o cubo da dimensão da matriz. Isso mostra que, para resolver um sistema linear fazendo primeiro a fatoração LU, a maior parte do trabalho está no processo de fatoração. Ele irá dominar o tempo de execução.

"""

# ╔═╡ 6ba68c65-ca58-4b14-bacc-3107b5b81a1b
md"""

## Pivoteamento

O processo de fatoração LU descrito parece de fato muito interessante. Uma pergunta natural é se essa fatoração existe para qualquer matriz quadrada. A resposta para isso pode ser retirada do próprio processo de fatoração. Olhando o algoritmo vemos que o algoritmo consegue ir até o fim se, e somente se, a cada iteração o termo $a_{ii}$ usando para calcular os coeficientes for não nulo. Ou seja o algoritmo irá falhar se, e somente se, após $k - 1$ iterações encontrarmos a seguinte situação:

$$\tilde U = 
\begin{bmatrix}
X      &X      &X      &X      &\dots  &X      &X      &\dots &X \\
0      &X      &X      &X      &\dots  &X      &X      &\dots &X \\
0      &0      &X      &X      &\dots  &X      &X      &\dots &X \\
\vdots &\vdots &\ddots &\ddots &\dots  &\vdots &\vdots &\dots &X \\ \hline
0      &0      &0      &\dots  &0      &X      &X      &\dots &X \\ \hline
\vdots &\vdots &\vdots &\vdots &X      &X      &X      &\dots &X \\
0      &0      &0      &0      &X      &X      &X      &\dots &X
\end{bmatrix}.$$

Acima os elementos potencialmente não nulos estão denotados por $X$ e a linha e coluna $k$ estão destacadas. 

Agora na $k$-ésima iteração o objetivo é zerar os elementos abaixo da posição $k \times k$ usando o elemento da diagonal que infelizmente é $0$ e o algoritmo não pode continuar. Em particular a porção superior esquerda com $k$ linhas e $k$ colunas dessa matriz, que vamos denotar por $U_k$, foi obtida através de um processo de escalonamento da mesma porção da matriz original, isso é de $A[1:k, 1:k]$. Relembrando a discussão que nos levou a descobrir a ideia da fatoração LU isso nos ensina que existem matrizes $L_1, \ldots, L_{k -1} \in \mathbb{R}^{k \times k}$ inversíveis tais que

$$L_{k-1} \dots L_1 A[1:k, 1: k] = \tilde{U}[1:k, 1:k].$$


Como as matrizes $L_{i},\ i = 1, \dots, k-1$ são inversíveis e a matriz $\tilde{U}[1:k, 1:k]$ não é inversível pois tem a última linha de zeros, vemos que a matriz $A[1:k, 1:k]$ também não é inversível. Isso pode ser confirmado de muitas formas. Por exemplo lembrando que um sistema baseado em $A[1:k, 1:k]$ e em $\tilde{U}[1:k, 1:k]$ tem que ter as mesmas soluções, com possíveis adaptações do lado direito. Claramente um sistema baseado em $\tilde{U}[1:k, 1:k]$ pode ter nenhuma ou infinitas soluções, mas nunca solução única. Isso caracteriza uma matriz não inversível. Outra forma ainda mais fácil é usar a propriedade que o determinante de um produto de matrizes é igual ao produto dos determinantes e lembrar do fato que uma matriz é inversível se, e somente, se seu determinante for não nulo. Isso nos leva ao seguinte resultado:

>**Teorema.** Uma matriz $A \in \mathbb{R}^{n \times n}$ pode ser  fatorada pelo algoritmo `preLU`, que chamaremos de *fatoração LU  sem pivoteamento*, se, e somente se, as submatrizes $A[1:k, 1:k],\  k = 1 \ldots n - 1$, tiverem determinantes não nulos.

_Observação._: Os determinantes das submatrizes $A[1:k, 1:k],\ k = 1 \ldots n$ são conhecidos como *menores principais* de $A$.

Mas o que fazer nesse caso? Olhando de novo para a matriz acima, podemos ter a ideia de tentar procurar na coluna $k$ abaixo da diagonal um elemento não nulo de $A$. Se isso for possível, trocamos a linha $k$ pela linha desse elemento (que seria equivalente a trocar duas equações de posição no sistema linear) e obtemos um sistema equivalente para o qual o algoritmo pode continuar. Essa operação de troca é de novo uma operação elementar, que pode ser representada por uma matriz identidade com as respectivas linhas trocadas, multiplicada à esquerda. Verifique.

A aplicação dessa regra permite calcular uma fatoração LU, não mais de $A$ mas de uma versão de $A$ com linhas permutadas. Esse tipo de matriz pode ser representado pela multiplicação à esquerda de $A$ por uma matriz de permutação $P$ que é uma matriz identidade com linhas trocadas de lugar representando as várias trocas de linhas necessárias para levar o processo à cabo. Ou seja, ao final obteremos algo na forma

$$PA = LU.$$

Mais uma vez vemos que agora o método só pára se não encontrar nenhum elemento não nulo da posição $k \times k$ para baixo, ou seja se a matriz parcial tiver a forma

$$\tilde{U} = \begin{bmatrix}
X      &X      &X      &X      &\dots   &X      &X      &\dots &X \\
0      &X      &X      &X      &\dots  &X      &X      &\dots &X \\
0      &0      &X      &X      &\dots  &X      &X      &\dots &X \\
\vdots &\vdots &\ddots &\ddots &\dots  &\vdots &\vdots &\dots &X \\ \hline
0      &0      &0      &\dots  &0      &X      &X      &\dots &X \\ \hline
\vdots &\vdots &\vdots &\vdots &\vdots &X      &X      &\dots &X \\
0      &0      &0      &0      &0      &X      &X      &\dots &X
\end{bmatrix}$$

Mas essa matriz tem determinante nulo. Para ver isso, comece fazendo a expansão do seu determinante pela primeira coluna. Como a coluna é quase inteira de zero vemos que esse determinante é o $\tilde{u}_{11} \det(\tilde{U}[2:n, 2:n])$. Continuando esse processo até a coluna $k$ obtemos 

$$\det(\tilde{U}) = \tilde{u}_{11} \tilde{u}_{22} \ldots \tilde{u}_{kk} \det(\tilde{u}[k+1:n, k+1:n]) = 0.$$

A última igualdade vem do fato que $u_{kk} = 0$.

Concluímos que o processo de fatoração LU com pivoteamento parcial somente pára se a matriz $\tilde{U}$ encontrada for não inversível. Mais uma vez essa matriz é obtida a partir de $A$ pelo produto de matrizes triangulares inversíveis e portanto concluímos que o processo somente pára se $A$ é não inversível. Provamos um novo resultado.

> **Teorema** Se uma matriz $A \in \mathbb{R}^{n \times n}$ for inversível, então ela admite fatoração LU com pivoteamento parcial.

Nosso próximo desafio é adaptar a rotina `preLU` para incorporar o pivoteamento parcial. Para isso é necessário guardar a informação de onde as linhas foram parar, e trocar linhas de $U$ e $L$ quando o pivoteamento for feito. Veja abaixo
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
"""

# ╔═╡ Cell order:
# ╟─4833dd6e-5826-11ec-172b-537492fc4e68
# ╠═ab7d391c-4a01-478b-bb9c-20110c3a3acc
# ╠═e3b065ef-a425-459d-bb4d-d25b7483a049
# ╠═6bed0f40-75e6-4e77-9c42-8e02b51ba91f
# ╠═9f1d96d0-2d21-43ae-9b8f-f1f6a094e86f
# ╟─a23f3937-0e2f-4859-baf7-10064230ffc9
# ╟─1fc543d6-27d0-4c80-a837-e393c3e25446
# ╟─25afda0a-73f7-46d8-9bae-049d36c7cabf
# ╟─6ba68c65-ca58-4b14-bacc-3107b5b81a1b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
