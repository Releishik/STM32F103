/* STM32F103, flash 64 kb, sram 20 kb */
as_stackTop = 20K;
as_heapSize = 0K;

MEMORY
{
	/* FLASH - ����������� flash ������ */
	FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 64K

	/* SRAM  - ��� ������ ����������, �.2.3.1 RM0090, ���.68 */
	SRAM       (RW)  : ORIGIN = 0x20000000, LENGTH = 20K 

	/* CCM - ������� ������ ����, �.2.3.1 RM0090, ���.68 */
	/* CCMDATARAM (RWX) : ORIGIN = 0x10000000, LENGTH = 64K  */     

	/* BKPSRAM- backup sram, �.2.3 RM0090, ���.65 */
	/* BKPSRAM    (RW)  : ORIGIN = 0x40024000, LENGTH = 4K */
}
SECTIONS
{
	.text : { 
		*(.vectors);    /* ��������� �������� ���������� */
		*(.text);       /*  */
		*(.asmcode)     /* ����� ��������� */
		*(.rodata);     /* Read only DATA (��������� � flash) */
	} > FLASH
	.data : /*  ������ */
	{
		as_dataStart = .; /* ����� ������ ������ */
		*(.data);
		as_dataEnd = .; /* ����� ����� ������ */
	} > FLASH
	.bss : { 
		as_bssStart = .;
		*(.bss);        /* ���������� � SRAM */
		as_bssEnd = .;
 	} > SRAM
	/* .ccmdataram : { */
	/*	*(.ccmdataram); /* SRAM ����, ��� ���� � ���������� */
 	/* } > CCMDATARAM      */
	/* .bkpsram : { */
	/*	*(.bkpsram)     /* SRAM � ����������������� �������� */
	/* } > BKPSRAM*/
}
