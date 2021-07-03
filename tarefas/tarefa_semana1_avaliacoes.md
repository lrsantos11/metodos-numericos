# Tarefa 1

## Comentários gerais

- Todos se saíram satisfatoriamente para a primeira tarefa. Fiquei contente o resultado! 
- Quase todos com um problema no refinamento do algoritmo com mais casas decimais. 
- Pedro Centenaro saiu-se com recursividade. Eu fiz algo parecido.

```julia
function calcula_raizdecimal(n, t = 0)
# 	Calcula raiz inteira exata
	a, b, status = calcula_raiz(n)
# 	Caso não haja raiz exata, faça aproximação com `t` casas
	if status != :RaizExata
		for digit in 1:t
			num_pontos = 11
			ran = collect(range(a, b, length=num_pontos))
			for index in 2:num_pontos
				if ran[index]^2 == n
					return ran[index], ran[index], :RaizDecimal
				elseif ran[index]^2 > n
					a, b, status = ran[index-1], ran[index], :IntervalodaRaiz
					break # Parando laço for mais interno
				end
			end
		end
	end
	return a, b, status
		
end	
```



## Comentários individuais

- Elias

  -  A construção do `vet_r` deveria estar dentro da função `calcula_raiz`.
  - Função `calcula_raiz_n(w, t)` não funcionou como esperado, pois para números grandes, você estava gerando um intervalo muito grande usando 


  ```julia
  s = range(1, w, length = (w-1)*10^t+1)
  ```

- Gabriela

  - Mesmo problema do Elias em relação à função `calcula_raiz_t(n, t)`	

- Gustavo

  - Na função `calcula_raiz` faltou o valor superior

    ```julia
    r =  range(m, (m+0.9), length = 10) 
    ```

  - Mesmo problema do Elias em `calcula_raizz(n,v)`;

- João Guilherme

  - Mesmo problema do Elias em relação à função `calcula_raizJV_parte2`;

- Pedro Testoni Júnior

  -  Mesmo problema do Elias em relação à função `calcula_raiz_PATJ_boa`;

- Pedro Centenaro

  -  Muito bom uso de recursividade! Perfeito.

- Tainá

  - Já sabe que tem o mesmo problema do Elias na função `Calcula_raiz_precisaot_Padawan`

  ```julia
  r = range(a, b, length = (10^t)+1) #Sim, eu sei, isso não é muito bom
  ```

- Neto

  - Faltou fazer uma função! Mas está suficiente para um primeiro programa.
  -  Mesmo problema do Elias em relação ao modo de fazer o refinamento;







