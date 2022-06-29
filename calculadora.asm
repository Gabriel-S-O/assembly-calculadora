.data
	s_mais: .asciiz " + "
	s_menos: .asciiz " - "
	s_mult: .asciiz " x "
	s_divis: .asciiz " / "
	s_igual: .asciiz " = "
	pular_linha: .asciiz "\n"
	
	menu_text: .asciiz "Escolha a operação (1 para +), (2 para -), (3 para /), (4 para x) e 0 para sair: "
	pedir_valor_x: .asciiz "Informe o primeiro valor: "
	pedir_valor_y: .asciiz "Informe o segundo valor: "
.text
	j menu
menu:

	la $a0, pular_linha
	li $v0, 4
	syscall

	la $a0, menu_text # imprime a label do menu 
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall
	
	li $v0, 5 # carrega o valor 5 pra usar a syscall de ler um int (o valor que é lido é armazenado no registrador v0)
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
	
	li $t1, 0
	beq $t1, $t0, encerrar 
leitor:
	la $a0, pedir_valor_x # imprime a label que pede o primeiro valor
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall
	
	# valores double utilizam 2 registradores por conta da precisão
	
	li $v0, 7 # carrega o valor 7 pra usar a syscall de ler double (por padrão o valor vai pro registrador $f0)
	syscall # chama a syscall
	mov.d $f2, $f0 # move o double que foi lido (está em f0 e f1) para f2
	
	la $a1, pedir_valor_y # imprime a label que pede o segundo valor
	li $v0, 4 # carrega o valor 4 pra usar a syscall de printar string
	syscall # chama a syscall
	
	li $v0, 7 # carrega o valor 7 pra usar a syscall de ler double (por padrão o valor vai pro registrador $f0)
	syscall # chama a syscall
	mov.d $f4, $f0 # move o double que foi lido (está em f0) para f4
	
	jr $ra # salta pra branch que está com o endereço salvo no registrador ra (nesse caso a branch soma)
soma: 
	jal leitor # salta pra branch leitor e guarda o endereço da branch soma no registrador ra
	add.d $f0, $f2, $f4 # guarda no registrador f0 o valor da soma dos registradores f2 e f4
	mov.d $f12, $f0 # move o resultado que está em f0 para o f12 (o registrador que a syscall printa para doubles)
	li $v0, 3 # carrega o valor 4 para usar a syscall de printar doubles
	syscall # chama a syscall
	
	j menu
subtrair:
	jal leitor
	sub.d $f0, $f2, $f4
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	j menu
dividir:
	jal leitor
	div.d $f0, $f2, $f4
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	j menu
multiplicar:
	jal leitor
	mul.d $f0, $f2, $f4
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	j menu
encerrar:
	li $v0, 10
