.section .rodata
.equ STACK_SIZE				,0x100 /* ������ ����� */
.equ HEAP_SIZE				,0x00 /* ������ ����������� ���������� ������ */
.equ FLASH_BASE            	,0x08000000 /* ������� ����� ����-������  64��*/
.equ SRAM_BASE             	,0x20000000 /*  ������� ����� ����������� ������ 20�� */
.equ PERIPH_BASE           	,0x40000000 /* ������� ����� ��������� ��������� */
.equ SRAM_BB_BASE          	,0x22000000 /*  ������� ����� ������� �������� ����� � ����������� ������ */
.equ PERIPH_BB_BASE        	,0x42000000 /* ������� ����� �������� ����� ��������� */
.equ FSMC_R_BASE           	,0xA0000000 /* ������� ����� FSMC ��������� */
.equ APB1_BASE       		,PERIPH_BASE	@ ��������� ���� APB1
.equ APB2_BASE       		,(PERIPH_BASE + 0x10000)	@ ��������� ���� APB2
.equ AHB_BASE        		,(PERIPH_BASE + 0x20000)	@ ��������� ���������
.equ NVIC_BASE				,0xE000E000


