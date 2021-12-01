### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ a236cca3-96b6-4b9c-b5b2-3a4bd4c716e7
begin
	using ForwardDiff, DataFrames,  LinearAlgebra
end

# ╔═╡ dbfd283a-ea6e-11eb-2033-a5646e8d2681
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 06 - Aula 01.2
"""

# ╔═╡ 9395bb5c-4c00-44b7-8ad1-77545550d458


# ╔═╡ 93fd1c70-bfe5-4904-a90d-e8190f7314c5
let 
	A = [1 2; 2 -1.]
	b = [3, 2]
	x = A \ b #Operador bara inverstida
	norm(A*x - b)
end

# ╔═╡ 41eac1c5-afc9-4d38-b4e9-5e33481cab72


# ╔═╡ 3943d502-00d2-49bd-a804-b0c7c9476f60


# ╔═╡ 5a324577-a8e3-4b7b-b49e-bb50e578e465
md"""
# Método de Newton para Sistemas Não-Lineares

O método de Newton admite uma generalização direta para resolver sistemas de equações não-lineares. Nesse caso temos uma função $F: \mathbb{R}^n \rightarrow \mathbb{R}^n$ e queremos resolver $F(x) = 0,\ x \in \mathbb{R}^n$. Em outras palavras, queremos encontrar $x_1, x_2, \ldots, x_n \in \mathbb{R}^n$ tais que

$\begin{align*}
f_1(x_1, x_2, \ldots, x_n) &= 0 \\
f_2(x_1, x_2, \ldots, x_n) &= 0 \\
\quad\quad\quad\vdots &\\
f_n(x_1, x_2, \ldots, x_n) &= 0,
\end{align*}$
em que $F(x) = (f_1(x), f_2(x), \ldots, f_n(x))$.

Nesse caso podemos usar resultados de Cálculo de Várias Variáveis. 
Lembremos que cada função $f_i: \mathbb{R}^n \rightarrow  \mathbb{R}$ admite uma aproximação linear

$$f_i(y) \approx f_i(x) + \nabla f_i(x)^\top(y - x),\ i = 1, \ldots, n.$$
em que $\nabla f(x) = (\partial f_i/\partial{x_1},\partial f_i/\partial{x_2},\ldots, \partial f_i/\partial{x_n})^\top$ é o gradiente de $f_i$ em $x$. Podemos escrever todas essas equações de forma compacta lembrando a definição da matriz Jacobiana de $F$ que é composta por linhas com os gradientes:

$$J_F(x) = \left[ \begin{array}{c}
\nabla f_1(x_1, x_2, \ldots, x_n))^\top \\
\nabla f_2(x_1, x_2, \ldots, x_n))^\top \\
\vdots \\
\nabla f_n(x_1, x_2, \ldots, x_n))^\top
\end{array} \right].$$

Temos o seguinte teorema. 

> **Teorema: (Teorema da série de Taylor para funções vetoriais)** 
> Sejam $x=\left(x_{1}, x_{2}, \ldots, x_{n}\right)^{T}, F=\left(f_{1}, f_{2}, \ldots, f_{m}\right)^{T}$, e assuma que  $F(x)$ tem derivadas limitadas pelo menos até ordem 2. Então, a partir de um vetor de direções  $d=\left(d_{1}, d_{2}, \ldots, d_{n}\right)^{T}$, a expansão de Taylor para cada função $f_{i}$ em cada coordenada $x_{j}$ nos dá
>
>$$F(x+d)=F(x)+J_F(x) d+\mathcal{O}\left(\|d\|^{2}\right)$$
>em que  $J_F(x)$ é a matrix Jacobiana das primeiras derivadas de $F$ em $x$.

Assim, fazendo $y=x+d$ podemos usar a aproximação

$$F(y) \approx F(x) + J_F(x)(y - x).$$
e então aplicar as mesmas ideias que nos levaram a deduzir o método de Newton.

Com efeito, queremos resolver

$$F(x) = 0.$$
Já temos uma aproximação da solução $x^k$ e queremos melhorá-la. Uma ideia é então substituir a função não-linear $F$ por sua aproximação linear calculada nesse último ponto e usar o seu zero como novo ponto. Isso é queremos resolver

$$F(x^{k + 1}) \approx F(x^k) + J_F(x^k)(x^{k + 1} - x^k) = 0.$$
Isolando $x^{k + 1}$, que pode ser feito desde que a matrix  Jacobiana seja inversível. Assim obtemos a iteração de Newton

$$x^{k +1} = x^k - J_F(x^k)^{-1}F(x^k).$$
##### Observações

- A iteração de Newton é uma clara generalização da equação que define o método de Newton no caso unidmensional: $x_{k+1} = x_k - (f'(x_k))^{-1} f(x_k)$

- Apesar da fórmula acima sugerir que devemos inicialmente inverter a matriz jacobiana, não há necessidade de inverter nenhuma matriz, o que exigiria a solução de $n$ sistemas lineares gerando uma complexidade total de $O(n ^4)$. Basta resolver inicialmente um único sistema

$$J_F(x^k)d^{k} = F(x^k)$$
e em seguida atualizar

$$x^{k + 1} = x^{k} - d^{k}.$$

- Se a Jacobiana for inversível, claramente, esses dois passos são equivalentes à fórmula do método de Newton dada acima.

-  O vetor $d_k$ é a chamado **direção de Newton**.

"""

# ╔═╡ e22b16be-6982-414e-a51a-0f472960c5df
md"""
#### Exemplo
Se quisermos resolver

$$F(x) = \left[ \begin{array}{c}
    x_1^2 - e^{-x_1 x_2} \\
    x_1x_2 + \sin(x_1)
\end{array} \right] = 0.$$

Temos

$$J_F(x) = \left[ \begin{array}{cc}
    2x_1 + x_2e^{-x_1 x_2} & x_1 e^{-x_1 x_2} \\
    x_2 + \cos(x_1)        & x_1
\end{array} \right].$$
Vamos implementar o método de Newton e testá-lo.

"""

# ╔═╡ e8f51d53-965b-4458-be6c-5aa2f3ab07bf
# Implementação
function newton_siseq(F, J, x⁰; ε :: Float64 = 1.0e-5, itmax :: Int = 100)
	df = DataFrame(k = Int[], xₖ = Vector[], normFᵏ = Float64[])
	k = 0
	xᵏ = x⁰
	while k ≤ itmax

	end
	return df, xᵏ, :MaxIter	
end

# ╔═╡ 90150313-e18d-46be-973f-330331870a0d
begin
	F(x) = [x[1]^2 - exp(-x[1]*x[2]), 
		    x[1]*x[2] + sin(x[1])]
	J(x)= [2*x[1] + x[2]*exp(-x[1]*x[2]) x[1]*exp(-x[1]*x[2]);
		   x[2] + cos(x[1])                   x[1] ]
	x⁰ = [2.,1]
	J(x⁰)
end

# ╔═╡ ab6ec7cd-f95e-44b3-ab4e-9cc97dfdf0df
df1, xᵏ,  = newton_siseq(F, J, x⁰,ε = 1e-12)

# ╔═╡ edb05618-8994-45cb-b502-88ff1db7480f


# ╔═╡ 29651fb8-dfdf-46af-995f-4bf9ba11ab6f
md"""

#### Critério de Parada
Note que temos nesse caso o mesmo problema para determinar o momento ideal de parada. Assim como no método de Newton para equações podemos usar a norma de $F(x)$ para definir quando o ponto está perto da solução. A justificativa para isso é continuidade. Uma justificativa mais formal pode ser obtida usando a expansão de Taylor em torno da solução $x^*$, assim como foi feito no método para uma variável. Outras opções de critério de parada que são muito usadas na prática são:

$\begin{aligned}
\| F(x) \| &\leq \epsilon \| F(x^0) \| \\
\| F(x) \| &\leq \epsilon_0 \| F(x^0) \| + \epsilon_1 \\
\| d^k \| &\leq \epsilon.
\end{aligned}$

Precisamos também destacar que a operação que mais cara em cada iteração do método de Newton é a resolução do sistema linear para cômputo do passo. Isso pode ser feito com os métodos como a fatoração LU. Em alguns casos, principalmente quando as matrizes envolvidas são grandes e esparsas, pode ser interessante usar um método iterativo para achar o passo de Newton. Nesse caso o passo não é calculado exatamente, apenas uma aproximação é obtida. Se a aproximação obtida for boa o método se comporta muitas vezes bem e é conhecido como Newton *inexato* ou *truncado*.

##### Convergência
Outro problema de do método de Newton para equações unidimensionais que também ocorre com o caso multidimensional é que a convergência não é garantida se o ponto inicial não estiver próximo de um zero onde a matriz Jacobiana não nula. O resultado típico de convergência é muito parecido com o resultado para uma dimensão apenas.

>**Teorema (da Convergência Quadrática de Newton).** Seja $F:\mathbb{R}^n \rightarrow \mathbb{R^n}$ uma função duas vezes continuamente diferenciável. Se $x^0$ inicia perto de uma raiz $x^*$ para a qual a matriz jacobiana de $F$ é inversível, então o método de Newton está bem definido e gera uma sequência convergindo para $x^*$ tal que 
>
>$$\|x^{k+1}−x^∗\| \leq M \|x^k−x^∗\|^2.$$
> em que $M>0$.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[compat]
DataFrames = "~1.2.2"
ForwardDiff = "~0.10.23"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f885e7e7c124f8c92650d61b9477b9ac2ee607dd"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.1"

[[ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "9a1d594397670492219635b35a3d830b04730d62"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.1"

[[CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dce3e3fea680869eaa0b774b2e8343e9ff442313"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.40.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

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
deps = ["LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "d8f468c5cd4d94e86816603f7d18ece910b4aaf1"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.5.0"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "6406b5112809c08b1baa5703ad274e1dded0652f"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.23"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

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

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "be9eef9f9d78cecb6f262f3c10da151a6c5ab827"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.5"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "d940010be611ee9d67064fe559edbb305f8cc0eb"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.2.3"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

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
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "f0bccf98e16759818ffc5d97ac3ebf87eb950150"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.8.1"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3c76dde64d03699e074ac02eb2e8ba8254d428da"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.13"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "fed34d0e71b91734bf0a7e10eb1bb05296ddbcd0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─dbfd283a-ea6e-11eb-2033-a5646e8d2681
# ╠═a236cca3-96b6-4b9c-b5b2-3a4bd4c716e7
# ╠═9395bb5c-4c00-44b7-8ad1-77545550d458
# ╠═93fd1c70-bfe5-4904-a90d-e8190f7314c5
# ╠═41eac1c5-afc9-4d38-b4e9-5e33481cab72
# ╠═3943d502-00d2-49bd-a804-b0c7c9476f60
# ╟─5a324577-a8e3-4b7b-b49e-bb50e578e465
# ╟─e22b16be-6982-414e-a51a-0f472960c5df
# ╠═e8f51d53-965b-4458-be6c-5aa2f3ab07bf
# ╠═90150313-e18d-46be-973f-330331870a0d
# ╠═ab6ec7cd-f95e-44b3-ab4e-9cc97dfdf0df
# ╠═edb05618-8994-45cb-b502-88ff1db7480f
# ╟─29651fb8-dfdf-46af-995f-4bf9ba11ab6f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
