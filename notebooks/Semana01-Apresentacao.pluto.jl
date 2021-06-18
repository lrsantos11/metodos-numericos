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

# ╔═╡ 56948164-ddb1-4b45-9f4d-f0354a2d0993
md"""

# MAT1831 - Métodos Numéricos (2021-1)
## Informações do curso

- Professor Luiz-Rafael Santos ([l.r.santos@ufsc.br](mailto:l.r.santos@ufsc.br))

- Ter e Qua 20:20-22:00 e Sex 18:30-20:10 (em formato remoto)

- Atendimento: A decidir

- [Disciplina no Moodle](https://moodle.ufsc.br/course/view.php?id=137044)

"""

# ╔═╡ 288d110b-0c15-4355-96cc-03159dc89b10
md"## Ementa de MAT1831 - Métodos Numéricos

- Introdução à computação científica usando linguagem *script*. 
- Visualização de dados.
- Aritmética de ponto-flutuante e erros de arredondamento. 
- Zeros de funções. 
- Estudo e implementação de métodos para solução de sistemas lineares. 
- Problemas de ajuste de dados. 
- Integração Numérica. 
- Métodos numéricos para EDO. 
"


# ╔═╡ 5f8ae8aa-f20f-4af0-a100-4f1d09d7ce81
md"""
## Avaliação
    
- Serão realizados até 12 Atividades-teste ou Projetos Computacionais para aferição de frequência, que renderão média T – cada teste ficará disponível por pelo menos 4 dias durante a respectiva semana.  
- Além disso, teremos 03 provas, P1, P2 e P3, nas semanas 5, 10 e 15 respectivamente, com início sempre às Sextas-feiras.
- Todas as avaliações serão assíncronas, organizadas na plataforma Moodle. 
- A média $$M$$ será calculada na forma:
    $$M = 0,2 T + 0,2 P1 + 0,3 P2 + 0,3 P3$$.
  - Se a frequência for suficiente (75%), 
  - O aluno estará aprovado se M for maior ou igual a 6,0. 
  - O aluno estará reprovado se M for menor que 3,0. 
  - Se M estiver entre 3,0 e 5,5, o mesmo terá direito a uma prova de recuperação. 
    
"""

# ╔═╡ 8164d338-ce20-11eb-29ce-7749362afceb
md"
# Introdução à Linguagem Julia

[Julia](https://www.julialang.org) é uma linguagem dinâmica de alto nível e alto desempenho.
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

- Você pode também usar um editor para programar em Julia (recomendo o [VsCode](https://www.julia-vscode.org). O editor é usado para fazer códigos sérios. Para desenvolver os exercícios, projetos, e futuros pacotes, é necessário criar arquivos e ter um ambiente adequado. 

- Nesta disciplina vamos usar o Pluto na maioria do tempo.
"

# ╔═╡ 1f708ef5-ed29-4c46-9a4f-7d721cfa9e80


# ╔═╡ c665c567-1ed3-409b-9fc9-66c4c1fba0ff
2+2

# ╔═╡ d423d847-e90e-49a4-8016-9939cb6a4021
A = [1 2;
	 3 4.]

# ╔═╡ 928e168f-4665-43c4-863a-06580d07db0a
x = [1., 2]

# ╔═╡ 39c459e7-9d01-49c9-81da-168085fcea0e
A*x

# ╔═╡ f2683258-3f57-4353-b2c7-e337457bcc01
md"""
## Esta é uma célula de `Markdown`
"""

# ╔═╡ b159effc-508f-41d4-a7cc-4c27dd908612
y = [2,1.]

# ╔═╡ Cell order:
# ╟─56948164-ddb1-4b45-9f4d-f0354a2d0993
# ╟─288d110b-0c15-4355-96cc-03159dc89b10
# ╟─5f8ae8aa-f20f-4af0-a100-4f1d09d7ce81
# ╟─8164d338-ce20-11eb-29ce-7749362afceb
# ╟─d0426d69-d528-45d6-b81b-c6d712452073
# ╟─9e5ca483-5b46-4ca8-bffa-1af3b97cd4f7
# ╟─96ede339-ba1a-48d6-899e-d2ec9f54b44f
# ╠═1f708ef5-ed29-4c46-9a4f-7d721cfa9e80
# ╠═d3ecc5f1-50ca-463e-9e8f-690fbb7bd56a
# ╠═fdc2356e-08a0-45e1-8dda-a1a94888eeba
# ╠═c665c567-1ed3-409b-9fc9-66c4c1fba0ff
# ╠═d423d847-e90e-49a4-8016-9939cb6a4021
# ╠═928e168f-4665-43c4-863a-06580d07db0a
# ╠═39c459e7-9d01-49c9-81da-168085fcea0e
# ╠═f2683258-3f57-4353-b2c7-e337457bcc01
# ╠═b159effc-508f-41d4-a7cc-4c27dd908612
