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
###### Semana 02
"""

# ╔═╡ a19428da-2ef3-4c39-b2bf-56d2ebc24338
md"""
**Estudante:** $(@bind SeuNome TextField(default="Digite seu nome aqui"))
"""

# ╔═╡ dc502ee2-d680-11eb-2256-694918597773
md"""
#### Tarefa Semana 2

> Repita os procedimentos feitos com a aproximação da derivada na Aula2-Semana2 para proceder para gerar uma gráfico com d $h$ versus o Erro Absoluto $E_a$ usando 
> 
>$\frac{f(x_0 + h) - f(x_0 - h)}{2h}$
> como aproximação da derivada $f'(x_0)$ para $f(x)= \sin(x)$ em $x_0 = 1.2$.
> 1. Gere um gráfico igual ao último gráfico da Aula2-Semana2 para esta aproximação e observe similitudes e deferenças entre este e o gráfico para a aproximação apresentada em sala de aula. 
> 1. **Pontos-extra:** Gere um gráfico pra alguma outra função de sua escolha que contenha as duas aproximações da derivada: a mostrada em sala de aula e esta da tarefa.

"""

# ╔═╡ 7c528774-b222-44e5-8a09-77a96cdf5b0d
md"""
**Observações:** 

- Faça o upload do Notebook Pluto com nome `Tarefa2_Meu_Nome.pluto.jl` na Tarefa 2  no Moodle

- Não esqueça de incluir as **Referências** consultadas, incluindo pessoas.

- Você abrir diretamente no Pluto a tarefa usando o seguinte [link](https://github.com/lrsantos11/metodos-numericos/raw/2021-1/tarefas/tarefa_semana2.jl)
"""

# ╔═╡ Cell order:
# ╟─eb2cde17-ccb3-41df-96d3-f0ef87a067fc
# ╟─e5e5e2d3-5674-4e0d-86b3-49a6cc07a60b
# ╟─a19428da-2ef3-4c39-b2bf-56d2ebc24338
# ╟─dc502ee2-d680-11eb-2256-694918597773
# ╠═7c528774-b222-44e5-8a09-77a96cdf5b0d
