### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ da0007d2-0816-4e13-beec-89e3cd848ede
using LinearAlgebra

# ╔═╡ 1623ba20-5693-11ec-0b0b-1358d14e7ab3
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 07 - Aula 01-02
"""

# ╔═╡ f1658e3d-1178-4fea-98ea-e28ac7f127a6
md"""
# Sistemas Lineares

Um dos problemas mais clássicos em computação científica é a resolução de sistemas lineares. Isso se dá por pelo menos dois motivos:

1. Sabemos resolvê-los bem. Ou seja, temos confiança que conseguimos resolver com alta precisão e de forma eficiente sistemas lineares com um número enorme de variáveis.

1. Outros problemas importantes podem ser reduzidos à solução de um ou mais sistemas lineares (potencialmente grandes, potencialmente infinitos).

Por isso vamos estudá-los durante as próximas aulas. Vamos começar estabelecendo um pouco de notação e recordando o que já sabemos sobre a solução de sistemas lineares.

Lembramos inicialmente que qualquer sistema linear de $n$ variáveis e $n$ incógnitas pode ser descrito em forma matricial. Ou seja, podemos descrever o problema de resolução de sistemas por uma equação.


$$Ax = b,$$

em que $A$ é uma matriz de $\mathbb{R}^{n \times n}$ e $b$ um vetor do $\mathbb{R}^n$. É claro que também é possível usar o mesmo tipo de notação para sistemas com números diferentes entre variáveis e incógnitas e nesse caso a matriz deixa de ser quadrada.

Uma primeira pergunta natural é: Quão fácil é resolver um sistema? A resposta para isso não é única. Pensando em um sistema geral, com centenas de variáveis por exemplo, ficamos com a impressão que é muito difícil. Mas se a matriz $A$ tiver estrutura especial, pode ser que a resolução do sistema seja fácil. Dois exemplos são:

* A matriz $A$ é a identidade. Nesse caso o solução é trivial $x = b$.
* A matriz $A$ é diagonal (todos os elementos fora da diagonal principal de $A$ são nulos). Mais uma vez a solução do sistema também é fácil, basta definir $x_i = b_i / a_{ii},\ i = 1, \ldots, n$, considerando que todos os elementos da diagonal são não nulos.
   
## Sistemas triangulares
   
Outro caso interessante ocorre quando $A$ é triangular inferior, ou superior, com todos os elementos da diagonal não nulos. Nesse caso podemos resolver o sistema por substituição. Vejamos um exemplo triangular superior.

$$\left\{
\begin{array}{lclclcll}
a_{11}x_1 &+& a_{12}x_2 &+& a_{13}x_3 &+& a_{14}x_4 &= b_1 \\
          & & a_{22}x_2 &+& a_{23}x_3 &+& a_{24}x_4 &= b_2 \\
          & &           & & a_{33}x_3 &+& a_{34}x_4 &= b_3 \\
          & &           & &           & & a_{44}x_4 &= b_4. 
\end{array}
\right.$$

Nesse caso é fácil achar o valor de $x_4$ usando a última equação. Susbtituindo o valor encontrado na penúltima equação passa a ser fácil encontrar encontrar o valor de $x_3$ e a assim por diante. Obtemos:

$$\begin{aligned}
x_4 &= b_4 / a_{44} \\
x_3 &= (b_3 - a_{34} x_4)/a_{33} \\
x_2 &= (b_2 - a_{23} x_3 - a_{24} x_4)/a_{22} \\
x_1 &= (b_1 - a_{12}x_2 - a_{13} x_3 - a_{14} x_4)/a_{11}. \\
\end{aligned}$$

Isso pode ser facilmente generalizado para o caso de mais variáveis. Chegamos à fórmula

$x_i = \frac{b_i - \sum_{j = i + 1}^n a_{ij} x_j}{a_{ii}},\ i = 1, \ldots, n.$

Agora, o curso de Cálculo Numérico não é apenas um curso de Matemática, então para nós não basta deduzir as fórmulas, temos que pensar um pouco como implementá-las. Vamos então apresentar uma rotina simples que resolve um sistema por retro-substituição.
"""

# ╔═╡ 5b77c9f8-3b2b-41ba-950d-e9ca03c7edf2
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


# ╔═╡ fb3af435-f8ae-469f-8784-71f034b07281
let 
	U = [1 2 3;0 3 7; 0 0 7.]
	b = [1, 4, 3.2]
	xsol = retro_subs(U,b)
	norm(U*xsol - b)
end

# ╔═╡ 516ba208-c113-47d1-a7a7-cb6b8b9a2083
md"""

> **Tarefa.** Um exercício interessante é escrever a versão do código para resolução de sistemas que são triangulares inferiores. Nesse caso a variável da solução que pode ser obtida imediatamente é $x_1$ e não mais $x_n$. A partir dela se obtém $x_2$ continuando até $x_n$. Que tal fazer isso na caixa de programa abaixo?

"""

# ╔═╡ 9bca219d-93bc-4247-b716-3746c411262d
# Funcao para resolver sistema triangular inferior por substituicao avançada
function subs(L,b)

end

# ╔═╡ 6a2db00e-ea3c-407e-be18-51a4e211506d
md"""
### Sistemas gerais

Agora o que fazer quando nos deparamos com um sistema geral como abaixo?

$\left\{
\begin{array}{lclclcll}
2x_1 &+& 3x_2 &+& x_3  &+& x_4  &= 3 \\
4x_1 &+& 7x_2 &+& 4x_3 &+& 3x_4 &= 6 \\
4x_1 &+& 7x_2 &+& 6x_3 &+& 4x_4 &= 4 \\
6x_1 &+& 9x_2 &+& 9x_3 &+& 8x_4 &= 3.
\end{array}
\right.$

Uma abordagem para isso, que é ensinada no ensino médio, é a ideia de *escalonamento*. Busca-se introduzir zeros nos coeficientes da primeira coluna das equações 2 em diante (para baixo). Depois transformamos em zeros os coeficientes da segunda coluna da equação 3 para frente e assim sucessivamente. O objetivo, é claro, é obter um sistema triangular equivalente ao sistema original. Para isso precisamos introduzir os zeros usando operações que preservem as soluções do sistema original. Isso pode ser feito usando-se operações elementares.

### Operações elementares

1. Multiplicar uma equação por um escalar não nulo.
1. Trocar duas equações de lugar.
1. Somar/Subtrair uma equação a outra.

Por exemplo, podemos introduzir um zero no primeiro coeficiente da segunda equação multiplicando a primeira linha por $-2$ e somando o resultado a segunda. Obteríamos então o sistema:

$\left\{
\begin{array}{lclclcll}
2x_1 &+& 3x_2 &+& x_3  &+& x_4  &= 3 \\
     &+&  x_2 &+& 2x_3 &+& x_4  &= 0 \\
4x_1 &+& 7x_2 &+& 6x_3 &+& 4x_4 &= 4 \\
6x_1 &+& 9x_2 &+& 9x_3 &+& 8x_4 &= 3.
\end{array}
\right.$

Outro fato interessante, que pode nos aproximar de uma implementação, é que as variáveis aparecem acima apenas por comodidade ou costume. A única informação que é realmente importante são os coeficientes e o lado direito. Isso sugere mais uma vez usar uma representação matricial do sistema. O sistema original poderia então ser representado por:

$\left[
\begin{array}{llll|l}
2 & 3 & 1 & 1 & 3 \\
4 & 7 & 4 & 3 & 6 \\
4 & 7 & 6 & 4 & 4 \\
6 & 9 & 9 & 8 & 3.
\end{array}
\right].$

Já o sistema transformado, após colocar um zero na posição $(2, 1)$ seria

$\left[
\begin{array}{llll|l}
2 & 3 & 1 & 1 & 3 \\
0 & 1 & 2 & 1 & 0 \\
4 & 7 & 6 & 4 & 4 \\
6 & 9 & 9 & 8 & 3.
\end{array}
\right].$

É claro que podemos colocar zeros também nas posições 3 e 4 da primeira coluna. Para isso basta somar à terceira linha mais uma vez $-2$ vezes a primeira. O coeficiente usado na multiplicação nada mais é do que o negativo valor da posição que se quer zerar divido pelo elemento que está na posição $1 \times 1$. Já para colocar um zero na posição $(4, 1)$ devemos somar à quarta $-3$ vezes a primeira. Mais uma vez o coeficiente $-3$ usado é obtido através da divisão entre o negativo do número que está na posição que deve ser eliminada dividido pelo número que está em $(1, 1)$. Vamos fazer isso, mas usando Julia. 
"""

# ╔═╡ be492efa-df70-40e9-9080-9043b0ebd073
A21 = [2.0 3 1 1; 0 1 2 1; 4 7 6 4; 6 9 9 8]

# ╔═╡ 3cf6d797-d99e-4fd9-ae1a-722cb7cbaf1c
b21 = [3.0, 0, 4, 3]

# ╔═╡ 768cf185-e7ca-476e-8fc9-8777f2e6b581
sistema21 = [A21 b21]

# ╔═╡ 7c6df6bb-7734-4585-8ad8-7231ef496af4
# Introduzindo zero na posicao (3, 1)
begin
	sistema31 =  sistema21
	ℓ31 = sistema21[3,1]/sistema21[1,1]
	sistema31[3,:] = sistema31[3,:] - ℓ31*sistema21[1,:]
	sistema31
end

# ╔═╡ 22c47931-36cd-45ba-be6f-98f0b4ee9b20
# Introduzindo zero na posicao (4, 1)
begin
	sistema41 =  sistema31
	ℓ41 = sistema31[4,1]/sistema31[1,1]
	sistema41[4,:] = sistema31[4,:] - ℓ41*sistema31[1,:]
	sistema41
end

# ╔═╡ 8e60176a-2332-4ef8-8aef-2c47870ac034
md"""
Assim, ao terminarmos de colocar zeros na primeira coluna abaixo da posição $(1, 1)$, obtemos

$\left[
\begin{array}{rrrr|r}
2 & 3 & 1 & 1 & 3 \\
0 & 1 & 2 & 1 & 0 \\
0 & 1 & 4 & 2 & -2 \\
0 & 0 & 6 & 5 & -6
\end{array}
\right].$

O próximo passo para se obter um sistema triangular é colocar zeros abaixo da posição $(2, 2)$. Isso pode ser obtido somando à terceira linha o inverso da segunda. Por sorte, o elemento na posição $(4, 2)$ já é zero e não precisa ser modificado. Fazemos então:
"""

# ╔═╡ 1437d4b1-7b50-4cde-9233-4719d84d1c4e
# Introduzindo zero na posicao (3, 2)
begin
	sistema32 =  sistema41
	ℓ32 = sistema32[3,2]/sistema32[2,2]
	sistema32[3,:] = sistema32[3,:] - ℓ32*sistema32[2,:]
	sistema32
end

# ╔═╡ b4f86c01-f9f4-43df-941e-0e41d8783883
md"""
Terminamos o processo introduzindo um zero na posição $(4, 3)$ usando um múltiplo da linha $3$.

"""

# ╔═╡ 57e025a0-b1b4-4de3-8f07-de73a49eaa9d
# Introduzindo zero na posicao (4, 3)
begin
	sistema43 =  sistema32
	ℓ43 = sistema43[4,3]/sistema43[3,3]
	sistema43[4,:] = sistema43[4,:] - ℓ43*sistema43[3,:]
	sistema43
end

# ╔═╡ 594a412c-8155-456a-a5be-d34d05cb78b2
md"""
Ao final temos o sistema

$\left[
\begin{array}{rrrr|r}
2 & 3 & 1 & 1 & 3 \\
0 & 1 & 2 & 1 & 0 \\
0 & 0 & 2 & 1 & -2 \\
0 & 0 & 0 & 2 & 0
\end{array}
\right].$

Ou usando a notação mais usual$

$\left\{
\begin{array}{rcrcrcrcl}
2x_1 & + & 3x_2 & + & 1x_3 & + & 1x_4 & = & 3 \\
     & + & 1x_2 & + & 2x_3 & + & 1x_4 & = & 0 \\
     &   &      &   & 2x_3 & + & 1x_4 & = & -2 \\
     &   &      &   &      &   & 2x_4 & = & 0.
\end{array}
\right.$

O sistema triangular superior que está pronto para ser resolvido por retro-substituição, apresentada acima. É claro que podemos escrever um programa em Julia que faz tudo de uma vez, pegando um sistema original e devolvendo a versão escalonada.

"""

# ╔═╡ dd5a7c3c-8399-4472-a208-a21178f79d74
# Escalonamento em Julia
function escalonamento(sistema)
	m, n = size(sistema) # m  número de linhas, n número de colunas
	for j ∈ 1:m-1
		for i ∈ j+1:m
			ℓ = sistema[i,j]/sistema[j,j]
			sistema[i,:] = sistema[i,:] - ℓ*sistema[j,:]
			sistema[i,j] = 0.0 
		end
	end
	return sistema
end

# ╔═╡ 40667bcf-d45d-4a0c-adc9-14ee287df1da
let
	A = [2.0 3 1 1; 4 7 4 3; 4 7 6 4; 6 9 9 8]
	b = [3.0, 6, 4, 3]
	escalonamento([A b])
end

# ╔═╡ 7684a6b7-db94-4062-b201-7e92790b490f
let 
	A = [0.003 59.14; 5.291 -6.130]
	b = [ 59.17; 46.78]
	E = escalonamento([A b])
end

# ╔═╡ 5d60b79a-8773-40f9-97c5-bbe04d59e0cd
md"""
Veja que o sistema obtido ao final é examente o desejado.

O código acima exige alguns comentários para explicar o que ocorre no laço `for`. 
- A primeira linha dentro do segundo laço `for` calcula os coeficientes que serão usados para multiplicar pela linha `i` (e depois somar nas debaixo).

- A terceira linha coloca zeros abaixo da posição `(i, i)`. Já sabemos que esses zeros vão aparecer lá, pois foi com esse objetivo que definimos os coeficientes. Para garantirmos que não temos erro de cancelamento, setamos este valor pra zero diretamente. 

"""

# ╔═╡ 65766d91-0ea7-45b3-8ffb-4ede84dffe40
let
	A = [3. 1 2; -1 2 1; 1 1 4]
	b = [6, 6, 2.]
	E = escalonamento([A b])
	U = E[:,1:3]
	b̄ = E[:,end]
	x̄ =  retro_subs(U,b̄)
	norm(A*x̄ - b)
end

# ╔═╡ cb511bf9-3dfe-44ca-9d25-aee106b4944b
md"""
## Fatoração LU

Se $A$ é uma matriz, uma *fatoração* de $A$ é um produto de outras matrizes, geralmente mais simples, que resulta em $A$. Isso é análogo ao caso de números inteiros que são fatorados em números primos.

Um fato interessante sobre o processo de escalonamento é que ele encontra, implicitamente, uma fatoração especial de $A$. Se organizarmos as contas de escalonamento podemos mostrar que ela encontra uma matriz triangular inferior $L$ e outra superior $U$ tal que

$$A = LU.$$

Para vermos que isso é verdade vamos analisar como representar cada operação realizada pelo escalonamento através de produtos de matrizes. Com esse objetivo vamos pensar o que ocorre quando multiplicamos uma matriz $A$ à esquerda por uma outra matriz que é igual à identidade a menos de uma posição fora da diagonal. Por exemplo,

$$
\begin{bmatrix}1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
-2 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
2 & 3 & 1 & 1 \\
4 & 7 & 4 & 3 \\
4 & 7 & 6 & 4 \\
6 & 9 & 9 & 8
\end{bmatrix}.$$

Com efeito, vejamos o valor do multiplicador $\ell_{32}$ que computamos anteriormente
"""

# ╔═╡ 37d63f83-5a69-4c72-a169-c20924e61715
ℓ31

# ╔═╡ 9f52842a-a8e9-486a-b423-5ec164a0ff90
md"""
Trabalhando um pouco nesse exemplo você verá que a matriz resultante é igual a matriz da direita com a terceira linha trocada pela linha que estava lá menos 2 vezes a primeira linha, ou seja

$$
\begin{bmatrix}2 & 3 & 1 & 1 \\
4 & 7 & 4 & 3 \\
0 & 1 & 4 & 2 \\
6 & 9 & 9 & 8
\end{bmatrix}.$$

De uma maneira geral, se multiplicarmos uma matriz $A$ à esquerda por uma matriz igual à identidade a menos de um elemento $c$ na posição $(i, j)$, obteremos uma matriz igual com a linha $i$ trocada por ela mesma somada a $c$ vezes a linha $j$. Esse é exatamente o tipo de operação usada pelo escalonamento. Ela pode ser interpretada como uma sequência de operações elementares do tipo multiplicar uma linha por um número não nulo e trocar uma linha por ela mesma mais outra. Logo o processo de escalonamento pode ser representada por multiplicações por matrizes. Por exemplo, para preencher com zeros a primeira coluna da matriz original acima, começando pela posição $(2, 1)$ até a posição $(4, 1)$ bastaria considerar os seguintes produtos por matrizes (leia da direita para a esquerda para entender mais facilmente).

$$\underbrace{
\begin{bmatrix}1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
-3 & 0 & 0 & 1
\end{bmatrix}}_{L_{41}}
\underbrace{
\begin{bmatrix}1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
-2 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}}_{L_{31}}
\underbrace{
\begin{bmatrix}1 & 0 & 0 & 0 \\
-2 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}}_{L_{21}}
\underbrace{
\begin{bmatrix}2 & 3 & 1 & 1 \\
4 & 7 & 4 & 3 \\
4 & 7 & 6 & 4 \\
6 & 9 & 9 & 8
\end{bmatrix}}_{A} = 
\begin{bmatrix}2 & 3 & 1 & 1 \\
0 & 1 & 2 & 1 \\
0 & 1 & 4 & 2 \\
0 & 0 & 6 & 5
\end{bmatrix}.$$

A notacão $L_{ij}$ representa matriz que coloca zero na posição $(i, j)$. De fato vamos verificar isso computacionalmente.
"""

# ╔═╡ d82ab93e-066e-4ff7-90f4-0ec1033efb4d
A = [2. 3 1 1; 4 7 4 3; 4 7 6 4; 6 9 9 8]

# ╔═╡ 083edc2a-c54c-4fd6-808b-c22c4ad1e78e
begin
	L21 = diagm(ones(4))
	L31 = diagm(ones(4))
	L41 = diagm(ones(4))
	L21[2,1] = -2
	L31[3,1] = -2
	L41[4,1] = -3
	L41*L31*L21*A
end

# ╔═╡ 1c108796-a564-4003-a3b5-3970c262ec8c
md"""
Compare o resultado obtido com o resultado do processo de escalonamento depois de colocar zeros abaixo do primeiro elemento da diagonal acima. Veja que a matriz de partida é a mesma. Outro fato interessante sobre as matrizes $L_1,\ L_2,\ L_3$ acima é que o seu produto é particularmente simples.

$$
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
-3 & 0 & 0 & 1
\end{bmatrix}}_{L_{41}}
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
-2 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}}_{L_{31}}
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
-2 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}}_{L_{21}} =
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
-2 & 1 & 0 & 0 \\
-2 & 0 & 1 & 0 \\
-3 & 0 & 0 & 1
\end{bmatrix}}_{L_1}.$$


"""

# ╔═╡ e2496a0b-45e9-437b-ae5e-19f17b5b24df
md"""
Basta copiar abaixo da primeira diagonal da identidade os coeficientes que aparecem nas três matrizes na sua posição natural, formando assim a matriz que zera os elementos desejados da coluna $1$. Vamos chamar essa matriz de $L_1$. Para entender o porque isso acontece basta interpretar o produto da direita para a esquerda. Podemos mais uma vez confirmar isso computacionalmente. 
"""

# ╔═╡ 36152d29-21cc-48c6-9dc4-7346c68f706e
L1 = L41*L31*L21

# ╔═╡ 143aab2a-7c84-41f9-8e82-51d9400385f8
md"""
Outro fato interessante sobre as matrizes que se combinam para formar $L_1$ é que suas inversas são fáceis de calcular. Basta inverter o elemento de fora da diagonal. Por exemplo

$$L_{31}^{-1} = 
\begin{bmatrix}1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
2 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}.$$

Confirmando:
"""

# ╔═╡ f6c73e4f-a9ae-44f9-8872-9390af853a4c
L31⁻¹ = inv(L31)

# ╔═╡ ec02ef75-4c13-4d4d-91f8-8f2de5005b10
md"""
Isso pode ser entendido porque essa mudança de sinal desfaz a operação elementar representada por essas matrizes. Pense um pouco. 

Agora lembrando que o inverso de um produto é o produto invertido das inversas termos

$$
L_1^{-1} = (L_{41} L_{31} L_{21})^{-1} =  L_{21}^{-1} L_{31}^{-1} L_{41}^{-1} = 
\begin{bmatrix}
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 0 \\
2 & 0 & 1 & 0 \\
3 & 0 & 0 & 1
\end{bmatrix}.$$

De novo ocorre o fenômeno que é simples multiplicar essas matrizes, basta copiar os elementos adequados nas respostas.

O restante do processo de escalonamento também pode continuar sendo representado por multiplicação por matrizes desse tipo. Continuamos o processo colocando zeros abaixo do segundo elemento da diagonal e por fim abaixo do terceiro. O processo todo seria então representado pelo produto.

$$
\underbrace{
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & -3 & 1
\end{bmatrix}}_{L_{43}}
}_{L_3}
\underbrace{
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}}_{L_{42}}
\underbrace{
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & -1 & 1 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}}_{L_{32}}
}_{L_2}
L_1
\underbrace{
\begin{bmatrix}
2 & 3 & 1 & 1 \\
4 & 7 & 4 & 3 \\
4 & 7 & 6 & 4 \\
6 & 9 & 9 & 8
\end{bmatrix}}_{A} = 
\begin{bmatrix}
2 & 3 & 1 & 1 \\
0 & 1 & 2 & 1 \\
0 & 0 & 2 & 1 \\
0 & 0 & 0 & 2
\end{bmatrix}.$$

"""

# ╔═╡ fddc54b0-b015-4ea4-842e-3a144a0fdf75
# Implementação
begin
	L2 = diagm(ones(4))
	L2[3,2] = -1
	L2[4,2] = 0.0
	L3 = diagm(ones(4))
	L3[4,3] = -3
	L3*L2*L1*A
end

# ╔═╡ ad86fa99-fb49-470c-ac9c-6e1d948742c8
escalonamento(A)

# ╔═╡ e3d8d74f-3e42-44b8-983e-886df5b43c32
md"""
Agora, vamos partir dessa última equação. Temos

$$L_3 L_2 L_1 A = U,$$
em que $U$ é a matriz triangular superior que obtemos ao final do processo de escalonamento. Podemos então passar o produto das matrizes $L_k$ para o outro lado, usando suas inversas, que sabemos como calcular. Obtendo:

$$A = L_1^{-1} L_2^{-1} L_3^{-1} U.$$
Mais uma vez há um "golpe de sorte" e o produto $L_1^{-1} L_2^{-1} L_3^{-1}$ também tem uma expressão particularmente simples, bastando copiar os elementos que aparecem abaixo das diagonais de cada uma dessa matriz na resposta. Isso ocorre porque o produto $L_{k}^{-1} \dots L_{n - 1}^{-1}$ é composto por matrizes com zeros abaixo da diagonal na coluna $k - 1$, já que nessas posições sempre houve $0$ nas linhas que já foram combinadas. Agora quando se multiplica essa matriz intermediária à esquerda por $L_{k-1}$ na coluna $k - 1$ apenas os elementos de $L_{k - 1}$ que estão abaixo da diagonal na coluna $k - 1$ irão importar, sendo diretamente copiados. Faça uns exemplos manualmente para se convencer disso. Já a confirmação numérica pode ser feita agora.
"""

# ╔═╡ 02955fa4-db1e-459f-ac2d-216da9a92135
inv(L3*L2*L1)

# ╔═╡ 4cc1cde4-2e71-419c-a3cf-1b56c51f3c66
md"""
De fato a inversa obtida também é uma matriz triangular inferior com os elementos das matrizes inversas copiados. A essa matriz $L_1^{-1} L_2^{-1} \ldots L_{n - 1}^{-1}$ vamos chamar de matriz $L$. Dessa forma obtermos justamente a expressão desejada:

$$A = LU.$$

Não podemos deixar de observar que talvez fosse mais natural nomear a matriz $L_1^{-1} L_2^{-1} \ldots L_{n - 1}^{-1}$ de $L^{-1}$. Isso não é feito para evitar uma notação pesada na importante igualdade $A = LU$. 

Deste modo fica natural adaptar o código de escalonamento para calcular a fatoração LU de uma matriz. Para isso basta guardar os coeficientes usados, com sinal adequado, na matriz $L$. A matriz $U$ é a matriz triangular superior final.
"""

# ╔═╡ 9913bd3f-86b6-40f9-9ba0-57fc8d6732e7
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

# ╔═╡ 55f2292d-dbf2-4ace-bbf8-51d5b4836065
let 
	A = [2.0 3 1 1; 4 7 4 3; 4 7 6 4; 6 9 9 8]
	L, U = preLU(A)
end

# ╔═╡ d277bb45-62de-4ff2-aa1f-17bfe9328497
md"""
- Alem da rotina de retro substituicao para a resolução de sistemas triangulares superiores precisamos de uma outra que faca a resolução de sistemas triangulares inferiores. Isso tinha ficado como exercício.
"""

# ╔═╡ 2c5d7d01-e932-485a-bce3-41f4d9ec5928
let
	A = [2.0 3 1 1; 4 7 4 3; 4 7 6 4; 6 9 9 8]
	b = [3.0, 6, 4, 3]
end

# ╔═╡ b0729c40-334e-4503-873e-f05ce14aa49f
md"""
- Um fato que pode ser importante em alguns casos é que uma vez calculada a fatoração LU de uma matriz ela pode ser utilizada sempre no lugar de $A$. Assim, por exemplo, se quisermos resolver sistemas lineares com diferentes lados direitos (diferentes vetores $b$) a fatoração pode ser feita uma única vez.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
"""

# ╔═╡ Cell order:
# ╠═1623ba20-5693-11ec-0b0b-1358d14e7ab3
# ╠═da0007d2-0816-4e13-beec-89e3cd848ede
# ╟─f1658e3d-1178-4fea-98ea-e28ac7f127a6
# ╠═5b77c9f8-3b2b-41ba-950d-e9ca03c7edf2
# ╟─516ba208-c113-47d1-a7a7-cb6b8b9a2083
# ╠═9bca219d-93bc-4247-b716-3746c411262d
# ╠═fb3af435-f8ae-469f-8784-71f034b07281
# ╟─6a2db00e-ea3c-407e-be18-51a4e211506d
# ╠═be492efa-df70-40e9-9080-9043b0ebd073
# ╠═3cf6d797-d99e-4fd9-ae1a-722cb7cbaf1c
# ╠═768cf185-e7ca-476e-8fc9-8777f2e6b581
# ╠═7c6df6bb-7734-4585-8ad8-7231ef496af4
# ╠═22c47931-36cd-45ba-be6f-98f0b4ee9b20
# ╟─8e60176a-2332-4ef8-8aef-2c47870ac034
# ╠═1437d4b1-7b50-4cde-9233-4719d84d1c4e
# ╟─b4f86c01-f9f4-43df-941e-0e41d8783883
# ╠═57e025a0-b1b4-4de3-8f07-de73a49eaa9d
# ╟─594a412c-8155-456a-a5be-d34d05cb78b2
# ╠═dd5a7c3c-8399-4472-a208-a21178f79d74
# ╠═40667bcf-d45d-4a0c-adc9-14ee287df1da
# ╠═7684a6b7-db94-4062-b201-7e92790b490f
# ╟─5d60b79a-8773-40f9-97c5-bbe04d59e0cd
# ╠═65766d91-0ea7-45b3-8ffb-4ede84dffe40
# ╟─cb511bf9-3dfe-44ca-9d25-aee106b4944b
# ╠═37d63f83-5a69-4c72-a169-c20924e61715
# ╟─9f52842a-a8e9-486a-b423-5ec164a0ff90
# ╠═d82ab93e-066e-4ff7-90f4-0ec1033efb4d
# ╠═083edc2a-c54c-4fd6-808b-c22c4ad1e78e
# ╟─1c108796-a564-4003-a3b5-3970c262ec8c
# ╟─e2496a0b-45e9-437b-ae5e-19f17b5b24df
# ╠═36152d29-21cc-48c6-9dc4-7346c68f706e
# ╟─143aab2a-7c84-41f9-8e82-51d9400385f8
# ╠═f6c73e4f-a9ae-44f9-8872-9390af853a4c
# ╟─ec02ef75-4c13-4d4d-91f8-8f2de5005b10
# ╠═fddc54b0-b015-4ea4-842e-3a144a0fdf75
# ╠═ad86fa99-fb49-470c-ac9c-6e1d948742c8
# ╟─e3d8d74f-3e42-44b8-983e-886df5b43c32
# ╠═02955fa4-db1e-459f-ac2d-216da9a92135
# ╟─4cc1cde4-2e71-419c-a3cf-1b56c51f3c66
# ╠═9913bd3f-86b6-40f9-9ba0-57fc8d6732e7
# ╠═55f2292d-dbf2-4ace-bbf8-51d5b4836065
# ╟─d277bb45-62de-4ff2-aa1f-17bfe9328497
# ╠═2c5d7d01-e932-485a-bce3-41f4d9ec5928
# ╟─b0729c40-334e-4503-873e-f05ce14aa49f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
