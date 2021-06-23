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
exp10(-3.23) #Base 10 10^(-3.23)

# ╔═╡ 529c5733-cdd0-4d04-8d15-d284d6cc436c
exp2(2) #Base 2

# ╔═╡ b16298f2-8d3b-4010-9007-0eaa48a4cbdb
cos(60)

# ╔═╡ 969653b8-b4b1-499c-9984-a8a762e51873
cosd(60)

# ╔═╡ c9389138-5903-4be6-9dec-8c62f3868ee0
cos( π / 3)

# ╔═╡ f5a5d2d8-5841-40d5-8e56-0f26484d45ad
round(π, digits = 120) #Arredondamento

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

# ╔═╡ c9b24a46-4df0-42f6-a073-703c298621e7
A = rand(2,3)

# ╔═╡ 9329d5b7-adca-4984-9f48-3c2d17e0d82c
vet1 = rand(3) 

# ╔═╡ 6a6482d6-3592-4faf-8196-75c62643de7d
A * vet1

# ╔═╡ 45d07057-0c5f-4a47-a331-659abda5f17e
zeros(10)

# ╔═╡ f3b8d641-8fc4-4c11-a91a-d5b651e15105
ones(3)

# ╔═╡ 9564e4f2-8274-4de6-a955-9a778f2f6482
fill(π,(3,3)) #fill (preencher) preenche um vetor com o valor

# ╔═╡ 80e10ff2-e65b-47a8-b11d-4ef677325c4d
vet2 = rand(2)

# ╔═╡ 2ec60ba8-3ffe-4c4d-afb3-086c0acaa6d5
A' #A' é equivalente à transposta de A, A^T

# ╔═╡ ce5eb4dd-0ab7-4c64-a6d0-8467ba36522d
A' * vet2 

# ╔═╡ 8a47a479-2344-4912-9ee2-53e40bb84ffd
B = randn(3,2)

# ╔═╡ d9021cdd-3c49-4ae8-8d31-64d0d01fb62e
A + B

# ╔═╡ 367c66a1-3443-468b-ade9-4d6c597d91ad
A' + B

# ╔═╡ 393746c0-6650-43d9-9c7a-465c6ad882b9
A + B'

# ╔═╡ a5547b35-245b-4d9e-8701-b3e81d464567
A * B 

# ╔═╡ f96557db-b6b7-4e03-95a6-11fdfa6b9d94
md"""
- Resolver o Sistema Linear (SL) 
$$Cx = b$$
"""

# ╔═╡ 6ff76355-f159-4164-855c-b797e50e58f2
begin
	C = rand(3,3)
	b = rand(3)
# 	Resolver o Sistema Linear (SL) Cx = b
	x = C\b #O comando `\` (barra invertida) resolve o sistema
end

# ╔═╡ d4a7a808-31bf-421b-9188-d1f73ed7487a
C * x - b

# ╔═╡ 47cd3d97-ade0-4713-9819-cc9a75061dd6
inv(C) #Inversa de C

# ╔═╡ ba71b626-64ff-4bdb-911e-4d725e77b7f7
norm(C*x - b, Inf)

# ╔═╡ 555f742e-e21d-4240-a91f-968d3b546659
norm(C*x - b) # = norm(C*x - b,2)

# ╔═╡ 4c2d7cac-d8d1-432b-b276-4917ce2a1bda
vet3 = [1., 3] 	

# ╔═╡ 91a91990-08b4-48fd-bd3a-653e2f4a316e
dot(vet2,vet3)

# ╔═╡ 2573bcf2-1f61-4f7e-a174-64cfacd562fa
vet2' * vet3

# ╔═╡ 8aa79ce4-1918-47d2-acf9-f2aa831f5d1b
md"""
- **Broadcasting:**
  - Usar uma função feita para números em cada componente de um vetor 
"""

# ╔═╡ 02208291-7e98-4379-93b2-5b052d68ffc0
D = rand(1:5,3,3)

# ╔═╡ e60ad857-2d17-4bd3-b3c3-c9ed47f8f494
E = rand(2:8,3,3)

# ╔═╡ 04cfba3e-91d5-48af-870b-6bfbb96b420e
D * E

# ╔═╡ f1d0e849-e5dd-439a-b4b5-a1f4b6228270
D .* E #Broadcast - .+Função

# ╔═╡ d0014623-085d-4162-b164-4ab360c84f18
sind.(D)

# ╔═╡ ee4d5876-43ee-4f5a-951a-0ea3114ded2d
I

# ╔═╡ 252c34fc-f179-45d9-8864-fc564ba013e5
D*I == D

# ╔═╡ aa5c435e-a069-452c-8a7f-d3ec19b844c6
F = [D  exp2.(E);
 E'    I     ]	

# ╔═╡ fc7fc26e-15b9-47f2-861a-ac8793e0b1f0
m, n = size(F)

# ╔═╡ 80d793be-5d74-4254-8359-d5f029d203a4
md"""
## Funções
- Como definir funções?
"""

# ╔═╡ 7a9cbc0b-ca41-4850-ba76-550ac76bbefb
f(x) = x^2

# ╔═╡ 67674a24-ba42-4d0a-b6d1-30a9a07b94c7
f(2.5)

# ╔═╡ dfb90994-8a44-4b7d-831b-e63eebc76d43
f.(D)

# ╔═╡ 9751c64a-a002-44e3-b3d5-a458f243f1e7
g(x,y) = exp(x+y) #f:R² → R

# ╔═╡ d88a0f6f-d30c-4f2e-b1af-93d29ec60cc1
g(2,3)

# ╔═╡ 61fe0558-a535-400a-b44c-8f7455d529e0
func1 = x -> sin(x)*cos(x)

# ╔═╡ edadaf37-303c-44b9-b73f-f972a9097198
func1(-3)

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
A fórmula de Stirling diz que podemos utilizar 

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
# ╠═b16298f2-8d3b-4010-9007-0eaa48a4cbdb
# ╠═969653b8-b4b1-499c-9984-a8a762e51873
# ╠═c9389138-5903-4be6-9dec-8c62f3868ee0
# ╠═f5a5d2d8-5841-40d5-8e56-0f26484d45ad
# ╟─2bf3a8d0-92e4-41a3-a376-c40a6794fb64
# ╠═f6cf2c81-d64e-42ae-8ca0-5e84d8c6ddbb
# ╠═7e594742-370d-4835-9056-81767ba3d7cf
# ╠═c9b24a46-4df0-42f6-a073-703c298621e7
# ╠═9329d5b7-adca-4984-9f48-3c2d17e0d82c
# ╠═6a6482d6-3592-4faf-8196-75c62643de7d
# ╠═45d07057-0c5f-4a47-a331-659abda5f17e
# ╠═f3b8d641-8fc4-4c11-a91a-d5b651e15105
# ╠═9564e4f2-8274-4de6-a955-9a778f2f6482
# ╠═80e10ff2-e65b-47a8-b11d-4ef677325c4d
# ╠═2ec60ba8-3ffe-4c4d-afb3-086c0acaa6d5
# ╠═ce5eb4dd-0ab7-4c64-a6d0-8467ba36522d
# ╠═8a47a479-2344-4912-9ee2-53e40bb84ffd
# ╠═d9021cdd-3c49-4ae8-8d31-64d0d01fb62e
# ╠═367c66a1-3443-468b-ade9-4d6c597d91ad
# ╠═393746c0-6650-43d9-9c7a-465c6ad882b9
# ╠═a5547b35-245b-4d9e-8701-b3e81d464567
# ╟─f96557db-b6b7-4e03-95a6-11fdfa6b9d94
# ╠═6ff76355-f159-4164-855c-b797e50e58f2
# ╠═d4a7a808-31bf-421b-9188-d1f73ed7487a
# ╠═47cd3d97-ade0-4713-9819-cc9a75061dd6
# ╠═ba71b626-64ff-4bdb-911e-4d725e77b7f7
# ╠═555f742e-e21d-4240-a91f-968d3b546659
# ╠═4c2d7cac-d8d1-432b-b276-4917ce2a1bda
# ╠═91a91990-08b4-48fd-bd3a-653e2f4a316e
# ╠═2573bcf2-1f61-4f7e-a174-64cfacd562fa
# ╟─8aa79ce4-1918-47d2-acf9-f2aa831f5d1b
# ╠═02208291-7e98-4379-93b2-5b052d68ffc0
# ╠═e60ad857-2d17-4bd3-b3c3-c9ed47f8f494
# ╠═04cfba3e-91d5-48af-870b-6bfbb96b420e
# ╠═f1d0e849-e5dd-439a-b4b5-a1f4b6228270
# ╠═d0014623-085d-4162-b164-4ab360c84f18
# ╠═ee4d5876-43ee-4f5a-951a-0ea3114ded2d
# ╠═252c34fc-f179-45d9-8864-fc564ba013e5
# ╠═aa5c435e-a069-452c-8a7f-d3ec19b844c6
# ╠═fc7fc26e-15b9-47f2-861a-ac8793e0b1f0
# ╟─80d793be-5d74-4254-8359-d5f029d203a4
# ╠═7a9cbc0b-ca41-4850-ba76-550ac76bbefb
# ╠═67674a24-ba42-4d0a-b6d1-30a9a07b94c7
# ╠═dfb90994-8a44-4b7d-831b-e63eebc76d43
# ╠═9751c64a-a002-44e3-b3d5-a458f243f1e7
# ╠═d88a0f6f-d30c-4f2e-b1af-93d29ec60cc1
# ╠═61fe0558-a535-400a-b44c-8f7455d529e0
# ╠═edadaf37-303c-44b9-b73f-f972a9097198
# ╟─206f3485-ba82-4b9e-948a-97e656f42b8a
# ╠═0d2074aa-f918-4b6e-a7b3-1a2a84be333e
# ╠═5f980d0a-44e0-4d37-82a4-86c1e0a014e8
# ╟─a37753de-9cb6-4d3d-84a7-087c8515886f
# ╠═33db5da8-74a8-41df-ba17-8bc0251c824b
# ╟─9fb230ba-dffc-4603-9c8d-00a1b1073d03
