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
	
section		.bss
	registro resd	1

section		.text

main:
	push	mode			
	push	fileName		
	call	fopen		
	mov		[fileHandle],eax
	add		esp,8

	cmp		eax,0

	jle		errorOpen
	mov		[fileHandle],eax

read:
	push	dword[fileHandle]	;Parametro 4: handle del archivo
	push	1					;Parametro 3: cantidad de registros
	push	4
	push	registro			;Parametro 1: dir area de memoria donde se copia
	call	fread				;LEO registro. Devuelve en eax la cantidad de bytes leidos
	add		esp,16

	cmp		eax,0				;Fin de archivo?
	jle		eof

	push 	dword[registro]
	push 	msgLinea
	call 	printf
	add 	esp, 8

	jmp		read

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
