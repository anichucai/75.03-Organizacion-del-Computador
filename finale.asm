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

	lenRegister		dd	32


;*************************************************************************
;							SECTION .BSS
;*************************************************************************
	
section		.bss

	registro 				resd	1

	posVector 				resd	1
	vector		times	30	resd	1


;*************************************************************************
;							SECTION .TEXT
;*************************************************************************

section		.text

;_________________________________main_____________________________________

main:
	
	mov 	dword[posVector], 1
	call 	readBinaryFile

	mov 	dword[posVector], 1
	call 	iterateVector

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
iterateVector:

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
	jle		iterateVector			

	ret

