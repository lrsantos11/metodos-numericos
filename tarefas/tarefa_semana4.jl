### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 5592f686-8a8d-4de2-93c9-ecf624e418f8
begin
	using PlutoUI
end

# ╔═╡ 63c25d7e-e17f-11eb-25e8-c3a9aaebcd7b
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 04
"""

# ╔═╡ b3da3782-393c-4098-b157-9835e725ac7e
md"""
**Estudante:** "Digite seu nome aqui"
"""

# ╔═╡ d7dc68d9-dd85-4e25-a766-a7e4e860a249
md"""
#### Tarefa Semana 4

1. Estude os zeros da função $f(x) = x^5 - 3x^3 - 2x + 1$ e encontre os intervalos que contém cada um dos três zeros de forma única usando os teoremas apresentados na S04A03.

1. Faça sua implementação sua implementação do _Método da Bissecção_ (MB), tomando como base a função `bissec` que foi apresentada na S04A03. Tal função deve, além do método, ser capaz de
    - Testar se os dados de entrada $f$, $a$, e $b$, satisfazem as hipóteses do MB;
    - Retornar todos os valores  $a_k$, $b_k$, $x_k$, $k$ e  $\lvert f_k\rvert$ em um `DataFrame` (**Dica**: Use a função `append!` para incluir novas linhas na tabela.)
1. Teste sua função no problema do tiro de canhão apresentado na S04A03, com os dados abaixo.
```julia 
# Dados problema do canhão
begin
	v0 = 6:12#Use a função `Slider` do pacote `PlutoUI`
	d = 6:20 #Use a função `Slider` do pacote `PlutoUI`
	g = 9.80665
end
```

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.9"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╟─63c25d7e-e17f-11eb-25e8-c3a9aaebcd7b
# ╠═b3da3782-393c-4098-b157-9835e725ac7e
# ╠═5592f686-8a8d-4de2-93c9-ecf624e418f8
# ╠═d7dc68d9-dd85-4e25-a766-a7e4e860a249
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
