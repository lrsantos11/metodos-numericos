### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ caf6c14d-86fb-4ae6-97c5-9e148810f977
using Plots

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

E a implementação direta dessa formula é dada abaixo.
"""

# ╔═╡ d242e2f1-48d1-4f11-a404-bbb90b4733f6
md"""
Problema resolvido. Parece que não há mais nada para fazer.

Mas se pensarmos um pouco é possível antecipar algumas situações em que a formula de Báskara pode sofrer de erros de cancelamento. Ela ainda é simples o suficiente para permitir alguma análise direta.

Observemos inicialmente que há duas somas, uma para achar o delta seguida de outra para achar as raízes. Infelizmente não se conhece uma forma de evitar o possível erro de cancelamento que pode surgir na fórmula do delta. Ele está associado a delta próximo de zero, ou seja $4ac$ negativo e com valor próximo a $b^2$. Vamos ver o que podemos fazer com a fórmula das raízes,

$x = \frac{-b \pm \sqrt{\Delta}}{2a}.$

Nela o valor de $-b$ será somando com valores positivos e negativos, ou seja necessariamente em um dos casos não há erro de cancelamento, pois os sinais serão iguais. Já quando $-b$ é positivo um possível erro de cancelamento ocorre quando calculamos $-b - \sqrt{\Delta}$. Caso $-b$ seja negativo a dificuldade pode ocorrer quando computamos $-b + \sqrt{\Delta}$. Além disso o cancelamento ocorre quando o $-b$ e $\sqrt{\Delta}$ tem módulos muito próximos. 

Vamos analisar com cuidado um caso particular. Inicialmente, vamos fixar $a = 1$, isso sempre pode ser feito dividindo a equação original por $a$. Vamos também supor que $b = -1$, assim $-b = 1$. Nesse caso a fórmula da raiz associada ao à situação de cancelamento é $1 - \sqrt{1 - 4c}$, que terá problemas para $c$ pequeno. Vamos ver se isso de fato ocorre. Para isso vamos usar o zero calculado com números `BigFloat` para comparação. O Julia permite que criemos números com qualquer precisão pré-definida usando esse tipo. O padrão é usar 256 bits de precisão, o que dá quatro vezes a precisão dupla que estamos mais acostumados. Se você quiser ainda mais bits de precisão basta usar a função `set_bigfloat_precision`. A desvantagem desse tipo de número é que as operações tornam-se muito mais lentas do que operações feitas com números do padrão IEEE 754, já que o `BigFloat` tem implementação feita por software.
"""

# ╔═╡ ab6d1a0d-ee3f-4f4c-bf22-8c8737787d95
# Implementação


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

# ╔═╡ Cell order:
# ╟─94f24f5a-d5f7-11eb-0c0d-5983bdf1822f
# ╠═caf6c14d-86fb-4ae6-97c5-9e148810f977
# ╟─b86c5fdf-7b7c-4566-8bcc-59f4be5004fc
# ╟─5a53346f-a40f-4b81-9d70-e1cd1ddf0690
# ╟─d242e2f1-48d1-4f11-a404-bbb90b4733f6
# ╠═ab6d1a0d-ee3f-4f4c-bf22-8c8737787d95
# ╟─e90056ae-60a6-47ea-a8d0-8d7383946f65
# ╠═1eb503e1-99b5-443f-a2b7-ad40ba807887
# ╟─12dfeb12-ddf1-4b98-920e-12b3f6e7a4bd
# ╠═a64cc299-bd61-4782-8fad-a738fab37a36
# ╟─923041ee-60dc-4934-b34e-636c7ed30f96
