.macro cin
	.data
		len: .asciz "Количество элементов в массиве: "
		number_error: .asciz "Ошибка: количество элементов должно быть в диапазоне от 0 до 10"
		arg: .asciz "Введите число: " 
		
	.align 2
		array: .space 64
		arrend:
	.text
		la a0, len				# Помещаем строку len в регистр a0
		li a7, 4				# Системный вызов №4 - вывести null-terminated string
		ecall
		read_int(s0)				# Чтение целого числа
		blt  s0, zero, uncorrect_number 	# Если число, введеннное пользователем, меньше нуля - переход к uncorrect_number
		addi, s10, s10, 10			# Помещаем в регистр s10 число 10
		bgt s0, s10, uncorrect_number 		# Если число, введеннное пользователем, больше десяти - переход к uncorrect_number
		j correct_number			# Переход к uncorrect_number
	      
	uncorrect_number: 	
		li a7, 4				# Системный вызов №4 - вывести null-terminated string
		la a0, number_error			# Помещаем строку number_error в регистр a0
		ecall					# Выводим текст ошибки
		li a0, 0             			# exit code
		li a7, 10           			# syscall exit
		ecall	
		
	correct_number:
		la t0 array				# Счетчик
		la s1 arrend
		while:	la a0, arg			# Помещаем в регистр а0 строку arg
			li a7, 4			# Системный вызов №4 - вывести null-terminated string
			ecall
			read_int(a0)			# Чтение целого числа
			sw a0 (t0)			# Запись введенного числа по адресу t0
			addi t0 t0 4			# Увеличение адреса на размер слова в байтах
			
			addi s2, s2, 1			# Увеличение счетчика, отвечающего за количество введенных элементов
			blt s2, s0, while 		# Если счетчик меньше числа элементов, запускаем тело цикла еще раз
		la t0 array
		mv s2, zero
	
.end_macro	
	
	
.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
.end_macro

.macro sum
	.data
		odd: .asciz "Количество нечетных элементов массива: "
		even: .asciz "Количество четных элементов массива: "
	.text
		sum_array:	
			lw a0 (t0)			# Загружаем в а0 значение по адресу t0
			mv s8, s3			# Запишем в регистр s8 промежуточное значение суммы
			add s3, s3, a0			# Добавим к счетчику суммы текущий элемент
			blt s8, zero, other		# Проверки на переполнение
			bgt s3, zero, ok 
			blt a0, zero, ok
			j error				# Если сумма была больше нуля, стала меньше нуля, а текущий элемент > 0 => произошло переполнение
			other:  blt s3, zero, ok 
				bgt a0, zero, ok	# Если сумма была меньше нуля, стала больше нуля, а текущий элемент < 0 => произошло переполнение
			error:	addi s11, s11, 1	# Положим в регистр s11 число 1, чтобы позднее понять, что была ошибка
				j end
	
			ok:
			addi t0, t0, 4			# Увеличение адреса на размер слова в байтах
			addi s2, s2, 1			# Увеличение счетчика, отвечающего за количество введенных элементов
			blt s2, s0, sum_array 		# Если счетчик меньше числа элементов, запускаем тело цикла еще раз
			end:
				
.end_macro


.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro


.macro cout_cor

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
	
.end_macro


.macro cout_uncor 	
	.data
		overflow: .asciz "Произошло переполнение!"
		correct_sum: .asciz "\nСумма до переполнения: "
		el_number: .asciz "\nКоличество просуммированных элементов: "
	.text
		la a0, overflow       			# Помещаем в регистр а0 строку overflow
		li a7, 4            			# Системный вызов №4 - вывести null-terminated string
		ecall
		la a0, correct_sum     		# Помещаем в регистр а0 строку correct_sum
		ecall
		print_int (s8)				# Вывод целого числа из регистра s8     
		la a0, el_number       		# Помещаем в регистр а0 строку el_number
		li a7, 4            			# Системный вызов №4 - вывести null-terminated string
		ecall
		print_int (s2)				# Вывод целого числа из регистра s2     
.end_macro
	 
.macro exit
		li a7 10       				# Системный вызов №10 — остановка программы 
		ecall	
.end_macro