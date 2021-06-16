#  Instalando Julia & Pluto


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

The line turns blue and the prompt changes to `pkg>`, telling you that you are now in _package manager mode_. This mode allows you to do operations on **packages** (also called libraries).

To install Pluto, run the following (case sensitive) command to *add* (install) the package to your system by downloading it from the internet.
You should only need to do this *once* for each installation of Julia:

```julia
(@v1.6) pkg> add Pluto
```

This might take a couple of minutes, so you can go get yourself a cup of tea!

![image](https://user-images.githubusercontent.com/6933510/91440380-ceb16400-e86e-11ea-9352-d164911774cf.png)

You can now close the terminal.

## Passo 4: Use a modern browser: Mozilla Firefox or Google Chrome
We need a modern browser to view Pluto notebooks with. Firefox and Chrome work best.


# Second time: _Running Pluto & opening a notebook_
Repeat the following Passos whenever you want to work on a project or homework assignment.

## Passo 1: Start Pluto

Start the Julia REPL, like you did during the setup. In the REPL, type:
```julia
julia> using Pluto

julia> Pluto.run()
```

![image](https://user-images.githubusercontent.com/6933510/91441094-eb01d080-e86f-11ea-856f-e667fdd9b85c.png)

The terminal tells us to go to `http://localhost:1234/` (or a similar URL). Let's open Firefox or Chrome and type that into the address bar.

![image](https://user-images.githubusercontent.com/6933510/91441391-6a8f9f80-e870-11ea-94d0-4ef91b4e2242.png)

> If you're curious about what a _Pluto notebook_ looks like, have a look at the **sample notebooks**. Samples 1, 2 and 6 may be useful for learning some basics of Julia programming. 
> 
> If you want to hear the story behind Pluto, have a look a the [JuliaCon presentation](https://www.youtube.com/watch?v=IAF8DjrQSSk).

If nothing happens in the browser the first time, close Julia and try again. And please let us know!

## Passo 2a: Opening a notebook from the web

This is the main menu - here you can create new notebooks, or open existing ones. Our homework assignments will always be based on a _template notebook_, available in this GitHub repository. To start from a template notebook on the web, you can _paste the URL into the blue box_ and press ENTER.

For example, homework 0 is available [here](/hw0/). Go to this page, and on the top right, click on the button that says "Edit or run this notebook". From these instructions, copy the notebook link, and paste it into the box. Press ENTER, and select OK in the confirmation box.

![image](https://user-images.githubusercontent.com/6933510/91441968-6b750100-e871-11ea-974e-3a6dfd80234a.png)

**The first thing we will want to do is to save the notebook somewhere on our own computer; see below.** 

## Passo 2b: Opening an existing notebook file
When you launch Pluto for the second time, your recent notebooks will appear in the main menu. You can click on them to continue where you left off.

If you want to run a local notebook file that you have not opened before, then you need to enter its _full path_ into the blue box in the main menu. More on finding full paths in Passo 3.

## Passo 3: Saving a notebook
We first need a folder to save our homework in. Open your file explorer and create one. 

Next, we need to know the _absolute path_ of that folder. Here's how you do that in [Windows](https://www.top-password.com/blog/copy-full-path-of-a-folder-file-in-windows/), [MacOS](https://www.josharcher.uk/code/find-path-to-folder-on-mac/) and [Ubuntu]().

For example, you might have:

- `C:\\Users\\fonsi\\Documents\\18S191_assignments\\` on Windows

- `/Users/fonsi/Documents/18S191_assignments/` on MacOS

- `/home/fonsi/Documents/18S191_assignments/` on Ubuntu

Now that we know the absolute path, go back to your Pluto notebook, and at the top of the page, click on _"Save notebook..."_. 

![image](https://user-images.githubusercontent.com/6933510/91444741-77fb5880-e875-11ea-8f6b-02c1c319e7f3.png)

This is where you type the **new path+filename for your notebook**:

![image](https://user-images.githubusercontent.com/6933510/91444565-366aad80-e875-11ea-8ed6-1265ded78f11.png)

Click _Choose_.

## Passo 4: Sharing a notebook

After working on your notebook (your code is autosaved when you run it), you will find your notebook file in the folder we created in Passo 3. This the file that you can share with others, or submit as your homework assignment to Canvas.
