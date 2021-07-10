### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 9bf79d09-0ea8-4370-9289-d2287dcef3a7
# Pacotes usados na aula!
begin
	using Plots, PlutoUI
	plotly() #Um backend para Gráficos mais iterativos
	using DataFrames, StatsBase, StatsPlots
end

# ╔═╡ 8076c3d8-6652-483c-87f8-4a446375b849
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 04 - Aula 03
"""

# ╔═╡ ad2160bd-8561-4087-a682-fc13722aea15
md"""
$\newcommand{\NN}{\mathbb{N}}$

# Equações não lineares

A resolução de equações não lineares surge naturalmente em diversas aplicações. Vamos começar com um exemplo simples. Considere que temos um canhão que dispara seus projéteis a uma velocidade inicial $v_0$. O objetivo é definir o ângulo $\theta$ de disparo para atingir um alvo que está a distância $d$ do canhão.

Nesse caso precisamos calibrar $\theta$ de forma a garantir que o projétil caia exatamente à distância dada. Dois fatores devem ser considerados. Logo após o disparo o projétil irá subir um pouco até a ação da gravidade inverter sua velocidade vertical ele começar a cair. O tempo total de voo é o tempo de subida mais o tempo de queda. Vamos considerar que apenas a força da gravidade age sobre o projétil, desconsiderando o efeito do atrito com o ar. Nesse caso temos que a aceleração vertical é constante igual $-g$, ou seja temos:

$\begin{align*}
y(0) = 0,\quad y'(t) = v_0 \sin(\theta), \quad y''(t) &= -g \Rightarrow \\
y(t) = 0 + v_0 \sin(\theta)t - \frac{g}{2} t^2.
\end{align*}$
O tempo total até o impacto será $T > 0$ é obtido resolvedo $y(t) = 0,\ t > 0$, que é dado por

$T = \frac{2v_0 \sin(\theta)}{g}.$

Já a distância horizontal pecorrida é dada por

$x(t) = v_0 \cos(\theta) t.$
De novo estamos desprezando o atrito com o ar.

O objetivo final é encontrar $\theta$ tal que $x(T) = d$. Ou seja queremos resolver a equação

$\frac{2 v_0^2 \sin(\theta) \cos(\theta)}{g} = d$
em função de $\theta$.

Em outras palavras, se definirmos

$f(\theta) = 2 v_0^2 \sin(\theta) \cos(\theta) - gd,$
desejamos encontrar $\theta$ tal que a equação não-linear

$f(\theta) = 0$
seja válida.

Apesar de essa equação admitir solução usando-se identidades trigonométricas, vamos encará-la como uma equação que não admite solução fechada. Nesse caso precisamos de um método que nos permita resolver equações gerais, além daquelas que conseguimos resolver manualmente usando manipulações algébricas. Esse é o objetivo das próximas aulas.

"""

# ╔═╡ b094d90d-ae3a-410d-b428-7dbf6e513209
md"""

# Estudo de equação lineares de uma variável

Como vimos anteriormente podemos ter interesse de resolver uma equação do tipo

$f(x) = 0,$
em que $f: \mathbb{R} \rightarrow \mathbb{R}$. Um $x$ que obedece à equação acima será chamado de uma zero ou raiz de $f$.

Vamos ver a seguir que isso pode ser resolvido por alguns métodos iterativos que irão encontrar soluções aproximadas dessa equação com precisão cada vez mais alta.

Inicialmente note que há algumas questões fundamentais que devem ser tratadas. Primeiro é preciso se perguntar se a equação tem solução. Se tal solução existir, ela é única? Vamos apresentar abaixo algumas condições matemáticas para isso. A situação mais confortável ocorre quando há solução e ela é única. Nesse caso não há dúvidas de qual o papel do método numérico: encontrar essa única raiz. Quando há mais de um zero a situação já não é tão clara. Será que todas as raízes têm sentido Físico? O método teria que encontrar todas as possíveis soluções? Isso é possível? Se o método for capaz de encontrar apenas uma solução, será que é possível escolher, ou guiar o algoritmo, para uma das raízes em particular? Quanto tempo o método demora para encontrar uma boa aproximação da, ou de uma, solução?

"""

# ╔═╡ 9f0f8a7d-5891-4384-98ed-56f8a3c6f1cd
md"""

## Existência e unicidade de soluções

Um resultado de cáculo fundamental para tratar da existência de soluções de uma equação não linear é o teorema de Bolzano, que é um corolário do

**Teorema de Valor Intermediário (TVI).** Seja $f: \mathbb{R} \rightarrow \mathbb{R}$ uma função contínua em um intervalo $[a, b] \subset \mathbb{R}$. Para todo $d$ entre $f(a)$ e $f(b)$, existe $c\in (a,b)$, tal que $f(c) = d$. 


**Teorema de Bolzano.** Seja $f: \mathbb{R} \rightarrow \mathbb{R}$ uma função contínua em um intervalo $[a, b] \subset \mathbb{R}$. Se $f(a)f(b) < 0$ então existe $c \in (a, b)$, tal que $f(c) = 0$.

Ou seja, se uma função contínua troca de sinal em um intervalo, então ela possui pelo menos um zero (nesse intervalo).

Por exemplo, seja a função

$f(x) = x^5 - 3x^3 - 2x + 1.$
Seu gráfico entre $[-2,2]$ mostra existência de três raízes.
"""

# ╔═╡ 8058826b-cebb-485f-88fa-55abda71743d
# Define a função
f(x) = x.^5 - 3.0*x.^3 - 2.0*x + 1.0

# ╔═╡ ff168e88-a44a-460a-8715-9a1d69c15953
f(-2)

# ╔═╡ f8e3a4a1-f787-4aad-9d0b-01ea740c0554
f(2)

# ╔═╡ 929c13b8-e931-4c11-85e1-e33143957ec2
f(-3)*f(3) < 0

# ╔═╡ 2e4b118a-e695-4dc1-8e80-76c3dce812fa


# ╔═╡ 46b773e1-6c10-44c5-9b51-513fe64d97ba
let # Escopo limitado
	# Define o intervalo
	x = range(-2,stop=2,length=100)
	# Desenha o gráfico e o eixo x.
	plot(x, f, label="y = f(x)", framestyle = :box)
	xlims!(-2,2)
	hline!([0.],  color=:black,label="", lw=2)
	scatter!([1.8509635925292969, 0.4054832458496094, -1.9194421768188477],zeros(3),label="")
end

# ╔═╡ 4e798009-e680-407a-b26b-28efbb0aacb9
md"""
 Note que entre $[1,2]$, temos $f(1)f(2)<0$, o que implica a existência de uma raiz neste intervalo. No entanto, essa condição é apenas uma *condição necessária* para a existência de zero. É claro que uma função pode ter o mesmo sinal nos extremos de um intervalo e mesmo assim ter zeros dentro dele. Considere o caso acima no intervalo $[-2, 1.5]$.

Já para garantir a unicidade é preciso exigir mais da função $f$. Uma hipótese razoável é que ela seja constantemente crescente ou decrescente dentro do intervalo. Para isso basta exigir que a derivada da função não troque de sinal.

**Teorema** Seja $f: \mathbb{R} \rightarrow \mathbb{R}$ diferenciável em um intervalo $[a, b] \subset \mathbb{R}$. Se $f(a)f(b) < 0$ e a derivada de $f$ tem sinal constante $(a, b)$, então existe um único $x \in (a, b)$, tal que $f(x) = 0$.

Aqui note que temos que considerar os valores da derivada em todo o intervalo e não apenas nos extremos.

"""

# ╔═╡ 83bcc891-9eb5-4b86-b1b8-528a5ef1bc9a
md"""

### Método da Bissecção

O teorema de Bolzano serve de ponto de partida para um primeiro método iterativo para resolução de equações não-lineares conhecido como bissecção. A ideia dele é simples. Imagine que $f$ é contínua e temos na mão um intervalo $[a, b]$ como no teorema. Isso quer dizer que temos certeza que existe uma raiz nesse intervalo. Uma aproximação razoável para essa raiz usando apenas essa informação é o ponto médio do intervalo. Aparentemente isso é tudo o que se pode fazer com essa informação.

Porém podemos também calcular a função nesse ponto médio $m = \frac{a + b}{2}$ e há três possibilidades:

1. Caso $f(m) = 0$, demos sorte. De fato o ponto médio é uma raiz que foi encontrada.

2. Sinal de $f(m)$ é o mesmo sinal de $f(a)$. Nesse caso podemos concluir, usando o teorema de Bolzano, que há uma raiz no intervalo $[m, b]$. Note que esse intervalo é bem menor que o original, tendo metade do seu comprimento.

3. Sinal de $f(m)$ é o mesmo sinal de $f(b)$. Nesse caso podemos concluir, usando o teorema de Bolzano, que há uma raiz no intervalo $[a, m]$. Note que esse intervalo é bem menor que o original, tendo metade do seu comprimento.
"""

# ╔═╡ 40086dd8-1808-4d35-92a4-9d7e7bf4d2fa
let
	x = range(1.5, 2.0, length = 100)
	p1 = plot(x, f, title="Caso 2", framestyle=:origin)
	p1 = hline!([0], color="black")
	p1 = ylims!(-4,4)
	y = range(0.01,0.75, length = 100)
	p2 = plot(y, f, framestyle=:origin,title="Caso 3")
	p2 = hline!([0], color="black")
	p2 = ylims!(-4,4)
	plot(p1,p2,layout = (1,2),legend=false)
end

# ╔═╡ 19d5ac06-bebf-4052-9031-2c013f51d1f9
md"""
Ou seja, ao avaliarmos  $f(x)$  conseguimos no mínimo melhorar a aproximação obtida, obtendo a cada passo um intervalo cada vez menor, dividindo o seu tamanho por 2. Note que o ponto médio do intervalo está à distância máxima de $\dfrac{b - a}{2}$ de uma raiz real do problema, já que existe raiz no intervalo. Dessa forma é natural parar o método quando a largura do intervalo for pequena o suficiente para aceitar o ponto médio como uma boa aproximação da raiz.

Isso sugere o seguinte método:
"""

# ╔═╡ b5f3881f-c886-4365-bd91-7da8d983c940
# Método da bissecção
function bissec(f, a, b; ε = 1.0e-5, itmax = 1_000)
	f(a)*f(b) < 0. ? nothing : error("Não temos certeza  de existência de raiz da função no intevalo [$a, $b]")
	k = 0
	aₖ = a
	bₖ = b
	while k ≤ itmax
		xₖ = (aₖ + bₖ)/2
		fₖ = f(xₖ)
		if abs(fₖ) < ε
			return xₖ, k, abs(fₖ), :Conv
		end
		if f(aₖ) * fₖ < 0
			bₖ = xₖ
		else
			aₖ = xₖ
		end
		k += 1	
	end
	return xₖ, k, :MaxIter	
	
end

# ╔═╡ cbda75f8-1fd2-41c8-bfc7-4a10642be15a
bissec(x->x^2-1, -1.7,.5)

# ╔═╡ 26c5e4e6-6ce7-433f-a3bf-5216d1e90814
md"""
- Resolvendo pelo método da bissecção para a função

$f(x) = x^5 - 3x^3 - 2x + 1.$
entre $[-1,1]$.
"""

# ╔═╡ 628d6924-df50-4ceb-b196-499c0d217281
# Testando função do incíio
sol1, k1, normsol, status1 = bissec(f,-1, 1, ε = 1e-8)

# ╔═╡ bcd4d09d-2ef0-4074-b0d3-07fcbae43581
md"""
#### Tarefa
- Resolva o problema do início do texto, isto é, encontrar zero de $f(\theta) = 2 v_0^2 \sin(\theta) \cos(\theta) - gd$.

"""

# ╔═╡ 9e9b0019-6f59-460a-a5c7-7b865d18adf4
# Dados para Tarefa
begin
	v0 = 12
	d = 10
	g = 9.80665
end

# ╔═╡ d2657e39-d90d-47f8-8974-8cc5bda8e983
md"""
### Convergência

Uma característica interessante do método da bissecção é que ele pede usa apenas os valores da função em alguns pontos para decidir o que fazer. Além disso o seu comportamento é bem previsível. O comprimento do intervalo é dividido por 2 a cada iteração. Assim podemos prever quantas iterações serão necessárias para terminar o método como função do comprimento inicial e da precisão, `epsilon`, desejada. 

Note que cada $x_n$ pode ser dado por

$x_n:=\frac{a_n+b_n}{2}, \forall n \in \mathbb{N}.$
 
Note que a cada novo intervalo $[a_n,b_n]$ é tal que $b_n-a_n$ é igual $\frac{b_{n-1}-a_{n-1}}{2}$, já que usamos na definição do novo intervalo o ponto médio $x_{n-1}$. Segue que
  
$b_n-a_n=\frac{b_0-a_0}{2^n}, \forall n\in \mathbb{N}.$

Seja a sequência $(x_n)_{n \in\mathbb{N} }$ tal que $x_n:=\frac{b_0-a_0}{2^n}$. 

Quando $n\to\infty$, temos que $x_n \to 0$. Além disso, $|x_n-x^*|<x_n, \forall n \in \mathbb{N}$, então a sequência positiva $(|x_n-x^*|)_{n \in \mathbb{N}}$  convergirá também para $0$. Isso significa que $x_n \to x^*$.


"""

# ╔═╡ Cell order:
# ╟─8076c3d8-6652-483c-87f8-4a446375b849
# ╠═9bf79d09-0ea8-4370-9289-d2287dcef3a7
# ╟─ad2160bd-8561-4087-a682-fc13722aea15
# ╟─b094d90d-ae3a-410d-b428-7dbf6e513209
# ╟─9f0f8a7d-5891-4384-98ed-56f8a3c6f1cd
# ╠═8058826b-cebb-485f-88fa-55abda71743d
# ╠═ff168e88-a44a-460a-8715-9a1d69c15953
# ╠═f8e3a4a1-f787-4aad-9d0b-01ea740c0554
# ╠═929c13b8-e931-4c11-85e1-e33143957ec2
# ╠═2e4b118a-e695-4dc1-8e80-76c3dce812fa
# ╟─46b773e1-6c10-44c5-9b51-513fe64d97ba
# ╟─4e798009-e680-407a-b26b-28efbb0aacb9
# ╟─83bcc891-9eb5-4b86-b1b8-528a5ef1bc9a
# ╟─40086dd8-1808-4d35-92a4-9d7e7bf4d2fa
# ╟─19d5ac06-bebf-4052-9031-2c013f51d1f9
# ╠═b5f3881f-c886-4365-bd91-7da8d983c940
# ╠═cbda75f8-1fd2-41c8-bfc7-4a10642be15a
# ╟─26c5e4e6-6ce7-433f-a3bf-5216d1e90814
# ╠═628d6924-df50-4ceb-b196-499c0d217281
# ╟─bcd4d09d-2ef0-4074-b0d3-07fcbae43581
# ╠═9e9b0019-6f59-460a-a5c7-7b865d18adf4
# ╟─d2657e39-d90d-47f8-8974-8cc5bda8e983
