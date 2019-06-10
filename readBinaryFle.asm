global		main
extern		printf
extern		fopen
extern		fwrite
extern		fread
extern		fclose

section		.data
	fileName	db	"numeros2.dat",0
	mode		db	"rb",0
	fileHandle	dd	0
	msgErrOpen	db  "Error en apertura de archivo",0,
	msgLinea	db  "%d",10,0
	msgLenLinea	db  "len vector: %d",10,0
	lenFile		dw	0
	
section		.bss
	registro resd	1

section		.text

main:
	

	call readBinaryFile

	push dword[lenFile]
	push msgLenLinea
	call printf
	add esp, 8

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

	push 	dword[registro]
	push 	msgLinea
	call 	printf
	add 	esp, 8

	inc   	dword [lenFile]

	jmp		readLine

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
