.include "cin.asm"
.include "sum.asm"
.include "cout_cor.asm"
.include "cout_uncor.asm"
.global main


main:
	jal cin    		# Вызов подпрограммы для ввода данных
	jal sum			# Вызов подпрограммы для подсчета суммы
	beq s11 zero corr	# Если переполнения не произошло, вызывается подпрограмма для случая без переполнения
	jal cout_uncor		# Вызов подпрограммы для случая переполнения
	corr:	jal cout_cor   # Вызов подпрограммы для случая без переполнения
	
	
	