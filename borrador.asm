iterateVector:

; busco num2

	mov		eax,dword[posVector]
	dec		eax		
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	eax, dword[eax]
	mov 	dword[num2], eax

; busco num1

	mov		eax,dword[posVector]
	dec		eax
	dec		eax				
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	eax, dword[eax]
	mov 	dword[num1], eax


; se compara num1 y num2
	mov 	eax, [num1]
	mov 	ebx, [num2]

	call 	compararAscendente

	cmp 	eax, 0
	jle 	continue

	call  	swap


continue:

	inc		dword[posVector]
	mov     eax, dword[lenVector]
	cmp		dword[posVector],eax
	jle		iterateVector			

	ret

compararAscendente:
	
	cmp 	eax, 0
	jle 	casoGeneral
	cmp 	ebx, 0
	jge 	casoGeneral
	mov  	eax, 1

casoGeneral:
	sub 	eax, ebx

	ret

swap:

; guardo en aux
	mov eax, dword[num2]
	mov dword[aux], eax

; busco num2 y swap 
	mov		eax,dword[posVector]
	dec		eax		
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	edx, dword[num1]
	mov 	dword[eax], edx

; busco num1 y swap

	mov		eax,dword[posVector]
	dec		eax
	dec		eax				
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	edx, dword[aux]
	mov 	dword[eax], edx

	ret

---------------------------------------------------------
compararAscendente:			;eax=1 si x<y
	
		cmp 	ecx, 0
		jle 	casoGeneralAscendente
		cmp 	edx, 0
		jge 	casoGeneralAscendente
		jmp  	falseCompararAscendente

	casoGeneralAscendente:
		sub 	ecx, edx
		cmp 	ecx, 0
		jge 	falseCompararAscendente
		mov		eax, dword[1]
		jmp  	finCompararAscendente

	falseCompararAscendente:
		mov  	eax, dword[-1]

	finCompararAscendente:
		ret

compararDescendente:
	
		cmp 	ecx, 0
		jge		casoGeneralDescendente
		cmp 	edx, 0
		jle 	casoGeneralDescendente
		jmp  	falseCompararDescendente

	casoGeneralDescendente:
		sub 	ecx, edx
		cmp 	ecx, 0
		jge 	falseCompararDescendente
		mov		eax, 1
		jmp  	finCompararDescendente

	falseCompararDescendente:
		mov  eax, -1

	finCompararDescendente:
		ret

printVector:

	mov		eax,dword[posVector]	;eax = posicion
	dec		eax						;eax = posicion - 1
	imul	dword[lenRegister]		;eax = (posicion - 1) * 10
	lea		eax,[vector+eax]		;eax = dir nombre

	push 	dword[eax]
	push 	msgLine
	call 	printf
	add 	esp, 8

	inc		dword[posVector]
	mov     eax, dword[lenVector]
	cmp		dword[posVector],eax
	jle		printVector			

	ret
-------------------------------------
;_______________________________insertion___________________________________

iterateVector:

; busco num2

	mov		eax,dword[posVector]
	dec		eax		
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	eax, dword[eax]
	mov 	dword[num2], eax

; busco num1

	mov		eax,dword[posVector]
	dec		eax
	dec		eax				
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	eax, dword[eax]
	mov 	dword[num1], eax


; se compara num1 y num2
	mov 	ecx, dword[num1]
	mov 	edx, dword[num2]

	call 	compararAscendente

	cmp 	eax, 0
	jge 	continue

	call  	swap


continue:

	inc		dword[posVector]
	mov     eax, dword[posVector]
	cmp		dword[lenVector],eax
	jge		iterateVector

	ret


swap:

; guardo en aux
	mov eax, dword[num2]
	mov dword[aux], eax

; busco num2 y swap 
	mov		eax,dword[posVector]
	dec		eax		
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	edx, dword[num1]
	mov 	dword[eax], edx

; busco num1 y swap

	mov		eax,dword[posVector]
	dec		eax
	dec		eax				
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	edx, dword[aux]
	mov 	dword[eax], edx

	ret


printVector:

	mov		eax,dword[posVector]	;eax = posicion
	dec		eax						;eax = posicion - 1
	imul	dword[lenRegister]		;eax = (posicion - 1) * 10
	lea		eax,[vector+eax]		;eax = dir nombre

	push 	dword[eax]
	push 	msgLine
	call 	printf
	add 	esp, 8

	inc		dword[posVector]
	mov     eax, dword[lenVector]
	cmp		dword[posVector],eax
	jle		printVector			

	ret
