### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
begin
	import Pkg; Pkg.add("DataFrames")
	using DataFrames
	using LinearAlgebra
end

# ╔═╡ a2d2d41c-d397-11eb-0f7d-ed2891f49049
md"""
###### UFSC/Blumenau
###### MAT1831 - Métodos Numéricos
###### Prof. Luiz-Rafael Santos
"""

# ╔═╡ 4d8839cb-f01e-47b0-9671-3eb4f58e5acf
md"""
- Vamos primeiro instalar pacotes do Julia usados na aula
"""

# ╔═╡ 09cb6899-07c6-436e-808f-b85f2c0f04de
md"""
# Introdução a Julia (continuação)
"""

# ╔═╡ 34ad60f7-8c7b-464c-8a67-1e9e6a562f84
exp(2) #Base e

# ╔═╡ 602c26a1-0fda-482f-bcd1-adc2aa8b821c
exp10(2) #Base 10

# ╔═╡ 529c5733-cdd0-4d04-8d15-d284d6cc436c
exp2(2) #Base 2

# ╔═╡ 2bf3a8d0-92e4-41a3-a376-c40a6794fb64
md"""
## Vetores e Matrizes (Arrays)
- É necessário chamar o pacote `LinearAlgebra` (pacote nativo do Julia) com o comando
```julia
using LinearAlgebra
```
- Seguem alguns exemplos
"""

# ╔═╡ f6cf2c81-d64e-42ae-8ca0-5e84d8c6ddbb
rand(3) # Vetor aleatório (distribuição Uniforme entre 0 e 1)

# ╔═╡ 7e594742-370d-4835-9056-81767ba3d7cf
randn(5) # Vetor aleatório (distribuição Normal)

# ╔═╡ 80d793be-5d74-4254-8359-d5f029d203a4
md"""
## Funções
- Como definir funções?
"""

# ╔═╡ 7a9cbc0b-ca41-4850-ba76-550ac76bbefb


# ╔═╡ 206f3485-ba82-4b9e-948a-97e656f42b8a
md"""
# Erros em Algorimos numéricos
## Erros relativos e absolutos
Inevitavelmente, encontraremos erros quando implementamos algum algoritmos numéricos. Isto porque tipicamente nosso objetivo é encontrar uma _aproximação $v$_ de alguma _solução exata $u$_. Há basicamente dois tipos de erros
- **Erro absoluto** em $v$ dado por
```math
E_A := \lvert u - v\rvert
```
- **Erro relativo** em $v$ dado por
```math
E_R := \frac{\lvert u - v\rvert}{\lvert u\rvert},
```
desde que $u\neq 0$. 
* O erro relativo tem, em geral, mais significado, em especial, para erros de _representação de ponto flutuante_
"""

# ╔═╡ 0d2074aa-f918-4b6e-a7b3-1a2a84be333e
u = [1, 1, -1.5, 100, 100]

# ╔═╡ 5f980d0a-44e0-4d37-82a4-86c1e0a014e8
v = [0.99, 1.01, -1.2, 99.99, 99]

# ╔═╡ a37753de-9cb6-4d3d-84a7-087c8515886f
md"""
---
- Usando `DataFrames` para nossa tabela ficar bonitinha!
"""

# ╔═╡ 33db5da8-74a8-41df-ba17-8bc0251c824b
DataFrame(:u=>u, :v=>v) #Erro absoluto e relativo

# ╔═╡ 9fb230ba-dffc-4603-9c8d-00a1b1073d03
md"""
##### Aproximação de Stirling para fatorial de ${n}$
A fórmula de Stirling diz que oodemos utilizar 

$$v = S_n = \sqrt{2\pi n} \left(\frac{n}{e}\right)^n$$

para aproximar $v = n! = 1\cdot 2\cdot  \cdots \cdot n$, o fatoral de ${n}$ para ${n}$ grande.
Usando a função `factorial(n)` de Julia vamos computar os erros relativos e absolutos de $S_n$, e apresentá-los em um `DataFrame`, para $1\leq n \leq 20$.
"""

# ╔═╡ Cell order:
# ╟─a2d2d41c-d397-11eb-0f7d-ed2891f49049
# ╟─4d8839cb-f01e-47b0-9671-3eb4f58e5acf
# ╠═b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
# ╟─09cb6899-07c6-436e-808f-b85f2c0f04de
# ╠═34ad60f7-8c7b-464c-8a67-1e9e6a562f84
# ╠═602c26a1-0fda-482f-bcd1-adc2aa8b821c
# ╠═529c5733-cdd0-4d04-8d15-d284d6cc436c
# ╟─2bf3a8d0-92e4-41a3-a376-c40a6794fb64
# ╠═f6cf2c81-d64e-42ae-8ca0-5e84d8c6ddbb
# ╠═7e594742-370d-4835-9056-81767ba3d7cf
# ╟─80d793be-5d74-4254-8359-d5f029d203a4
# ╠═7a9cbc0b-ca41-4850-ba76-550ac76bbefb
# ╟─206f3485-ba82-4b9e-948a-97e656f42b8a
# ╠═0d2074aa-f918-4b6e-a7b3-1a2a84be333e
# ╠═5f980d0a-44e0-4d37-82a4-86c1e0a014e8
# ╟─a37753de-9cb6-4d3d-84a7-087c8515886f
# ╠═33db5da8-74a8-41df-ba17-8bc0251c824b
# ╟─9fb230ba-dffc-4603-9c8d-00a1b1073d03
