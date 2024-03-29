.include "Bases.inc"
.section .rodata
.equ FLASH_ACR, (AHB_BASE + 0x2000)

.equ RCC              	,(AHB_BASE + 0x1000) @ �������� RCC
.equ RCC_CR		,(RCC+0x00) @ ������� �������� ������� (����� ��������� �������/���������� ������������)

.equ RCC_CFGR,  (RCC+0x04) @ ������� ������������ ������������ (����� ����������� ������������)

/*����� ������� ����� �������� ������������*/
.equ SW_PLL, 2
.equ SW_HSE, 1
.equ SW_HSI, 0

.equ SWS_MASK, 0x0C

.equ SW_AHB1, 0x00
.equ SW_AHB2, 0x80
.equ SW_AHB4, 0x90
.equ SW_AHB8, 0xA0
.equ SW_AHB16, 0xB0
.equ SW_AHB64, 0xC0
.equ SW_AHB128, 0xD0
.equ SW_AHB256, 0xE0
.equ SW_AHB512, 0xF0

.equ SW_APB1_1, 0x00
.equ SW_APB1_2, 0x400
.equ SW_APB1_4, 0x500
.equ SW_APB1_8, 0x600
.equ SW_APB1_16, 0x700

.equ SW_APB2_1, 0x00
.equ SW_APB2_2, 0x2000
.equ SW_APB2_4, 0x2800
.equ SW_APB2_8, 0x3000
.equ SW_APB2_16, 0x3800

.equ SW_ADC2, 0x0000
.equ SW_ADC4, 0x4000
.equ SW_ADC6, 0x8000
.equ SW_ADC8, 0xC000

.equ SW_PLLMUL2, 0x00
.equ SW_PLLMUL3, 0x40000
.equ SW_PLLMUL4, 0x80000
.equ SW_PLLMUL5, 0xC0000
.equ SW_PLLMUL6, 0x100000
.equ SW_PLLMUL7, 0x140000
.equ SW_PLLMUL8, 0x180000
.equ SW_PLLMUL9, 0x1C0000
.equ SW_PLLMUL10, 0x200000
.equ SW_PLLMUL11, 0x240000
.equ SW_PLLMUL12, 0x280000
.equ SW_PLLMUL13, 0x2C0000
.equ SW_PLLMUL14, 0x300000
.equ SW_PLLMUL15, 0x340000
.equ SW_PLLMUL16, 0x380000
.equ SW_PLLMUL16_1, 0x3C0000

.equ SW_PLLFROMHSE, 0x10000

.equ SW_MCO_NO, 0x0
.equ SW_MCO_SYS, 0x4000000
.equ SW_MCO_HSI, 0x5000000
.equ SW_MCO_HSE, 0x6000000
.equ SW_MCO_PLL, 0x7000000

.equ RCC_CIR	,(RCC+0x08) @ ������� ���������� ������������
.equ RCC_APB2_RST			,(RCC+0x0C) @ ������� ������ ��������� APB2
.equ RCC_APB1_RST			,(RCC+0x10) @ ������� ������ ��������� APB1
.equ RCC_AHBENR	,(RCC+0x14) @ ������� ��������� ����������� AHB
.equ RCC_APB2ENR				,(RCC+0x18) @ ������� ��������� ����������� APB2
.equ RCC_APB1ENR				,(RCC+0x1C) @ ������� ��������� ����������� APB1
.equ RCC_BDCR				,(RCC+0x20) @ ������� �������� ������� ���������� ��������
/*
16 BDRST - ���������� ����� ������ ���������� ��������
15 RTCEN - ��������� ������������ RTC
9:8 RTCSEL - �������� ������� RTC
	00 - �� �����������
	01 - ������� �������������� �����
	10 - ���������� �������������� ���������
	11 - ������� ��������������� �����, �������� �� 128
2 LSEBYP - ������ ��������� �������� ����������
1 LSERDY - ������� �������������� ��������� �����
0 LSEON - ��������� �������� ���
*/
.equ RCC_CSR					,(RCC+0x24) @ ������� ����������/���������
.equ CR�,           (AHB_BASE + 0x3000) @ �������� CRC
.equ CRC_DR,    (CRC + 0x00) @ 32������ ������� ������
.equ CRC_IDR,   (CRC + 0x04) @ 8������ ����������� ������� ������
.equ CRC_CR,    (CRC + 0x08) @ 1������ ������� ����� ��������� 0xFFFFFFFF � CRC_DR

.equ PWR,   (APB1_BASE + 0x7000) @��������  ���������� ��������
.equ PWR_CR, (PWR + 0x00) @ ������� ���������� ��������
.equ PWR_CSR,   (PWR + 0x04) @ ������� �������/����������

.equ BKP,   (APB1_BASE + 0x6C00) @�������� ���������� ��������
/* 42 16������ �������� ������ ���������� �������� */
.equ BKP_DR1, (BKP + 0x04)
.equ BKP_DR2, (BKP + 0x08)
.equ BKP_DR3, (BKP + 0x0C)
.equ BKP_DR4, (BKP + 0x10)
.equ BKP_DR5, (BKP + 0x14)
.equ BKP_DR6, (BKP + 0x18)
.equ BKP_DR7, (BKP + 0x1C)
.equ BKP_DR8, (BKP + 0x20)
.equ BKP_DR9, (BKP + 0x24)
.equ BKP_DR10, (BKP + 0x28)

.equ BKP_DR11, (BKP + 0x40)
.equ BKP_DR12, (BKP + 0x44)
.equ BKP_DR13, (BKP + 0x48)
.equ BKP_DR14, (BKP + 0x4C)
.equ BKP_DR15, (BKP + 0x50)
.equ BKP_DR16, (BKP + 0x54)
.equ BKP_DR17, (BKP + 0x58)
.equ BKP_DR18, (BKP + 0x5C)
.equ BKP_DR19, (BKP + 0x60)
.equ BKP_DR20, (BKP + 0x64)
.equ BKP_DR21, (BKP + 0x68)
.equ BKP_DR22, (BKP + 0x6C)
.equ BKP_DR23, (BKP + 0x70)
.equ BKP_DR24, (BKP + 0x74)
.equ BKP_DR25, (BKP + 0x78)
.equ BKP_DR26, (BKP + 0x7C)
.equ BKP_DR27, (BKP + 0x80)
.equ BKP_DR28, (BKP + 0x84)
.equ BKP_DR29, (BKP + 0x88)
.equ BKP_DR30, (BKP + 0x8C)
.equ BKP_DR31, (BKP + 0x90)
.equ BKP_DR32, (BKP + 0x94)
.equ BKP_DR33, (BKP + 0x98)
.equ BKP_DR34, (BKP + 0x9C)
.equ BKP_DR35, (BKP + 0xA0)
.equ BKP_DR36, (BKP + 0xA4)
.equ BKP_DR37, (BKP + 0xA8)
.equ BKP_DR38, (BKP + 0xAC)
.equ BKP_DR39, (BKP + 0xB0)
.equ BKP_DR40, (BKP + 0xB4)
.equ BKP_DR41, (BKP + 0xB8)
.equ BKP_DR42, (BKP + 0xBC)
/*=============================*/
.equ BKP_RTCCR, (BKP + 0x2C) @ ������� ���������� ����� ��������� �������
.equ BKP_CR, (BKP + 0x30) @������� ��������
.equ BKP_CSR, (BKP + 0x34) @������� ��������/�������

.equ GPIOA, (APB2_BASE + 0x800)
.equ GPIOB, (APB2_BASE + 0xC00)
.equ GPIOC, (APB2_BASE + 0x1000)
.equ GPIOD, (APB2_BASE + 0x1400)
.equ GPIOE, (APB2_BASE + 0x1800)
.equ GPIOF, (APB2_BASE + 0x1C00)
.equ GPIOG, (APB2_BASE + 0x2000)

.irp port,"A","B","C","D","E","F"
    .equ GPIO_CRL_\port, (GPIO\port + 0x00)
.endr

.irp port,"A","B","C","D","E","F"
    .equ GPIO_CRH_\port, (GPIO\port + 0x04)
.endr

.irp port,"A","B","C","D","E","F"
    .equ GPIO_IDR_\port, (GPIO\port + 0x08)
.endr

.irp port,"A","B","C","D","E","F"
    .equ GPIO_ODR_\port, (GPIO\port + 0x0C)
.endr

.irp port,"A","B","C","D","E","F"
    .equ GPIO_BSRR_\port, (GPIO\port + 0x10)
.endr

.irp port,"A","B","C","D","E","F"
    .equ GPIO_BRR_\port, (GPIO\port + 0x14)
.endr

.irp port,"A","B","C","D","E","F"
    .equ GPIO_LCKR_\port, (GPIO\port + 0x18)
.endr

.macro GetBB reg, base, p, bit @ ������ �������� ������ ������� �������� ����� � �������
   ldr \reg,=(\base+(\p*32+\bit*4))
.endm
.macro GetBBp reg, p, bit @ ������ �������� ������ ������� �������� ����� ��������� � �������
    ldr \reg, =(PERIPH_BB_BASE + (\p*32+\bit*4))
.endm

.equ AFIO, APB2_BASE @ �������� �������������� ������� �����-������
.equ AFIO_EVCR, (AFIO+0x0) @ ������� �������� �������
.equ AFIO_MAPR, (AFIO+0x04) @ ������� ��������������� � ������� ������������ �����-������
.equ AFIO_EXTICR1, (AFIO+0x08) @ 1 ������� ������������ ������� ����������
.equ AFIO_EXTICR2, (AFIO+0x0C) @ 2 ������� ������������ ������� ����������
.equ AFIO_EXTICR2, (AFIO+0x10) @ 3 ������� ������������ ������� ����������
.equ AFIO_EXTICR2, (AFIO+0x14) @ 4 ������� ������������ ������� ����������
.equ AFIO_MAPR2, (AFIO + 0x1C) @ 2 ������� ��������������� � ������� ������������ �����-������

.equ TIM2, APB1_BASE
.equ TIM2_CR1, (TIM2+0x00) @ 1 ������� �������� �������
.equ TIM2_CR2, (TIM2+0x04) @ 2 ������� �������� �������
.equ TIM2_SMCR, (TIM2+0x08) @ ������� �������������� ���������� �������
.equ TIM2_DIER, (TIM2+0x0C) @ ������� ��������� ���/����������
.equ TIM2_SR, (TIM2+0x10) @ ������  ���������
.equ TIM2_EGR, (TIM2+0x14) @ ������� ��������� �������
.equ TIM2_CCMR1, (TIM2+0x18) @ 1 ������� ������ �������/���������
.equ TIM2_CCMR2, (TIM2+0x1C) @ 2 ������� ������ �������/���������
.equ TIM2_CCER, (TIM2+0x20) @ ������� ��������� �������/���������
.equ TIM2_CNT, (TIM2+0x24) @ �������
.equ TIM2_PSC, (TIM2+0x28) @ ������������
.equ TIM2_ARR, (TIM2+0x2C) @ ��������������� �������
.equ TIM2_CCR1, (TIM2+0x34) @ 1 ������� �������/���������
.equ TIM2_CCR2, (TIM2+0x38) @ 2 ������� �������/���������
.equ TIM2_CCR3, (TIM2+0x3C) @ 3 ������� �������/���������
.equ TIM2_CCR4, (TIM2+0x40) @  4 ������� �������/���������
.equ TIM2_DCR, (TIM2+0x48) @ ������� �������� ���
.equ TIM2_DMAR, (TIM2+0x4C) @ ����� ��� ��� ������ ��������

.equ TIM3, (APB1_BASE + 0x400) 
.equ TIM3_CR1, (TIM3+0x00) @ 1 ������� �������� �������
.equ TIM3_CR2, (TIM3+0x04) @ 2 ������� �������� �������
.equ TIM3_SMCR, (TIM3+0x08) @ ������� �������������� ���������� �������
.equ TIM3_DIER, (TIM3+0x0C) @ ������� ��������� ���/����������
.equ TIM3_SR, (TIM3+0x10) @ ������  ���������
.equ TIM3_EGR, (TIM3+0x14) @ ������� ��������� �������
.equ TIM3_CCMR1, (TIM3+0x18) @ 1 ������� ������ �������/���������
.equ TIM3_CCMR2, (TIM3+0x1C) @ 2 ������� ������ �������/���������
.equ TIM3_CCER, (TIM3+0x20) @ ������� ��������� �������/���������
.equ TIM3_CNT, (TIM3+0x24) @ �������
.equ TIM3_PSC, (TIM3+0x28) @ ������������
.equ TIM3_ARR, (TIM3+0x2C) @ ��������������� �������
.equ TIM3_CCR1, (TIM3+0x34) @ 1 ������� �������/���������
.equ TIM3_CCR2, (TIM3+0x38) @ 2 ������� �������/���������
.equ TIM3_CCR3, (TIM3+0x3C) @ 3 ������� �������/���������
.equ TIM3_CCR4, (TIM3+0x40) @  4 ������� �������/���������
.equ TIM3_DCR, (TIM3+0x48) @ ������� �������� ���
.equ TIM3_DMAR, (TIM3+0x4C) @ ����� ��� ��� ������ ��������

@NVIC
@ �������� ���������� ����������
.equ NVIC_ISER0, (NVIC_BASE + 0x100)
.equ NVIC_ISER1, (NVIC_BASE + 0x104)
.equ NVIC_ISER2, (NVIC_BASE + 0x108)
@ �������� ������� ����������
.equ NVIC_ICER0, (NVIC_BASE + 0x180)
.equ NVIC_ICER1, (NVIC_BASE + 0x184)
.equ NVIC_ICER2, (NVIC_BASE + 0x188)
@ �������� ��������� �������� ����������� ����������
.equ NVIC_ISPR0, (NVIC_BASE + 0x200)
.equ NVIC_ISPR1, (NVIC_BASE + 0x204)
.equ NVIC_ISPR2, (NVIC_BASE + 0x208)
@ �������� ������ �������� ����������� ����������
.equ NVIC_I�PR0, (NVIC_BASE + 0x280)
.equ NVIC_I�PR1, (NVIC_BASE + 0x284)
.equ NVIC_I�PR2, (NVIC_BASE + 0x288)
@ �������� ��������� ���������� 1�������� (�������� ������ ������� 4 ����)
.equ NVIC_PRI0, (NVIC_BASE + 0x400)
@ �������� �������� ���������� ����������
.equ NVIC_IABR0, (NVIC_BASE + 0x300)
.equ NVIC_IABR1, (NVIC_BASE + 0x304)
@ ������� ��������� � ���������� ������������ ��������� ����������
.equ NVIC_SHCSR, (NVIC_BASE + 0xD24)
@ ������� ���������� � ��������� ����������
.equ NVIC_ICSR, (NVIC_BASE + 0xD04) @ � ����� 0-9 ����� ��������������� ����������; 12-21 ����� ���������� ����������
@ ������ ����������� ����������
.equ NVIC_AIRCR, (NVIC_BASE + 0xD0C) @ � ����� 8-10 ����� ������������� 
@ 011 - PRI: 0bpppp 0000
@ 100 - PRI: 0bppps 0000
@ 101 - PRI: 0bppss 0000
@ 110 - PRI: 0bpsss 0000
@ 111 - PRI: 0bssss 0000
.equ SCB, (NVIC_BASE + 0x08)
.equ SCB_ICSR, (SCB + 0x04)

.equ EXTI, (APB2_BASE + 0x400)
.equ EXTI_PR, (EXTI + 0x14)
.equ EXTI_IMR, (EXTI + 0x00)
.equ EXTI_RTSR, (EXTI + 0x08)
.equ EXTI_FTSR, (EXTI + 0x0C)
@ 16bit registers
.equ RTC, (APB1_BASE + 0x2800)
.equ RTC_CRH, (RTC + 0x00)
@ 2 OWIE - ��������� ���������� ������������
@ 1 ALRIE - ��������� ����������-����������
@ 0 SECIE - ��������� ���������� ����������
.equ RTC_CRL, (RTC + 0x04)
@ 5 RTOFF - ���������� �������� RTC
@ 4 CNF - ���� ������������
@ 3 RSF - ���� ������������� ��������
@ 2 OWF - ���� ������������
@ 1 ALRF - ����-���������
@ 0 SECF - ��������� ����
.equ RTC_DIVH, (RTC + 0x10)
@ 3-0 ������� ���� ��������
.equ RTC_DIVL, (RTC + 0x14) @ ������� ���� �������� 16bit
.equ RTC_PRLH, (RTC + 0x08)
@ 3-0 ������� ���� ��������
.equ RTC_PRLL, (RTC + 0x0c) @ ������� ���� �������� 16bit
.equ RTC_CNTH, (RTC + 0x18) @ 16bit
.equ RTC_CNTL, (RTC + 0x1C) @ 16bit
.equ RTC_ALRH, (RTC + 0x20) @ 16bit
.equ RTC_ALRL, (RTC + 0x24) @ 16bit


.macro BREAK
	eor r0, r0
L_infLoop:
	cmp r0, 1
	bne L_infLoop
.endm
.macro PERF_START 
	mov r0, 0
	mov r1, 1
	ldr r7, =0xE000EDFC
	ldr r9, [r7]
	ldr r8, =0x01000000
	orr r9, r8
	str r9, [r7]
	ldr r7, =0xE0001004
	str r0, [r7]
	ldr r9, =0xE0001000
	ldr r8, [r9]
	orr r8, r1
	str r8, [r9]
.endm
.macro PERF_END reg
	ldr \reg, =0xE0001004
	ldr \reg, [\reg]
.endm
