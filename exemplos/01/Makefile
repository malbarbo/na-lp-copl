all: maximo
	@echo Testando programa maximo.c
	@./maximo
	@echo Testando programa maximo.rkt
	@raco test maximo.rkt
	@echo Testando programa maximo.pl
	@swipl -q -t test maximo.pl

maximo: maximo.c
	@gcc -o maximo maximo.c
