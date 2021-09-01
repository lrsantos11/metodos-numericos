### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 2b0f8ca8-2bce-4784-9110-1fdbb18b27d0
begin
	using Plots, PlutoUI, ForwardDiff, DataFrames, StatsPlots, LinearAlgebra, SpecialFunctions,LaTeXStrings
	plotly()
end

# ╔═╡ 83c15f2c-d266-4ec4-bcd3-a464615cf7ae
using SparseArrays

# ╔═╡ 7ac099ac-0aa4-11ec-014c-b7e75ef5ebf5
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 12 - Aula 01
"""

# ╔═╡ a983ec5b-2d81-4210-a1f1-5c478bcbbede
md"""
# Sistemas lineares
"""

# ╔═╡ f266e93d-3c65-4ef5-8e91-ee63ade7d39c
md"""
## Fatoração LU

Dada uma matriz $A\in \mathbb{R}^n$, a eliminação de Gauss pode ser entendida como a fatoração da matriz $A$ em 

$A = LU$. 
Em `julia` usamos o comando `lu` para este cálculo. 

Vejam que de fato $LU$ é igual à matriz $A$ original. Na verdade, essa igualdade absoluta é obtida nesse caso por que todas as contas, apesar de serem feitas com ponto flutante, geraram números inteiros que podem ser representados. De uma forma geral esperamos que o resultado final sejam aproximadamente a $L$ e a $U$ desejadas. Voltaremos a discutir erros depois.

### Utilizando a fatoração LU para resolver sistemas

Começamos essa discussão falando sobre a solução de sistemas lineares mas fizemos um desvio acima para comentar sobre uma fatoração de matrizes. Vamos agora voltar a trilha original, vendo como usar a fatoração LU para resolver um sistema linear. Desejamos encontrar $x$ tal que

$$Ax = b.$$
Isso é equivalente a buscar $x$ tal que

$$LUx = b.$$
Como lidar com sistemas que tem produtos de matrizes como acima? Uma ideia é criar variáveis intermediárias, resolvendo o sistema da esquerda para a direita. Por exemplo, no caso acima podemos inicialmente buscar $y$ tal que

$$L y = b.$$
Isso é fácil de calcular porque o sistema é triangular inferior. Depois disso resolvemos

$$U x = y.$$
Assim, obtemos o $x$ desejado, solução do sistema original. Note que de novo basta resolver um sistema triangular, mas agora superior. De fato colocando as duas últimas expressões juntas temos
$$U x = y \implies L (U x) = b \implies Ax = b.$$
A primeira implicação usa a definição de $y$. 
"""

# ╔═╡ 93b645f3-0af2-467b-9cf0-dc7c36c1fa54
# Exemplo1
begin
	A1 = [2.0 3 1 1; 4 7 4 3; 4 7 6 4; 6 9 9 8]
	b1 = [3.0, 6, 4, 3]
	fat_lu1 = lu(A1, Val(false))
end

# ╔═╡ f6d227ec-23c4-45bf-9621-c45f37bab0c8
fat_lu1.L

# ╔═╡ 162ef5fa-5d89-4a4a-98fe-13afcebc69f4
istril(fat_lu1.L)

# ╔═╡ 4d5b260c-b311-40fa-afc5-4f10a9f3d7b8
fat_lu1.U

# ╔═╡ b4085a60-69be-42f5-abad-50173d107e7c
istriu(fat_lu1.U)

# ╔═╡ 941f8135-fe39-4ed4-a391-0b1e617d3da3
fat_lu1.L * fat_lu1.U

# ╔═╡ cdc1dfbe-45ec-4e67-aa1c-49a3de442153
y1 = fat_lu1.L \ b1

# ╔═╡ a953ea17-f22f-4880-b31a-e16e2d16f698
x1 = fat_lu1.U \ y1

# ╔═╡ 043b30f0-3d40-4d87-bdfa-96158c8ee690
norm(b1 - A1*x1)

# ╔═╡ 4477ef3d-c3ae-4cde-9708-8a4ed292b194
x12 = fat_lu1 \ b1

# ╔═╡ a30599d2-c700-4f6c-ad0f-707ab92c137a
A1 \ b1

# ╔═╡ 28d44316-c5ab-4b84-92f0-ec254734f323
lu([0 1; 1 1.],Val(false))

# ╔═╡ 0de91742-2a39-42c6-8094-56602e0ac393
md"""
### Pivoteamento

A fatoração LU é de fato muito interessante. Uma pergunta natural é se essa fatoração existe para qualquer matriz quadrada. A resposta é não. Se algum dos pivôs (da eliminação de Gauss) se anular não poderemos prosseguir. 

> **Teorema.** Uma matriz $A \in \mathbb{R}^{n \times n}$ possui *fatoração LU (sem pivoteamento)*, se, e somente se, as submatrizes $A[1:k, 1:k],\ k = 1 \ldots n - 1$, tiverem determinantes não nulos.

**Observação.** Os determinantes das submatrizes $A[1:k, 1:k],\ k = 1 \ldots n$ são conhecidos como *menores principais* de $A$.

Mas o que fazer nesse caso?  Se isso for possível, trocamos duas equações de posição no sistema linear e obtemos um sistema equivalente para o qual o algoritmo pode continuar. Essa operação de troca é de novo uma operação elementar, que pode ser representada por uma matriz identidade com as respectivas linhas trocadas, multiplicada à esquerda. 

A aplicação dessa regra permite calcular uma fatoração LU, não mais de $A$ mas de uma versão de $A$ com linhas permutadas. Esse tipo de matriz pode ser representado pela multiplicação à esquerda de $A$ por uma matriz de permutação $P$ que é uma matriz identidade com linhas trocadas de lugar representando as várias trocas de linhas necessárias para levar o processo à cabo. Ou seja, ao final obteremos algo na forma

$$PA = LU.$$

>**Teorema** Se uma matriz $A \in \mathbb{R}^{n \times n}$ for inversível, então ela admite fatoração LU com pivoteamento parcial.

- `lu` de `julia` faz pivoteamento parcial, por padrão.
"""

# ╔═╡ ea520c60-558a-4542-9b05-0a44c868ddf2
[0 1 ; 1 0]*[0 1; 1  1]

# ╔═╡ af88ce3b-cb74-4c8b-9a35-d719d53aec84
fat_lu11 = lu([0 1; 1 1])

# ╔═╡ 709b1b0b-6ea4-4b6e-8cff-52bacc27af2f
fat_lu11.L * fat_lu11.U

# ╔═╡ 17cafa2e-0102-43d7-b923-3c20d322ba3a
fat_lu11.P

# ╔═╡ 2079219f-043f-4d17-956c-d2665943b78a
fat_lu11.P*fat_lu11.L*fat_lu11.U

# ╔═╡ d5142365-3e56-4bc3-8294-2977e227243c
b11 = [1,2]

# ╔═╡ 0c284979-9e53-46c1-8775-4fb559b26c69
y11 =fat_lu11.L \ b11[fat_lu11.p]

# ╔═╡ edff7c0f-428b-443d-8fdb-4b0c87155550
x11 = fat_lu11.U \ y11

# ╔═╡ a01483ea-5ab4-4c55-84f9-faacda4217aa
[0 1; 1 1] \ b11

# ╔═╡ cf3d979e-7293-4b32-9afc-68184785ec89
md"""
### Número de condição

A menos que tomemos cuidado de fazer pivoteamento parcial $(PA = LU)$ a fatoração LU pode falhar em resolver sistemas lineares simples. Pelo menos a precisão final obtida pode ser muito ruim.

Vamos agora ver que há sistemas lineares que tem uma propriedade intrínseca que impede que eles sejam resolvidos com alta precisão. Para entender isso vamos apresentar dois casos de sistemas no plano e relembrar um pouco sobre a sua solução geométrica.

Dado um sistema de duas equações e duas incógnitas, por exemplo

$\begin{aligned}
x + y &= 2 \\
x - 2y &= -1.
\end{aligned}$

Aprendemos que podemos resolvê-lo graficamente desenhando as retas que representam cada uma das duas equações e procurando o seu ponto de cruzamento. Nesse caso teríamos.
"""

# ╔═╡ da3c023a-ddd3-4885-8ce7-8650c71b0abb
begin 
	plot(x->2-x,0,2,lab = "")
	plot!(x->(x+1)/2,0,2,lab = "")
end

# ╔═╡ 274dd537-f7d6-4173-a9d9-d0bd98613cdd
A2 = [1 1 ; 1 -2]

# ╔═╡ 24666d56-e103-4949-b351-eeba9dd78cc3
b2 = [2, -1]

# ╔═╡ 34cf2ada-1a97-45c7-b81a-cf11f763883f
A2 \ b2

# ╔═╡ 3b286a50-26d6-472c-8584-c3ea98464d8a
md"""
Nessa imagem vemos claramento o ponto de cruzamento que é $(1, 1)$. A situação ficaria bem menos clara se as duas retas fossem quase paralelas. Isso ocorre por exemplo com o sistema

$\begin{aligned}
x + y &= 2 \\
(1.0 + 10^{-1})x + y &= 2 + 10^{-1}.
\end{aligned}$
Nesse caso a figura fica:
"""

# ╔═╡ 8cf0c701-42b7-4a73-95d9-69437cc306be
begin 
	plot(x->2-x,0,2,lab = "")
	plot!(x->2.01 - 1.01x,0,2,lab = "")
end

# ╔═╡ 3b219946-200b-42b3-8481-780a0b21341c
md"""
Agora o ponto de intersecção continua sendo $(1, 1)$ mas isso é muito menos claro visualmente. A única solução é ir tentando aumentar a imagem próximo à região de intersecção (zoom) para tentar ver melhor. Por outro lado se você imaginar que as linhas tem espessura fixa o zoom não vai adiantar muito. Há uma precisão máxima que pode ser obtida. De forma análoga ao caso de linhas de espessura fixa, a precisão que pode ser atingida com números do tipo ponto flutuante é também limitada.

Dessa forma, é de se esperar que quando queremos resolver um sistema associado a equações quase paralelas o computador tenha problemas. Vamos ver isso.
"""

# ╔═╡ 6763b10a-28c7-4b75-9018-cc0d04a6ff08
begin
	# Constroi um sistema que tem solucao exata (1, 1) mas com a segunda # equacao muito parecida com a primeira.
	pertubacao = 1.0e-13
	A3 = [1.0 1.0; 1.0+pertubacao 1.0-pertubacao]
	b3 = [2.0, 2.0]
	fat_lu3 = lu(A3)
	y3 = fat_lu3.L\b3[fat_lu3.p]
	x3 = fat_lu3.U\y3
end

# ╔═╡ 9dbe3737-56f4-49f8-a923-9a1d7f561c7f
norm(x3 - [1,1])/norm([1.1])

# ╔═╡ 8c7facd7-3a76-4e35-b8e8-f5e84d1bbef5
md"""
Veja que a solução calculada tem erro confirmado pelo calculo do erro relativo. Um fato interessante é que é possível calcular um valor a partir da matriz que nos diz quando esperar que problemas numéricos como os que vimos acima podem ocorrer. Mas para isso precisamos fazer um pequeno desvio e falar sobre normas de matrizes.

### Distâncias e normas de vetores e matrizes.

Em Matemática chamamos de norma, ou comprimento de um vetor $x \in \mathbb{R}^n$, uma função $x \mapsto \| x \| \in \mathbb{R}$ tal que:
1. Para todo $x \in \mathbb{R}^n$  $\| x \| \geq 0$ e $\| x \| = 0$ somente se $x = 0$.

1. Para todo $x \in \mathbb{R}^n$ e $\alpha \in \mathbb{R}$ temos $\| \alpha x \| = |\alpha| \| x \|$.

1. Vale a desigualdade triangular, isto é, $\| x + y \| \leq \| x \| + \| y \|$ para todos $x, y \in \mathbb{R}^n$.

A ideia por detrás dessa definição é capturar diferentes formas de medir tamanho ou distância, mas preservando a propriedade que vetores pequenos tem tamanhos pequenos, somente o vetor nulo tem tamanho $0$ e que o tamanho do lado de um triângulo é menor ou igual a soma dos tamanhos dos outros dois lados.

Com a norma definida podemos definir a distância entre dois vetores como a norma de sua diferença, como é natural.

Vejamos agora alguns os exemplos mais importantes de norma.

$\begin{align}
\| x \|_1 &= | x_1 | + | x_2 | + \ldots + | x_n |. \\
\| x \|_2 &= \sqrt{x_1^2 + x_2^2 + \ldots + x_n^2}. \\
\| x \|_\infty &= \max \{ | x_1 |, | x_2 |, \ldots, | x_n | \}.
\end{align}$


"""

# ╔═╡ 99f6a0d9-18cd-4689-9127-4365b6e772bc
x4 = fill(1.,5)

# ╔═╡ ed52fe75-26d9-488b-9a41-eb4ca86d2d40
norm(x4,1)

# ╔═╡ 06a54494-4b71-4bd7-8443-76f2f4bb4e6b
norm(x4,2) # = norm(x4)

# ╔═╡ 686d1d28-c67a-45eb-b91c-73a472b669c4
norm(x4,Inf)

# ╔═╡ ec36911d-8e73-4d3c-bff5-566a111c00f5
md"""
É fácil mostrar que as definições acima obedecem às três propriedades que definem uma norma usando as propriedades relacionadas da função módulo.

Uma pergunta natural é: porque se preocupar com formas alternativas de medir comprimento de vetor ou distância entre dois vetores que não seja a distância usual, euclidiana, que é capturada na definição da norma 2? Para entender disso imagine que você mora em uma cidade com ruas formando um quadriculado. Se você está em um ponto $(x_1, y_1)$ nessa cidade e quer ir para o ponto $(x_2, y_2)$ é fácil entender que o mínimo que você precisa se movimentar é justamente $| x_1 - x_ 2 |$ na horizontal $| y_1 - y_2 |$ na vertical. Ou seja, na prática a distância entre esses pontos é $| x_1 - x_ 2 | + | y_1 - y_2 |$ que está justamente relacionada à norma 1.

Da mesma forma que podemos estar interessados em definir o comprimento ou de vetores podemos também querer definir o comprimento ou tamanho de matrizes. Isso é usualmente feito referindo-se a normas de vetores. Vamos mais uma vez apresentar as definições mais importantes para o curso. Seja $A \in \mathbb{R}^{n \times n}$ temos

$\begin{align}
\| A \|_1 &= \max \{ \| a_{1:n, i} \|_1,\ i = 1, \ldots, n \} \quad\quad \text{(máxima norma 1 das colunas de A)}. \\
\| A \|_2 &= \max_{\| x \|_2 = 1} \{ \| Ax \|_2 \}.\\
\| A \|_\infty &= \max \{ \| a_{i, 1:n} \|_1,\ i = 1, \ldots, n \} \quad\quad \text{(máxima norma 1 das linhas de A)}. \\
\end{align}$

Uma propriedade fundamental que relaciona as normas de matrizes com as respectivas normas de vetores é apresentada a seguir.

> **Proposição.** $$\| Ax \|_\dagger \leq \| A \|_\dagger \| x \|_\dagger,$$ em que $\dagger$  pode ser substituido (nas três posições ao mesmo tempo) por $1$, $2$, ou $\infty$.

Vejamos um exemplo numérico.
"""

# ╔═╡ 3e2ad1e9-7501-43bc-8a75-197e564a50c3
A4= 5*rand(5,5)

# ╔═╡ f248faa7-8bbd-4638-af36-2953ee9ff6cc
norm(reshape(A4,25))

# ╔═╡ 9fc810b3-e815-4988-98ed-119f3e47c2c0
norm(A4) #Norma de Frobenius

# ╔═╡ c7b066a3-4d2b-49da-9168-a412d2a07474
opnorm(A4,1)

# ╔═╡ f1120902-cea7-4d64-b896-f7e59f6ae9e1
opnorm(A4,2)

# ╔═╡ ff0e6e4c-3bdf-4091-9ec3-8703b432b046
opnorm(A4,Inf)

# ╔═╡ 29ac9cc6-135f-4c09-8284-9618a93abb0f
md"""
De posse dessas definições, estamos prontos para retomar o nosso objetivo original: apresentar um valor que pode ser calculado a partir da matriz associada ao sistema que desejamos resolver e que seja capaz de estimar a risco de corremos de ter grandes erros numéricos.

### Número de condição

Esse valor é conhecido como *número de condição* e pode ser entendido como uma forma de estimar o quanto a matriz está perto de ser não-inversível, ou seja o quão perto suas linhas (ou colunas) estão de se tornarem linearmente dependentes. Ele é dado por

$\kappa(A) = \| A \| \| A^{-1} \|.$

Vamos inicialmente calcular o número de condição das duas matrizes associados aos sistemas no plano vistos anteriormente:
"""

# ╔═╡ 96b7683f-29ed-4ff3-82f2-fca950793cd6
A2

# ╔═╡ 0c4fc7e4-4f09-454f-b21c-fa9952550f05
opnorm(A2)*opnorm(inv(A2))

# ╔═╡ bb87f148-afbb-4a7f-aa70-334a10fd093e
A3

# ╔═╡ 43c230d2-ad37-465f-ac4b-3ad335894cce
opnorm(A3)*opnorm(inv(A3))

# ╔═╡ 9e135f63-2388-4f31-a2ae-419e857a1633
cond(A3)

# ╔═╡ 493b9408-fdd9-41e4-a073-f0a93a67ee6f
md"""
Como vocês podem ver o número de condição da segunda matriz é muito grande, da ordem de $10^{13}$. Isso sugere que é possível que encontremos dificuldades numéricos ao calcular a fatoração LU (mesmo usando pivoteamento) dessa matriz ou ao tentar resolver um sistema linear baseado nela, como já observamos.
"""

# ╔═╡ 1d57abfb-b54e-40c3-83c0-687ded116ab5
spA1 = sprand(250,250,0.027)

# ╔═╡ 1cca2a8d-4bf4-4fad-aa0c-8d5667bb963d
250*250

# ╔═╡ feee670a-666e-4381-a863-273044e80ed8
nnz(spA1)

# ╔═╡ 1c98a26f-8cf4-4820-bf97-be098a0c9c3b
lu(spA1)

# ╔═╡ 892b8d10-7591-4eb3-bf74-169126a2c885
md"""
## Métodos iterativos

Os metodos que apresentamos acima, escalonamento (eliminação de Gauss) e fatoração LU, têm como característica a modificação do sistema original para colocá-lo em um formato que pode ser resolvido rapidamente. O grosso do trabalho, que é da ordem $O(\frac{2}{3} n^3)$, é gasto nesse processo de transformação do sistema ou da respectiva matriz. Até que ele seja terminado não se obtém nenhuma aproximação da solução. Esse tipo de método tem então uma característica do tipo "tudo ou nada". Ou o usuário espera que todo o trabalho seja feito ou ele sai sem nenhuma resposta. Esses métodos são conhecidos como métodos diretos.

Uma alternativa ao métodos diretos são os métodos iterativos. Neles o objetivo é aproximar, o mais rapidamente possível, a resposta. O que se perde é que em geral não é possível calculá-la exatamente. Esses métodos são usados quando, por exemplo, $n$ é muito grande e então não é possível esperar que um método direto termine o seu trabalho. Outra situação onde pode ser desejável usar métodos iterativos é quando a matriz $A$ possui muitos elementos nulos. Nesse caso dizemos que $A$ é uma matriz *esparsa*. Voltaremos a comentar isso depois.

Vamos apresentar agora as ideias por trás do método iterativo mais simples. Ele se baseia em uma observação trivial. Para fixar as ideias vamos iniciar com um sistema $2$ por $2$.

$\left\{ \begin{array}{rcrcl}
2.5x &-& y &=& 1.5 \\
x &-& 2y &=& -1.
\end{array}\right.$
Podemos facilmente resolver o sistema e verificarque é solução é em $(x, y) = (1, 1)$. Veja o gráfico dele abaixo
"""

# ╔═╡ 1a72d395-5891-4802-b35a-bae043d0ffaa
begin 
	eq1(x) = 2.5*x - 1.5
	eq2(x) = (x+1)/2
	plt1 = plot(eq1,0,2,lab="")
	plot!(eq2,0,2,lab="") 
end

# ╔═╡ d19cac04-4277-46d8-8f87-f9dab4d055e6
md"""
### Método de Jacobi
Uma outra forma de encarar as equações do sistema é vê-las como fórmulas de como calcular uma das variáveis das soluções se conhecêssemos a outra. Isso fica claro se reorganizarmos um pouco as duas equações.

$\begin{align}
x &= (1.5 + y)/2.5 \\
y &= (1 + x)/2.
\end{align}$
A ideia do método de Jacobi é melhorar uma aproximação da solução que obtivemos até o momento $k$, que vamos denotar por $(x^k, y^k)$, usando essas duas equações como se elas estivessem partindo da solução exata. Isto é fazer

$\begin{align}
x^{k+1} &= (1.5 + y^k)/2.5 \\
y^{k+1} &= (1 + x^k)/2.
\end{align}$

Geometricamente, o que a primeira equação faz é encontrar a coordenada $x$ do ponto na reta azul que tem coordenada $y = y^k$, ou seja a intersecção da reta azul com uma reta paralela ao eixo x que passar por $(x^k, y^k)$. Já a segunda equação busca a coordenada $y$ do ponto na reta vermelha que cruza com uma reta vertical que passa também por $(x^k, y^k)$.

Para entender isso melhor, imagine que temos $(x^k, y^k) = (1.4, 1.3)$. O código abaixo representa as contas feitas a apresenta o novo ponto calculado bem como o ponto de partida. Note que o novo ponto se aproxima da solução que é a intersecção das retas.
"""

# ╔═╡ adc47a26-5820-4b6a-a17d-a020ea2df030
begin
	# Implementação
	xk, yk = 1.4, 1.3
	xk₊ = (1.5 + yk)/2.5 
	yk₊ = (1 + xk)/2
	scatter!(plt1,[xk, xk₊], [yk, yk₊],leg=false)
	deltax = xk₊:0.01:xk 
	deltay = yk₊:0.01:yk
	plot!(plt1, deltax, yk*ones(length(deltax)),c=:black,ls=:dash)
	plot!(plt1, deltax, yk₊*ones(length(deltax)),c=:black,ls=:dash)
	plot!(plt1,  xk₊*ones(length(deltay)), deltay ,c=:black,ls=:dash)
	plot!(plt1,  xk*ones(length(deltay)), deltay ,c=:black,ls=:dash)
end


# ╔═╡ 50da2ae6-387c-4e17-a6c5-6b3d33422b09
md"""
Podemos ainda continuar fazendo isso, gerando então uma sequencia e ver se ela se aproxima ou não da solução:
"""

# ╔═╡ 77350f6c-c0cc-4d37-b3b0-d4122f817345
# Implementação
function iteracao(xk₊, yk₊;k = 10)
	xk, yk = xk₊, yk₊
	for i in 1:k
		xk = (1.5 + yk)/2.5
		yk = (1 + xk)/2
	end
	return [xk, yk]
end
		


# ╔═╡ 06342a78-0735-4922-aada-1b82fcc0c9e4
norm(iteracao(xk, yk,k=5) - [1,1])

# ╔═╡ 46a4a97f-f307-4fcb-aeda-6303ceb2ffcb
md"""
É interessante brincar um pouco com o código acima variando o número de passos dados e o ponto de partida. Note também que o último ponto computado é impresso logo após o gráfico. Verifique como ele muda quando você muda os parâmetros sugeridos.

Vemos então que a ideia simples de Jacobi pode funcionar, pelo menos em alguns casos. Será possível identificar de antemão se o método funcionará ou não? Isso será o tema da subseção Análise de Convergência abaixo. Por enquanto vamos fazer mais um experimento.

O que ocorreria se o sistema tivesse as duas equações trocadas? Ou seja se ele fosse

$$\left\{ \begin{array}{rcrcl}
x &-& 2y &=& -1 \\
2.5x &-& y &=& 1.5. 
\end{array}\right.$$
Nesse caso as fórmulas de atualização seriam

$\begin{align}
x^{k+1} &= -1 + 2y^k \\
y^{k+1} &= 2.5x - 1.5.
\end{align}$

Podemos copiar a implementação do método acima com as devidas modificações para ver o que ocorre. Vamos agora marcar o ponto inicial na cor magenta para destacar um fenômeno interessante. Observe também que o ponto inicial está bem mais perto da solução. Ele é $(0.01, 0.01)$.
"""

# ╔═╡ 305a3754-cccc-4069-8473-ed52ff14c698
# Implementalçao

# ╔═╡ 4f4103d1-33c9-4eac-8e0d-ed36788852c6
md"""
O que observamos acima é um pouco surpreendente. A sequencia gerada pelo Método de Jacobi agora se afasta da solução. Isso ocorreu devido a simples troca da ordem das equações, o que mostra que o método é bastante sensível. Vamos entender isso melhor na seção sobre convergência abaixo. Ainda, destacamos que apesar de o método ter sido apresentado para o caso de duas equações e duas variáveis, a sua extensão para o caso com $n$ equações e variáveis é direta. Basta isolar a variável $i$ usando a linha $i$ e obtemos a fórmula geral.

$$x^{k+1}_i = \frac{b_i - \sum_{j = 1}^{i - 1} a_{ij} x^k_j - \sum_{j = i + 1}^{n} a_{ij} x^k_j}{a_{ii}},\ i = 1, \ldots, n.$$

Podemos também intrduzir uma pequena variação que busca melhorar o método de Jacobi. Para isso vamos escrever as fórmulas genéricas de Jacobi para um sistema de 3 variáveis e 3 equações com matriz associada $A = (a_{ij})$.

$\begin{align}
x^{k+1}_1 &= \frac{b_1 - a_{12} x^k_2 - a_{13}x^k_3}{a_{11}} \\
x^{k+1}_2 &= \frac{b_2 - a_{21} x^k_1 - a_{23}x^k_3}{a_{22}} \\
x^{k+1}_3 &= \frac{b_3 - a_{31} x^k_1 - a_{32}x^k_2}{a_{33}}.
\end{align}$

### Método de Gauss-Seidel

Observe que no momento que vamos calcular $x^{k+1}_3$ já temos as novas aproximações das duas primeiras coordenadas $x^{k + 1}_1$ e $x^{k + 1}_2$. Se o método estiver indo bem, temos a expectativas que essas aproximações sejam melhores que os valores de $x^k$. Então por que não aproveitá-los? Essa é a ideia do método de Gauss-Seidel. Nele as novas coordenadas já computadas são aproveitadas no cômputo da próxima coordenada. No caso de 3 variáveis teríamos:

$\begin{align}
x^{k+1}_1 &= \frac{b_1 - a_{12} x^k_2 - a_{13}x^k_3}{a_{11}} \\
x^{k+1}_2 &= \frac{b_2 - a_{21} x^{k+1}_1 - a_{23}x^k_3}{a_{22}} \\
x^{k+1}_3 &= \frac{b_3 - a_{31} x^{k+1}_1 - a_{32}x^{k+1}_2}{a_{33}}.
\end{align}$
Podemos também apresentar a versão geral do método de Gauss-Seidel, adaptando a fórmula geral do método de Jacobi acima.

$$x^{k+1}_i = \frac{b_i - \sum_{j = 1}^{i - 1} a_{ij} x^{k+1}_j - \sum_{j = i + 1}^{n} a_{ij} x^k_j}{a_{ii}},\ i = 1, \ldots, n.$$


Abaixo modificamos a implementação anterior do método de Jacobi para o sistema do início desta seção de modo usar a ideia de Gauss-Seidel. Note que a aproximação da solução obtida após um número fixo de iterações é melhor do que o método de Jacobi. Isso ocorre devido ao uso de informação mais recente à medida que as coordenadas são calculadas.
"""

# ╔═╡ b97ef960-45d6-40b6-8574-80005682e593
# Método de Gauss-Seidel


# ╔═╡ f191e877-b219-467a-87f8-06798f07391d
md"""
Porém o método sofre de problemas semelhantes ao de Jacobi. Uma simples troca da ordem das equações faz com que o método se afaste da solução ao invés de se aproximar. Vamos agora começar a estudar quando podemos garantir que um método converge à solução do problema.


Nessa seção vamos supor que a matriz do sistema

$$Ax = b$$
é inversível. Isso garante que o sistema tem solução única que vamos denotar por $x^*$. 

Como vimos, os métodos de Jacobi e Gauss-Seidel não tentam calcular uma solução diretamente. Eles tentam melhorar uma aproximação da solução cada vez mais, gerando uma sequencia $x^1, x^2, x^2, \ldots$. Quando podemos dizer que a solução obtida é suficiente boa? Quando podemos dizer que um método desses funciona?

>**Definição.** Seja $x^1, x^2, x^2, \ldots$, uma sequência gerada por um método iterativo. Dizemos que o método *converge* se existe $x^*$ solução do problema de interesse tal que a sequencia calculada $\{ x^k \}$ converge para $x^*$. Ou seja se a distância entre $x^k$ e $x^*$ converge para 0 (zero).

Nosso objetivo agora é apresentar condições que possam garantir que os métodos iterativos que estudamos convergem à solução $x^*$ do sistema $Ax = b$. Para isso vamos começar observando que uma forma interessante de se ver um método iterativo é como uma função que é calculada em uma aproximação $x$ do ponto desejado resultando em uma nova aproximação $x^+$ que é potencialmente melhor. Ou seja, podemos imaginar que um algoritmo pode muitas vezes ser descrito por uma função $\phi: \mathbb{R}^n \rightarrow \mathbb{R}^n$ e a regra

$$x^{k + 1} = \phi(x^k).$$
Caso tal função de iteração $\phi$ exista, é natural que ela tenha a propriedade de que se o ponto de partida já é a solução $x^*$ então a $\phi$ diga que "se deve ficar parado" para não perder a solução. Isto é

$$x^* = \phi(x^*).$$
Além disso, também é natural pedir que se o ponto não for uma solução então $\phi$ devolva um ponto diferente. Caso contrário método iterativo poderia ficar parado em cima de pontos que não são soluções. Isso em linguagem matemática é o mesmo que dizer que $\phi$ deve ter como único ponto fixo justamente a solução do problema de interesse.

Retomando o problema de sistemas lineares, vamos tentar re-escrever os métodos de Jacobi e Gauss-Seidel descobrindo a expressão da função $\phi$. Para isso é útil quebrar a matriz $A$ do sistema que desejamos resolver

$$A x = b$$
em três submatrizes. Vamos escrever $A = L + D + U$, em que $L$ contém os elementos abaixo da diagonal de $A$ (e tem zero na diagonal e acima dela), $D$ contém a diagonal de $A$ (e zero fora da diagonal) e $U$ possui os elementos que ficam acima da diagonal.

Retomando a formula do Jacobi.

$$x^{k+1}_i = \frac{b_i - \sum_{j = 1}^{i - 1} a_{ij} x^k_j - \sum_{j = i + 1}^{n} a_{ij} x^k_j}{a_{ii}},\ i = 1, \ldots, n,$$
podemos escrevê-la de forma mais compacta como

$$x^{k + 1} = D^{-1}(b - Lx^k - U x^k).$$
Reorganizando os termos temos

$$x^{k + 1} = -D^{-1}(L + U)x^k + D^{-1}b.$$
Isso sugere a função de iteração

$$\phi_J(x) = -D^{-1}(L + U)x + D^{-1}b.$$

No caso do método de Gauss-Seidel a situação é semelhante, porém um pouco mais interessante.

$\begin{gather}
x^{k + 1} = D^{-1}(b - Lx^{k+1} - U x^k) \iff \\
D x^{k + 1} = b - Lx^{k+1} - U x^k \iff \\
D x^{k + 1} + L x^{k + 1} = -Ux^k + b \iff \\
(D + L) x^{k + 1} = -Ux^k + b \iff \\
x^{k + 1} = -(D + L)^{-1}Ux^k + (D + L)^{-1}b.
\end{gather}$
Nesse caso a função de iteração é 

$$\phi_{GS}(x) = -(D + L)^{-1}Ux + (D + L)^{-1}b.$$

Nos dois casos vemos que a função de iteração pode ser escrita como 

$$\phi(x) = Bx + c,$$ 
em que $B$ é uma matriz e c um vetor constante. Também nos dois casos como $x^*$ é tal que $A x^* = b$ temos $\phi(x^*) = x^*$, como gostaríamos. Vamos ver isso no caso de Gauss-Seidel

$\begin{align}
\phi_{GS}(x^*) &= -(D + L)^{-1}Ux^* + (D + L)^{-1}b \\
               &= -(A - U)^{-1}Ux^* + (A - U)^{-1}b \\
               &= -(A - U)^{-1}Ux^* + (A - U)^{-1} A x^* \\
               &= (A - U)^{-1}(-U + A)x^* \\
&= x^*.\end{align}$



"""

# ╔═╡ 994d6967-ab00-4efe-93a2-fd3c14f1fc10
# Método de Gauss-Seidel


# ╔═╡ 29500930-27a2-430c-b5eb-463124cc96a9
md"""
## Convergência


A pergunta sobre a convergência dos métodos pode então ser repensada da seguinte forma: se $\phi(x)$ tem a expressão $Bx + c$, quando podemos garantir que o $\| x^k - x^* \|$ converge para $0$? Para isso façamos algumas manipulações simples

$\begin{align}
\| x^{k + 1} - x^* \|_\dagger &= \| \phi(x^k) - x^* \|_\dagger \\
                              &= \| \phi(x^k) - \phi(x^*) \|_\dagger \\
                              &= \| Bx^k + c - Bx^* - c \|_\dagger \\
                              &= \| B(x^k - x^*) \|_\dagger \\
                              &\leq \| B \|_\dagger \| x^k - x^* \|_\dagger.
\end{align}$
Na última passagem usamos a propriedade que relaciona a norma de matrizes com a respectiva norma de vetores.

Aplicando isso recursivamente vemos que 

$$\| x^{k + 1} - x^* \|_\dagger \leq  \| B \|_\dagger^k \| x^1 - x^* \|_\dagger.$$
Note que isso garante que $\| x^{k + 1} - x^* \|_\dagger \rightarrow 0$ sempre que $\| B \|_\dagger < 1$. Podemos imediatamente enunciar o seguinte resultado:

>**Teorema.** Considere que um sistema linear $Ax = b$ com solução única. Considere também um método iterativo descrito por uma função $\phi$ que tenha a solução do sistema como único ponto fixo. Se $\phi$ é descrita por $\phi(x) = Bx + c$ então o método converge sempre que $\| B \|_\dagger < 1$ para alguma das normas consideradas.

**Observação.** Note que acima não escrevemos "converge na norma $\| \cdot \|_\dagger$" mas simplesmente usamos "converge". Isso porque é fácil de provar, pelo menos paras as normas vistas nessa seção que se $\| x^k - x^* \|_\dagger \rightarrow 0$ para alguma das normas o mesmo ocorre para as outras. Isso ocorre porque é possível achar para cada par de normas uma constante, que geralmente depende da dimensão do espaço, tal que uma norma é menor do que essa constante vezes a outra.

O que esse teorema nos ensina sobre os métodos de Jacobi e Gauss-Seidel? Por exemplo, no caso do método de Jacobi, em que a matriz $B = -D^{-1}(L + U)$ podemos ver que

>**Teorema.** A matriz associada ao método de Jacobi $B = -D^{-1}(L + U)$ tem norma infinito menor estrita que $1$ se 
>
>$$| a_{ii} | > \sum_{j = 1, j \neq i}^n | a_{ij} |.$$

**Prova.** Lembremos que a norma infinito de uma matriz é a máxima norma 1 de suas linhas. Mas os elementos da linha $i$ de $B$ são exatamente 

$$b_{ij} = \begin{cases} \frac{a_{ij}}{a_{ii}},\ j = 1, \ldots, n, I \neq j \\ 0,\ i = j. \end{cases}$$
Assim, a norma 1 da linha $i$ de b é igual a

$$\sum_{\substack{j = 1\\ i \neq j}}^n \left| \frac{a_{ij}}{a_{ii}} \right| < 1.$$
A última desigualdade segue imediatamente da hipótese do teorema. Ou seja, todas as linhas de $B$ tem norma $1$ menor que $1$ e portanto $\| B \|_\infty < 1$. $\blacksquare$

**Observação.**  Uma matriz cujos elementos da diagonal superam em módulo somas dos módulos dos outros elementos da mesma linha é chamada de *matriz diagonal dominante por linhas*. O que o teorema diz é que o método de Jacobi converge se a matriz do sistema for diagonal dominante por linhas. Observe que esse resultado ajuda a entender porque a ordem das equações, que estão relacionadas às linhas da matriz, é importante para a convergência. Se a linha escolhilda para isolar o termo $x_i$ tiver a constante que multiplica essa variável muito pequena em módulo o método pode não convergir. Isso é exatamente o que ocorre quando trocamos as ordem das duas equações no sistema usando como exemplo anteriormente.

Acabamos essa seção com dois comentários e com um exemplo de implementação do método de Jacobi.

1. Pode-se mostrar que o critério de dominância por linhas também é válido para Gauss-Seidel.

1. O método de Gauss-Seidel é tipicamente mais rápido do que o de Jacobi. Porém ele estabelece uma ordem na qual as variáveis devem ser atualizadas e por isso é de paralelização mais difícil. Nesse sentido há problemas em que Jacobi ainda pode valer à pena se o ganho com seu palelismo inerente foi maior do que o ganho obtido por Gauss-Seidel por aproveitar os valores das vairáveis já atualizadas. Isso tem se tornado mais importante nos últimos anos em que o crescimento de poder computacional tem vindo mais do aumento do número de processadores do que no aumento de velocidade de cada unidade de processamento.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"

[compat]
DataFrames = "~1.2.2"
ForwardDiff = "~0.10.19"
LaTeXStrings = "~1.2.1"
Plots = "~1.21.1"
PlutoUI = "~0.7.9"
SpecialFunctions = "~1.6.1"
StatsPlots = "~0.14.26"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Arpack]]
deps = ["Arpack_jll", "Libdl", "LinearAlgebra"]
git-tree-sha1 = "2ff92b71ba1747c5fdd541f8fc87736d82f40ec9"
uuid = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
version = "0.4.0"

[[Arpack_jll]]
deps = ["Libdl", "OpenBLAS_jll", "Pkg"]
git-tree-sha1 = "e214a9b9bd1b4e1b4f15b22c0994862b66af7ff7"
uuid = "68821587-b530-5797-8361-c406ea357684"
version = "3.5.0+3"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "a4d07a1c313392a77042855df46c5f534076fab9"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.0"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c3598e525718abcc440f69cc6d5f60dda0a1b61e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.6+5"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "e2f47f6d8337369411569fd45ae5753ca10394c6"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.0+6"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "bdc0937269321858ab2a4f288486cb258b9a0af7"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.3.0"

[[Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "75479b7df4167267d75294d14b58244695beb2ac"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.14.2"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "9995eb3977fbf67b86d0a0a0508e83017ded03f2"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.14.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[DataValues]]
deps = ["DataValueInterfaces", "Dates"]
git-tree-sha1 = "d88a19299eba280a6d062e135a43f00323ae70bf"
uuid = "e7dc6d0d-1eca-5fa6-8ad6-5aecde8b7ea5"
version = "0.4.13"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[DiffResults]]
deps = ["StaticArrays"]
git-tree-sha1 = "c18e98cba888c6c25d1c3b048e4b3380ca956805"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.0.3"

[[DiffRules]]
deps = ["NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "3ed8fa7178a10d1cd0f1ca524f249ba6937490c0"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.3.0"

[[Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "abe4ad222b26af3337262b8afb28fab8d215e9f8"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.3"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns"]
git-tree-sha1 = "f389cb8974e02d7eaa6ae2ccedbbfb43174cd8e8"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.14"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "92d8f9f208637e8d2d28c664051a00569c01493d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.1.5+1"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "LibVPX_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3cc57ad0a213808473eafef4845a74766242e05f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.3.1+4"

[[FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "f985af3b9f4e278b1d24434cbb546d6092fca661"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.3"

[[FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3676abafff7e4ff07bbd2c42b3d8201f31653dcc"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.9+8"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "7c365bdef6380b29cfc5caaf99688cd7489f9b87"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.12.2"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "35895cf184ceaab11fd778b4590144034a167a2f"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.1+14"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "NaNMath", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "b5e930ac60b613ef3406da6d4f42c35d8dc51419"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.19"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "cbd58c9deb1d304f5a245a0b7eb841a2560cfec6"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.1+5"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "dba1e8614e98949abfa60480b13653813d8f0157"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+0"

[[GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "182da592436e287758ded5be6e32c406de3a2e47"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.58.1"

[[GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d59e8320c2747553788e4fc42231489cc602fa50"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.58.1+0"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7bf67e9a481712b3dbe9cb3dac852dc4b1162e02"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "44e3b40da000eab4ccb1aecdc4801c040026aeb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.13"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[Interpolations]]
deps = ["AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "61aa005707ea2cebf47c8d780da8dc9bc4e0c512"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.4"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IrrationalConstants]]
git-tree-sha1 = "f76424439413893a832026ca355fe273e93bce94"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.0"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "591e8dc09ad18386189610acafb970032c519707"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.3"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

[[LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[LibVPX_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "12ee7e23fa4d18361e7c2cde8f8337d4c3101bc7"
uuid = "dd192d2f-8180-539f-9fb4-cc70b1dcf69a"
version = "1.10.0+0"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "761a393aeccd6aa92ec3515e428c26bf99575b3b"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+0"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "3d682c07e6dd250ed082f883dc88aee7996bf2cc"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.0"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "c253236b0ed414624b083e6b72bfe891fbd2c7af"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2021.1.1+1"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "0fb723cd8c45858c22169b2e42269e53271a6df7"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.7"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "2ca267b08821e86c5ef4376cffed98a46c2cb205"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[MultivariateStats]]
deps = ["Arpack", "LinearAlgebra", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "8d958ff1854b166003238fe191ec34b9d592860a"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.8.0"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "16baacfdc8758bc374882566c9187e785e85c2f0"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.9"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Observables]]
git-tree-sha1 = "fe29afdef3d0c4a8286128d4e45cc50621b1e43d"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.4.0"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "c0f4a4836e5f3e0763243b8324200af6d0e0f90c"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.5"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7937eda4681660b4d6aeeecc2f7e1c81c8ee4e2f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "4dd403333bcf0909341cfe57ec115152f937d7d8"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "438d35d2d95ae2c5e8780b330592b6de8494e779"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.3"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "c67334c786157d6ef091ce622b365d3d60b1e2c4"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.12"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "0036d433cacff4767ff622be3cb2c281b773a2b4"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.21.1"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "cde4ce9d6f33219465b55162811d8de8139c0414"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.2.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "12fbe86da16df6679be7521dfb39fbc861e1dc7b"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.1"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Ratios]]
deps = ["Requires"]
git-tree-sha1 = "7dff99fbc740e2f8228c6878e2aad6d7c2678098"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.1"

[[RecipesBase]]
git-tree-sha1 = "44a75aa7a527910ee3d1751d1f0e4148698add9e"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.2"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "32efa73dece357e9c834cae8af00265752c80061"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.3.5"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "54f37736d8934a12a200edea2f9206b03bdf3159"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.7"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "LogExpFunctions", "OpenSpecFun_jll"]
git-tree-sha1 = "a322a9493e49c5f3a10b50df3aedaf1cdb3244b7"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.6.1"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3240808c6d463ac46f1c1cd7638375cd22abbccb"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.12"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "fed1ec1e65749c4d96fc20dd13bea72b55457e62"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.9"

[[StatsFuns]]
deps = ["IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "20d1bb720b9b27636280f751746ba4abb465f19d"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.9"

[[StatsPlots]]
deps = ["Clustering", "DataStructures", "DataValues", "Distributions", "Interpolations", "KernelDensity", "LinearAlgebra", "MultivariateStats", "Observables", "Plots", "RecipesBase", "RecipesPipeline", "Reexport", "StatsBase", "TableOperations", "Tables", "Widgets"]
git-tree-sha1 = "e7d1e79232310bd654c7cef46465c537562af4fe"
uuid = "f3b207a7-027a-5e70-b257-86293d7955fd"
version = "0.14.26"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "1700b86ad59348c0f9f68ddc95117071f947072d"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.1"

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableOperations]]
deps = ["SentinelArrays", "Tables", "Test"]
git-tree-sha1 = "019acfd5a4a6c5f0f38de69f2ff7ed527f1881da"
uuid = "ab02a1b2-a7df-11e8-156e-fb1833f50b87"
version = "1.1.0"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "d0c690d37c73aeb5ca063056283fde5585a41710"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll"]
git-tree-sha1 = "2839f1c1296940218e35df0bbb220f2a79686670"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.18.0+4"

[[Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "eae2fbbc34a79ffd57fb4c972b08ce50b8f6a00d"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.3"

[[WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "59e2ad8fd1591ea019a5259bd012d7aee15f995c"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.3"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "acc685bcf777b2202a904cdcb49ad34c2fa1880c"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.14.0+4"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7a5780a0d9c6864184b3a2eeeb833a0c871f00ab"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "0.1.6+4"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "c45f4e40e7aafe9d086379e5578947ec8b95a8fb"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d713c1ce4deac133e3334ee12f4adff07f81778f"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2020.7.14+2"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "487da2f8f2f0c8ee0e83f39d13037d6bbf0a45ab"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.0.0+3"

[[xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─7ac099ac-0aa4-11ec-014c-b7e75ef5ebf5
# ╠═2b0f8ca8-2bce-4784-9110-1fdbb18b27d0
# ╟─a983ec5b-2d81-4210-a1f1-5c478bcbbede
# ╟─f266e93d-3c65-4ef5-8e91-ee63ade7d39c
# ╠═93b645f3-0af2-467b-9cf0-dc7c36c1fa54
# ╠═f6d227ec-23c4-45bf-9621-c45f37bab0c8
# ╠═162ef5fa-5d89-4a4a-98fe-13afcebc69f4
# ╠═4d5b260c-b311-40fa-afc5-4f10a9f3d7b8
# ╠═b4085a60-69be-42f5-abad-50173d107e7c
# ╠═941f8135-fe39-4ed4-a391-0b1e617d3da3
# ╠═cdc1dfbe-45ec-4e67-aa1c-49a3de442153
# ╠═a953ea17-f22f-4880-b31a-e16e2d16f698
# ╠═043b30f0-3d40-4d87-bdfa-96158c8ee690
# ╠═4477ef3d-c3ae-4cde-9708-8a4ed292b194
# ╠═a30599d2-c700-4f6c-ad0f-707ab92c137a
# ╠═28d44316-c5ab-4b84-92f0-ec254734f323
# ╟─0de91742-2a39-42c6-8094-56602e0ac393
# ╠═ea520c60-558a-4542-9b05-0a44c868ddf2
# ╠═af88ce3b-cb74-4c8b-9a35-d719d53aec84
# ╠═709b1b0b-6ea4-4b6e-8cff-52bacc27af2f
# ╠═17cafa2e-0102-43d7-b923-3c20d322ba3a
# ╠═2079219f-043f-4d17-956c-d2665943b78a
# ╠═d5142365-3e56-4bc3-8294-2977e227243c
# ╠═0c284979-9e53-46c1-8775-4fb559b26c69
# ╠═edff7c0f-428b-443d-8fdb-4b0c87155550
# ╠═a01483ea-5ab4-4c55-84f9-faacda4217aa
# ╟─cf3d979e-7293-4b32-9afc-68184785ec89
# ╠═da3c023a-ddd3-4885-8ce7-8650c71b0abb
# ╠═274dd537-f7d6-4173-a9d9-d0bd98613cdd
# ╠═24666d56-e103-4949-b351-eeba9dd78cc3
# ╠═34cf2ada-1a97-45c7-b81a-cf11f763883f
# ╟─3b286a50-26d6-472c-8584-c3ea98464d8a
# ╠═8cf0c701-42b7-4a73-95d9-69437cc306be
# ╟─3b219946-200b-42b3-8481-780a0b21341c
# ╠═6763b10a-28c7-4b75-9018-cc0d04a6ff08
# ╠═9dbe3737-56f4-49f8-a923-9a1d7f561c7f
# ╟─8c7facd7-3a76-4e35-b8e8-f5e84d1bbef5
# ╠═99f6a0d9-18cd-4689-9127-4365b6e772bc
# ╠═ed52fe75-26d9-488b-9a41-eb4ca86d2d40
# ╠═06a54494-4b71-4bd7-8443-76f2f4bb4e6b
# ╠═686d1d28-c67a-45eb-b91c-73a472b669c4
# ╟─ec36911d-8e73-4d3c-bff5-566a111c00f5
# ╠═3e2ad1e9-7501-43bc-8a75-197e564a50c3
# ╠═f248faa7-8bbd-4638-af36-2953ee9ff6cc
# ╠═9fc810b3-e815-4988-98ed-119f3e47c2c0
# ╠═c7b066a3-4d2b-49da-9168-a412d2a07474
# ╠═f1120902-cea7-4d64-b896-f7e59f6ae9e1
# ╠═ff0e6e4c-3bdf-4091-9ec3-8703b432b046
# ╟─29ac9cc6-135f-4c09-8284-9618a93abb0f
# ╠═96b7683f-29ed-4ff3-82f2-fca950793cd6
# ╠═0c4fc7e4-4f09-454f-b21c-fa9952550f05
# ╠═bb87f148-afbb-4a7f-aa70-334a10fd093e
# ╠═43c230d2-ad37-465f-ac4b-3ad335894cce
# ╠═9e135f63-2388-4f31-a2ae-419e857a1633
# ╟─493b9408-fdd9-41e4-a073-f0a93a67ee6f
# ╠═83c15f2c-d266-4ec4-bcd3-a464615cf7ae
# ╠═1d57abfb-b54e-40c3-83c0-687ded116ab5
# ╠═1cca2a8d-4bf4-4fad-aa0c-8d5667bb963d
# ╠═feee670a-666e-4381-a863-273044e80ed8
# ╠═1c98a26f-8cf4-4820-bf97-be098a0c9c3b
# ╟─892b8d10-7591-4eb3-bf74-169126a2c885
# ╠═1a72d395-5891-4802-b35a-bae043d0ffaa
# ╟─d19cac04-4277-46d8-8f87-f9dab4d055e6
# ╠═adc47a26-5820-4b6a-a17d-a020ea2df030
# ╠═50da2ae6-387c-4e17-a6c5-6b3d33422b09
# ╠═77350f6c-c0cc-4d37-b3b0-d4122f817345
# ╠═06342a78-0735-4922-aada-1b82fcc0c9e4
# ╠═46a4a97f-f307-4fcb-aeda-6303ceb2ffcb
# ╠═305a3754-cccc-4069-8473-ed52ff14c698
# ╠═4f4103d1-33c9-4eac-8e0d-ed36788852c6
# ╠═b97ef960-45d6-40b6-8574-80005682e593
# ╠═f191e877-b219-467a-87f8-06798f07391d
# ╠═994d6967-ab00-4efe-93a2-fd3c14f1fc10
# ╟─29500930-27a2-430c-b5eb-463124cc96a9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
