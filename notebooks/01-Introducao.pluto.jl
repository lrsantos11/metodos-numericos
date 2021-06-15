### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ d3ecc5f1-50ca-463e-9e8f-690fbb7bd56a
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ fdc2356e-08a0-45e1-8dda-a1a94888eeba
using PlutoUI

# ╔═╡ 8164d338-ce20-11eb-29ce-7749362afceb
md"
# Introdução à Linguagem Julia

Julia é uma linguagem dinâmica de alto nível e alto desempenho.
Ela se assemelha ao MATLAB e ao Python na facilidade de escrita
de código, mas sua velocidade pode ser comparável ao C e Fortran.

A versão mais atual do Julia é a **1.6**.
"

# ╔═╡ d0426d69-d528-45d6-b81b-c6d712452073
md"##  Pluto

- O Pluto é uma interface web para Julia que é leve e reativa.
Usando o Pluto, aulas e apresentações ficam mais práticas.

- Cada *célula* do Pluto pode ser executada com um `shift+enter`, ou
um `ctrl+enter`, sendo que o último comando cria automaticamente uma nova célula abaixo da que está sendo usada.

- Você pode adicionar novas células usando o `+` no acima ou abaixo de cada célula.
"

# ╔═╡ 9e5ca483-5b46-4ca8-bffa-1af3b97cd4f7
md"
## O REPL - Terminal Interativo

Ao abrir o Julia no Windows, ou digitar `julia` no terminal do Mac
ou Linux, se abrirá um prompt tipo

````julia
julia>
````

O Pluto também serve como esse prompt e todo comando digitado aqui
pode ser digitado lá.
"

# ╔═╡ 96ede339-ba1a-48d6-899e-d2ec9f54b44f
md"
## Pluto vs Editor

- O Pluto é utilizado para aulas, apresentações, workshops. A parte importante é a interatividade.

- Você pode também usar um editor para programar em Julia (recomendo o (VsCode)[https://www.julia-vscode.org/]). O editor é usado para fazer códigos sérios. Para desenvolver os exercícios, projetos, e futuros pacotes, é necessário criar arquivos e ter um ambiente adequado. 

- Nesta disciplina vamos usar o Pluto na maioria do tempo.
"

# ╔═╡ c665c567-1ed3-409b-9fc9-66c4c1fba0ff


# ╔═╡ d423d847-e90e-49a4-8016-9939cb6a4021


# ╔═╡ Cell order:
# ╟─8164d338-ce20-11eb-29ce-7749362afceb
# ╟─d0426d69-d528-45d6-b81b-c6d712452073
# ╟─9e5ca483-5b46-4ca8-bffa-1af3b97cd4f7
# ╟─96ede339-ba1a-48d6-899e-d2ec9f54b44f
# ╠═d3ecc5f1-50ca-463e-9e8f-690fbb7bd56a
# ╠═fdc2356e-08a0-45e1-8dda-a1a94888eeba
# ╠═c665c567-1ed3-409b-9fc9-66c4c1fba0ff
# ╠═d423d847-e90e-49a4-8016-9939cb6a4021
