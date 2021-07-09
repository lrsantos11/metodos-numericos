### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 4284c20f-05ed-4707-ad8d-a43ddefbd621
begin
	import Pkg; Pkg.add("HTTP"); Pkg.add("RollingFunctions")
	Pkg.add("StatsBase"); Pkg.add("CSV")
	using DataFrames, CSV, HTTP, RollingFunctions, Dates
end

# ╔═╡ 21595edc-d9bf-11eb-233f-abb831d37641
# Ferramentas úteis para a aula!
begin
	using Plots, PlutoUI
	plotly() #Um backend para Gráficos mais iterativos
end

# ╔═╡ 2906bfca-784f-4a7c-9fe1-4a34b5fa6d6c
### Pacote de Estatística e dados básicos
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
- [Tutorial completo](https://github.com/bkamins/Julia-DataFrames-Tutorial/) de `DataFrames` usando Jupyter
- Correspondente ao `pandas` do Python e ao `r-dataframe` do R.
- Um `DataFrame` é uma estrutura de dados com colunas que tem nomes (_labels_) e que podem ter diferentes tipos de dados. 
- Tem sempre duas dimensões e funciona parecido com uma tabela do SQL ou uma planilha (do Excel).

"""

# ╔═╡ 5e6c2def-5512-40ab-9d9d-2d9b83b8ff1e
a = [1,2,3,4,5.]

# ╔═╡ 7eb8f7db-6fc7-44c5-9cd1-4c8ae28222b7
# Implementação

# ╔═╡ b7f2d576-f730-4f7c-bb68-9c643c2d14b2
df_a =  DataFrame( X =  a)

# ╔═╡ 01a33976-beb3-40fd-af82-7cff433bee3c
df_b = DataFrame( :ColunaA => a)

# ╔═╡ c6d28eb8-7819-448b-94de-42ca87d0c3d6
df = DataFrame(:A => 1:2:1000, :B => repeat(1:10, inner = 50), :C => 1:500)

# ╔═╡ 5360d3b5-191a-4ab1-ae4f-4bbd1206c04b
# Quantidade de linhas e colunas
size(df)

# ╔═╡ 6121d36a-2593-4df9-ac68-9c8b62aeeeca
# Primeiras 5 linhas
first(df, 5)

# ╔═╡ c831b543-a31a-45b9-b32a-369ccac49f1f
# Últimas 10 linhas
last(df,10)

# ╔═╡ 21add671-cab3-4292-bc31-0bca5d4b7ab8
#  Subconjuntos
df[[10, 20, 50],[:A, :B]]

# ╔═╡ 83432568-03a7-4969-b141-6847a8e6b630
df[:,[:C, :A]]

# ╔═╡ e28cfe3f-5f51-482b-80df-51b2f322d937
# coluna de df como vetor
df[:,:C]

# ╔═╡ 0a046f08-7cf5-4582-86af-bc7b07bea716
# Coluna de df como dataframe
df[:,[:C]]

# ╔═╡ 3e6528b2-aa68-452c-851f-b0b39525b468
# Outra maneira de tomar coluna como vetor
df.C

# ╔═╡ 1c3e8777-d822-4df4-996b-1eb1077b97c8
# Seleção de colunas
df[df.A .> 500,:]

# ╔═╡ d2c70304-c8d8-43c6-8b3f-5f2deec59d67
df[(df.A .> 500) .& (250 .<  df.C .< 350), :]

# ╔═╡ 3bb506e0-73b2-4d55-893b-168dbbe8022a
# Resumo dos dados
describe(df, :all)

# ╔═╡ 0b7af787-794e-474b-bd88-ebb3911b6291
# Média
mean(df.B)

# ╔═╡ f34e38c9-35e0-4c10-b210-990796a8d8d5
md"""
# Dados disponibilizados
- Dados em geral em formato `csv` (_comma separared values_ - valores separados por vírgula)
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

# ╔═╡ 625f5ddc-333f-468a-9074-d39a5a591eba
size(df_geral) 

# ╔═╡ 40594163-2cd0-4543-b872-5e4e3e79a1ad
# Nomes das colunas
names(df_geral)

# ╔═╡ 47c48fcc-0c32-4897-865a-326b94ed0701
df_sc = filter(row -> row.state == "SC" && row.date >= Date("2020-12-01"),df_geral)

# ╔═╡ ef6d2d71-eb4d-45a7-9bb3-4d383eca1ad5
# Detalhes sobre os campos
combine(df_sc, :newDeaths.=> [sum,  mean], :newCases .=> [sum, mean])

# ╔═╡ 5564bb12-ba34-4116-b2b9-d4ea2d578c92
casos = df_sc.newCases

# ╔═╡ 5a08dd82-1b97-4713-b176-c7fc4ea425f9
bar(df_sc.date,casos, label = "Novos Casos Diários", title = "Santa Catarina",c=:skyblue2,alpha = 0.2)

# ╔═╡ 6ab3d2c3-0c6d-4f99-b68b-6d93e86705b8
md"""
### Média móvel
"""

# ╔═╡ 2d273cb6-bc47-4621-86f2-2f6ede327ad2
begin
	janela = 7
	media_movel = rollmean(casos,janela)
	bar(df_sc.date,casos,label = "Novos Casos Diários", title = "Santa Catarina - Dez/20 - Jul/2021",c=:skyblue2, alpha = 0.2)
	plot!(df_sc.date[janela:end],  media_movel, label = "Média móvel de $janela dias", lw = 3,c=:skyblue2)
end

# ╔═╡ 90e35fba-58e3-4d3e-a12b-0ded94ba49a7
md"""
### Dados IBAMA
 - Fonte [IBAMA](https://dados.gov.br/dataset/autos-de-infracao)
 - Apresentação no CidamoWeek de [Lucas Barros](https://youtu.be/YSPcql_bpG8?t=5718)
   - [Jupyter notebook](https://colab.research.google.com/drive/1PUqOqMQtOY3nZmzYZnErquO64bUKi3y1) da apresentação
"""

# ╔═╡ 4859e1a8-ea34-498c-9f52-933be8475827
url_ibama = "http://dadosabertos.ibama.gov.br/dados/SIFISC/auto_infracao/auto_infracao/auto_infracao.csv"

# ╔═╡ 376c6be2-b1d2-427e-8243-d48934e756e3
df_ibama = CSV.read(HTTP.get(url_ibama).body, DataFrame,enc"utf8")

# ╔═╡ ab114725-f7d8-47b4-bb58-a601d095e2c6
md"""
### Our world in data

- Fonte para dados COVID no mundo em [https://ourworldindata.org/coronavirus-source-data](https://ourworldindata.org/coronavirus-source-data)
"""

# ╔═╡ f2a7995f-638e-4811-84f8-b74079499ebf


# ╔═╡ a96e9951-e919-4d4f-9652-1336674366bf


# ╔═╡ 8bf5d656-ed40-4742-9f9b-acdbce34c917


# ╔═╡ 8af1738c-ff53-4e37-92ea-64cfbc593242
combine(df_sc, :vaccinated => maximum∘skipmissing)

# ╔═╡ 59fddee1-11ce-466f-971e-0c325da72c65
select(df_sc, :vaccinated => collect, :vaccinated_per_100_inhabitants => collect,skipmissing=true)


# ╔═╡ 471695c6-3fa2-49f6-8236-519ce1160af7
combine(df_sc, :vaccinated =>  mean∘skipmissing => :MediaVacinados)

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
# ╠═01a33976-beb3-40fd-af82-7cff433bee3c
# ╠═c6d28eb8-7819-448b-94de-42ca87d0c3d6
# ╠═5360d3b5-191a-4ab1-ae4f-4bbd1206c04b
# ╠═6121d36a-2593-4df9-ac68-9c8b62aeeeca
# ╠═c831b543-a31a-45b9-b32a-369ccac49f1f
# ╠═21add671-cab3-4292-bc31-0bca5d4b7ab8
# ╠═83432568-03a7-4969-b141-6847a8e6b630
# ╠═e28cfe3f-5f51-482b-80df-51b2f322d937
# ╠═0a046f08-7cf5-4582-86af-bc7b07bea716
# ╠═3e6528b2-aa68-452c-851f-b0b39525b468
# ╠═1c3e8777-d822-4df4-996b-1eb1077b97c8
# ╠═d2c70304-c8d8-43c6-8b3f-5f2deec59d67
# ╠═2906bfca-784f-4a7c-9fe1-4a34b5fa6d6c
# ╠═3bb506e0-73b2-4d55-893b-168dbbe8022a
# ╠═0b7af787-794e-474b-bd88-ebb3911b6291
# ╟─f34e38c9-35e0-4c10-b210-990796a8d8d5
# ╟─7ceaa98c-b3d2-4ce7-8ccc-33c187087208
# ╠═92ead4ba-1a27-498f-af01-f26ac2c77cfe
# ╠═d23da46b-da4b-4290-abdf-3937cdc53f96
# ╠═625f5ddc-333f-468a-9074-d39a5a591eba
# ╠═40594163-2cd0-4543-b872-5e4e3e79a1ad
# ╠═47c48fcc-0c32-4897-865a-326b94ed0701
# ╠═ef6d2d71-eb4d-45a7-9bb3-4d383eca1ad5
# ╠═5564bb12-ba34-4116-b2b9-d4ea2d578c92
# ╠═5a08dd82-1b97-4713-b176-c7fc4ea425f9
# ╟─6ab3d2c3-0c6d-4f99-b68b-6d93e86705b8
# ╠═2d273cb6-bc47-4621-86f2-2f6ede327ad2
# ╟─90e35fba-58e3-4d3e-a12b-0ded94ba49a7
# ╠═4859e1a8-ea34-498c-9f52-933be8475827
# ╠═376c6be2-b1d2-427e-8243-d48934e756e3
# ╟─ab114725-f7d8-47b4-bb58-a601d095e2c6
# ╠═f2a7995f-638e-4811-84f8-b74079499ebf
# ╠═a96e9951-e919-4d4f-9652-1336674366bf
# ╠═8bf5d656-ed40-4742-9f9b-acdbce34c917
# ╠═8af1738c-ff53-4e37-92ea-64cfbc593242
# ╠═59fddee1-11ce-466f-971e-0c325da72c65
# ╠═471695c6-3fa2-49f6-8236-519ce1160af7
