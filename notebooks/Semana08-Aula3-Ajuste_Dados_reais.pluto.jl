### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 21595edc-d9bf-11eb-233f-abb831d37641
# Pacotes usados na aula!
begin
	using Plots, PlutoUI
	plotly() #Um backend para Gráficos mais iterativos
	using DataFrames, CSV, HTTP, RollingFunctions, Dates
	import Pkg; Pkg.add("StatsPlots"); Pkg.add("Missings")
	using StatsPlots, Missings, StatsBase, LinearAlgebra
end

# ╔═╡ 1ef4cf62-0899-4e5c-8a17-33a2d72c482b
using LsqFit

# ╔═╡ f903bc7e-5ead-4e30-a8ec-ba7523e21f98
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 08 - Aula 03
"""

# ╔═╡ 85ebfc47-80dd-45ce-9427-007593a2fc61
md"""
# Ajuste de dados reais
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

# ╔═╡ cab9e418-8dd1-4acf-9caf-9af877c99b19
levels(df_geral.state)

# ╔═╡ f2a7995f-638e-4811-84f8-b74079499ebf
# Ordenando por coluna  (Sort)
sort(df_geral, :state)

# ╔═╡ 703618cc-d1cc-44c4-ad7a-4b6aa1f92c3a
#Filtrando
df_sc = filter(row -> row.state ==  "SC" && row.date ≥ Date("2020-01-01"), df_geral)

# ╔═╡ ca73e54e-180f-4b44-bcd8-4313c65afe79
exp_model(x,β) = β[1]*exp.(β[2]*x)

# ╔═╡ 6a06343d-a919-443c-aad0-5d9d4d9ffd8a
logistic_model(x,β)=  β[3] ./ (1 .+ exp.(-(x .- β[2]) ./ β[1]))

# ╔═╡ 23a3d271-3821-4ade-8dc1-7fcbbe84efac
gompertz_model(x,β) = β[3]*exp.(-β[2]*exp.(-x./β[1]))

# ╔═╡ fac60068-68e7-475a-afb0-d71f5b6ea9ff
let 
	f1(x) = exp_model(x,[2, 0.23])
	f2(x) = logistic_model(x,[4.8, 50, 100_000 ])
	f3(x) = gompertz_model(x,[12, 49, 100_000])
	plt = plot(f1,0,48, label = "Exp")
	plot!(f2, 0, 120, label = "Logístico")
	plot!(f3, 0, 120, label = "Gompertz", leg = :bottomright)
end

# ╔═╡ e9d9b943-ef42-4fa7-8ce8-eca7cc6cab89
md"""
Pacote `LsqFit.jl` precisa:
1. Modelo (não linear) com parâmetros a serem ajustados da forma `model(x,β)`, em que `β` é o vetor dos parâmetros
2. Dados de entrada do tipo $(x_i,y_i)$
3. Possivelmente um chute inicial para os parâmetros
e devolve pra gente os parâmetros ajustados, o vetor dos resíduos  e uma estimatia da jacobiana de $F(x)$, na solução.  Detalhe, estamos resolvendo 

$\min \frac{1}{2} \|F(x)\|^2$
"""

# ╔═╡ f2f1b749-806e-43e0-a938-62f15078a225
ydata = df_sc.totalCases

# ╔═╡ d252345f-d377-479a-9875-4f73007f36ec
num_rows, num_cols = size(df_sc)

# ╔═╡ c136a684-3e67-4270-b33c-eb70352d1bfe
xdata = collect(1:num_rows)

# ╔═╡ ac6739df-8cdc-4cd0-bb47-88b0175307f9
plt_casos = @df df_sc plot(xdata, :totalCases, label = "Total de Casos", leg = :bottomright)

# ╔═╡ 3c5cc6ea-4697-4f03-ae8f-30a01461f48e
md"""
## Exponencial
"""

# ╔═╡ 7794bb9a-c41c-4cf8-9ef0-0efb42ad746c
fit_exp = curve_fit(exp_model, xdata, ydata, [0.5, 0.5]);

# ╔═╡ 2c027de1-9ea6-4ee6-8808-55ac74fe7f1f
norm(fit_exp.resid)

# ╔═╡ de520f56-bb13-4326-82d9-d81c7fa2b655
β_exp = fit_exp.param

# ╔═╡ 52dd25a1-c3a9-472b-80ad-397002b652ab
plot(plt_casos, x->exp_model(x,β_exp),  label = "Exponencial")

# ╔═╡ d331a115-6922-45d0-b802-404ea47f353e
md"""
## Logistico
"""

# ╔═╡ f4708678-3420-400c-a110-57da16189bb9
fit_log = curve_fit(logistic_model, xdata, ydata, [0.5, 0.5, 0.5]);

# ╔═╡ 73d73c4c-929f-4c3e-a5ab-3494a337fbb4
fit_log.converged

# ╔═╡ 0c240c06-af84-4474-8103-3b58dd452d27
norm(fit_log.resid)

# ╔═╡ f03098df-bb79-4d68-bac2-32fc8e5c60f8
β_log = fit_log.param

# ╔═╡ 24c4b349-41a5-43da-af1a-71889b1fed24
plot(x->logistic_model(x,β_log),  label = "Logistico")

# ╔═╡ ff600f4d-0d14-4ee0-a9e9-5aa20a44ea26
md"""
## Gompertz
"""

# ╔═╡ 6fe34fab-8058-44d8-b10d-f69d4cc13347
fit_gom = curve_fit(gompertz_model, xdata, ydata, [0.5, 0.5, 1e6]);

# ╔═╡ f514bc1b-e0b4-4062-9706-e94da358bb22
fit_gom.converged

# ╔═╡ 03156486-3c5d-4890-9c26-6ebde6dc3ad8
norm(fit_gom.resid)/maximum(df_sc.totalCases)

# ╔═╡ 55b9ae65-b544-4ba1-898a-cf718edcffac
β_gom = fit_gom.param

# ╔═╡ 0e69917d-6942-465d-aefb-782104f4d0e7
plot(plt_casos, x->gompertz_model(x,β_gom), 0,1200,  label = "Gompertz", Title = "Ajuste dos dados de Casos - Modelo Gompertz")

# ╔═╡ eff8e5c2-12eb-4345-a15a-2cef557406bb
last(df_sc.vaccinated_second_per_100_inhabitants)

# ╔═╡ Cell order:
# ╟─f903bc7e-5ead-4e30-a8ec-ba7523e21f98
# ╟─21595edc-d9bf-11eb-233f-abb831d37641
# ╟─85ebfc47-80dd-45ce-9427-007593a2fc61
# ╟─7ceaa98c-b3d2-4ce7-8ccc-33c187087208
# ╠═92ead4ba-1a27-498f-af01-f26ac2c77cfe
# ╠═d23da46b-da4b-4290-abdf-3937cdc53f96
# ╠═40594163-2cd0-4543-b872-5e4e3e79a1ad
# ╠═cab9e418-8dd1-4acf-9caf-9af877c99b19
# ╠═f2a7995f-638e-4811-84f8-b74079499ebf
# ╠═703618cc-d1cc-44c4-ad7a-4b6aa1f92c3a
# ╠═ac6739df-8cdc-4cd0-bb47-88b0175307f9
# ╠═ca73e54e-180f-4b44-bcd8-4313c65afe79
# ╠═6a06343d-a919-443c-aad0-5d9d4d9ffd8a
# ╠═23a3d271-3821-4ade-8dc1-7fcbbe84efac
# ╠═fac60068-68e7-475a-afb0-d71f5b6ea9ff
# ╟─e9d9b943-ef42-4fa7-8ce8-eca7cc6cab89
# ╠═1ef4cf62-0899-4e5c-8a17-33a2d72c482b
# ╠═f2f1b749-806e-43e0-a938-62f15078a225
# ╠═d252345f-d377-479a-9875-4f73007f36ec
# ╠═c136a684-3e67-4270-b33c-eb70352d1bfe
# ╟─3c5cc6ea-4697-4f03-ae8f-30a01461f48e
# ╠═7794bb9a-c41c-4cf8-9ef0-0efb42ad746c
# ╠═2c027de1-9ea6-4ee6-8808-55ac74fe7f1f
# ╠═de520f56-bb13-4326-82d9-d81c7fa2b655
# ╠═52dd25a1-c3a9-472b-80ad-397002b652ab
# ╟─d331a115-6922-45d0-b802-404ea47f353e
# ╠═f4708678-3420-400c-a110-57da16189bb9
# ╠═73d73c4c-929f-4c3e-a5ab-3494a337fbb4
# ╠═0c240c06-af84-4474-8103-3b58dd452d27
# ╠═f03098df-bb79-4d68-bac2-32fc8e5c60f8
# ╠═24c4b349-41a5-43da-af1a-71889b1fed24
# ╟─ff600f4d-0d14-4ee0-a9e9-5aa20a44ea26
# ╠═6fe34fab-8058-44d8-b10d-f69d4cc13347
# ╠═f514bc1b-e0b4-4062-9706-e94da358bb22
# ╠═03156486-3c5d-4890-9c26-6ebde6dc3ad8
# ╠═55b9ae65-b544-4ba1-898a-cf718edcffac
# ╠═0e69917d-6942-465d-aefb-782104f4d0e7
# ╠═eff8e5c2-12eb-4345-a15a-2cef557406bb
