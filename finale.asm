;*************************************************************************
;				~	 I N S E R T I O N   S O R T		~
;*************************************************************************


global		main
extern		printf
extern		fopen
extern		fwrite
extern		fread
extern		fclose


;*************************************************************************
;							SECTION .DATA
;*************************************************************************

section		.data

	fileName		db	"numeros.dat",0
	mode			db	"rb",0
	fileHandle		dd	0
	msgErrOpen		db  "Error en apertura de archivo",10,0,
	
	msgLine			db  "%d",10,0
	
	msgLenLine		db  "len vector: %d",10,0
	lenVector		dd	0

	lenRegister		dd	33

	msgLuego 		db "Luego de iterar...",10,0

	msgComparacion 	db "Comparo %d y %d",10,0

	msgResultado	db "Resulta %d y %d",10,0

	msgSwap			db "aux: %d",10,0

	


;*************************************************************************
;							SECTION .BSS
;*************************************************************************
	
section		.bss

	registro 				resd	1

	posVector 				resd	1
	vector		times	30	resd	1

	num1	 				resd	1
	num2	 				resd	1
	aux	 					resd	1


;*************************************************************************
;							SECTION .TEXT
;*************************************************************************

section		.text

;_________________________________main_____________________________________

main:
	
	mov 	dword[posVector], 1
	call 	readBinaryFile

	mov 	dword[posVector], 1
	call 	printVector 

	call 	insertionSort

	push	msgLuego
	call 	printf
	add 	esp, 4

	mov 	dword[posVector], 1
	call 	printVector 

	ret

;_____________________________readBinaryFile_______________________________

readBinaryFile:

	push	mode			
	push	fileName		
	call	fopen		
	mov		[fileHandle],eax
	add		esp,8

	cmp		eax,0

	jle		errorOpen
	mov		[fileHandle],eax

readLine:

	push	dword[fileHandle]
	push	1
	push	4
	push	registro
	call	fread
	add		esp,16

	cmp		eax,0	
	jle		eof

	call 	fillVector

	inc   	dword[lenVector]

	jmp		readLine


fillVector:

	mov		eax,dword[posVector]				
	dec		eax						
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]		

	mov 	edx, dword[registro]
	mov 	dword[eax], edx

	inc		dword[posVector]

	ret

eof:

	push	dword[fileHandle]
	call	fclose
	add		esp,4
	jmp		endReadBinaryFile
	
errorOpen:

	push	msgErrOpen
	call	printf
	add		esp,4
	
endReadBinaryFile:

	ret

;_______________________________insertion___________________________________


insertionSort:

	mov 	dword[posVector], 1
	mov 	esi, 1

iterar_i:
	

	cmp 	esi, dword[lenVector]
	jge 	endInsertionSort

	push 	esi

	
	iterar_j:

	; busco num2

		mov		eax, dword[posVector]
		add 	eax, esi
		dec		eax
		imul	dword[lenRegister]		
		lea		eax,[vector+eax]

		mov 	edx, dword[eax]
		mov 	dword[num2], edx


	; busco num1

		mov		eax,dword[posVector]
		add 	eax, esi
		dec		eax
		dec		eax
		imul	dword[lenRegister]	
		lea		eax,[vector+eax]

		mov 	edx, dword[eax]
		mov 	dword[num1], edx




	;resto num1-num2
		mov 	eax, dword[num1]
		mov 	ebx, dword[num2]

		cmp 	eax, ebx
		jle 	continue

	; si num1 mayor, imprimir
		call  	swap


	continue:


		dec		esi
		cmp 	esi, 0
		jg		iterar_j

		pop 	esi
		inc 	esi
		jmp 	iterar_i			

endInsertionSort:
	ret


swap:

; guardo en aux
	mov 	eax, dword[num2]
	mov 	dword[aux], eax

; busco num2

	mov		eax,dword[posVector]
	add 	eax, esi
	dec		eax		
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	edx, dword[num1]
	mov 	dword[eax], edx

; busco num1

	mov		eax,dword[posVector]
	add 	eax, esi
	dec		eax
	dec		eax				
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]

	mov 	edx, dword[aux]
	mov 	dword[eax], edx

	ret



printVector:

	mov		eax,dword[posVector]	
	dec		eax						
	imul	dword[lenRegister]		
	lea		eax,[vector+eax]		

	push 	dword[eax]
	push 	msgLine
	call 	printf
	add 	esp, 8

	inc		dword[posVector]
	mov     eax, dword[lenVector]
	cmp		dword[posVector],eax
	jle		printVector			

	ret
