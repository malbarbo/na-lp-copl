---
# vim: set spell spelllang=pt_br sw=4:
title: Exercícios
geometry: "margin=1.8cm"
fontsize: 12pt
---

<!-- Subprogramas -->

@. O que são parâmetros formais e parâmetros reais?

@. Quando a vinculação por posição dos parâmetros reais aos parâmetros
formais pode ser inadequada? Quais são as alternativas?

@. Você acha necessária a distinção entre procedimentos e funções? Explique.

@. Quais as vantagens e desvantagens de permitir subprogramas aninhados? Porque
a linguagem C não suporta subprogramas aninhados?

@. Java e C suportam passagem de parâmetro no modo de entrada e saída? Explique.

@. Compare os métodos de implementação para passagem de parâmetros de modo
de entrada e saída.

@. Explique o que é um fechamento e porque eles são necessários.

@. O que é um subprograma sobrecarregado?

@. O que é polimorfismo paramétrico? Dê um exemplo em uma linguagem de
programação real de sua utilidade.

@. Quais as vantagens e desvantagens do polimorfismo estático e dinâmico?


<!-- Implementação de subprogramas -->

@. O que é um registro de ativação?

@. Na maioria das linguagens as instâncias de registro de ativação são alocadas
dinamicamente, em que situação eles podem ser alocados estaticamente? Explique.

@. Por que na maioria das linguagens os registros de ativação são alocados
em uma pilha e não no heap?

@. Escreva uma função recursiva e mostre a pilha de execução com 3
registros de ativação para a função.

@. Explique as ações necessárias para a chamada e retorno de um subprograma na linguagem C.

@. Explique como o EP é utilizado na implementação de subprogramas com
variáveis dinâmicas na pilha.

@. Fale sobre duas formas de implementação de escopo dinâmico.


<!-- Tipos de dados abstratos e construções de encapsulamento -->

@. O que é um tipo abstrato de dado?

@. Quais são as vantagens na utilização dos tipos abstratos de dados?

@. Porque um arquivo aberto em C é representado por um ponteiro (`*FILE`) e não
por uma estrutura alocada na pilha?

@. Escolha uma linguagem e fale sobre o seu suporte a tipos abstratos de dados.

@. O que é um tipo de dado abstrato parametrizado? As linguagens dinâmicas,
como Python, suportam tipos de dados abstratos parametrizados? Explique.


<!-- Suporte a programação orientada a objetos -->

@. Quais são as três características da programação orientada a objetos?

@. Quais as vantagens e desvantagens das linguagens onde todos os dados são
objetos?

@. É possível ter vinculação dinâmica de métodos sem herança? Explique.

@. Pesquise e fale sobre o propósito da anotação `@Overrite` em Java.

@. Quais são as vantagens e desvantagens do uso de herança?

@. Em C++, qual é a utilidade de criar uma subclasse que não seja um subtipo?
Existe alguma forma de obter o mesmo resultado sem criar uma subclasse? Explique.

@. O que é uma variável polimórfica? Dê um exemplo em uma linguagem de
programação real mostrando a utilidade deste tipo de variável.

@. Explique como a vinculação dinâmica de métodos pode ser implementada usando
uma tabela de métodos virtuais.


<!-- Tratamento e exceções e tratamento de eventos -->

@. O que é uma exceção?

@. Como os erros podem ser tratados em linguagens que não suportam exceções?

@. Porque algumas exceções não devem ser tratadas? O que fazer nestes casos?

@. Em Java, qual a diferença entre exceções checadas e não checadas?
