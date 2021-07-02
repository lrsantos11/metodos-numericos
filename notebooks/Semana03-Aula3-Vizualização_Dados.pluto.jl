### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 4284c20f-05ed-4707-ad8d-a43ddefbd621
begin
	import Pkg; Pkg.add("HTTP"); Pkg.add("RollingFunctions")
	using DataFrames, CSV, HTTP, RollingFunctions, Dates
end

# ╔═╡ 21595edc-d9bf-11eb-233f-abb831d37641
# Ferramentas úteis para a aula!
begin
	using Plots, PlutoUI
	plotly() #Um backend para Gráficos mais iterativos
end

# ╔═╡ 356e53ef-39c7-45b9-b4d0-5bace1242b0e
using StatsBase

# ╔═╡ f903bc7e-5ead-4e30-a8ec-ba7523e21f98
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 03 - Aula 03
"""

# ╔═╡ aa519336-d5bc-4665-a067-cab6e525639d
md"""
- Exemplo de uso do `plotly`.
"""

# ╔═╡ c5da2535-e468-4f1a-bbf5-bda497f60994
scatter(rand(10))

# ╔═╡ 85ebfc47-80dd-45ce-9427-007593a2fc61
md"""
# Vizualização de Dados
"""

# ╔═╡ e5822f92-cc42-4968-a8d7-c7447777c980
md"""
- Atualmente a geração de dados e a disponibilidade destes dados está em voga
- Termos como _Ciência de Dados_, _Big Data_, etc., são bastante comuns nas áreas de tecnologia
- No Brasil, a lei de acesso a informações (LAI - Lei [12.527/2011](http://www.planalto.gov.br/ccivil_03/_ato2011-2014/2011/lei/l12527.htm) regula o acesso a informações e exige transparência e acessibilidade aos dados em geral do serviço público, de forma atualizada 
- Tomada de decisão baseada em dados é uma necessidade tanto no ambiente público quanto privado
"""

# ╔═╡ d0038966-d245-4659-8407-36561b6e57fd
md"""
## Uso de `DataFrames`

- `DataFrame` é um pacote de _tratamento de dados tabulados_ do Julia que permite análises de maneira robusta.
- Documentação do  [`DataFrames`](https://dataframes.juliadata.org/stable/)
- Correspondente ao `pandas` do Python e ao `r-dataframe` do R.
- Um `DataFrame` é uma estrutura de dados com colunas que tem nomes (_labels_) e que podem ter diferentes tipos de daods. 
- Tem sempre duas dimenões e funciona parecido com uma tabela do SQL ou uma planilha (do Excel).

"""

# ╔═╡ 5e6c2def-5512-40ab-9d9d-2d9b83b8ff1e
a = [1,2,3,4,5]

# ╔═╡ 7eb8f7db-6fc7-44c5-9cd1-4c8ae28222b7
# Implementação

# ╔═╡ b7f2d576-f730-4f7c-bb68-9c643c2d14b2
df_a =  DataFrame(a =  a)

# ╔═╡ 5360d3b5-191a-4ab1-ae4f-4bbd1206c04b
# Quantidade de linhas e colunas


# ╔═╡ 6121d36a-2593-4df9-ac68-9c8b62aeeeca
# Primeiras 5 linhas


# ╔═╡ c831b543-a31a-45b9-b32a-369ccac49f1f
# Últimas 10 linhas


# ╔═╡ 21add671-cab3-4292-bc31-0bca5d4b7ab8
#  Subconjuntos

# ╔═╡ f34e38c9-35e0-4c10-b210-990796a8d8d5
md"""
# Dados disponibilizados
- Dados em geral em formato `csv` (_comma separared values_)
  - Pacote `CSV.jl`
- Dados na internet
  - Pacote  `HTTP`
"""

# ╔═╡ 7ceaa98c-b3d2-4ce7-8ccc-33c187087208
md"""
### Dados da COVID Brasil
 - Vários portais (inclusive governamentais)
   * Dois importantes: [Brasil.io](https://brasil.io/home/) e [Portal wcota](https://covid19br.wcota.me/)
"""

# ╔═╡ 92ead4ba-1a27-498f-af01-f26ac2c77cfe
url = "https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv"

# ╔═╡ d23da46b-da4b-4290-abdf-3937cdc53f96
# Baixando dados via url
df_geral = CSV.read(HTTP.get(url).body, DataFrame)

# ╔═╡ 40594163-2cd0-4543-b872-5e4e3e79a1ad
# Nomes das colunas
names(df_geral)

# ╔═╡ 47c48fcc-0c32-4897-865a-326b94ed0701
df_sc = filter(row -> row.state == "SC" && row.date >= Date("2020-01-01"),df_geral)

# ╔═╡ 4317e4d9-37fe-4476-a277-e19101bd7855
### Pacote de Estatística e dados básicos

# ╔═╡ ef6d2d71-eb4d-45a7-9bb3-4d383eca1ad5
# Detalhes sobre os campos
combine(df_sc, :newDeaths.=> [sum,  mean], :newCases .=> [sum, mean])

# ╔═╡ 5564bb12-ba34-4116-b2b9-d4ea2d578c92
casos = df_sc.newDeaths

# ╔═╡ 5a08dd82-1b97-4713-b176-c7fc4ea425f9
bar(df_sc.date,casos, label = "Novos Casos Diários", title = "Santa Catarina",c=:skyblue2,alpha = 0.2)

# ╔═╡ 2d273cb6-bc47-4621-86f2-2f6ede327ad2
begin
	janela = 7
	media_movel = rollmean(casos,janela)
	bar(df_sc.date,casos,label = "Novos Casos Diários", title = "Santa Catarina",c=:skyblue2, alpha = 0.2)
	plot!(df_sc.date[janela:end],  media_movel, label = "Média móvel de $janela dias", lw = 3,c=:skyblue2)
end

# ╔═╡ 90e35fba-58e3-4d3e-a12b-0ded94ba49a7
md"""
### Dados IBAMA
 - Fonte [IBAMA](https://dados.gov.br/dataset/autos-de-infracao)
 - Apresentação no CidamoWeekd de [Lucas Barros](https://youtu.be/YSPcql_bpG8?t=5718)
   - [Jupyter notebook](https://colab.research.google.com/drive/1PUqOqMQtOY3nZmzYZnErquO64bUKi3y1) da apresentação
"""

# ╔═╡ 4859e1a8-ea34-498c-9f52-933be8475827
url_ibama = "http://dadosabertos.ibama.gov.br/dados/SIFISC/auto_infracao/auto_infracao/auto_infracao.csv"

# ╔═╡ 376c6be2-b1d2-427e-8243-d48934e756e3
# df_ibama = CSV.read(HTTP.get(url_ibama).body, DataFrame)

# ╔═╡ ab114725-f7d8-47b4-bb58-a601d095e2c6


# ╔═╡ Cell order:
# ╟─f903bc7e-5ead-4e30-a8ec-ba7523e21f98
# ╠═21595edc-d9bf-11eb-233f-abb831d37641
# ╟─aa519336-d5bc-4665-a067-cab6e525639d
# ╠═c5da2535-e468-4f1a-bbf5-bda497f60994
# ╟─85ebfc47-80dd-45ce-9427-007593a2fc61
# ╟─e5822f92-cc42-4968-a8d7-c7447777c980
# ╟─d0038966-d245-4659-8407-36561b6e57fd
# ╠═4284c20f-05ed-4707-ad8d-a43ddefbd621
# ╠═5e6c2def-5512-40ab-9d9d-2d9b83b8ff1e
# ╠═7eb8f7db-6fc7-44c5-9cd1-4c8ae28222b7
# ╠═b7f2d576-f730-4f7c-bb68-9c643c2d14b2
# ╠═5360d3b5-191a-4ab1-ae4f-4bbd1206c04b
# ╠═6121d36a-2593-4df9-ac68-9c8b62aeeeca
# ╠═c831b543-a31a-45b9-b32a-369ccac49f1f
# ╠═21add671-cab3-4292-bc31-0bca5d4b7ab8
# ╠═f34e38c9-35e0-4c10-b210-990796a8d8d5
# ╟─7ceaa98c-b3d2-4ce7-8ccc-33c187087208
# ╟─92ead4ba-1a27-498f-af01-f26ac2c77cfe
# ╠═d23da46b-da4b-4290-abdf-3937cdc53f96
# ╠═40594163-2cd0-4543-b872-5e4e3e79a1ad
# ╠═47c48fcc-0c32-4897-865a-326b94ed0701
# ╠═4317e4d9-37fe-4476-a277-e19101bd7855
# ╠═356e53ef-39c7-45b9-b4d0-5bace1242b0e
# ╠═ef6d2d71-eb4d-45a7-9bb3-4d383eca1ad5
# ╠═5564bb12-ba34-4116-b2b9-d4ea2d578c92
# ╠═5a08dd82-1b97-4713-b176-c7fc4ea425f9
# ╠═2d273cb6-bc47-4621-86f2-2f6ede327ad2
# ╟─90e35fba-58e3-4d3e-a12b-0ded94ba49a7
# ╠═4859e1a8-ea34-498c-9f52-933be8475827
# ╠═376c6be2-b1d2-427e-8243-d48934e756e3
# ╠═ab114725-f7d8-47b4-bb58-a601d095e2c6
