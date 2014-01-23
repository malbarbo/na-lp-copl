---
title: Concorrência
---

# Introdução

### Introdução

-   Concorrência pode acontecer em quatro níveis \pause

    -   Instrução de máquina

    -   Instrução de linguagem

    -   Unidade (subprograma)

    -   Programa

    \pause

-   Como não existe questões de linguagens em concorrência no nível de instrução
    de máquina e programa, estes não serão discutidos

### Introdução

-   Arquiteturas multiprocessadores

    -   Final da década de 50, um processador de propósito geral e um ou mais
        processadores para operações de entrada e saída

    -   Início da década de 60, múltiplos processadores completos, usados para
        concorrência no nível de programas

    -   Metade da década de 60, múltiplos processadores parciais, usado para
        concorrência no nível de instrução de máquina

    -   Single-Instruction Multiple-Dada (SIMD)

    -   Multiple-Instruction Multiple-Dada (MIMD) - processadores independentes
        que podem ser sincronizados (concorrência no nível de unidade)

### Introdução

-   Uma **linha de controle** (thread of control) em um programa é a sequência
    de pontos do programa atingidos a medida que o controle flui por ele

-   Um programa projetado para ter mais que uma linha de controle é chamado de
    **multithreaded**

-   Categorias de concorrência

    -   Concorrência física, múltiplos processadores independentes (múltiplas
        linhas de controle)

    -   Concorrência lógica, a aparência de concorrência física está presente
        pelo compartilhamento por tempo de um processador

-   Co-rotinas (quasi-concorrente) tem apenas uma linha de controle

### Introdução

-   Motivação para o uso de concorrência

    -   Aumentar a velocidade de execução

    -   Uma maneira conceitual diferente de projetar soluções, muitas situações
        do mundo real envolvem concorrência

    -   Computadores com múltiplos processadores são amplamente usados

-   Um dos objetivos do software concorrente é ser escalável

-   Um software é **escalável** se a velocidade de execução aumenta quando mais
    processadores estão disponíveis

# Concorrência no nível de subprograma

### Concorrência no nível de subprograma

-   Uma **tarefa** ou **processo** é uma unidade de programa que pode estar em
    execução concorrente com outras unidades do programa

-   Um tarefa difere de um subprograma comum

    -   Uma tarefa pode ser iniciada implicitamente

    -   Quando um unidade de programa inicia a execução de uma tarefa, ela não é
        necessariamente suspensa

    -   Quando a execução de uma tarefa é completada, o controle pode não
        retornar ao chamador

-   Tarefas **pesadas** (heavyweight) executam em seu próprio espaço de
    endereçamento

-   Tarefas **leves** (lightweight) executam no mesmo espaço de endereçamento
    (mais eficiente)

### Concorrência no nível de subprograma

-   As tarefas geralmente trabalham juntas

-   Uma tarefa é **disjunta** se ela não se comunica ou não afeta a execução de
    outras tarefas

-   Sincronização de tarefas

    -   Um mecanismo que controla a ordem que as tarefas são executadas

    -   Dois tipos de sincronização

        -   Sincronização de cooperação

        -   Sincronização de competição

    -   A comunicação é necessária para a sincronização

        -   Variáveis não locais compartilhadas

        -   Parâmetros

        -   Troca de mensagem

### Concorrência no nível de subprograma

-   Cooperação: Uma tarefa A precisa esperar uma tarefa B completar alguma
    atividade antes que ela continue a execução (Ex: o problema do
    produtor-consumidor)

-   Competição: Duas ou mais tarefas precisam de algum recurso que não pode ser
    usado simultaneamente (ex: um contador compartilhado)

    -   Competição é geralmente resolvida por acesso mutualmente exclusivo

### Concorrência no nível de subprograma

-   Fornecer sincronização requer um mecanismo para adiar a execução da tarefa

-   O controle de execução das tarefas são mantidas pelo **escalonador**, que
    mapeia a execução das tarefas para os processadores disponíveis

-   Estados das tarefas

    -   Nova - criada mas ainda não iniciada

    -   Pronta - pronta para executar mas não está executando

    -   Executando

    -   Bloqueada - esteve rodando, mas não pode continuar (geralmente esperando
        um evento acontecer)

    -   Morta - Não está mais ativa

### Concorrência no nível de subprograma

-   **Vivência** significa que se algum evento (ex: término do programa) deve
    ocorrer, ele vai ocorrer

-   Em um ambiente de concorrência, uma tarefa pode facilmente perder a vivência

-   Quando todas as tarefas em um ambiente de concorrência perdem a vivência,
    ocorre um **deadlock**

### Concorrência no nível de subprograma

-   Questões de projeto

    -   Sincronização de cooperação e de competição

    -   Controle do escalonamento das tarefas

    -   Como e quando as tarefas são criadas

    -   Quando e como as tarefas iniciam e terminam a execução

# Mecanismos de controle de concorrência

## Semáforos

### Semáforos

-   Dijkstra - 1965

-   Um **semáforo** é uma estrutura de dados que consiste de um contador e uma
    fila de tarefas

-   Podem ser usados para implementar travas no código que acessa dados
    compartilhados

-   Têm apenas duas operações, esperar (wait) e liberar (release), chamados de P
    e V por Dijkstra

-   Podem ser usados para fornecer sincronização de cooperação e competição

### Semáforos

-   Exemplo: um buffer compartilhado

-   O buffer é implementado como um TAD com as operações `deposit` e `fetch`

-   Dois semáforos são usado para a cooperação: `emptyspots` e `fullspots`

-   Os semáforos são usados para armazenar o número de lugares vazios e ocupados
    no buffer

### Semáforos

-   `deposit` precisa checar `emptyspots` para ver se têm espaço no buffer \pause

    -   Se têm espaço, o contador de `emptyspots` é decrementado e o valor é
        inserido

    -   Se não têm espaço, o chamador é colocado na fila de `emptyspots`

    -   Quando `deposit` termina, ele precisa incrementar o contador de
        `fullspots`

    \pause

-   `fetch` precisa checar `fullspots` para ver se tem um valor \pause

    -   Se tem um lugar preenchido, o contador de `fullspots` é decrementado e o
        valor é removido

    -   Se não tem nenhum valor no buffer, o chamador é colocado na fila de
        `fullspots`

    -   Quando `fetch` termina, ele incrementa o valor do contador de
        `emptyspots`

### Semáforos

    wait(aSemaphore)
    if aSemaphore’s counter > 0 then
       decrement aSemaphore’s counter
    else
       put the caller in aSemaphore’s queue
       attempt to transfer control to a ready task
         -- if the task ready queue is empty,
         -- deadlock occurs
    end

### Semáforos

    release(aSemaphore)
    if aSemaphore’s queue is empty then
       increment aSemaphore’s counter
    else
       put the calling task in the task ready queue
       transfer control to a task from aSemaphore’s queue
    end

### Semáforos

    semaphore fullspots, emptyspots;
    fullstops.count = 0;
    emptyspots.count = BUFLEN;

    task producer;
      loop
        // produce value
        wait(emptyspots);    // wait for space
        deposit(value);
        release(fullspots);  // increase filled
      end loop;
    end producer;

    task consumer;
      loop
        wait(fullspots);     // wait till not empty
        fetch(value);
        release(emptyspots); // increase empty
        // consume value
      end loop;
    end consumer;

### Semáforos

-   Um terceiro semáforo, chamado `access`, é usado para o controle de accesso
    (sincronização de competição)

-   O contador de `access` terá apenas os valores 0 e 1

-   Tal semáforo é chamado de semáforo binário

-   As operações `wait` e `release` precisam ser atômicas

###

    semaphore fullspots, emptyspots, access;
    access.count = 1;
    fullstops.count = 0;
    emptyspots.count = BUFLEN;
    task producer;
      loop
        // produce value
        wait(emptyspots);
        wait(access);
        deposit(value);
        release(access);
        release(fullspots);
      end loop;
    end producer;
    task consumer;
      loop
        wait (fullspots);
        wait(access);
        fetch(value);
        release(access);
        release(emptyspots);
        // consume value
      end loop;
    end consumer;

### Semáforos

-   Avaliação

    -   Uso incorreto de semáforos pode causar falha na sincronização de
        cooperação, ex: ocorrerá overflow do buffer se a chamada `wait` em
        `fullspots` for esquecida

    -   Uso incorreto de semáforos pode causar falha na sincronização de
        competição, ex: o programa entrará em deadlock se a chamada `release` de
        `access` for esquecida

## Monitores

### Monitores

-   Encapsular os dados compartilhados e as operações em um tipo abstrato de
    dados

-   Transferir a responsabilidade de sincronização para o ambiente de execução

-   Exemplos de linguagens

    -   Ada

    -   Java

    -   C\#

### Monitores

-   Sincronização de competição

    -   Os dados residem no monitor

    -   A implementação do monitor garante a sincronização permitindo apenas um
        acesso por vez

    -   As chamadas a procedimentos dos monitores são enfileiradas
        implicitamente quando o monitor está ocupado

    \pause

-   Sincronização de cooperação

    -   É responsabilidade do programador

    -   O programador precisa garantir que o buffer compartilhado não vai sofrer
        overflow ou underflow

### Monitores

-   Avaliação

    -   Oferece um maneira mais fácil de realizar sincronização de competição do
        que os semáforos

    -   Mesmo poder de expressão de controle de concorrência dos semáforos

        -   Monitores podem ser usados para implementar semáforos

        -   Semáforos podem ser usados para implementar monitores

    -   Suporte a sincronização de cooperação é similar a dos semáforos,
        portanto, tem os mesmos problemas

## Troca de Mensagens

### Troca de Mensagens

-   É um modelo geral para concorrência

    -   Pode ser usado para implementar monitores e semáforos

    -   Pode ser usado para sincronização de cooperação

-   A ideia e realizar a comunicação entre duas tarefas, quando as duas
    estiverem prontas para se comunicar

### Troca de Mensagens

-   Para suportar tarefas concorrentes com troca de mensagens, uma linguagem
    precisa

    -   Um mecanismo que permita uma tarefa indicar quando ela quer receber uma
        mensagem

    -   Uma maneira de lembrar quais tarefas estão esperando sua mensagem ser
        recebida

    -   Uma maneira justa de escolher a próxima mensagem

-   Quando uma mensagem enviada por uma tarefa é aceita, a transmissão da
    mensagem é chamada de **rendezvous**

# Exemplos de linguagens

## Suporte a concorrência em Ada

### Suporte a concorrência em Ada

-   O controle de concorrência das tarefas é baseado em troca de mensagens

-   O modelo de tarefas é complexo (esta apresentação é limitada)

-   As tarefas em Ada são mais ativas que os monitores

-   Existem vários mecanismos para a escolha entre os pedidos para acessar seus
    recursos

### Suporte a concorrência em Ada

-   Definição de uma tarefa

    -   Uma tarefa tem uma especificação e um corpo (como os pacotes)

    -   A especificação define a interface, que é uma coleção de pontos de
        entrada

    -   O corpo descreve as ações que são executadas quando um rendezvous ocorre

    -   Pontos de entrada na especificação são definidos com a cláusula `access`
        no corpo

### Suporte a concorrência em Ada

```ada
task Task_Example is
  entry Entry_1(Item: in Integer);
end Task_Example;

task body Task_Example is
  begin
    loop
      accept Entry_1 (Item: in Integer) do
        ...
      end Entry_1;
    end loop;
  end Task_Example;
```

### Suporte a concorrência em Ada

-   Semântica da troca de mensagens

    -   Uma tarefa executa até o início de uma cláusula `accept` e espera por
        uma mensagem

    -   O emissor de uma mensagem é suspenso esperando a mensagem ser aceita e
        durante o rendezvous (execução da cláusula `accept`)

    -   Cada cláusula `accept` tem uma fila para armazenar as mensagens que
        estão esperando

    -   Os parâmetros de `accept` pode transmitir informação em ambas as
        direções

### Linha do tempo de um troca de mensagem

- Imagem 13-3 do livro

<!-- FIXME: esta imagem não tem no arquivo disponível para dowload
![](imagens/copl-13-3.png)
!-->

### Suporte a concorrência em Ada

-   Tipos de tarefas

    -   Uma tarefa que tem apenas cláusulas `accept`, é chamada de **tarefa
        servidor**

    -   Uma tarefa sem cláusula `accept` é chamada de **tarefa ator**

    -   Uma tarefa ator pode enviar mensagens para outras tarefas

    -   Uma emissor precisa saber o nome da entrada do receptor, mas não o
        contrário

### Suporte a concorrência em Ada

-   Múltiplas entradas

    -   Uma tarefa pode ter mais que uma entrada

    -   Cada entrada é listada na especificação

    -   No corpo deve existir uma cláusula `accept` para cada entrada

    -   As cláusulas `accept` podem vir uma após a outra, o que define a ordem
        que as mensagens serão recebidos, ou colocadas em uma cláusula `select`

### Suporte a concorrência em Ada

```ada
task body Teller is
  loop
    select
      accept Drive_Up(formal params) do
        ...
      end Drive_Up;
      ...
    or
      accept Walk_Up(formal params) do
        ...
      end Walk_Up;
      ...
    end select;
  end loop;
end Teller;
```

### Suporte a concorrência em Ada

-   Semântica das tarefas com `select`

    -   Se exatamente uma fila de entrada não está vazia, uma mensagem é
        escolhida desta fila

    -   Se mais de uma fila de entrada não está vazia, escolhe uma não
        deterministicamente, e aceite uma mensagem desta fila

    -   Se todas as filas estão vazias, espere

-   Esta construção é chamada de **espera seletiva**

-   O código que segue a cláusula `accept` (antes de outra cláusula ) é
    executada concorrentemente com o emissor

### Suporte a concorrência em Ada

-   Sincronização de cooperação

    -   Obtida com cláusulas `accept` guardadas (por uma condição)

    -   Uma cláusula guardada pode estar **aberta** ou **fechada**

    -   Uma cláusula que a guarda é verdadeira está aberta

    -   Uma cláusula que a guarda é false está fechada

    -   Uma cláusula sem guarda está sempre aberta

    \pause

    ```ada
    when not Full(Buffer) =>
      accept Deposit (New_Value) do
        ...
      end
    ```


### Suporte a concorrência em Ada

-   Semântica das tarefas com `select` com cláusulas `accept` guardadas

    -   `select` verifica as guardas de todas as cláusulas

    -   Se exatamente um cláusula está aberta, a sua fila é checada por
        mensagens

    -   Se mais de uma cláusula está aberta, uma delas é escolhida não
        deterministicamente

    -   Se todas cláusulas estão fechadas, é um erro de execução

    -   A cláusula `select` pode ter uma cláusula `else`, que está sempre aberta

    -   A cláusula `select` pode ter uma cláusula `terminate`, que só é
        selecionada quando estiver aberta e todas as outras cláusulas fechadas

### Suporte a concorrência em Ada

-   Sincronização de competição

    -   Encapsular os dados compartilhados em uma tarefa

    -   A sincronização está implícita na semântica das cláusulas `accept`,
        apenas uma pode estar ativa

    \pause

-   Exemplo: problema do produtor consumidor

###

```ada
task body Buf_Task is
   Bufsize : constant Integer := 10;
   Buf : array (1..Bufsize) of Integer;
   Filled : Integer Range 0..Bufsize := 0;
   Next_In, Next_Out : Integer range 1..Bufsize := 1;
begin
  loop
    select
      when Filled < Bufsize =>
        accept Deposit(Item : in Integer) do
          Buf(Next_In) := Item;
        end Deposit;
        Next_In := (Next_In mod Bufsize) + 1;
        Filled := Filled + 1;
    or
      when Filled > 0 =>
        accept Fetch(Item : out Integer) do
          Item := Buf(Next_Out);
        end Fetch;
        Next_Out := (Next_Out mod Bufsize) + 1;
        Filled := Filled - 1;
    end select;
  end loop;
end Buf_Task;
```

###

```ada
task Producer;
task Consumer;

task body Producer is
  New_Value : Integer;
begin
  New_Value := 0;
  loop
    -- produce new value --
    Buf_Task.Deposit(New_Value);
  end loop;
end Producer;

task body Consumer is
  Stored_Value : Integer;
begin
  loop
    Buf_Task.Fetch(Stored_Value);
    -- consume value --
  end loop;
end Consumer;
```

### Suporte a concorrência em Ada

-   Término de tarefas

    -   A execução de uma tarefa está **completa** se o controle chegou no final
        do código

    -   Se uma tarefa não criou tarefas dependentes e ela está completa, então
        ela está **terminada**

    \pause

-   Prioridade das tarefas

    -   A prioridade de uma tarefa pode ser definida com a instrução:


            pragma Priority (expression);


    -   A prioridade de uma tarefa só vale quando a tarefa está na fila de
        tarefas prontas

    -   As tarefas com maior prioridade são executadas primeiro

### Suporte a concorrência em Ada

-   Sincronização de competição quando os dados não estão encapsulados em uma
    tarefa

    -   Semáforo binário

    \pause

    ```ada
    task Binary_Semaphore is
      entry Wait;
      entry Release;
    end Binary_Semaphore;

    task body Binary_Semaphore is
      begin
      loop
        accept Wait;
        accept Release;
      end loop;
    end Binary_Semaphore;
    ```


### Suporte a concorrência em Ada

-   Concorrência em Ada 95

    -   Objetos protegidos: uma maneira mais eficiente de implementar acesso a
        dados compartilhados (sem rendezvous)

    -   Comunicação assíncrona

### Suporte a concorrência em Ada

-   Objetos protegidos

    -   Um objeto protegido é semelhante a um monitor

    -   Acesso a um objeto protegido é feito através de mensagem (como em uma
        tarefa), ou através de subprogramas protegidos

    -   Um procedimento protegido fornece acesso mutualmente exclusivo de
        leitura-escrita

    -   Um função protegida fornece acesso concorrente apenas de leitura

###

```ada
protected Buffer is
  entry Deposit(Item : in Integer);
  entry Fetch(Item : out Integer);
  private
    Bufsize : constant Integer := 100;
    Buf : array (1..Bufsize) of Integer;
    Filled : Integer range 0..Bufsize := 0 ;
    Next_In,
    Next_Out : Integer range 1..Bufsize := 1;
end Buffer;
protected body Buffer is
  entry Deposit(Item ; in Integer) when Filled < Bufsize is
  begin
    Buf(Next_In) := Item;
    Next_In := (Next_In mod Bufsize) + 1;
    Filled := Filled + 1;
  end Deposit;
  entry Fetch(Item : out Integer) when Filled > 0 is
  begin
    Item := Buf(Next_Out);
    Next_Out := (Next_Out mod Bufsize) + 1;
    Filled := Filled - 1;
  end Fetch;
end Buffer;
```

### Suporte a concorrência em Ada

-   Avaliação

    -   A troca de mensagens é um modelo de concorrência poderoso e geral

    -   Objetos protegidos são uma maneira melhor para sincronismo em dados
        compartilhados

    -   Sobre sincronização de competição, na falta de processadores
        distribuídos, a escolha entre monitores e tarefas com troca de mensagens
        é uma questão de preferência

    -   Para sistemas distribuídos, troca de mensagens é um modelo de
        concorrência melhor

## Threads em Java

### Threads em Java

-   As unidades concorrentes em java são métodos nomeados `run`

-   As tarefas que executam os métodos `run`, são chamadas de threads

-   As threads são tarefas leves

-   Existem duas maneiras de criar um método run

    -   Criar uma subclasse da classe `Thread` e sobrescrever o método `run`

    -   Implementar a interface `Runnable`, que declara o método `run`

-   As threads em Java são um assunto complexo, esta apresentação fornece apenas
    uma introdução ao assunto

### Threads em Java

-   Métodos da classe `Thread`

    -   `start` inicia a execução concorrente do método `run`

    -   `yield` faz um pedido para a thread ser retirada do processador

    -   `sleep` bloqueia a thread

    -   `join` faz uma thread esperar que a execução de outra thread termine
        `run`

    -   `stop`, `suspend`, `resume`, depreciados por problema de proteção

### Threads em Java

-   Término de uma thread

    -   A maneira comum e o método `run` chegar no final do código

    -   O método `interrupt` é usado para comunicar a uma thread que ela deve
        parar a execução

    -   O método `interrupt` marca uma flag na thread que deve ser verificada
        constantemente

    -   Se a thread estiver dormindo ou esperando, a exceção
        `InterruptedException` é lançada

### Threads em Java

-   Prioridades

    -   A prioridade padrão de uma thread é a mesma prioridade da thread que a
        criou

    -   Existem três constantes para prioridade `MIN_PRIORITY`, `NORM_PRIORITY`,
        `MAX_PRIORITY`

    -   A prioridade de uma thread pode ser alterada com o método `setPriority`

### Threads em Java

-   Sincronização de competição

    -   Um método marcado com o modificador `synchronized` precisa terminar sua
        execução antes que qualquer outro método sincronizado possa acessar o
        objeto

    -   A sincronização de competição é feita marcado cada método que acessa
        dados compartilhados como sincronizado

        ```java
        ...
        public synchronized void deposit(int item) { ... }
        public synchronized int fetch() { ... }
        ...
        ```


    -   Os dois métodos acima são sincronizados, o que previne que a execução de
        cada um interfira o outro

    -   Se apenas uma parte do método lida com dados compartilhados, a instrução
        `synchronized` pode ser usada

        ```java
        synchronized (expression) {
            statements;
        }
        ```


### Threads em Java

-   Sincronização de cooperação

    -   É feita através dos métodos `wait`, `notify`, `notifyAll` da classe
        `Object`

    -   Todo objeto tem uma lista de threads que chamaram o método `wait` no
        objeto

    -   O método `notify` é chamado para informar para uma thread que o evento
        que ela estava esperando aconteceu

    -   As vezes, as threads estão esperando com condições distintas, neste caso
        o método `notifyAll` é usado para despertar todas as threads na lista de
        espera do objeto. Neste caso, o método `wait` é chamado em um laço

    -   Os métodos `wait`, `notify`, `notifyAll` só podem ser chamados em uma
        seção sincronizada

### Threads em Java

-   Arquivo `ProducerConsumer.java`

### Threads em Java

-   Avaliação

    -   O suporte a concorrência em Java é relativamente simples mas efetivo

    -   Não é tão poderoso quando as tarefas em Ada

-   Java 5 melhorou o suporte a concorrência com o pacote `java.util.concurrent`

-   Java 7 framework fork/join

## Threads em C\#

### Threads em C\#

-   Vagamente baseado em Java, com diferenças significativas

    -   Qualquer método pode ser executado em sua própria thread

    -   Uma thread é criado pela classe `Thread`

    -   Criar uma thread não inicia a sua execução concorrente; isto precisa ser
        feito com o método `Start`

    -   Uma thread pode esperar pelo término de outra chamando o método `Join`

    -   Uma thread pode ser suspensa com `Sleep`

    -   Uma thread pode ser terminada com `Abort`

### Threads em C\#

-   Três forma de sincronismo de threads \pause

-   A classe `Interlocked`

    -   Usado quando a única operação que precisa ser sincronizada é o
        incremento e decremento de um inteiro

    \pause

-   A instrução `lock`

    -   Usado para marcar regiões críticas

        ```cs
        lock(expression) { ... }
        ```

    \pause

-   A classe `Monitor`

    -   Sincronização mais sofisticada (métodos
        `Enter, Wait, Pulse, PulseAll, Exit`)

### Threads em C\#

-   Avaliação

    -   Uma melhora pequena em relação ao Java, qualquer método pode executar em
        sua própria thread

    -   O término de execução de uma thread é mais claro que em Java

    -   Como as thread são tarefas leves, elas não são tão versáteis quanto as
        tarefas em Ada

# Concorrência no nível de instrução

### Concorrência no nível de instrução

-   Fornecer um mecanismo que o programador possa usar para informar o
    compilador a maneira que o programa pode ser mapeado para um arquitetura
    multiprocessador

-   Minimizar a comunicação entre os processadores e as memórias de outros
    processadores

### HPF - High Performace Fortran

-   Uma coleção de extensões que permitem o programador fornecer informações
    para o compilador que o ajudam a otimizar o código para computadores
    multiprocessados

-   Especifica o número de processadores, a distribuição dos dados para as
    memórias dos processadores e o alinhamento dos dados

### HPF - High Performace Fortran

-   Número de processadores

        !HPF$ PROCESSORS procs (n)

    \pause

-   Distribuição dos dados

        !HPF$ DISTRIBUTE (kind) ONTO procs :: identifier_list

    -   `kind` pode ser `BLOCK` ou `CYCLIC`

    \pause

-   Relacionar a distribuição de um array com outro

        ALIGN array1_element WITH array2_element

    \pause

-   Exemplo

        REAL list_1(1000), list_2(1000)
        INTEGER list_3(500), list_4(501)
        !HPF$ PROCESSORS proc (10)
        !HPF$ DISTRIBUTE (BLOCK) ONTO procs :: list_1, list_2
        !HPF$ ALIGN list_1(index) WITH list_4 (index+1)

        list_1(index) = list_2(index)
        list_3(index) = list_4(index + 1)

### HPF - High Performace Fortran

-   A instrução `FORALL` é usada para especificar uma lista de instruções que
    podem ser executadas concorrentemente

        FORALL (index = 1:1000)
            list_1(index) = list_2(index)

# Referências

### Referências

-   Robert Sebesta, Concepts of programming languages, 9ª edição. Capítulo 13.


<!-- vim: set spell spelllang=pt_br: -->
