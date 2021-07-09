### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 21595edc-d9bf-11eb-233f-abb831d37641
# Pacotes usados na aula!
begin
	using Plots, PlutoUI
	plotly() #Um backend para Gráficos mais iterativos
	using DataFrames, CSV, HTTP, RollingFunctions, Dates
	import Pkg; Pkg.add("StatsPlots"); Pkg.add("Missings")
	using StatsPlots, Missings, StatsBase
end

# ╔═╡ 8bf5d656-ed40-4742-9f9b-acdbce34c917
begin
	Pkg.add("RDatasets")
	using RDatasets
end

# ╔═╡ f903bc7e-5ead-4e30-a8ec-ba7523e21f98
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 04 - Aula 01-02
"""

# ╔═╡ 85ebfc47-80dd-45ce-9427-007593a2fc61
md"""
# Vizualização de Dados
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
begin
  df_geral = Missings.replace(CSV.read(HTTP.get(url).body, DataFrame),0)
  df_geral = df_geral.x	
end

# ╔═╡ 40594163-2cd0-4543-b872-5e4e3e79a1ad
# Nomes das colunas
names(df_geral)

# ╔═╡ f2a7995f-638e-4811-84f8-b74079499ebf
# Ordenando por coluna  (Sort)
sort(df_geral, :state)

# ╔═╡ 608c9d45-a181-4b5c-a7b5-a5311284b0bb
# Ordenando por coluna ordem reversa  (Sort)
sort(df_geral, :state, rev=true)

# ╔═╡ 703618cc-d1cc-44c4-ad7a-4b6aa1f92c3a
#Filtrando
df_sc = filter(row -> row.state ==  "SC" && row.date >= Date("2021-01-01") &&  !ismissing(row.vaccinated), df_geral)

# ╔═╡ a901b28d-7742-4686-8557-609e4855d383
Sul = ["SC", "PR", "RS"]

# ╔═╡ d38691e8-6ce2-475c-8a31-d93f1365c6e4
df_sul = sort(filter(row -> row.state ∈ Sul && row.date >= Date("2021-01-01"), df_geral),:state)

# ╔═╡ a61ddbdf-763e-495d-ad0d-17e64413f8aa
md"""
- Como calcular o número de vacinados por dia, em SC?
  - Coluna `:newVaccinated`
"""

# ╔═╡ f6caeac6-0ded-46b7-afce-301248731d93
#  vcat (vertical concatenation)
newVaccinated = [ 0; df_sc.vaccinated[2:end] - df_sc.vaccinated[1:end-1]]

# ╔═╡ 733c6000-ac10-402a-a395-d55c93d96a19
length(newVaccinated)

# ╔═╡ 7d4b4e60-74be-47a9-82de-121318b668a6
df_sc.newVaccinated = newVaccinated

# ╔═╡ 56ce8318-9c46-416f-a649-280a76532925
df_sc

# ╔═╡ 0cd02c71-d87a-48b6-9d7e-22f4968b0811
bar(df_sc.date, df_sc.newVaccinated)

# ╔═╡ 39197362-dc29-4349-82c7-db907fb0086e
#StatsPlots
# @df df_sc bar(:date, [:newCases :newVaccinated], c=[:red :lightblue])

# ╔═╡ 4e72aea5-ef93-4f8b-b320-dab26b7114f5
# Apensando dfs

# ╔═╡ d469c45a-7705-49ab-95d4-de2c22f6ea93
df_pr = filter(row -> row.state == "PR" && row.date >= Date("2021-01-01") && !ismissing(row.vaccinated), df_geral)

# ╔═╡ cff2cf15-ac1e-4f04-862e-198c9e53a252
df_rs = filter(row -> row.state == "RS" && row.date >= Date("2021-01-01") && !ismissing(row.vaccinated), df_geral)

# ╔═╡ d91059e6-2c32-41de-a4d8-b1c77d1850fd


# ╔═╡ 6157ba8c-ee6d-465b-bb63-aa079cbe0e6e
append!(df_sc,df_rs, cols=:union)

# ╔═╡ 335353f9-3201-4b1e-92cb-5ed1b3f768d1
append!(df_sc,df_pr, cols = :union)

# ╔═╡ a9f406e1-98de-4278-a5bc-a2256be311de
# Agrupamento
gdf = groupby(df_geral,:state)

# ╔═╡ 990a22ac-d30d-4f02-9e81-9d13a879faba
combine(gdf, :newCases => mean)

# ╔═╡ bfddc6ca-2d24-4aa5-bef7-e2493323d72e
sort(combine(gdf, :deaths => maximum => :NumeroMortos, :deaths_per_100k_inhabitants => maximum => :Mortos100k_hab), :Mortos100k_hab, rev=true)

# ╔═╡ c003ad5e-3be9-477a-9b5c-866b02580da9
for df in gdf
	plt = @df df bar(:date, :deaths)
	estado = "grafico"*df.state[1]
	# savefig(plt, estado)

end

# ╔═╡ 1bfd2c5f-294a-4685-95e1-479aed323da1
names(df_geral)

# ╔═╡ a96e9951-e919-4d4f-9652-1336674366bf
md"""
- Pacote `RDatasets.jl`
  - Banco de dados para exercícios da linguagem `R` convertida para o uso em `DataFrame`
"""

# ╔═╡ 6d3613ee-d453-41db-9e12-60e3225ef425
#  700+ conjunto de dados de R
RDatasets.datasets()

# ╔═╡ 71a5217e-801f-4894-ae61-1071d64b119c
# Tabela com os pacotes do R disponíveis
RDatasets.packages()

# ╔═╡ 87465641-3d13-4ba7-98aa-230155b80798
iris = dataset("datasets", "iris")

# ╔═╡ 299b909f-bd1b-46d3-9db5-34b3ca3a24a3
gdf_iris = groupby(iris,:Species)

# ╔═╡ 3efab108-7951-4afc-834d-bc79c1a39869
combine(gdf_iris, nrow, :SepalLength => (x -> [extrema(x)]) => [:max, :min])

# ╔═╡ 224cc1ad-1f4f-4133-a33e-f3272ea4b63b
with_terminal() do
	for df in gdf_iris
		println(size(df,1))
	end
end

# ╔═╡ d0d3d873-facb-47ee-bec2-881626e55cad
Movies = dataset("ggplot2", "movies")

# ╔═╡ cae15489-7f91-4585-8caf-abb2e79a248a
describe(Movies)

# ╔═╡ 1040e938-c796-4323-ae93-ef5026ae4d11
# Joins (Juntando dados)

# ╔═╡ f1dfc141-2bb4-48c5-a03c-ebed327d47f7
pessoas = DataFrame(NM = [20, 30, 40], Nome = ["Enzo", "Vitoria", "Valentina"])

# ╔═╡ d7207a7f-4cc8-48f2-b14d-033dc3e983f3
curso = DataFrame(NM = [20, 30, 40], Curso = ["Matemática", "Automação", "Materiais"])

# ╔═╡ 5b769466-1726-4add-ba6b-e1b86131bda4
nome_curso = innerjoin(pessoas, curso, on = :NM)

# ╔═╡ e7c913b0-3f1d-4f54-a067-481659fd0b6b
a = DataFrame(Cidade = ["Gaspar", "Brusque", "Brusque", "Blumenau", "Telêmaco Borba"], Nomes = ["Voão", "Jainá", "Ledro", "LR", "Tudri"], Categoria = [1,2,3,4,5])

# ╔═╡ e2a3e935-5a53-4b07-9eab-086ee2255c84
b = DataFrame(Localidade = ["Blumenau", "Blumenau", "Brusque"], Info = ["Tentenaro", "Leto", "Libis"],  Dados = [6, 7 , 3])

# ╔═╡ 2c425fac-d769-4fd9-89ce-58da77ccaac5
innerjoin(a,b, on = [:Cidade => :Localidade, :Categoria => :Dados ])

# ╔═╡ Cell order:
# ╠═f903bc7e-5ead-4e30-a8ec-ba7523e21f98
# ╠═21595edc-d9bf-11eb-233f-abb831d37641
# ╠═85ebfc47-80dd-45ce-9427-007593a2fc61
# ╟─7ceaa98c-b3d2-4ce7-8ccc-33c187087208
# ╠═92ead4ba-1a27-498f-af01-f26ac2c77cfe
# ╠═d23da46b-da4b-4290-abdf-3937cdc53f96
# ╠═40594163-2cd0-4543-b872-5e4e3e79a1ad
# ╠═f2a7995f-638e-4811-84f8-b74079499ebf
# ╠═608c9d45-a181-4b5c-a7b5-a5311284b0bb
# ╠═703618cc-d1cc-44c4-ad7a-4b6aa1f92c3a
# ╠═a901b28d-7742-4686-8557-609e4855d383
# ╠═d38691e8-6ce2-475c-8a31-d93f1365c6e4
# ╟─a61ddbdf-763e-495d-ad0d-17e64413f8aa
# ╠═f6caeac6-0ded-46b7-afce-301248731d93
# ╠═733c6000-ac10-402a-a395-d55c93d96a19
# ╠═7d4b4e60-74be-47a9-82de-121318b668a6
# ╠═56ce8318-9c46-416f-a649-280a76532925
# ╠═0cd02c71-d87a-48b6-9d7e-22f4968b0811
# ╠═39197362-dc29-4349-82c7-db907fb0086e
# ╠═4e72aea5-ef93-4f8b-b320-dab26b7114f5
# ╠═d469c45a-7705-49ab-95d4-de2c22f6ea93
# ╠═cff2cf15-ac1e-4f04-862e-198c9e53a252
# ╠═d91059e6-2c32-41de-a4d8-b1c77d1850fd
# ╠═6157ba8c-ee6d-465b-bb63-aa079cbe0e6e
# ╠═335353f9-3201-4b1e-92cb-5ed1b3f768d1
# ╠═a9f406e1-98de-4278-a5bc-a2256be311de
# ╠═990a22ac-d30d-4f02-9e81-9d13a879faba
# ╠═bfddc6ca-2d24-4aa5-bef7-e2493323d72e
# ╠═c003ad5e-3be9-477a-9b5c-866b02580da9
# ╠═1bfd2c5f-294a-4685-95e1-479aed323da1
# ╟─a96e9951-e919-4d4f-9652-1336674366bf
# ╠═8bf5d656-ed40-4742-9f9b-acdbce34c917
# ╠═6d3613ee-d453-41db-9e12-60e3225ef425
# ╠═71a5217e-801f-4894-ae61-1071d64b119c
# ╠═87465641-3d13-4ba7-98aa-230155b80798
# ╠═299b909f-bd1b-46d3-9db5-34b3ca3a24a3
# ╠═3efab108-7951-4afc-834d-bc79c1a39869
# ╠═224cc1ad-1f4f-4133-a33e-f3272ea4b63b
# ╠═d0d3d873-facb-47ee-bec2-881626e55cad
# ╠═cae15489-7f91-4585-8caf-abb2e79a248a
# ╠═1040e938-c796-4323-ae93-ef5026ae4d11
# ╠═f1dfc141-2bb4-48c5-a03c-ebed327d47f7
# ╠═d7207a7f-4cc8-48f2-b14d-033dc3e983f3
# ╠═5b769466-1726-4add-ba6b-e1b86131bda4
# ╠═e7c913b0-3f1d-4f54-a067-481659fd0b6b
# ╠═e2a3e935-5a53-4b07-9eab-086ee2255c84
# ╠═2c425fac-d769-4fd9-89ce-58da77ccaac5
