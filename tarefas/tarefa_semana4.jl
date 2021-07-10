### A Pluto.jl notebook ###
# v0.14.8

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

# ╔═╡ Cell order:
# ╟─63c25d7e-e17f-11eb-25e8-c3a9aaebcd7b
# ╠═b3da3782-393c-4098-b157-9835e725ac7e
# ╠═5592f686-8a8d-4de2-93c9-ecf624e418f8
# ╟─d7dc68d9-dd85-4e25-a766-a7e4e860a249
