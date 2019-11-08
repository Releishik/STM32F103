.section .rodata
.equ STACK_SIZE				,0x100 /* размер стека */
.equ HEAP_SIZE				,0x00 /* размер динамически выделяемой памяти */
.equ FLASH_BASE            	,0x08000000 /* Базовый адрес флэш-памяти  64кБ*/
.equ SRAM_BASE             	,0x20000000 /*  Базовый адрес оперативной памяти 20кБ */
.equ PERIPH_BASE           	,0x40000000 /* базовый адрес регистров переферии */
.equ SRAM_BB_BASE          	,0x22000000 /*  базовый адрес области привязки битов в оперативной памяти */
.equ PERIPH_BB_BASE        	,0x42000000 /* базовый адрес привязки битов переферии */
.equ FSMC_R_BASE           	,0xA0000000 /* базовый адрес FSMC регистров */
.equ APB1_BASE       		,PERIPH_BASE				@ Перифирия шины APB1
.equ APB2_BASE       		,(PERIPH_BASE + 0x10000)	@ Перифирия шины APB2
.equ AHB_BASE        		,(PERIPH_BASE + 0x20000)	@ Служебная переферия


