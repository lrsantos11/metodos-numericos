### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ caf6c14d-86fb-4ae6-97c5-9e148810f977
# Ferramentas úteis para a aula!
begin
	using Plots
	Eᵣ(xh,x) = abs(x - xh) / abs(xh) # erro relativo
end

# ╔═╡ 94f24f5a-d5f7-11eb-0c0d-5983bdf1822f
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 03 - Aula 01
"""

# ╔═╡ b86c5fdf-7b7c-4566-8bcc-59f4be5004fc
md"""
$\renewcommand{\fl}{\operatorname{fl}}$
# Aritimética de Ponto Flutuante (continuação)

"""

# ╔═╡ 5a53346f-a40f-4b81-9d70-e1cd1ddf0690
md"""
### Um exemplo mais sofisticado de camcelamento numérico

Um exemplo mais sofisticado aparece quando resolvemos equações do segundo grau. Nesse caso sabemos que as raízes desejadas podem ser obtidas através da fórmula de Báskara. Se queremos as raízes de $ax^2 + bx + c = 0$, calculamos

$\Delta = b^2 - 4ac,\quad\quad x = \frac{-b \pm \sqrt{\Delta}}{2a}.$

A implementação direta dessa formula é dada abaixo.
"""

# ╔═╡ b78b3380-93fa-4ce6-9626-90f5bd8f13d9
function raizes(a,b,c)
	
	
end

# ╔═╡ 0dbde1de-bbdd-441a-beea-2d74c1479098
raizes(1.0,-11.5,15)

# ╔═╡ d242e2f1-48d1-4f11-a404-bbb90b4733f6
md"""
Se pensarmos um pouco é possível antecipar algumas situações em que a formula de Báskara pode sofrer de erros de cancelamento. Ela ainda é simples o suficiente para permitir alguma análise direta.

Observemos inicialmente que há duas somas, uma para achar o delta seguida de outra para achar as raízes. Infelizmente não se conhece uma forma de evitar o possível erro de cancelamento que pode surgir na fórmula do delta. Ele está associado a delta próximo de zero, ou seja $4ac$ negativo e com valor próximo a $b^2$. Vamos ver o que podemos fazer com a fórmula das raízes,

$x = \frac{-b \pm \sqrt{\Delta}}{2a}.$

0  valor de $-b$ será somando com valores positivos e negativos, ou seja necessariamente em um dos casos não há erro de cancelamento, pois os sinais serão iguais. Já quando $-b$ é positivo um possível erro de cancelamento ocorre quando calculamos $-b - \sqrt{\Delta}$. Caso $-b$ seja negativo a dificuldade pode ocorrer quando computamos $-b + \sqrt{\Delta}$. 

- O cancelamento ocorre quando o $-b$ e $\sqrt{\Delta}$ tem módulos muito próximos. 
---
"""

# ╔═╡ 66907e20-2706-44a8-b07f-b2dc35142bfe
md"""
Vamos analisar com cuidado um caso particular. Fixando $a = 1$, (isso sempre pode ser feito dividindo a equação original por $a$). Vamos também supor que $b = -1$, assim $-b = 1$. Nesse caso a fórmula da raiz associada ao à situação de cancelamento é $1 - \sqrt{1 - 4c}$, que terá problemas para $c$ pequeno. Vamos ver se isso de fato ocorre. 

- Para isso vamos usar o zero calculado com números `BigFloat` para comparação. 

- O Julia permite que criemos números com qualquer precisão pré-definida usando esse tipo. O padrão é usar 256 bits de precisão, o que dá quatro vezes a precisão dupla que estamos mais acostumados. 

- Se você quiser ainda mais bits de precisão basta usar a função `set_bigfloat_precision`. 

- **Desvantagem**: as operações tornam-se muito mais lentas do que operações feitas com números do padrão IEEE 754, já que o `BigFloat` tem implementação feita por software.
"""

# ╔═╡ ab6d1a0d-ee3f-4f4c-bf22-8c8737787d95
# Implementação
function raizes_big(a,b,c)
	a, b, c = BigFloat(a), BigFloat(b), BigFloat(c)
	r₁, r₂ = raizes(a,b,c) 
	return float(r₁), float(r₂)
end

# ╔═╡ 0de73c84-e8f9-4718-800a-0cf3d88d308a
# Coeficientes que definem o polinômio

# ╔═╡ 09ed8af2-4320-44d4-847e-ec693cbb43d1
# Calcula as raízes de polinomios e guarda os resultados para comparar.

# ╔═╡ 4e934350-6e4d-4c39-b060-07c500ca25b3
# Gráfico: valor de c vs  -log10 do erro relativo

# ╔═╡ e90056ae-60a6-47ea-a8d0-8d7383946f65
md"""
Uma bela figura mostrando que a precisão cai com $c$ próximo de zero, chegando a ter no mínimo quase 5 casas corretas apenas.

A pergunta importante é: como evitar isso? De fato se quiséssemos calcular a raiz maior, próximo de 1, não teríamos problema. Veja isso mudando o sinal da comparação para escolha da raiz no programa acima (troque `minimum` por `maximum`). A ideia agora é usar a raiz boa para estimar a outra. Como fazer isso? Lembremos que

$x^2 + bx + c = (x - r_1)(x - r_2) = x^2 - (r_1 + r_2)x + r_1 r_2,$

em que $r_1$ e $r_2$ denotam as raízes. Portanto se conhecemos uma raiz, digamos $r_1$, podemos calcular a outra pela expressão

$r_2 = \frac{c}{r_1}$
que não envolve nenhuma soma ou subtração, logo não há erro de cancelamento.

Vamos usar esse fato em uma versão alternativa para o cálculo de raízes.
"""

# ╔═╡ 1eb503e1-99b5-443f-a2b7-ad40ba807887
# Implementação


# ╔═╡ 12dfeb12-ddf1-4b98-920e-12b3f6e7a4bd
md"""
Repetindo o teste acima
"""

# ╔═╡ a64cc299-bd61-4782-8fad-a738fab37a36
# Implementação

# ╔═╡ 923041ee-60dc-4934-b34e-636c7ed30f96
md"""
Note como a precisão se mantém constante, entre 15 e 16 casas decimais, que é tudo o que pode se esperar de cálculos em precisão dupla. O problema, pelo menos nesse caso foi completamente sanado.

"""

# ╔═╡ 1ced6850-94a8-432f-8f93-e8df5adfcf78
md"""
## Misturando números de ordem diferente

- Outra situação em que ocorre a perda de dígitos significativos em operações de soma/subtração é quando combinamos números com ordens de grandeza diferentes. 

- Um caso radical disso é quando tentamos somar a um número outro valor de módulo menor que o épsilon da máquina vezes o módulo do número. Nesse caso, não importa o quão complicado seja o  número menor, o o resultado vai simplesmente repetir o de maior módulo. 

- Isso vem diretamente da forma de representação de números de ponto flutuante e da definição do épsilon da máquina. 


"""

# ╔═╡ 8c162e05-c478-42b9-b157-fef8a546f5fe
# épsilon da máquina em relação à π
eps_π = eps(Float64(π))

# ╔═╡ c37b0c47-c39c-4576-9187-4ed89e76610f
md"""
Se isso ocorrer uma única vez não há grande problema, a resposta obtida é uma ótima aproximação do valor real. Mas isso pode ser um problema se queremos somar um número grande a vários valores pequenos. Nesse caso os dígitos menos significativos dos números pequenos vão sendo esquecidos durante a soma com o grande a cada soma. Já se os números pequenos fossem somados juntos poderia ocorrer de eles todos combinados terem um valor mais representativo com relação ao valor maior.

Para deixar isso mais claro vamos mostrar um exemplo. Sabemos que a somatória

$\sum_{k = 1}^\infty \frac{1}{k^2} = \frac{\pi^2}{6}.$
Podemos estar interessados em verificar isso experimentalmente no computador fazendo uma soma parcial, mas com grande número de termos. 

Isto é feito na forma mais natural pela rotina abaixo.
"""

# ╔═╡ c11c3f1e-9369-4bbd-acf4-c15ea56d8169
# Implementação
function soma_crescente(N)
	
end

# ╔═╡ d1eadb0f-c0a5-44fa-8559-8a5f449f1da5
md"""
##### Observações
- No código acima a variável `soma` é inicializada com `0.0f0` que é o $0$ de precisão simples. Usamos precisão simples para ver os problemas mais facilmente. 
- De uma maneira geral, para Julia, uma constante numérica do tipo `1.5` é um número de precisão dupla (é o caso de todos os números são em geral). 
- Para forçar a criação de números com precisão simples precisamos usar a função `Float32` ou deixar claro que a constante é desse tipo com a letra `f` em uma representação em notação científica do número. 
- Se no lugar de `f` aparece o usual `e` a constante seria intepretada como um `Float64` ou seja um número de precisão dupla. 

"""

# ╔═╡ 578f979b-19ac-4238-bdc7-7f61bdf4f2a6
md"""
- Qual a precisão da função `soma_crescente`?
"""

# ╔═╡ 2e22a8a1-bdf2-4978-813f-e4112f71dced
# Implementação
# Calcular os erros relativos para valores de N como potências de 2 de 1 a 2^30. 


# ╔═╡ 583a77d9-3ab6-4f80-abd2-9cc151d24b6e
md"""
- Note que nessas somas, quando $k$ é grande, então $1/k^2$ é muito pequeno em relação a parte inicial da soma já calculada, que iniciou em 1 e cresce. Assim, a partir de um certo ponto os valores $1/k^2$ não importam mais. 
- Com isso você pode ver que a precisão atingida com números de precisão simples chega apenas a 4 casas, ao invés das 8 casas esperadas. 

Vamos agora ver o que ocorre se fizermos a soma do menor número para o maior.
"""

# ╔═╡ bf0a3392-f48a-4549-9f37-a690fe0ded11
# Implementação
function soma_decrescente(N)
	
end

# ╔═╡ 7f1341a8-abe7-4fc7-969d-ce2295ee519f
# Gráfico

# ╔═╡ a2694189-321d-4488-bb43-bd3c69dd4e87
md"""
Observe que seguindo a ordem decrescente a precisão máxima para números de precisão simples, de 8 casas, é atingida.
"""

# ╔═╡ Cell order:
# ╟─94f24f5a-d5f7-11eb-0c0d-5983bdf1822f
# ╠═caf6c14d-86fb-4ae6-97c5-9e148810f977
# ╟─b86c5fdf-7b7c-4566-8bcc-59f4be5004fc
# ╟─5a53346f-a40f-4b81-9d70-e1cd1ddf0690
# ╠═b78b3380-93fa-4ce6-9626-90f5bd8f13d9
# ╠═0dbde1de-bbdd-441a-beea-2d74c1479098
# ╟─d242e2f1-48d1-4f11-a404-bbb90b4733f6
# ╟─66907e20-2706-44a8-b07f-b2dc35142bfe
# ╠═ab6d1a0d-ee3f-4f4c-bf22-8c8737787d95
# ╠═0de73c84-e8f9-4718-800a-0cf3d88d308a
# ╠═09ed8af2-4320-44d4-847e-ec693cbb43d1
# ╠═4e934350-6e4d-4c39-b060-07c500ca25b3
# ╟─e90056ae-60a6-47ea-a8d0-8d7383946f65
# ╠═1eb503e1-99b5-443f-a2b7-ad40ba807887
# ╟─12dfeb12-ddf1-4b98-920e-12b3f6e7a4bd
# ╠═a64cc299-bd61-4782-8fad-a738fab37a36
# ╟─923041ee-60dc-4934-b34e-636c7ed30f96
# ╠═1ced6850-94a8-432f-8f93-e8df5adfcf78
# ╠═8c162e05-c478-42b9-b157-fef8a546f5fe
# ╟─c37b0c47-c39c-4576-9187-4ed89e76610f
# ╠═c11c3f1e-9369-4bbd-acf4-c15ea56d8169
# ╟─d1eadb0f-c0a5-44fa-8559-8a5f449f1da5
# ╟─578f979b-19ac-4238-bdc7-7f61bdf4f2a6
# ╠═2e22a8a1-bdf2-4978-813f-e4112f71dced
# ╟─583a77d9-3ab6-4f80-abd2-9cc151d24b6e
# ╠═bf0a3392-f48a-4549-9f37-a690fe0ded11
# ╠═7f1341a8-abe7-4fc7-969d-ce2295ee519f
# ╟─a2694189-321d-4488-bb43-bd3c69dd4e87
