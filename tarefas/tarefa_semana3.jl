### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ eb2cde17-ccb3-41df-96d3-f0ef87a067fc
using PlutoUI

# ╔═╡ e5e5e2d3-5674-4e0d-86b3-49a6cc07a60b
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 03
"""

# ╔═╡ a19428da-2ef3-4c39-b2bf-56d2ebc24338
md"""
**Estudante:** $(@bind SeuNome TextField(default="Digite seu nome aqui"))
"""

# ╔═╡ dc502ee2-d680-11eb-2256-694918597773
md"""
#### Tarefa Semana 3

Usando os dados da COVID19 disponibilizados na S03A03, faça os seguintes procedimentos
1. Escolha um estado brasileiro e filtre os dados para o ano de 2021
1. Apresente uma tabela `DataFrame` usando o comando `combine` com total e média de mortos por dia e casos por dia
1. Para o estado escolhido apresente o total de vacinados e o número de vacinados por 100k habitantes. Qual o valor para o Brasil? Procure na internet e compare os valores do estado escolhido e do Brasil com pelo menos mais 3 países.
1. Faça um gráfico de barras e inclua a média móvel com $7$ e $14$ dias com os seguintes dados para o estado escolhido com _Mortes Diárias_ (`newDeaths`)
1. Repita o item 4. para o Brasil (Dica: Filtre usando o `state == "TOTAL"`
1. Compare o número vacinados por 100k habitantes com primeira e segunda dose, através de um gráfico  tanto para o estado escolhido no item 1. quanto para o Brasil. 

"""

# ╔═╡ 7c528774-b222-44e5-8a09-77a96cdf5b0d
md"""
**Observações:** 

- Faça o upload do Notebook Pluto com nome `Tarefa2_Meu_Nome.pluto.jl` na Tarefa 2  no Moodle

- Não esqueça de incluir as **Referências** consultadas, incluindo pessoas.

- Você abrir diretamente no Pluto a tarefa usando o seguinte [link](https://github.com/lrsantos11/metodos-numericos/raw/2021-1/tarefas/tarefa_semana3.jl)
"""

# ╔═╡ Cell order:
# ╟─eb2cde17-ccb3-41df-96d3-f0ef87a067fc
# ╟─e5e5e2d3-5674-4e0d-86b3-49a6cc07a60b
# ╟─a19428da-2ef3-4c39-b2bf-56d2ebc24338
# ╟─dc502ee2-d680-11eb-2256-694918597773
# ╟─7c528774-b222-44e5-8a09-77a96cdf5b0d
