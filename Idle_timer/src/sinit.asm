.syntax unified
.thumb
.cpu cortex-m3

.bss
timerActivated:
.word 0
timDelayValue:
.word 0

.text
.align 2
.include "Registers.inc"
.global SystemInit72
.global wait
.global tim2Init
.global TIM2_IRQHandler
.global Delay
.global timerActivated
.global timDelayValue
.equ timeout, 12

SystemInit72:
	push {r0, r1, r2, r3, r4, r5, r6, lr}
	mov r0, 1 @ one for bitband
     ldr r1, =RCC_CFGR @ RCC_CFGR address
	 GetBBp r2, RCC_CR, 0 @ bitband for RCC_CR
	 GetBBp r3, RCC_CFGR, 0 @ bitband for RCC_CFGR
	 GetBBp r4, FLASH_ACR, 0 @ bitband for FLASH_ACR
	 
	 str r0, [r2, 16*4] @ HSEON bit setup
	 add r5, r2, (17*4) @ HSERDY bitband address loading in r5
	 bl wait @ wait until HSE not ready
	 
	 ldr r5, [r1] @ RCC_CFGR value
	 ldr r6, =(SW_AHB1 | SW_APB1_2 | SW_APB2_1 | SW_ADC6 | SW_PLLMUL9 | SW_PLLFROMHSE) @ AHB-/1  APB1-/2 APB2-/1 ADC-/6 PLL-*9 PLL from HSE USB /1.5
	 orr r5, r6 @ CONFIGURATION SETUP
	 str r5, [r1] @ write back RCC_CFGR value
	 
	 str r0, [r4, 16] @ enable prefetch buffer
	 str r0, [r4, 4] @ set latensy by 2
	 
	 str r0, [r2, 24*4] @ set PLLON bit
	 add r5, r2, (25*4) @ PLLRDY bitband address loading in r5
	 bl wait @ wait until PLL not ready
	 
	 str r0, [r3, 4] @ set PLL as system clock (SW bit 1)
	 add r5, r3, (3*4) @ SWS bitband address loading in r5
	 bl wait @ wait until system clock not ready
	 pop {r0, r1, r2, r3, r4, r5, r6, lr}
	 bx lr
	 
	 @ input in r5
wait:
    push {r2, r3, r4, lr} 			@ save registers
	mov r3, 1 				@ unit in r4
    add r3, r3, r3, lsl timeout	@ timer set
w01:
    subs r3,1 
    beq wend 
    ldr r4, [r5] @ check
    tst r4, 1
    beq w01
    pop {r2, r3, r4, lr}
    bx lr
wend:
    mov r6, -1
	pop {r2, r3, r4, lr}
    bx lr

TIM2_IRQHandler:
	push {r0, r1, r2, lr}
	ldr r0, =0x10000000 @ ���������� �28
	ldr r1, =NVIC_I�PR0 @ ������� ��������� ������������ ����������
	ldr r2, [r1]
	tst r2, r0 @ �������� �� ������������ ���������� �28
	itt ne
	ldrne r1, =NVIC_I�PR0 @ ���� ��������
	strne r0, [r1] @ �������� �������
	nop
	ldr r0, =timDelayValue @ ���������� 32������  ����������-������� 
	ldr r1, [r0]
	add r1, 1 @ ������ ������������ ���������� �� �������
	str r1, [r0]
L01:
	GetBBp r0, TIM2_SR, 0 @  ������� �������� ���� ���������� ���������� �� ������������
	eor r1, r1 @ ���� � ������� r1
	str r1, [r0] @ ����� ���� ���������� ����������
	pop {r0, r1, r2, lr}
bx lr

tim2Init: @ output: r5
/*  TIM2_CR1
CEN(0) - counter enable; UDIS(1) - update disable; URS(2) - update reques source; OPM(3) - one pulse mode
DIR(4) - direction; CMS(5-6) - center-aligned mode selection; ARPE(7) - Auto-reload preload enable; CKD(8-9) - clock division*/
/* TIM2_DIER
UIE(0) - update interrupt enable; CC1IE(1) - capture/compare 1 interrupt enable; CC2IE(1) - capture/compare 2 interrupt enable;
CC3IE(1) - capture/compare 3 interrupt enable;CC4IE(1) - capture/compare 4 interrupt enable;TIE(6) - trigger interrupt enable;
UDE(8) - update DMA request enable; CC1DE(9) - capture/compare 1 DMA request enable;CC2DE(10) - capture/compare 2DMA request enable;
CC3DE(11) - capture/compare 3 DMA request enable;CC4DE(12) - capture/compare 4 DMA request enable;TDE(14) - trigger DMA ruquest enable */
push {r0-r3, lr}
	mov r0, 1
	GetBBp r1, RCC_APB1ENR, 0
	str r0, [r1] @ ��������� ������������ TIM2 �.�. ������������ APB1 /2, �� ������� ������������ ������� 72���
	GetBBp r1, TIM2_CR1, 0
	GetBBp r2, TIM2_DIER, 0
	str r0, [r1, 4] @ ���������� ������� Update
	@ str r0, [r1, 12] @ ������������ �����
	str r0, [r1, 8] @ Update ������ �� ������������/�����������
	@ str r0, [r2, 0] @ ���������� �� Update ��������
	@ str r0, [r2, 28] @ ���������� �� �������� ��������
	ldr r2, =TIM2_ARR @ ����� ��������-��������������
	mov r3, 0 @ �������� ��� ��������������
	str r3, [r2] @ ������� ����� ������� �� ����
	ldr r2, =TIM2_PSC @ ����� ��������-������������
	ldr r3, =35999
	str r3, [r2] 	@ ��������� ������������ �� 36000 �������� 1000 ������ � �������
				@ � ��������� � ARR =1 ���������� ������� ������ ������������
	/*
	@ NVI� setup BEGIN			
	mov r0, 0x10000000 @ ���������� �28 - TIM2_IRQ
	ldr r1, =NVIC_ISER0 @ ����� �������� ���������� ����������
	ldr r3, [r1] @ ��������� ��������
	orr r3, r0 @ �������� ���������� �28
	str r3, [r1] @ ������ � ������� ISER0
	ldr r1, =NVIC_PRI0 @ ������������ ��������� �������� ����������
	ldrb r2, =0x10
	add r1, 28 
	strb r2, [r1] @ �������� ���������� 1 ��� 28 ����������
	@ NVIC setup END
	*/
	GetBBp r1, TIM2_CR1, 0 @ CEN bit - writing 1 enable timer
	str r0, [r1] @ ������ ����������
	mov r0, 0
	str r0, [r1, 4] @ ����������� ���������� �� Update
	pop {r0-r3, lr}
	bx lr

Delay: @ ����: r5, �����: r5
	push {r0-r3, lr}
	ldr r0, =timerActivated @ ����� ����� ���������� �������
	ldr r2, =timDelayValue
	eor r1, r1
	str r1, [r2]
	mov r1, 1
	ldr r3, [r0] @ ��������� �������� �����
	cmp r3, 0   	@ ��������� � �����
	bne del01 	@ ���� ���� �� ������� ��������� �������, ����� ������� � ������� ��������
	push {r5}
	bl tim2Init
	tst r5, r1 @ �������� ������� �� ������
	it ne 		@ ���� ���0 �������� TIM2_CR1 ����������
	strne r1, [r0]	@ �� ���������� ���� ��������� �������
	pop {r5}
del01:
	ldr r1, [r2]
	cmp r1, r5
	bne del01
	pop {r0-r3, lr}
	bx lr
	