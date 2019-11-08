/* STM32F103, flash 64 kb, sram 20 kb */
as_stackTop = 20K;
as_heapSize = 0K;

MEMORY
{
	/* FLASH - Программная flash память */
	FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 64K

	/* SRAM  - ОЗУ общего назначения, п.2.3.1 RM0090, стр.68 */
	SRAM       (RW)  : ORIGIN = 0x20000000, LENGTH = 20K 

	/* CCM - быстрая память ядра, п.2.3.1 RM0090, стр.68 */
	/* CCMDATARAM (RWX) : ORIGIN = 0x10000000, LENGTH = 64K  */     

	/* BKPSRAM- backup sram, п.2.3 RM0090, стр.65 */
	/* BKPSRAM    (RW)  : ORIGIN = 0x40024000, LENGTH = 4K */
}
SECTIONS
{
	.text : { 
		*(.vectors);    /* Указатели векторов прерываний */
		*(.text);       /*  */
		*(.asmcode)     /* Текст программы */
		*(.rodata);     /* Read only DATA (константы в flash) */
	} > FLASH
	.data : /*  Данные */
	{
		as_dataStart = .; /* адрес начала данных */
		*(.data);
		as_dataEnd = .; /* адрес конца данных */
	} > FLASH
	.bss : { 
		as_bssStart = .;
		*(.bss);        /* Переменные в SRAM */
		as_bssEnd = .;
 	} > SRAM
	/* .ccmdataram : { */
	/*	*(.ccmdataram); /* SRAM ядра, для кода и переменных */
 	/* } > CCMDATARAM      */
	/* .bkpsram : { */
	/*	*(.bkpsram)     /* SRAM с энергонезависимым питанием */
	/* } > BKPSRAM*/
}
