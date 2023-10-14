.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro	
cout_uncor: 	
.data
	overflow: .asciz "Произошло переполнение!"
	correct_sum: .asciz "\nСумма до переполнения: "
	el_number: .asciz "\nКоличество просуммированных элементов: "
.text
	la a0, overflow       	# Помещаем в регистр а0 строку overflow
	li a7, 4            	# Системный вызов №4 - вывести null-terminated string
	ecall
	la a0, correct_sum     # Помещаем в регистр а0 строку correct_sum
	ecall
	print_int (s8)		# Вывод целого числа из регистра s8     
	la a0, el_number       # Помещаем в регистр а0 строку el_number
	li a7, 4            	# Системный вызов №4 - вывести null-terminated string
	ecall
	print_int (s2)		# Вывод целого числа из регистра s2     
	li a7 10       		# Системный вызов №10 — остановка программы 
	ecall	
	
	
