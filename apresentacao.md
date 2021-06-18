### MAT1831  - Métodos Numéricos

A disciplina **Métodos Numéricos** serve para conectar dois campos do conhecimento: a Matemática e a Computação. Muitas vezes também é conhecida como **Cálculo Numérico** nos currículos mais antigos.

Essencialmente, a disciplina introduz ao aluno como resolver alguns problemas matemáticos de maneira numérica, isto é, sem buscar uma solução analítica, seja porque uma não existe, ou porque não é facilmente obtida.

Também é importante notar que existe a teoria e prática de computação, assim como da matemática. Não basta apenas entender como resolver problemas com o computador, mas codificar tais problemas e métodos de solução em alguma linguagem computacional e também entender quais são as limitações impostas pelo computador

É necessário que o aluno compreenda bem os conceitos matemáticos envolvidos, assim como a programação utilizada. Para conseguir acompanhar a disciplina, você vai necessitar de conhecimentos de Cálculo diferencial de uma e várias variáveis e um pouco de Álgebra Linear matricial. Conhecimentos de Análise e Álgebra Linear mais avançados ajudam, mas não são estritamente necessários. Do ponto de vista da comptução, se você já tiver contato com alguma linguagem de programação, terá facilidades, mas um dos objetivos da disciplina é "Implementar os métodos estudados em ambiente computacional de linguagem *script*" (veja o Plano de ensino), isto é, vamos programar. 

Considerando que esta disciplina será dada de forma remota, em consideração ao Calendário Excepcional para 2021-1, algumas diferenças de metodologia serão adotadas. Vamos adotar a divisão semanal de atividades com tarefas que deverão ser entregues após o final de cada semana para considerarmos a frequência. Muitas destas tarefas envolverão implementação computacional de um ou mais métodos estudados naquela semana. 

### Referências

Métodos Numéricos (ou Cálculo Numérico) é uma disciplina razoavelmente antiga, e contém várias referências bibliográficas.
O assunto pode aparecer com nomes diversos:

- Cálculo Numérico
- Introdução à Análise Numérica;
- (Introdução à) Métodos Numéricos;
- Métodos Computacionais (ou Numéricos) da Matemática (ou Engenharia).

O assunto se difere de Análise Numérica clássica pois não teremos tanta profundidade nas teorias matemáticas envolvidas.

Algumas referências clássicas são:

1. M. A. G. Ruggiero e V. L. da R. Lopes, **Cálculo Numérico - Aspectos Teórios e Computacionais**, 2a ed. Pearson, 1997.
2. R. L. Burden e J. D. Faires, **Análise Numérica**, 9a ed. Cengage Learning, 2010.
3. U. M. Ascher e C. Greif, **A First Course in Numerical Methods**, 1a ed. SIAM, 2011.


Para referências avançadas, consulte:
1. G. H. Golub e C. F. Van Loan, **Matrix Computations**, 3a ed. Baltimore, MD, USA: Johns Hopkins University Press, 1996.
2. L. N. Trefethen e D. Bau, III, **Numerical Linear Algebra**. Society for Industrial and Applied Mathematics, 1997.
3. W. H. Press et al., **Numerical Recipes: The Art of Scientific Computing**, 3a ed. Cambridge University Press, 2007.


Para tempos de pandemia, considerando que não temos acesso aos livros, nosso plano de ensino elenca as seguintes referências, que estão disponíveis *on-line* (muitas vezes necessitando do uso de [VPN UFSC](https://servicosti.sistemas.ufsc.br/publico/detalhes.xhtml?servico=112) ):



1. ASANO, C; COLI,  Eduardo. **Cálculo Numérico** – Fundamentos e Aplicações. Apostila do IME-USP, 2009. [link](https://www.ime.usp.br/~asano/LivroNumerico/LivroNumerico.pdf)
2. QUARTERONI, A.; SALERI, F. **Cálculo Científico**. 1. ed. Milano: Springer Milan, 2007.  [link com VPN](https://link.springer.com/content/pdf/10.1007/978-88-470-0718-5.pdf)
3. SANDERS, D. **18.330: Introduction to Numerical Analysis**. Respositório GitHub. MIT, 2021. [link](https://github.com/mitmath/18330)
4. SIQUEIRA, A. Cálculo Numérico em Julia. Repositório GitHub e Vídeo-Aulas. UFPR, 2020. [link](https://github.com/abelsiqueira/calculo-numerico-em-julia)
5. WATKINS, D. S. Fundamentals of Matrix Computations: Watkins/Fundamentals of Matrix Computations. Hoboken, NJ, USA: John Wiley & Sons, Inc., 2002. [link com VPN](https://onlinelibrary.wiley.com/doi/pdf/10.1002/0471249718)

### Programação em linguagem script

A programação para fins matemáticos é bastante antiga, e já acompanha as linguagens de programação mais antigas. Dentre elas, se destacam duas: Fortran e C. Muitas das coisas escritas hoje em vários campos avançados de matemática, física e engenharia utilizam essas ferramentas - por motivos que discutiremos em sala. Por outro lado, essas linguagens são razoavelmente mais complicadas de se utilizar, e hoje em dia temos várias linguagens de programação que são voltadas, ou facilitam, o desenvolvimento de softwares matemáticos. Uma característica importante destas linguagens é que elas são de *alto nível*, isto é, são mais fáceis de se utilizar e ler.

São várias as linguagens de programação matemáticas, mas vamos focar em 3 aqui:

- **MATLAB/Octave:** O MATLAB é de longe a mais popular. Foi criada há mais de 20 anos justamente com o objetivo acima de facilitar o desenvolvimento de softwares matemáticos. O MATLAB não é apenas uma linguagem, mas um software completo com interface de desenvolvimento, gráficos, histórico, etc. O MATLAB é um software proprietário, então como alternativa, existe o Octave, que é software livre, e entende a maior parte dos comandos que o MATLAB usa (desta disciplina, todos). Atualmente, o Octave conta com interface similar à do MATLAB, e se assemelha visualmente bastante ao primeiro;
- **Python + Numpy/Scipy**: O Python é uma linguagem de alto nível multipropósito: isto é, não foi feita para matemática. Por isso, é possível encontrá-la em muitas áreas. Em particular, os pacotes Numpy e Scipy proporcionam as ferramentas necessárias para deixar o Python atraente para utilização na matemática. É uma forte alternativa ao MATLAB, por ser software livre e contar com vários pacotes específicos. Em especial, tem sido bastante utilizado em Machine Learing e Data Science;
- **Julia**: [Julia](julialang.org) é uma linguagem relativamente  nova mas que veio com um propósito bastante específico: ser mais rápido que o MATLAB porém similar em relação a comenados e a facilitade de seu uso, e com melhor interação com Fortran e C. Apesar de ser nova, já cumpre bastante do pretendido.

##### Julia
 Minha experiência nos últimos 3 anos com o uso do Julia me fizeram escolher esta linguagem para esta disciplina. Você pode aproveitar para conhecer outras linguagens, porém **Julia será a linguagem utilizada neste semestre**.
    - Como instalar Julia? Na página do YouTube do [LABMAC](http://labmac.mat.blumenau.ufsc.br/) você encontra o tutorial (https://youtu.be/lKzhEkxvp4Y) que te ajuda na instalação. 

##### Uso de Pluto!

Nesta disciplina, utilizaremos uma ferramenta do Julia chamada [*Pluto Notebook*](plutojl.org), que é uma espécie de nota de aula interativa que usa um navegador conectado ao Julia e onde se podee escrever texto e código de programação. Em particular,  o código pode ser modificado e executado. Isso permite que o aluno teste seu código de maneira mais amigável. O vídeo (https://youtu.be/ZnF27xxlcD8) do [Prof. Abel Siqueira ](https://abelsiqueira.github.io/) explora o Pluto.  Aliás, a página do youtube do prof. Abel possui vários vídeos que iremos utilzar durante nossa disciplina. 
