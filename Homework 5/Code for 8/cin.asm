cin:
.include "macrolib.asm"
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
	
ret	
	
	

	 
