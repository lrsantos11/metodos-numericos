### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
begin
	using LinearAlgebra
end

# ╔═╡ a2d2d41c-d397-11eb-0f7d-ed2891f49049
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 02 - Aula 01
"""

# ╔═╡ 09cb6899-07c6-436e-808f-b85f2c0f04de
md"""
# Introdução a Julia (continuação)
"""

# ╔═╡ 4d8839cb-f01e-47b0-9671-3eb4f58e5acf
md"""
- Vamos primeiro instalar pacotes do Julia usados na aula
"""

# ╔═╡ 34ad60f7-8c7b-464c-8a67-1e9e6a562f84
exp(2) #Base ℯ^2

# ╔═╡ 602c26a1-0fda-482f-bcd1-adc2aa8b821c
exp10(-3.23) #Base 10 10^(-3.23)

# ╔═╡ 529c5733-cdd0-4d04-8d15-d284d6cc436c
exp2(2) #Base 2

# ╔═╡ b16298f2-8d3b-4010-9007-0eaa48a4cbdb
cos(60)

# ╔═╡ ca39c547-85d6-419e-ba29-118f1397c28a
sind(45)

# ╔═╡ 969653b8-b4b1-499c-9984-a8a762e51873
cosd(60)

# ╔═╡ c9389138-5903-4be6-9dec-8c62f3868ee0
cos( π / 3)

# ╔═╡ f5a5d2d8-5841-40d5-8e56-0f26484d45ad
round(π, digits = 120) #Arredondamento

# ╔═╡ f56f35ec-26e0-4c3f-b84d-3b4b6713c756
md"""
- Numerical Recipes in C (ou Fotran)
"""

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
rand(3,1)  # Vetor aleatório (distribuição Uniforme entre 0 e 1)

# ╔═╡ 76493cc3-5f5c-4784-a035-e316503aa50e
rand(3)

# ╔═╡ 7e594742-370d-4835-9056-81767ba3d7cf
randn(5) # Vetor aleatório (distribuição Normal com média 0)

# ╔═╡ c9b24a46-4df0-42f6-a073-703c298621e7
A = rand(2,3)

# ╔═╡ 1b2bdc7c-692b-4eb4-b2b0-7200367b957b
A[:]

# ╔═╡ 9329d5b7-adca-4984-9f48-3c2d17e0d82c
vet1 = rand(3) 

# ╔═╡ 6a6482d6-3592-4faf-8196-75c62643de7d
A * vet1

# ╔═╡ faf58646-5b42-4ce9-96f7-0bbecffb44d0
vet1 * A

# ╔═╡ 45d07057-0c5f-4a47-a331-659abda5f17e
zeros(10)

# ╔═╡ 363544f4-3827-4f4a-8318-d9fea83c58a3
zeros(3,3)

# ╔═╡ f3b8d641-8fc4-4c11-a91a-d5b651e15105
ones(3)

# ╔═╡ b53a8a4c-bbb5-4c49-bd6a-54edd55f57dd
ones(2,2)

# ╔═╡ 9564e4f2-8274-4de6-a955-9a778f2f6482
fill(π,(3,3)) #fill (preencher) preenche um vetor com o valor

# ╔═╡ d8db75fb-8e7b-4df1-af20-8e6cac2d60bd
fill(A,(2,2))

# ╔═╡ 80e10ff2-e65b-47a8-b11d-4ef677325c4d
vet2 = rand(2)

# ╔═╡ 2ec60ba8-3ffe-4c4d-afb3-086c0acaa6d5
A' #A' é equivalente à transposta de A, A^T

# ╔═╡ a05bd030-5259-4006-ab7d-fc70f4a5fe95
A''

# ╔═╡ ce5eb4dd-0ab7-4c64-a6d0-8467ba36522d
A'*vet2 

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

# ╔═╡ 47e1ee60-6800-4183-b9b6-273e65d52c69
md"""
### NUNCA CALCULE A INVERSA DE UMA MATRIZ
"""

# ╔═╡ 5965d39f-1101-40dd-8af9-60dc439119dc
inv(C)

# ╔═╡ d4a7a808-31bf-421b-9188-d1f73ed7487a
C * x - b

# ╔═╡ 8580a1d4-c48b-4862-8b8c-6460445fab4b
md"""
- Norma de vetores
"""

# ╔═╡ ba71b626-64ff-4bdb-911e-4d725e77b7f7
norm(C*x - b, Inf) # Norma do max - norm(x,Inf) = max_i {abs(x_i)}

# ╔═╡ 555f742e-e21d-4240-a91f-968d3b546659
norm(C*x - b) # = norm(C*x - b,2)

# ╔═╡ 03990c57-2c72-4a3e-82a0-0ac359973cde
norm(C*x - b,1) # = norm(C*x - b,1)

# ╔═╡ 4c2d7cac-d8d1-432b-b276-4917ce2a1bda
vet3 = [1., 3] 	

# ╔═╡ ea1d770a-c5ee-4870-ae28-e129112f37f0
md"""
- Produto  interno Euclideano
"""

# ╔═╡ dcb77ed9-7f51-40be-b0f8-235f37920b7d
md"""
$\langle x, u \rangle = \sum_{i=1}^{n} x_iu_i = x^T u$
"""

# ╔═╡ 91a91990-08b4-48fd-bd3a-653e2f4a316e
dot(vet2,vet3)

# ╔═╡ 2573bcf2-1f61-4f7e-a174-64cfacd562fa
vet2' * vet3

# ╔═╡ 8aa79ce4-1918-47d2-acf9-f2aa831f5d1b
md"""
- **Broadcasting:**
  - Usar uma função feita para números em cada componente de um vetor 
"""

# ╔═╡ 023d8be6-2c6d-4e41-aa80-ae952d4bebb5
vet4 = rand(1:5,3)

# ╔═╡ 40245ca8-86ef-47fa-8ea3-011650194b13
fbroad(x) = x^2 + 2*x

# ╔═╡ 196e595c-1c88-4e32-891f-3b57471a575f
sin.(vet4) # operação . faz brodcast (transmissão)

# ╔═╡ 1f1b5cc3-97db-46b3-8c26-36366235c40c
fbroad.(vet4)

# ╔═╡ 02208291-7e98-4379-93b2-5b052d68ffc0
D = rand(1:5,3,3)

# ╔═╡ e60ad857-2d17-4bd3-b3c3-c9ed47f8f494
E = rand(2:8,3,3)

# ╔═╡ 04cfba3e-91d5-48af-870b-6bfbb96b420e
D * E

# ╔═╡ f1d0e849-e5dd-439a-b4b5-a1f4b6228270
D .* E #Broadcast - .+Função - Produto de Haddamard

# ╔═╡ d0014623-085d-4162-b164-4ab360c84f18
sind.(D)

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
g(x,y) = exp(x+y) #f:ℝ² → ℝ

# ╔═╡ d88a0f6f-d30c-4f2e-b1af-93d29ec60cc1
g(2,3)

# ╔═╡ 61fe0558-a535-400a-b44c-8f7455d529e0
func1 = x -> sin(x)*cos(x)

# ╔═╡ edadaf37-303c-44b9-b73f-f972a9097198
func1(-3)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ Cell order:
# ╟─a2d2d41c-d397-11eb-0f7d-ed2891f49049
# ╟─09cb6899-07c6-436e-808f-b85f2c0f04de
# ╟─4d8839cb-f01e-47b0-9671-3eb4f58e5acf
# ╠═b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
# ╠═34ad60f7-8c7b-464c-8a67-1e9e6a562f84
# ╠═602c26a1-0fda-482f-bcd1-adc2aa8b821c
# ╠═529c5733-cdd0-4d04-8d15-d284d6cc436c
# ╠═b16298f2-8d3b-4010-9007-0eaa48a4cbdb
# ╠═ca39c547-85d6-419e-ba29-118f1397c28a
# ╠═969653b8-b4b1-499c-9984-a8a762e51873
# ╠═c9389138-5903-4be6-9dec-8c62f3868ee0
# ╠═f5a5d2d8-5841-40d5-8e56-0f26484d45ad
# ╟─f56f35ec-26e0-4c3f-b84d-3b4b6713c756
# ╟─2bf3a8d0-92e4-41a3-a376-c40a6794fb64
# ╠═f6cf2c81-d64e-42ae-8ca0-5e84d8c6ddbb
# ╠═76493cc3-5f5c-4784-a035-e316503aa50e
# ╠═7e594742-370d-4835-9056-81767ba3d7cf
# ╠═c9b24a46-4df0-42f6-a073-703c298621e7
# ╠═1b2bdc7c-692b-4eb4-b2b0-7200367b957b
# ╠═9329d5b7-adca-4984-9f48-3c2d17e0d82c
# ╠═6a6482d6-3592-4faf-8196-75c62643de7d
# ╠═faf58646-5b42-4ce9-96f7-0bbecffb44d0
# ╠═45d07057-0c5f-4a47-a331-659abda5f17e
# ╠═363544f4-3827-4f4a-8318-d9fea83c58a3
# ╠═f3b8d641-8fc4-4c11-a91a-d5b651e15105
# ╠═b53a8a4c-bbb5-4c49-bd6a-54edd55f57dd
# ╠═9564e4f2-8274-4de6-a955-9a778f2f6482
# ╠═d8db75fb-8e7b-4df1-af20-8e6cac2d60bd
# ╠═80e10ff2-e65b-47a8-b11d-4ef677325c4d
# ╠═2ec60ba8-3ffe-4c4d-afb3-086c0acaa6d5
# ╠═a05bd030-5259-4006-ab7d-fc70f4a5fe95
# ╠═ce5eb4dd-0ab7-4c64-a6d0-8467ba36522d
# ╠═8a47a479-2344-4912-9ee2-53e40bb84ffd
# ╠═d9021cdd-3c49-4ae8-8d31-64d0d01fb62e
# ╠═367c66a1-3443-468b-ade9-4d6c597d91ad
# ╠═393746c0-6650-43d9-9c7a-465c6ad882b9
# ╠═a5547b35-245b-4d9e-8701-b3e81d464567
# ╟─f96557db-b6b7-4e03-95a6-11fdfa6b9d94
# ╠═6ff76355-f159-4164-855c-b797e50e58f2
# ╟─47e1ee60-6800-4183-b9b6-273e65d52c69
# ╠═5965d39f-1101-40dd-8af9-60dc439119dc
# ╠═d4a7a808-31bf-421b-9188-d1f73ed7487a
# ╟─8580a1d4-c48b-4862-8b8c-6460445fab4b
# ╠═ba71b626-64ff-4bdb-911e-4d725e77b7f7
# ╠═555f742e-e21d-4240-a91f-968d3b546659
# ╠═03990c57-2c72-4a3e-82a0-0ac359973cde
# ╠═4c2d7cac-d8d1-432b-b276-4917ce2a1bda
# ╟─ea1d770a-c5ee-4870-ae28-e129112f37f0
# ╟─dcb77ed9-7f51-40be-b0f8-235f37920b7d
# ╠═91a91990-08b4-48fd-bd3a-653e2f4a316e
# ╠═2573bcf2-1f61-4f7e-a174-64cfacd562fa
# ╟─8aa79ce4-1918-47d2-acf9-f2aa831f5d1b
# ╠═023d8be6-2c6d-4e41-aa80-ae952d4bebb5
# ╠═40245ca8-86ef-47fa-8ea3-011650194b13
# ╠═196e595c-1c88-4e32-891f-3b57471a575f
# ╠═1f1b5cc3-97db-46b3-8c26-36366235c40c
# ╠═02208291-7e98-4379-93b2-5b052d68ffc0
# ╠═e60ad857-2d17-4bd3-b3c3-c9ed47f8f494
# ╠═04cfba3e-91d5-48af-870b-6bfbb96b420e
# ╠═f1d0e849-e5dd-439a-b4b5-a1f4b6228270
# ╠═d0014623-085d-4162-b164-4ab360c84f18
# ╟─80d793be-5d74-4254-8359-d5f029d203a4
# ╠═7a9cbc0b-ca41-4850-ba76-550ac76bbefb
# ╠═67674a24-ba42-4d0a-b6d1-30a9a07b94c7
# ╠═dfb90994-8a44-4b7d-831b-e63eebc76d43
# ╠═9751c64a-a002-44e3-b3d5-a458f243f1e7
# ╠═d88a0f6f-d30c-4f2e-b1af-93d29ec60cc1
# ╠═61fe0558-a535-400a-b44c-8f7455d529e0
# ╠═edadaf37-303c-44b9-b73f-f972a9097198
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
