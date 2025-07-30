input = input.txt
output = output.txt

main: cal.l cal.y
	bison -d cal.y
	flex cal.l
	gcc cal.tab.c lex.yy.c -o a.exe
	./a.exe < $(input) > $(output)
