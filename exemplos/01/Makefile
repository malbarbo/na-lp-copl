MSG=echo Testando

test-apelidos-java: Apelidos.class
	@${MSG} Apelidos.java
	@java Apelidos

test-apelidos-cpp: apelidos-cpp
	@${MSG} apelidos.cpp
	@./apelidos-cpp

test-apelidos-rs: apelidos-rs
	# falha na compilação!
	@${MSG} apelidos.rs
	@./apelidos-rs

test-maximo-c: maximo-c
	@${MSG} maximo.c
	@./maximo-c

test-maximo-rkt:
	@${MSG} maximo.rkt
	@raco test maximo.rkt

test-maximo-pl:
	@${MSG} Testando maximo.pl
	@swipl -q -t test maximo.pl

maximo-c: maximo.c
	@cc -o maximo-c maximo.c

apelidos-cpp: apelidos.cpp
	@c++ -o apelidos-cpp apelidos.cpp

apelidos-rs: apelidos.rs
	@rustc apelidos.rs

Apelidos.class: Apelidos.java
	@javac Apelidos.java
