# Usando LABMAC

O Laboratório de Matemática Aplicada e Computacional (LABMAC) permite que você use o Julia e o Pluto em um computador mais robusto. 

## Acesso por ssh
Cada usuário irá receber um login através login e senha (este login é feito através do contato com o responsável técnico do laboratório  [Luiz Fernando Bossa](mailto:l.f.bossa@ufsc.br). Os experimentos devem ser realizados somente na máquina labmac03.blumenau.ufsc.br.

O acesso à maquina se dá por `ssh` que é um programa para acesso remoto. Quem usa Linux já deve o cliente ssh instalado. Se você usa Windows 10, instale o cliente Openssh seguindo essas [instruções](https://tecnoblog.net/229971/windows-10-ativar-openssh-cliente). Caso você prefira usar outro cliente de ssh para o Windows, você deve verificar como fazer a configuração por conta própria. 

Você também precisa usar o VPN da UFSC para poder acessar as máquina do LABMAC. Veja [aqui](https://servicosti.sistemas.ufsc.br/publico/detalhes.xhtml?servico=112) as instruções para seu ambiente.

Após estar com o VPN ligado, você deve acessar a máquina `labmac02` usando o seu shell preferido no Linux ou o PowerShell no Windows digitando:
```bash
ssh -L ZZZZ:localhost:ZZZZ seu_usuario@labmac03.blumenau.ufsc.br
```
em que `ZZZZ = 1234 + YYYY`, e `YYYY` são os últimos 4 números da sua matrícula. Por exemplo, se sua matrícula for 20152020, `ZZZZ = 1234 + 2020 = 3254`.

A partir daí você deve ter entrado em um shell da máquina labmac02. Sugiro que você mude para o diretório Documentos para trabalhar lá. Para isso basta digitar
```bash
mkdir Documentos
cd Documentos
```

Se quiser, organize seu trabalho em sub-pastas para o seu trabalho usando comandos como o mkdir e o cd como acima.


Se quiser, pode atualizar sua versão do Julia (ou instalar, se não estiver instalado) usand o comando 

```bash
pip3 install jill --user -U 
jill install --upgrade
```



Para iniciar um seção do Pluto, você deve entrar no julia digitando 
```bash
julia
```

No Julia, instale os pacotes `Pluto` e `PlutoUI` e depois rode o Pluto usando o comando
```julia
julia> using Pluto
julia> Pluto.run(port=ZZZZ,launch_browser=false)
```
em que `ZZZZ` é o número que você usou para logar. 

Julia vai devolver a seguinte mensagem
```julia

Go to http://localhost:ZZZZ/?secret=xxxxxxxx in your browser to start writing ~ have fun!

Press Ctrl+C in this terminal to stop Pluto
```
em que `xxxxxxx` vai ser um número único. 

Usando o endereço [http://localhost:ZZZZ/?secret=xxxxxxxx]() no seu navegador você vai conseguir acessar ao Pluto no computador do LABMAC.

