.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro
cout_cor:

.data
	ans_sum: .asciz "Сумма элементов массива: "
	numb_el: .asciz "\nКоличество просуммированных элементов: "
.text

	la a0, ans_sum       			# Помещаем в регистр а0 строку ans_sum
	li a7, 4            			# Системный вызов №4 - вывести null-terminated string
	ecall
	print_int (s3)				# Вывод целого числа из региистра s3
	
	la a0, numb_el      			# Помещаем в регистр а0 строку numb_el
	li a7, 4            			# Системный вызов №4 - вывести null-terminated string
	ecall
	
	print_int (s2)				# Вывод целого числа из регистра s2     				
	ecall
	li a7 10       				# Системный вызов №10 — остановка программы 
	ecall	
	
	

	