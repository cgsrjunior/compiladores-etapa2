# Autor: Cleiber Rodrigues
# Cartao: 00271039 


etapa2: clean y.tab.c lex.yy.c hash.c main.c
	gcc lex.yy.c -o etapa2 

y.tab.c: parser.y
	bison parser.y -dy

lex.yy.c: scanner.l 
	flex scanner.l 

clean: 
	rm -f etapa2 lex.yy.c y.tab.c y.tab.h