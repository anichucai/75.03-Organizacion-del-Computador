global		main
extern		printf
extern		fopen
extern		fwrite
extern		fread
extern		fclose

section		.data

	fileName		db	"numeros.dat",0
	mode			db	"rb",0
	fileHandle		dd	0
	msgErrOpen		db  "Error en apertura de archivo",10,0,
	
	msgLine			db  "%d",10,0
	
	msgLenLine		db  "len vector: %d",10,0
	lenFile			dw	0

	lenRegister		dw	32

	
section		.bss

	registro 				resd	1

	posVector 				resd	1
	vector		times	30	resd	1



section		.text

main:
	
	mov 	dword[posVector], 1
	call readBinaryFile

	mov 	dword[posVector], 1
	call  printVector

	ret


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

	inc   	dword [lenFile]

	jmp		readLine


fillVector:

	mov		eax,dword[posVector]					;eax = posicion
	dec		eax						;eax = posicion - 1
	imul	dword[lenRegister]		;eax = (posicion - 1) * 10
	lea		eax,[vector+eax]		;eax = dir nombre

	mov 	edx, dword[registro]
	mov 	dword[eax], edx

	inc		dword[posVector]

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
	cmp		dword[posVector],10
	jle		printVector			

	ret


eof:
	push	dword[fileHandle]
	call	fclose
	add		esp,4
	jmp		endProg
	
errorOpen:
	push	msgErrOpen
	call	printf
	add		esp,4
	
endProg:	
	ret
