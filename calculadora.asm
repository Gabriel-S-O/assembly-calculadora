# feito na IDE MARS vers�o 4.5

.data
	s_mais: .asciiz " + "
	s_menos: .asciiz " - "
	s_mult: .asciiz " x "
	s_divis: .asciiz " / "
	s_igual: .asciiz " = "
	pular_linha: .asciiz "\n"
	
	menu_text: .asciiz "Escolha a opera��o (1 para +), (2 para -), (3 para /), (4 para x) e 0 para sair: "
	pedir_valor_x: .asciiz "Informe o primeiro valor: "
	pedir_valor_y: .asciiz "Informe o segundo valor: "
.text
	j menu # salta pra label do menu
menu:

	la $a0, pular_linha # imprime a string que pula uma linha
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall

	la $a0, menu_text # imprime a string do menu 
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall
	
	li $v0, 5 # carrega o valor 5 pra usar a syscall de ler um int (o valor que � lido � armazenado no registrador v0)
	syscall # chama a syscall
	move $t0, $v0  # coloca o valor que ta no registrador v0 (usado pra syscall) no t0
	
	li $t1, 1 # carrega o valor 1 no registrador t1
	beq $t1, $t0, soma # caso o valor que foi lido no input seja 1, vai saltar pra soma	
	
	li $t1, 2 # carrega o valor 1 no registrador t1
	beq $t1, $t0, subtrair # caso o valor que foi lido no input seja 2, vai saltar pra subtrair
	
	li $t1, 3 # carrega o valor 1 no registrador t1
	beq $t1, $t0, dividir # caso o valor que foi lido no input seja 3, vai saltar pra dividir	
	
	li $t1, 4 # carrega o valor 1 no registrador t1
	beq $t1, $t0, multiplicar # caso o valor que foi lido no input seja 4, vai saltar pra multiplicar
	
	li $t1, 0 # carrega o valor 0 no registrador t1
	beq $t1, $t0, encerrar  # caso o valor que foi lido no input seja 0, vai saltar pra encerrar
leitor:
	la $a0, pedir_valor_x # imprime a string que pede o primeiro valor
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall
	
	# valores double utilizam 2 registradores por conta da precis�o
	
	li $v0, 7 # carrega o valor 7 pra usar a syscall de ler double (por padr�o o valor vai pro registrador $f0)
	syscall # chama a syscall
	mov.d $f2, $f0 # move o double que foi lido (est� em f0 e f1) para f2
	
	la $a1, pedir_valor_y # imprime a string que pede o segundo valor
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall
	
	li $v0, 7 # carrega o valor 7 pra usar a syscall de ler double (por padr�o o valor vai pro registrador $f0)
	syscall # chama a syscall
	mov.d $f4, $f0 # move o double que foi lido (est� em f0) para f4
	
	jr $ra # salta pra label que est� com o endere�o salvo no registrador ra
soma: 
	jal leitor # salta pra label leitor e guarda o endere�o da label soma no registrador ra
	add.d $f0, $f2, $f4 # guarda no registrador f0 o valor da soma dos registradores f2 e f4
	mov.d $f12, $f0 # move o resultado que est� em f0 para o f12 (o registrador que a syscall printa o valor para doubles)
	li $v0, 3 # carrega o valor 3 para usar a syscall de printar doubles
	syscall # chama a syscall
	
	j menu # salta pra label do menu
subtrair:
	jal leitor # salta pra label leitor e guarda o endere�o da label subtrair no registrador ra
	sub.d $f0, $f2, $f4 # guarda no registrador f0 o valor da subtra��o dos registradores f2 e f4
	mov.d $f12, $f0 # move o resultado que est� em f0 para o f12 (o registrador que a syscall printa o valor para doubles)
	li $v0, 3 # carrega o valor 3 para usar a syscall de printar doubles
	syscall # chama a syscall
	
	j menu # salta pra label do menu
dividir:
	jal leitor # salta pra label leitor e guarda o endere�o da label dividir no registrador ra
	div.d $f0, $f2, $f4 # guarda no registrador f0 o valor da divis�o dos registradores f2 e f4
	mov.d $f12, $f0 # move o resultado que est� em f0 para o f12 (o registrador que a syscall printa o valor para doubles)
	li $v0, 3 # carrega o valor 3 para usar a syscall de printar doubles
	syscall # chama a syscall
	
	j menu # salta pra label do menu
multiplicar:
	jal leitor # salta pra label leitor e guarda o endere�o da label multiplicar no registrador ra
	mul.d $f0, $f2, $f4 # guarda no registrador f0 o valor da multiplica��o dos registradores f2 e f4
	mov.d $f12, $f0 # move o resultado que est� em f0 para o f12 (o registrador que a syscall printa o valor para doubles)
	li $v0, 3 # carrega o valor 3 para usar a syscall de printar doubles
	syscall # chama a syscall
	
	j menu # salta pra label do menu
encerrar:
	li $v0, 10 # carrega o valor 10 no registrador v0 que chama a syscall que encerra a execu��o
	syscall