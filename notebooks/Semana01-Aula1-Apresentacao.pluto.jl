### A Pluto.jl notebook ###
# v0.16.4

using Markdown
using InteractiveUtils

# ╔═╡ 2b50dac0-47e7-4d21-a4ac-e22026c51dc5
md"""
###### UFSC/Blumenau
###### MAT1831 - Métodos Numéricos
###### Prof. Luiz-Rafael Santos
###### Semana 01 - Aula 01
"""

# ╔═╡ 56948164-ddb1-4b45-9f4d-f0354a2d0993
md"""

# MAT1831 - Métodos Numéricos (2021-2)
## Informações do curso

- Professor Luiz-Rafael Santos ([l.r.santos@ufsc.br](mailto:l.r.santos@ufsc.br))

- Seg 10:10-12:00, Qua 08:20-10:00$^*$ e Qui 10:10-12:00 (em formato remoto) com maioria das atividades síncronas (todas as atividades síncronas serão gravadas)

- Atendimento: A decidir

- [Disciplina no Moodle](https://moodle.ufsc.br/course/view.php?id=148745)

- [Página do Github da disciplina] (https://github.com/lrsantos11/metodos-numericos)

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
    
- Serão realizados no máximo 12 Atividades-teste ou Projetos Computacionais para aferição de frequência, que renderão média $T$ – cada teste ficará disponível por pelo menos 4 dias durante a respectiva semana (entrega prevista para Seg às 10h).  
- Além disso, teremos 03 provas, $P1, P2$ e $P3$, nas semanas 5, 10 e 15 respectivamente, com início sempre às Sextas-feiras.
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

[Julia](https://www.julialang.org) é uma linguagem dinâmica de *alto nível* e **alto desempenho*.
- Ela se assemelha ao MATLAB e ao Python na facilidade de escrita
de código, mas sua velocidade pode ser comparável ao C e Fortran.

![texty](https://julialang.org/assets/benchmarks/benchmarks.svg)


- A versão mais atual do Julia é a **1.6**.
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

- Você pode também usar um editor para programar em Julia (recomendo o [VsCode](https://www.julia-vscode.org)). 
- Um editor é usado para fazer códigos sérios. Para desenvolver os exercícios, projetos, e futuros pacotes, é necessário criar arquivos e ter um ambiente adequado. 

- Nesta disciplina vamos usar o Pluto na maioria do tempo.
"

# ╔═╡ e7b00b38-667e-47eb-9924-69a7f6c6c4e0
md"""
## Introdução ao Julia
"""

# ╔═╡ 2539b502-4d09-4048-ac10-17c6577a4ea6
# Numeros

# ╔═╡ d423d847-e90e-49a4-8016-9939cb6a4021
# Matrizes

# ╔═╡ 928e168f-4665-43c4-863a-06580d07db0a
#Vetores

# ╔═╡ 39c459e7-9d01-49c9-81da-168085fcea0e
# Produto Matriz vetor

# ╔═╡ f2683258-3f57-4353-b2c7-e337457bcc01
# Markdown
md"""
## Esta é uma célula de `Markdown`
"""

# ╔═╡ Cell order:
# ╟─2b50dac0-47e7-4d21-a4ac-e22026c51dc5
# ╟─56948164-ddb1-4b45-9f4d-f0354a2d0993
# ╟─288d110b-0c15-4355-96cc-03159dc89b10
# ╟─5f8ae8aa-f20f-4af0-a100-4f1d09d7ce81
# ╟─8164d338-ce20-11eb-29ce-7749362afceb
# ╟─d0426d69-d528-45d6-b81b-c6d712452073
# ╟─9e5ca483-5b46-4ca8-bffa-1af3b97cd4f7
# ╟─96ede339-ba1a-48d6-899e-d2ec9f54b44f
# ╠═e7b00b38-667e-47eb-9924-69a7f6c6c4e0
# ╠═2539b502-4d09-4048-ac10-17c6577a4ea6
# ╠═d423d847-e90e-49a4-8016-9939cb6a4021
# ╠═928e168f-4665-43c4-863a-06580d07db0a
# ╠═39c459e7-9d01-49c9-81da-168085fcea0e
# ╠═f2683258-3f57-4353-b2c7-e337457bcc01
