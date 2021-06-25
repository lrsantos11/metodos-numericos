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
###### Semana 02 - Aula 03
"""

# ╔═╡ b86c5fdf-7b7c-4566-8bcc-59f4be5004fc
md"""
$\renewcommand{\fl}{\operatorname{fl}}$
# Aritimética de Ponto Flutuante

## Introdução

O computador é uma máquina finita, feita a partir de um número finito de objetos e capaz de armazenar e manipular um número finito de dados. Fica então a dúvida: como ele pode armazenar ou fazer contas com números que não admitem representação finita, como os números irracionais?  Como se pode calcular o $\sin(\pi)$ se o computador não pode armazenar o $\pi$, pelo menos não completamente? Isso não pode ser feito exatamente.

O que se pode fazer então é **armazenar** uma aproximação de $\pi$, uma aproximação muito boa, que será usada no lugar do número verdadeiro. Para a grande maioria das situações isso é bom o suficiente. O objetivo dessa primeira parte do curso é discutir um pouco sobre como o computador guarda os números, que tipo de garantia podemos esperar na qualidade das aproximações feitas e que problemas podem surgir devido a essas aproximações. Isso é especialmente importante quando lembramos que podemos executar milhões, ou até bilhões de operações em sequência, cada uma com um pequeno erro. Esses erros se acumulam? Eles se cancelam?

Primeiros vejamos o que é $\pi$ para o computador:
"""

# ╔═╡ 00668afc-b4b2-4d70-8ac0-32da4844f686
Float64(π)

# ╔═╡ 960cec6b-6cf0-44b8-b3b2-76efa5a53080
md"""
Como você pode vê o computador armazena uma boa aproximação do número, acima são mostrados os primeiros 16 dígitos significativos e estão todos corretos. Veremos abaixo porque.



## Origem dos erros

Mas de onde podem vir os erros? Podemos destacar pelo menos 4 fontes naturais de erros que enfrentamos no dia-a-dia:

1. *Erro de aquisição ou medida*: ocorre quando precisamos medir ou estimar algo. Essa é a situação que vocês encontram no laboratório de Física, por exemplo.

1. *Erro de representação*: imagine que você quer usar um número decimal com um grupo finito de dígitos para representar o fração $\frac{1}{3}$. Como ela é uma dízima periódica isso é impossível de ser feito e o erro será grande ou pequeno de acordo com o número de casas armazenadas.

1. *Erro associado a cálculos com precisão finita*: Esse erro aparece quando queremos realizar uma operação sobre números já representados e o resultado não pode ser representando. Por exemplo, queremos dividir 1 por 3. Note que muitas vezes desejamos realizar vários, mesmo milhões ou bilhões de cálculos em sequencia, e cada um deles tem o potencial de gerar erros. Como já disse esse é o principal tipo de erro que iremos estudar.

1. *Erro associado a algoritmos que aproximam soluções (métodos iterativos)*: Infelizmente não há fórmula finita para o cálculo exato das soluções de muitos problemas matemáticos. O caso mais clássico é o cômputo de raízes de polinômio de grau maior ou igual a 5. Nesse caso lançamos mão de métodos iterativos que tentam aproximar a solução desejada através de um processo potencialmente infinito. Veremos exemplos disso no curso. Mas não temos como esperar tempo infinito para que o processo atinja o valor desejado. Nesse caso paramos a execução do programa uma vez que uma aproximação aceitável do valor desejado tenha sido obtida e guardamos essa aproximação.



"""

# ╔═╡ e12e8462-4280-42d9-a995-b52480e47dd2
md"""
# Representação de números no computador

Para armazenar números no computador adotou-se um sistema que busca diminuir espaços vazios entre os números representados de forma relativa. Esse sistema é conhecido como *representação de ponto flutuante*. A ideia é guardar uma quantidade fixa de *dígitos significativos* (ignorando possíveis zeros à esquerda que não dizem nada) e um outro número dizendo onde está a vírgula, ou o ponto em inglês e daí o nome, *ponto flutuante*. Mais precisamente um sistema de ponto flutuante é caracterizado basicamente por três quantidades:

1. Uma *base* $b$. No computador essa base é tipicamente $2$ (base binária). Mas nos nossos exemplos em sala iremos usar a base $10$ que é mais usual para nós, humanos.

1. A quantidade de números (dígitos na base) armazenados. Os dígitos armazenados são conhecidos como *mantissa* e denotada por $m$. Para evitar duplicidade de representação é importante definir exatamente a forma da mantissa. Uma escolha comum é considerar que a mantissa é um número que tem o primeiro dígito nulo, depois a vírgula seguida de pelo menos um dígito não nulo. Ou seja a mantissa deve ser um número cujo módulo pertence a $[0.1, 1)$.

1. A quantidade mínima e máxima de um inteiro, chamado de *expoente*, que é usado para dizer em que posição está a vírgula, denotado por $e$.

$x = \pm(0.d_1d_2d_3\ldots d_{m-1}d_{m})\times b^e$
em que $d_1\neq 0$.

Para deixar isso mais claro vamos definir um sistema simples em base decimal e ver que tipo de números podem ser representados.

1. Base 10.

1. A mantissa guarda 4 dígitos.

1. O menor expoente é -99 e o maior 99.

Imagine que queremos representar o número 0.034. Seguindo as regras e escolha descritas acima esse número será representado pela mantissa $0.3400$ (note que o número é  estritamente menor que $1$ e maior ou igual a $0.1$) e expoente $$-1$$. Ou seja representamos 
- $$0.034 = 0.3400\cdot10^{-1}.$$

A unicidade da representação evita dúvidas e desperdício com múltiplas representações para o mesmo número.

E como seria representado o nosso amigo $\pi$? Vamos relembrar o seu valor.

"""

# ╔═╡ 24c6e582-1e1e-435a-b0e6-4fc9f7d4c3b1
BigFloat(π) #Mais casas decimais corretas.

# ╔═╡ 9a63e356-911c-478a-ab08-34d3a163ce07
md"""
A melhor representação que podemos obter é
```math
\pi \approx 0.3141 \cdot 10^1.
```

Note que em particular o menor número representável em módulo no nosso sistema é $0.1000 \cdot 10^{-99}$ e o maior $0.9999 \cdot 10^{99}$.

Agora qual é o sistema de ponto flutuante adotado no computador? Quase todas as máquinas modernas implementam o padrão IEEE 754. Ele define dois tipos básicos de números. Números de precisão simples (o `float` de C), ocupam 32 bits divididos entre 1 bit para o sinal, 8 bits para o expoente e 23 para mantissa. Já a precisão dupla (o `double` de C) usa um bit para o sinal, 11 para o expoente e 52 para a mantissa totalizando 64 bits. 

Em base decimal isso nos dá, em precisão dupla, um número com aproximadamente 15 casas decimais na mantissa e expoente indo de -1022 a 1023. Quem quiser mais informações sobre o padrão IEEE 754 pode consultar esse [texto](http://steve.hollasch.net/cgindex/coding/ieeefloat.html).

Um fato interessante em sistemas de ponto flutuante é que há buracos entre os números representáveis, já que existe um número finito deles. Isto sifingica que que nem todos os números reais tem representação em sistemas de ponto flutuante. Isso vai ocasionar algumas situações interessantes como, por exemplo, o fato de que o elemento neutro da soma não é único.

Em particular depois do número 1 (que é representável usando mantissa 0,1 e expoente 1) há um primeiro próximo número representável. O que ocorre se tentarmos somar ao 1 um número tão pequeno que a soma resultante esteja mais perto do 1 do que desse próximo número? Vamos querer que a resposta seja o próprio 1, já que esse é o número representável mais próximo da resposta correta. Ou seja, se $u$ é pequeno vamos querer que o computador devolva como resultado da operação
```math
1 + u
```
o próprio 1! Vamos normalmente denotar os resultados calculados pelo computador através do operador $\fl$. Usando essa notação vemos que para $u$ pequeno
```math
\fl(1 + u) = 1.
```
"""

# ╔═╡ 292b079c-3adc-4a7a-9966-ff2a368afa96
1 + eps()

# ╔═╡ 6bd08fe7-2bcd-4e85-b883-5c8ab4ed44c8
1 + eps()/2

# ╔═╡ a6324f07-427b-4ffa-ae66-ddd823bb2fc9
md"""
Vamos chamar de *unidade de arredondamento*, ou *epsilon da máquina*, denotado por $\epsilon_{mac}$, o menor número para o qual ainda resulta que $\operatorname{fl}(1 + \epsilon_{mac}) > 1$. Isso é, basicamente, a metade da distância entre o 1 e o próximo número representável. Esse número nos dá uma ideia de quantas casas de precisão o nosso sistema tem. Em particular no caso do padrão IEEE 754 temos as unidades de arredondamento:

1. Precisão simples: $\epsilon_{mac} \approx 1.19209 \cdot 10^{-7}$.

1. Precisão dupla: $\epsilon_{mac} \approx 2.22045 \cdot 10^{-16}$.

O padrão IEEE 754 além de definir esses dois sistemas de ponto flutuante obriga ainda que as operações aritméticas básicas sejam realizadas de modo a garantir que o valor obtido ao final é a melhor representação possível do valor exato. Isso é, dados dois números representáveis $x_1$ e $x_2$ o sistema IEEE 754 exige que o computador implemente a sua versão da soma, que vamos representar por $\oplus$, de modo que $x_1 \oplus x_2$ seja o número representável mais próximo de $x_1 + x_2$. Em particular, isso garante que o erro

$| (x_1 \oplus x_2) - (x_1 + x_2) | \leq \epsilon_{mac} |x_1 + x_2|$

Ou seja, o erro relativo ao se fazer a operação de soma como implementada seguindo ao padrão IEEE 754 é no máximo $\epsilon_{mac}$. Isso não vale apenas para a operação de soma, vale para todas as operações aritméticas fundamentais que são soma, subtração, multiplicação, divisão e cálculo da raiz quadrada.

"""

# ╔═╡ b9844f13-c267-4eae-b0fd-69a3d2915c71
md"""
## Erros de cancelamento

Quando ficamos sabendo da propriedade descrita acima, isto, é que o computador implementando o padrão IEEE 754 é capaz de garantir a execução das operações básicas com erro relativo máximo proporcional ao epsilon da máquina, ficamos com a impressão que essas operações não são capazes de gerar muitas dificuldades numéricas. Afinal de contas, para números de precisão dupla, isso dá impressão que os valores calculados estarão corretos pelo menos até a décima quinta casa. Parece mais do que o suficiente. Porém há um caso, que muitas vezes ignoramos em uma primeira leitura, que pode trazer muitos problemas. O fenômeno é conhecido como *erro de cancelamento*. Vamos ver primeiro um exemplo em que ele ocorre e depois discutir o que ocorreu.

Considere que queremos calcular $49213 + 31.728 − 49244 = 0.728$ em um computador com sistema decimal e cinco casas na mantissa. Note que, como todos os números da conta original têm cinco casas, parece que não estamos pedindo nada demais. A primeira operação executada obtém

$\operatorname{fl}(49213 + 31.728) = \operatorname{fl}(49244.728) = 49245.$ 

Note o resultado final armazenado é tão bom como prometido. Ele tem cinco casas corretas. De fato, o erro relativo é

$\frac{|49245 - 49244.728|}{|49244.728|} \approx 5.523 \cdot 10^{-6},$

que é próximo ao epsilon da máquina. 

Agora fazemos a operação final, **usando o resultado já calculado**,

$\operatorname{fl}(49245 - 49244) = \operatorname{fl}(1) = 1.$

Veja que esse resultado tem quase nenhuma relação com o valor exato que é 0.728. Ele apenas acerta a ordem de grandeza. Mas **não tem nenhum dígito correto**, muito menos os cinco dígitos significativos esperados.
"""

# ╔═╡ 2a445201-df9b-4a86-91c0-c6ffa7bf301b
md"""
### Exemplos de erros de cancelamento

Considere a seguinte expressão $\sqrt{x^2 + 1} - x$. Quando ela irá gerar erros de cancelamento? Se você pensar um pouco, à medida que $x$ vai para $\infty$ o valor $x^2 + 1$ fica relativamente mais perecido com o $x^2$. O $1$ se torna irrelevante perante o $x^2$ que é muito grande. Assim a raiz quadrada desse valor deve ficar muito próxima de $| x |$. Quando fomos subtrair essa raiz quadrada $x$, que é positivo, teremos erro de cancelamento.

Podemos então prever que $\sqrt{x^2 + 1} - x$ deve gerar erros de cancelamento para $x$ grande. Para ver isso vamos aproximar o erro relativo comparando números calculados com precisão simples com números calculados com precisão dupla.
"""

# ╔═╡ 09471dc2-1dc1-4106-9b60-7a57e17688de
expr(x) = sqrt(x^2 + 1) - x # Expressão

# ╔═╡ 51ffe6c7-3b72-4f00-af55-aaafa1542df1
a, b = 1e+1, 1e+4 # Intervalo [a,b]

# ╔═╡ 30da546a-3e1c-487e-9e79-3e84f62d907c
Eᵣ(xh,x) = abs(x - xh) / abs(xh)

# ╔═╡ d3dbda41-d1cc-4739-9cbc-c740ec0a7d29
# x ∈ [a,b]
x = collect(range(a, b, length = 1000))

# ╔═╡ 6207fb3a-73c8-4534-9390-8f7ddc3d7f10
exprx_double = expr.(x)

# ╔═╡ c5384b39-4237-4ef0-9645-7f1ff77181bf
x_single = Float32.(x)

# ╔═╡ 33aa31b3-9871-49af-9c4f-e26dd7913f7a
exprx_single = expr.(x_single)

# ╔═╡ 93b2317c-45f6-4d04-a166-33e0f1472ba5
log_erro = log10.(Eᵣ.(exprx_double,exprx_single))

# ╔═╡ 1e743aad-4501-4be2-95ae-6f6ad1fbb58c
begin
	plot(x,-log_erro,xaxis=:log10)
	title!("Dígitos corretos em função de x")
	ylabel!("Dígitos corretos")
	xlabel!("x")
end

# ╔═╡ 1589e991-c91e-43e4-9368-bc0c6104893d
md"""
#### Como corrigir isto?

Como você pode ver, a precisão começa razoável. Há mais de 5 casas significativas. O número de casas significativas cai rapidamente chegando a 0 antes de $x = 10^4$. 

Será que é possível evitar esse erro? Será que é possível  re-escrever a expressão de modo a evitar o problema para $x$ grande? A resposta é sim, veja:

$(\sqrt{x^2 + 1} - x)(\sqrt{x^2 + 1} + x) = x^2 + 1 - x^2 = 1.$

Ou seja,

$\sqrt{x^2 + 1} - x = \frac{1}{\sqrt{x^2 + 1} + x}.$

Essa última expressão não tem erros de cancelamento quando $x$ é grande, já que não ocorre subtração de valores próximos. Note o que ocorre ao usarmos essa expressão para o cômputo da fórmula.
"""

# ╔═╡ e6cf7ab8-833f-4477-84c4-28081ecb6136


# ╔═╡ 5a53346f-a40f-4b81-9d70-e1cd1ddf0690
md"""
### Um exemplo mais sofisticado

Um exemplo mais sofisticado aparece quando resolvemos equações do segundo grau. Nesse caso sabemos que as raízes desejadas podem ser obtidas através da fórmula de Báskara. Se queremos as raízes de $ax^2 + bx + c = 0$, calculamos
$\Delta = b^2 - 4ac,\quad\quad x = \frac{-b \pm \sqrt{\Delta}}{2a}.$

E a implementação direta dessa formula é dada abaixo.
"""

# ╔═╡ 39156ca2-1bc0-4b94-bd11-c60c1c293425


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
# ╠═00668afc-b4b2-4d70-8ac0-32da4844f686
# ╟─960cec6b-6cf0-44b8-b3b2-76efa5a53080
# ╟─e12e8462-4280-42d9-a995-b52480e47dd2
# ╠═24c6e582-1e1e-435a-b0e6-4fc9f7d4c3b1
# ╟─9a63e356-911c-478a-ab08-34d3a163ce07
# ╠═292b079c-3adc-4a7a-9966-ff2a368afa96
# ╠═6bd08fe7-2bcd-4e85-b883-5c8ab4ed44c8
# ╟─a6324f07-427b-4ffa-ae66-ddd823bb2fc9
# ╟─b9844f13-c267-4eae-b0fd-69a3d2915c71
# ╟─2a445201-df9b-4a86-91c0-c6ffa7bf301b
# ╠═09471dc2-1dc1-4106-9b60-7a57e17688de
# ╠═51ffe6c7-3b72-4f00-af55-aaafa1542df1
# ╠═30da546a-3e1c-487e-9e79-3e84f62d907c
# ╠═d3dbda41-d1cc-4739-9cbc-c740ec0a7d29
# ╠═6207fb3a-73c8-4534-9390-8f7ddc3d7f10
# ╠═c5384b39-4237-4ef0-9645-7f1ff77181bf
# ╠═33aa31b3-9871-49af-9c4f-e26dd7913f7a
# ╠═93b2317c-45f6-4d04-a166-33e0f1472ba5
# ╠═1e743aad-4501-4be2-95ae-6f6ad1fbb58c
# ╟─1589e991-c91e-43e4-9368-bc0c6104893d
# ╠═e6cf7ab8-833f-4477-84c4-28081ecb6136
# ╟─5a53346f-a40f-4b81-9d70-e1cd1ddf0690
# ╠═39156ca2-1bc0-4b94-bd11-c60c1c293425
# ╟─d242e2f1-48d1-4f11-a404-bbb90b4733f6
# ╠═ab6d1a0d-ee3f-4f4c-bf22-8c8737787d95
# ╟─e90056ae-60a6-47ea-a8d0-8d7383946f65
# ╠═1eb503e1-99b5-443f-a2b7-ad40ba807887
# ╟─12dfeb12-ddf1-4b98-920e-12b3f6e7a4bd
# ╠═a64cc299-bd61-4782-8fad-a738fab37a36
# ╟─923041ee-60dc-4934-b34e-636c7ed30f96
