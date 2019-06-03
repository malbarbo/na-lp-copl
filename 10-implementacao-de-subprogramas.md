---
# vim: set spell spelllang=pt_br sw=4:
title: Implementação de subprogramas
---

Semântica geral das chamadas e retornos
=======================================

## Semântica geral das chamadas e retornos

- A implementação de subprogramas deve ser baseada na semântica da **ligação de
  subprogramas**

    - Envolve as operações de chamada e retorno


## Semântica geral das chamadas e retornos

- Ações associadas com as chamadas de subprogramas

    - Passagem de parâmetros

    - Alocação e vinculação das variáveis locais dinâmicas na pilha

    - Salvar o estado de execução do subprograma chamador

    - Transferência do controle para o subprograma chamado

    - Mecanismos de acesso a variáveis não locais (no caso de subprogramas
      aninhados)


## Semântica geral das chamadas e retornos

- Ações associadas com os retornos de subprogramas

    - Retorno dos parâmetros de saída

    - Desalocação das variáveis locais

    - Restauração do estado da execução

    - Retorno do controle ao subprograma chamador



Subprogramas "simples"
======================

## Subprogramas "simples"

- Não aninhados

- Não recursivos

- Todas as variáveis locais são estáticas


## Subprogramas "simples"

- Semântica da chamada requer as ações

    1. Salvar o estado da unidade de programa corrente

    2. Computar e passar os parâmetros

    3. Passar o endereço de retorno ao subprograma chamado

    4. Transferir o controle ao subprograma chamado


## Subprogramas "simples"

- Semântica do retorno requer as ações

    1. Copiar os valores dos parâmetros formais de saída para os parâmetros
       reais

    2. Copiar o valor de retorno (no caso de função)

    3. Restaurar o estado de execução do chamador

    4. Transferir o controle de volta ao chamador


## Subprogramas "simples"

- Como estas ações são distribuídas entre o subprograma chamador
  e o subprograma chamado?


## Subprogramas "simples"

- Memória requerida para a chamada e retorno

    - Estado do chamador

    - Parâmetros

    - Endereço de retorno

    - Valor de retorno para funções

    - Valores temporários utilizados no código do subprograma


## Subprogramas "simples"

- As ações do subprograma chamado podem ocorrer

    - No início da execução (**prólogo**)

    - No final da execução (**epílogo**)


## Subprogramas "simples"

- Um subprograma simples consiste de duas partes de tamanhos fixos

    - Código do subprograma

    - As variáveis locais e os demais dados


## Subprogramas "simples"

- O formato (layout) da parte não código do subprograma é chamado de **registro
  de ativação**

- Uma **instância do registro de ativação** é um exemplo concreto do registro
  de ativação

- Como as linguagens com subprogramas simples não suportam recursão só pode
  haver uma instância do registro de ativação de cada subprograma

- Como o registro de ativação tem tamanho fixo, pode ser alocado estaticamente


## Subprogramas "simples"

![](figs/10-1.pdf)


## Subprogramas "simples"

![](figs/10-2.pdf)


Subprogramas com variáveis locais dinâmicas na pilha
====================================================

## Subprogramas com variáveis locais dinâmicas na pilha

- Registros de ativação mais complexos

    - O compilador precisa gerar código para alocação e desalocação das
      variáveis locais

- Suporte a recursão

    - Mais de uma instância de registro de ativação para um subprograma


## Subprogramas com variáveis locais dinâmicas na pilha

- O formato de registro de ativação é conhecido em tempo de compilação

- O tamanho do registro de ativação pode variar (se existirem arranjos
  dinâmicos na pilha, por exemplo)

- Os registros de ativação precisam ser criados dinamicamente


## Subprogramas com variáveis locais dinâmicas na pilha

![](figs/10-3.pdf)


## Subprogramas com variáveis locais dinâmicas na pilha

- O endereço de retorno geralmente consiste em um ponteiro para a instrução que
  segue a chamada do subprograma

- O **vínculo dinâmico** aponta para a base da instância do registro de
  ativação do chamador

- Os parâmetros são valores ou endereços dados pelo chamador

- As variáveis locais são alocadas (e possivelmente inicializadas) no
  subprograma chamado


## Subprogramas com variáveis locais dinâmicas na pilha

<div class="columns">
<div class="column" width="30%">
\footnotesize

```c
void sub(float total, int part){
  int list[5];
  float sum;
  ...
}
```
</div>
<div class="column" width="70%">
![](figs/10-4.pdf)
</div>
</div>


## Subprogramas com variáveis locais dinâmicas na pilha

- Ativar um subprograma requer a criação dinâmica de um registro de ativação

- O registro de ativação é criado na **pilha de execução** (run-time stack)

- O **ponteiro de ambiente** (EP - Enviromnet Pointer) aponta para a base do
  registro de ativação da unidade de programa que está executando


## Subprogramas com variáveis locais dinâmicas na pilha

- O EP é mantido pelo sistema \pause

    - O EP é salvo como vínculo dinâmico do novo registro de ativação quando
        um subprograma é chamado

    - O EP é alterado para apontar para a base do novo registro de ativação

    - No retorno, o topo da pilha é alterado para EP - 1, e o EP é alterado
      para o vínculo dinâmico do registro de ativação do subprograma que está
      terminado

    \pause

- O EP é usado como base do endereçamento por deslocamento dos dados na
  instância do registro de ativação


## Subprogramas com variáveis locais dinâmicas na pilha

- Ações do subprograma chamador

    1. Criar um registro de ativação

    2. Salvar o estado da unidade de programa corrente

    3. Computar e passar os parâmetros

    4. Passar o endereço de retorno ao subprograma chamado

    5. Transferir o controle ao subprograma chamado


## Subprogramas com variáveis locais dinâmicas na pilha

- Ações no prólogo do subprograma chamado

    1. Salvar o antigo EP com vínculo dinâmico, e atualizar o seu valor

    2. Alocar as variáveis locais


## Subprogramas com variáveis locais dinâmicas na pilha

- Ações no epílogo do subprograma chamado

    1. Copiar os valores dos parâmetros formais de saída para os parâmetros
       reais

    2. Copiar o valor de retorno (no caso de função)

    3. Atualizar o topo da pilha e restaurar o EP para o valor do antigo
       vinculo dinâmico

    4. Restaurar o estado de execução do chamador

    5. Transferir o controle de volta ao chamador


## Exemplo sem recursão

<div class="columns">
<div class="column" width="25%">
\scriptsize

```c
void fun1(float r) {
  int s, t;
  ...       // <- 1
  fun2(s);
}
void fun2(int x) {
  int y;
  ...       // <- 2
  fun3(y);
}
void fun3(int q) {
  ...       // <- 3
}
void main() {
  float p;
  ...
  fun1(p);
}
```
</div>
<div class="column" width="75%">
![](figs/10-5.pdf)
</div>
</div>


## Subprogramas com variáveis locais dinâmicas na pilha

- A coleção de vínculos dinâmicos na pilha em um determinado momento é chamado
  de **cadeia dinâmica** ou **cadeia de chamadas**

- Referência as variáveis locais podem ser representadas por deslocamentos
  a partir do início do registro de ativação, cujo endereço é armazenado em EP

    - Este é o **deslocamento local** (`local_offset`)

- O deslocamento local pode ser determinado em tempo de compilação


## Exemplo com recursão

<div class="columns">
<div class="column" width="30%">
\scriptsize

```c
int fat(int n) {
  // <- 1
  if (n <= 1) {
    return 1;
  } else {
    return n * fat(n - 1);
  }
  // <- 2
}
void main() {
  int value;
  value = fat(3);
  // <- 3
}
```
</div>
<div class="column" width="70%">
![](figs/10-6.pdf){width=6cm}
</div>
</div>


## Exemplo com recursão

<div class="columns">
<div class="column" width="30%">
\scriptsize

```c
int fat(int n) {
  // <- 1
  if (n <= 1) {
    return 1;
  } else {
    return n * fat(n - 1);
  }
  // <- 2
}
void main() {
  int value;
  value = fat(3);
  // <- 3
}
```
</div>
<div class="column" width="70%">
![](figs/10-7.pdf)
</div>
</div>


## Exemplo com recursão

<div class="columns">
<div class="column" width="30%">
\scriptsize

```c
int fat(int n) {
  // <- 1
  if (n <= 1) {
    return 1;
  } else {
    return n * fat(n - 1);
  }
  // <- 2
}
void main() {
  int value;
  value = fat(3);
  // <- 3
}
```
</div>
<div class="column" width="70%">
![](figs/10-8.pdf){height=8cm}
</div>
</div>



Subprogramas aninhados
======================

## Subprogramas aninhados

- Algumas linguagens com escopo estático permitem subprogramas aninhados
  (Fortran 95, Ada, Python, JavaScript, Ruby, Lua)

- Todas as variáveis não locais que podem ser acessadas estão em algum registro
  de ativação na pilha


## Subprogramas aninhados

- Processo para encontrar um referência não local

    - Encontrar o registro de ativação correto

    - Determinar o deslocamento dentro do registro de ativação

- A forma mais comum de implementação é o encadeamento estático


## Subprogramas aninhados

- Um **vínculo estático** aponta para a base de uma instância do registro de
  ativação de uma ativação do pai estático

- Uma **cadeia estática** é uma cadeia de vínculos estáticos que conecta certas
  instâncias de registros de ativação

- A cadeia estática conecta todos os ancestrais estáticos de um subprograma em
  execução

- A cadeia estática é usado para implementar acesso as variáveis não locais


## Subprogramas aninhados

- Encontrar a instância do registro de ativação correta é direto, basta seguir
  os vínculos. \pause Mas pode ser ainda mais simples

    - **`static_depth`** é um inteiro associado com o escopo estático cujo
      valor é a profundidade de aninhamento deste escopo

    - O **`chain_offset`** ou **`nesting_depth`** de uma referência não local
      é a diferença entre o `static_depth` do subprograma que faz a referência
      e do subprograma onde a variável referenciada foi declarada

    - Uma referência a uma variável pode ser representada por um par
      `(chain_offset, local_offset)`, sendo `local_offset` o deslocamento no
      registro de ativação da variável referenciada


## Exemplo

<div class="columns">
<div class="column" width="50%">
\tiny

```ada
procedure Main is
  X : Integer;
  procedure Bigsub is
    A, B, C : Integer;
    procedure Sub1 is
      A, D : Integer;
      begin -- of Sub1
        A := B + C;    -- <----- 1
      end;  -- of Sub1
    procedure Sub2(X : Integer) is
      B, E : Integer;
      procedure Sub3 is
        C, E : Integer;
        begin -- of Sub3
          Sub1;
          E := B + A;  -- <----- 2
        end; -- of Sub3
      begin -- of Sub2
        Sub3;
        A := D + E;    -- <----- 3
      end; -- of Sub2
    begin -- of Bigsub
      Sub2(7);
    end; -- of Bigsub
  begin
    Bigsub;
  end; -- of Main
```

</div>
<div class="column" width="50%">
\small
Qual é o valor (`chain_offset`, `local_offset`) da referência a variável `A`
nos pontos 1, 2 e 3?

\pause

- Ponto 1
    - Variável local
    - `(0, 3)`
- Ponto 2
    - Variável não local (`bigsub`)
    - `(2, 3)`
- Ponto 3
    - Variável não local (`bigsub`)
    - `(1, 3)`
</div>
</div>

##

![](figs/10-9.pdf)


## Subprogramas aninhados

- Como a cadeia estática é mantida? \pause

- A cadeia estática precisa ser modificada a cada chamada ou retorno de
  subprograma

- O retorno é trivial

- A chamada é mais complexa


## Subprogramas aninhados

- Embora o escopo do pai seja facilmente determinado em tempo de compilação,
  a mais recente instância do registro de ativação do pai precisa ser
  encontrada a cada chamada \pause

- Este processo pode ser feito com dois métodos

    - Buscar pela cadeia dinâmica \pause

    - Tratar as declarações e referências de subprogramas como as de variáveis


## Subprogramas aninhados

- Críticas ao método de encadeamento estático

    - Acesso a uma referência não local pode ser lento se a profundidade do
      aninhamento for grande

    - Em sistemas de tempo crítico, é difícil determinar o custo de acesso
      a variáveis não locais



Blocos
======

## Blocos

- Algumas linguagens (incluindo C), permitem a criação de escopos definidos
  pelos usuários, chamados blocos

    ```c
    {
      int temp;
      temp = list[upper];
      list[upper] = list[lower];
      list[lower] = temp;
    }
    ```


## Blocos

- Blocos podem ser implementados de duas maneiras

    - Usando encadeamento estáticos (blocos são tratados como subprogramas sem
      parâmetros)

    - Como o valor máximo de memória requerido pelas variáveis de bloco podem
      ser determinados em tempo de compilação, esta memória poder ser alocada
      na pilha e as variáveis de bloco são tratadas como variáveis locais


## Blocos

<div class="columns">
<div class="column" width="30%">
\footnotesize

```c
void main() {
  int x, y, z;
  while (...) {
    int a, b, c;
    ...
    while (...){
      int d, e;
      ...
    }
  }
  while (...) {
    int f, g;
    ...
  }
  ...
}
```
</div>
<div class="column" width="70%">
![](figs/10-10.pdf)
</div>
</div>


Escopo dinâmico
===============

## Escopo dinâmico

- Existem duas maneiras para implementar acesso a variáveis não locais em
  linguagens com escopo dinâmico

    - Acesso profundo

    - Acesso raso


## Escopo dinâmico

- Acesso profundo

    - As referências não locais são encontradas seguindo os registros de
      ativação na cadeia dinâmica

    - O tamanho da cadeia não pode ser estaticamente determinada

    - Os nomes das variáveis devem ser armazenadas nos registros de ativação


## Escopo dinâmico

<div class="columns">
<div class="column" width="30%">
\footnotesize

```c
void sub3() {
  int x, z;
  x = u + v;
  ...
}
void sub2() {
  int w, x;
  ...
}
void sub1() {
  int v, w;
  ...
}
void main() {
  int v, u;
  ...
}
```
</div>
<div class="column" width="70%">
![](figs/10-11.pdf)
</div>
</div>


## Escopo dinâmico

- Acesso raso

    - As variáveis locais ficam em um lugar central (não ficam no registro de
      ativação)

    - Uma pilha para cada nome de variável

    <!-- TODO: completar os tópicos de escopo dinâmico -->


## Escopo dinâmico

<div class="columns">
<div class="column" width="30%">
\footnotesize

```c
void sub3() {
  int x, z;
  x = u + v;
  ...
}
void sub2() {
  int w, x;
  ...
}
void sub1() {
  int v, w;
  ...
}
void main() {
  int v, u;
  ...
}
```
</div>
<div class="column" width="70%">
\small
Chamadas: `main`, `sub1`, `sub1`, `sub2`, `sub3`.
![](figs/10-12.pdf)
</div>
</div>


## Referências

- Robert Sebesta, Concepts of programming languages, 9ª edição. Capítulo 10.
