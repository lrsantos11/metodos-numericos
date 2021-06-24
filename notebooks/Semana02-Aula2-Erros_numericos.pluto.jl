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

# ╔═╡ b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
begin
	using LinearAlgebra
	using PlutoUI
	import Pkg; Pkg.add("DataFrames"); Pkg.add("Plots")
	using DataFrames
	using Plots
end

# ╔═╡ a2d2d41c-d397-11eb-0f7d-ed2891f49049
md"""
##### UFSC/Blumenau
##### MAT1831 - Métodos Numéricos
##### Prof. Luiz-Rafael Santos
###### Semana 02 - Aula 02
"""

# ╔═╡ 206f3485-ba82-4b9e-948a-97e656f42b8a
md"""
# Erros em Algorimos numéricos
## Erros relativos e absolutos
Inevitavelmente, encontraremos erros quando implementamos algum algoritmos numéricos. Isto porque tipicamente nosso objetivo é encontrar uma _aproximação $v$_ de alguma _solução exata $u$_. 

Há basicamente dois tipos de erros

- **Erro absoluto** em $v$ dado por
```math
E_A := \lvert u - v\rvert
```
- **Erro relativo** em $v$ dado por
```math
E_R := \frac{\lvert u - v\rvert}{\lvert u\rvert},
```
desde que $u\neq 0$. 
* O erro relativo tem, em geral, mais significado, em especial, para erros de _representação de ponto flutuante_
"""

# ╔═╡ 4d8839cb-f01e-47b0-9671-3eb4f58e5acf
md"""
---
- Vamos incluir/instalar os pacotes do Julia usados nesta aula
"""

# ╔═╡ 0d2074aa-f918-4b6e-a7b3-1a2a84be333e
u = [1, 1, -1.5, 100, 100]

# ╔═╡ 5f980d0a-44e0-4d37-82a4-86c1e0a014e8
v = [0.99, 1.01, -1.2, 99.99, 99]

# ╔═╡ a37753de-9cb6-4d3d-84a7-087c8515886f
md"""
---
- Usando `DataFrames` para nossa tabela ficar bonitinha!
"""

# ╔═╡ c1d32147-6e12-4cd6-b949-5e4833476d08
Eₐ(x,y) = abs(x-y)

# ╔═╡ 0ce7be2b-1c1c-4af7-a471-0540df2bb675
Eᵣ(u,v) = Eₐ(u,v) / abs(u)

# ╔═╡ bd93cba3-90b9-4ce4-b915-af387b7176a5
Eᵣ.(u,v)

# ╔═╡ 33db5da8-74a8-41df-ba17-8bc0251c824b
DataFrame(:ValorExato => u, :Aproximação=>v, :ErroAbsoluto => Eₐ.(u,v), :ErroRelativo =>  Eᵣ.(u,v) )#Erro absoluto e relativo

# ╔═╡ 9fb230ba-dffc-4603-9c8d-00a1b1073d03
md"""
##### Aproximação de Stirling para fatorial de ${n}$
A fórmula de Stirling diz que podemos utilizar 

$$v = S_n = \sqrt{2\pi n} \left(\frac{n}{e}\right)^n$$

para aproximar $u = n! = 1\cdot 2\cdot  \cdots \cdot n$, o fatorial de ${n}$ para ${n}$ grande.
Usando a função `factorial(n)` de Julia vamos computar os erros relativos e absolutos de $S_n$, e apresentá-los em um `DataFrame`, para $1\leq n \leq 20$.
"""

# ╔═╡ 74b0f57c-3758-4a16-9acf-fc9b08ab0740
@bind n Slider(1:21, show_value=true)

# ╔═╡ d6f40096-694b-4178-9d26-66c4a3b5dce9
ℯ #\euler

# ╔═╡ ddc90b13-a044-40f6-a7e6-2b7409e7d987
Sₙ(n) = √(2*π*n)*(n/ℯ)^n

# ╔═╡ f6fb6e86-144e-4ed4-b7ae-b23d2e0d2baa
factorial(n)

# ╔═╡ 16e07d77-fb1a-41f4-b75b-039df5ef0c0b
Sₙ(n)

# ╔═╡ 8b515e5b-63b6-445c-a357-bb4737840135
vet_n = collect(1:15)

# ╔═╡ 8656a832-7630-460c-bc3c-c24ac2451e40
fat_orig = factorial.(vet_n)

# ╔═╡ c7ba3231-6bd7-410d-8a81-914834262500
fat_stir = Sₙ.(vet_n)

# ╔═╡ 5f9e1188-6e48-44a2-9232-63c24106f5de
DataFrame(:Fatorial => fat_orig, :Stirling => fat_stir,  :ErroAbsoluto => Eₐ.(fat_orig,fat_stir), :ErroRelativo =>  Eᵣ.(fat_orig,fat_stir))

# ╔═╡ a6dd9b2d-6479-4d7f-ae7b-5d22c26d5df4
md"""
##### Aproximação da derivada

- A derivada de uma função ${f}$ em um ponto ${x_0}$ é dada por
```math
f'(x_0) = \lim_{x\to x_0} \frac{f(x) - f(x_0)}{x-x_0} = \lim_{h\to 0} \frac{f(x_0 +h) - f(x_0)}{h}, \text{ fazendo  } x = x_0 + h.
```
---
- Assim, usando o Teorema de Taylor de 1ª ordem, para $h$ pequeno, podemos fazer
```math
f'(x_0) \approx  \frac{f(x_0 +h) - f(x_0)}{h}.
```
> **Teorema de Taylor**
```math
\begin{aligned}
f\left(x_{0}+h\right) &=f\left(x_{0}\right)+h f'\left(x_{0}\right)+\frac{h^{2}}{2} f^{\prime \prime}\left(x_{0}\right)+\cdots+\frac{h^{k}}{k !} f^{(k)}\left(x_{0}\right) \\
&+\frac{h^{k+1}}{(k+1) !} f^{(k+1)}(\xi)
\end{aligned}
```
"""

# ╔═╡ f24249dc-5ead-4bda-abcd-3fe0a10501e1
aprox_deriv(f,x₀,h) = (f(x₀ + h) - f(x₀))/h

# ╔═╡ a4276d2f-4e1e-4a78-80c6-a1f4ad514f10
@bind h Slider(0.01:0.01:0.5,show_value=true,default=.5)

# ╔═╡ cf5f5921-ccc7-418a-83fb-ab0517dbc601
let #Escopo com variáveis locais
	f(x) = -(x-1)^2 + 1
	x₀ = 0.5
	m = aprox_deriv(f,x₀,h)
	plot(f,0.25,1.2,leg=false,xlims = (0.2,1.25),ylims = (0.3,1.1))
	plot!(x->m*(x-x₀) + f(x₀),0.25,1.2,lw = 1.5)
	plot!(x->-2(x₀-1)*(x-x₀) + f(x₀),0.25,1.2,lw = 2)
	scatter!([x₀, x₀+h], [f(x₀),f(x₀+h)])
end

# ╔═╡ b099e1bf-7c5d-416e-943b-2565b0412f6d
md"""
###### Exemplo: Derivada de $f(x) = \sin (x)$ em $x_0 = 1.2$.
"""

# ╔═╡ dc8d88bb-f499-4c66-8206-2734ce832127
x₀ = 1.2

# ╔═╡ 9046d64b-e01a-42e4-ad47-ffabfa674729
cos(x₀)

# ╔═╡ 41b53fc1-f620-41e4-9a46-d59cd4bed6e8
h₀ = [0.1, 0.01, 0.001, 1e-4, 1e-7]

# ╔═╡ 4b5fdf26-1c4d-4269-a2db-be3dadfe3f48
der_fx₀ = aprox_deriv.(sin,x₀,h₀)

# ╔═╡ e2fd90ee-c3c1-4c4c-a2ab-ccb2427fc81f
DataFrame(:h => h₀, :ErroAbsoluto => Eₐ.(cos(x₀), der_fx₀), :ErroRelativo => Eᵣ.(cos(x₀), der_fx₀))

# ╔═╡ 9383bf51-6c77-4ddc-b83e-2c4b0550982d
h₁ = [1e-8, 1e-9, 1e-10, 1e-11, 1e-13, 1e-15, 1e-16]

# ╔═╡ 9071eafb-f080-4520-a114-aa65e2a54235
der_fx₁ = aprox_deriv.(sin,x₀,h₁)

# ╔═╡ 001748e6-c0e9-460d-b6b1-6e0688cce16a
DataFrame(:h => h₁, :ErroAbsoluto => Eₐ.(cos(x₀), der_fx₁), :ErroRelativo => Eᵣ.(cos(x₀), der_fx₁))

# ╔═╡ 1716126d-cd8e-4cae-98f3-a5636b926a83
err =  Eₐ.(cos(x₀), der_fx₀)

# ╔═╡ Cell order:
# ╟─a2d2d41c-d397-11eb-0f7d-ed2891f49049
# ╟─206f3485-ba82-4b9e-948a-97e656f42b8a
# ╟─4d8839cb-f01e-47b0-9671-3eb4f58e5acf
# ╠═b25c1fd4-b6e2-4248-8bb9-41a1f06032dd
# ╠═0d2074aa-f918-4b6e-a7b3-1a2a84be333e
# ╠═5f980d0a-44e0-4d37-82a4-86c1e0a014e8
# ╟─a37753de-9cb6-4d3d-84a7-087c8515886f
# ╠═c1d32147-6e12-4cd6-b949-5e4833476d08
# ╠═0ce7be2b-1c1c-4af7-a471-0540df2bb675
# ╠═bd93cba3-90b9-4ce4-b915-af387b7176a5
# ╠═33db5da8-74a8-41df-ba17-8bc0251c824b
# ╟─9fb230ba-dffc-4603-9c8d-00a1b1073d03
# ╠═74b0f57c-3758-4a16-9acf-fc9b08ab0740
# ╠═d6f40096-694b-4178-9d26-66c4a3b5dce9
# ╠═ddc90b13-a044-40f6-a7e6-2b7409e7d987
# ╠═f6fb6e86-144e-4ed4-b7ae-b23d2e0d2baa
# ╠═16e07d77-fb1a-41f4-b75b-039df5ef0c0b
# ╠═8b515e5b-63b6-445c-a357-bb4737840135
# ╠═8656a832-7630-460c-bc3c-c24ac2451e40
# ╠═c7ba3231-6bd7-410d-8a81-914834262500
# ╠═5f9e1188-6e48-44a2-9232-63c24106f5de
# ╟─a6dd9b2d-6479-4d7f-ae7b-5d22c26d5df4
# ╠═f24249dc-5ead-4bda-abcd-3fe0a10501e1
# ╟─cf5f5921-ccc7-418a-83fb-ab0517dbc601
# ╟─a4276d2f-4e1e-4a78-80c6-a1f4ad514f10
# ╟─b099e1bf-7c5d-416e-943b-2565b0412f6d
# ╠═dc8d88bb-f499-4c66-8206-2734ce832127
# ╠═9046d64b-e01a-42e4-ad47-ffabfa674729
# ╠═41b53fc1-f620-41e4-9a46-d59cd4bed6e8
# ╠═4b5fdf26-1c4d-4269-a2db-be3dadfe3f48
# ╠═e2fd90ee-c3c1-4c4c-a2ab-ccb2427fc81f
# ╠═9383bf51-6c77-4ddc-b83e-2c4b0550982d
# ╠═9071eafb-f080-4520-a114-aa65e2a54235
# ╠═001748e6-c0e9-460d-b6b1-6e0688cce16a
# ╠═1716126d-cd8e-4cae-98f3-a5636b926a83
