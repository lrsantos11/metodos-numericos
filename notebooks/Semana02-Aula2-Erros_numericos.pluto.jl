### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
begin
	using LinearAlgebra
	using PlutoUI
	import Pkg; Pkg.add("DataFrames")
	using DataFrames
end

# ╔═╡ a2d2d41c-d397-11eb-0f7d-ed2891f49049
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 02 - Aula 02
"""

# ╔═╡ 206f3485-ba82-4b9e-948a-97e656f42b8a
md"""
# Erros em Algorimos numéricos
## Erros relativos e absolutos
Inevitavelmente, encontraremos erros quando implementamos algum algoritmos numéricos. Isto porque tipicamente nosso objetivo é encontrar uma _aproximação $v$_ de alguma _solução exata $u$_. 

Há basicamente dois tipos de erros

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

# ╔═╡ 4d8839cb-f01e-47b0-9671-3eb4f58e5acf
md"""
- Vamos incluir/instalar os pacotes do Julia usados nesta aula
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
A fórmula de Stirling diz que podemos utilizar 

$$v = S_n = \sqrt{2\pi n} \left(\frac{n}{e}\right)^n$$

para aproximar $v = n! = 1\cdot 2\cdot  \cdots \cdot n$, o fatoral de ${n}$ para ${n}$ grande.
Usando a função `factorial(n)` de Julia vamos computar os erros relativos e absolutos de $S_n$, e apresentá-los em um `DataFrame`, para $1\leq n \leq 20$.
"""

# ╔═╡ 212fdbfd-545a-4cf6-a2fd-9d146d827e75


# ╔═╡ Cell order:
# ╟─a2d2d41c-d397-11eb-0f7d-ed2891f49049
# ╟─206f3485-ba82-4b9e-948a-97e656f42b8a
# ╠═4d8839cb-f01e-47b0-9671-3eb4f58e5acf
# ╠═b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
# ╠═0d2074aa-f918-4b6e-a7b3-1a2a84be333e
# ╠═5f980d0a-44e0-4d37-82a4-86c1e0a014e8
# ╟─a37753de-9cb6-4d3d-84a7-087c8515886f
# ╠═33db5da8-74a8-41df-ba17-8bc0251c824b
# ╟─9fb230ba-dffc-4603-9c8d-00a1b1073d03
# ╠═212fdbfd-545a-4cf6-a2fd-9d146d827e75
