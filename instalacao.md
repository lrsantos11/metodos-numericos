#  Primeira vez: Instalando Julia & Pluto


## Passo 1: Install Julia 1.6.0

Vá em [https://julialang.org/downloads](https://julialang.org/downloads) e baixe a versão corrente e estável do Julia (1.6.0), usando a versão do seu sistema operacional (Linux x86, Mac, Windows, etc).

## Passo 2: Rode Julia

Depois de instalar, **garanta que você pode rodar o Julia**. Em alguns sistemas pode ser que você tenha que procurar "Julia 1.6.0"; em outros, significa rodar o comando `julia` no terminal. Garanta que você possa executar `1 + 1`:

![image](https://user-images.githubusercontent.com/6933510/91439734-c573c780-e86d-11ea-8169-0c97a7013e8d.png)

*Garanta que você consegue calcular `1+1` em Julia*

## Passo 3: Instale [`Pluto`](https://github.com/fonsp/Pluto.jl)

Vamos instalar agora um [**notebook Pluto**](https://github.com/fonsp/Pluto.jl/blob/master/README.md) que será usado durante nosso curso. Pluto é _ambiente de programação_ em Julia desenvolvido para iteratividade e experimentos rápidos.

Abra o **Julia REPL**. Esta é a interface de linha de comando do Julia, similar a figura anterior.

Aqui você digita os _comandos do Julia_, e quando você pressiona ENTER, vai rodar, e você verá os resultados.

Para instalar Pluto, nós vamos rodar o _ambiente de gerenciador de pacotes_. Para trocar do modo _Julia_ para o modo _Pkg_, digite `]` (fecha colchetes) no prompt do `julia>`:
```julia
julia> ]

(@v1.6) pkg>
```

A linha se torna azul e o prompt muda para `pkg>`, dizendo que você está no modo _gerenciador de pacotes_. Este modo permite que você faça operações com pacotes (**packages** em inglês também chamados bibliotecas).

Para instalar o Pluto, rode os seguinte (_case sensitive_)  comandos para *add* (instalar) o pacote ao seu sistema, baixando-o da internet. Você só precisará fazer isso uma única vez para cada instalação do Julia:

```julia
(@v1.6) pkg> add Pluto
```

Isto pode demorar um pouco, então vá tomar um cafézinho!

![image](https://user-images.githubusercontent.com/6933510/91440380-ceb16400-e86e-11ea-9352-d164911774cf.png)



## Passo 4: Use um navegador moderno: Mozilla Firefox ou Google Chrome
Você precisa de um navegador de internet para ver notebooks Pluto. Firefox e Chrome são os melhores.


# Segunda vez: _Rodando Pluto & abrindo notebooks_
Repita os seguintes passos sempre que quiser trabalhar em um projeto ou em alguma tarefa.

## Passo 1: Inicie Pluto

Inicie o Julia REPL, como durante o _setup_. No REPL, digite:
```julia
julia> using Pluto

julia> Pluto.run()
```

![image](https://user-images.githubusercontent.com/6933510/91441094-eb01d080-e86f-11ea-856f-e667fdd9b85c.png)

O terminal dirá para você acessar `http://localhost:1234/` (ou URL similar). Vamos abrir Firefox ou Chrome e digitar este endereço na barra de endereço.

![image](https://user-images.githubusercontent.com/6933510/91441391-6a8f9f80-e870-11ea-94d0-4ef91b4e2242.png)

> Você pode ter uma visão do que é um  _notebook Pluto_ olhando para os **sample notebooks** (notebooks exemplos). Exemplo 1, 2 e 6 podem ser úteis para aprender coisas básicas em Julia. 
> 

Se nada acontecer com o navegador da primeira vez, feche Julia e tente novamente. 

## Passo 2a: Abrindo um notebook da rede

Este é o menu principal - você pode criar um notebook novo ou abrir algum já existente ou mesmo baixar um _modelo_ baseado em alguma URL, como um repositório do GitHub. Para iniciar um notebook que se encontra na internet,  _cole a URL na caixa azul e pressione_ ENTER.


**A primeira coisa é tentar salvar o notebook em seu próprio computador; veja abaixo.** 

## Passo 2b: Abrindo um notebook existente
Quando for rodar o Pluto por uma segunda vez, seus notebooks recentes aparecerão no menu principal. Clique sobre eles para continuar de onde você parou.

Se você quer rodar um notebook local que não foi aberto antes, você deve usar   _caminho completo_ do mesmo na caixa azul do menu principal.

## Passo 3: Salvando um notebook
Você precisa de uma pasta para salvar seus testes e tarefas. 

Feito isso, precisamos saber o  _caminho absoluto_  desta pasta. 
Consulte aqui como fazer isso em [Windows](https://www.top-password.com/blog/copy-full-path-of-a-folder-file-in-windows/), [MacOS](https://www.josharcher.uk/code/find-path-to-folder-on-mac/) and [Ubuntu]().

Por exemplo, você pode terFor example, you might have:

- `C:\\Users\\lrsantos\\Documents\\MAT1831_tarefas\\` on Windows

- `/Users/lrsantos/Documents/MAT1831_tarefas/` on MacOS

- `/home/lrsantos/Documents/MAT1831_tarefas/` on Ubuntu

Agora que você conhece o caminho absoluto, vá em seu notebook Pluto, e no topo da página clique em _"Save notebook..."_. 

![image](https://user-images.githubusercontent.com/6933510/91444741-77fb5880-e875-11ea-8f6b-02c1c319e7f3.png)

Aqui você digita o **novo_caminho+nome_arquivo.jl** do seu notebook:

![image](https://user-images.githubusercontent.com/6933510/91444565-366aad80-e875-11ea-8ed6-1265ded78f11.png)

Clique _Choose_.

## Passo 4: Compartilhando um notebook

Depois de trbalhar em um notebook (o código é sempre salvo automaticamente), você encontrará seu notebook na pasta criada no Passo 3. Este arquivo pode ser compartilhado com outros ou submetido como tarefa no Moodle.
