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
	ldr r0, =0x10000000 @ прерывание №28
	ldr r1, =NVIC_IСPR0 @ регистр установки отложенности прерывания
	ldr r2, [r1]
	tst r2, r0 @ проверка на отложенность прерывания №28
	itt ne
	ldrne r1, =NVIC_IСPR0 @ если отложено
	strne r0, [r1] @ сбросить признак
	nop
	ldr r0, =timDelayValue @ глобальная 32битная  переменная-счетчик 
	ldr r1, [r0]
	add r1, 1 @ каждую миллисекунду увеличение на единицу
	str r1, [r0]
L01:
	GetBBp r0, TIM2_SR, 0 @  битовая привязка бита активности прерывания по переполнению
	eor r1, r1 @ ноль в регистр r1
	str r1, [r0] @ сброс бита активности прерывания
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
	str r0, [r1] @ включение тактирования TIM2 т.к. предделитель APB1 /2, то частота тактирования таймера 72МГц
	GetBBp r1, TIM2_CR1, 0
	GetBBp r2, TIM2_DIER, 0
	str r0, [r1, 4] @ отключение события Update
	@ str r0, [r1, 12] @ однотактовый режим
	str r0, [r1, 8] @ Update только от переполнения/опустошения
	@ str r0, [r2, 0] @ Прерывание по Update включено
	@ str r0, [r2, 28] @ Прерывание по триггеру включено
	ldr r2, =TIM2_ARR @ адрес регистра-автозагрузчика
	mov r3, 0 @ значение для автозагрузчика
	str r3, [r2] @ счетчик будет считать до двух
	ldr r2, =TIM2_PSC @ адрес регистра-предделителя
	ldr r3, =35999
	str r3, [r2] 	@ установка предделителя на 36000 получаем 1000 тактов в секунду
				@ в сочетании с ARR =1 получается событие каждую миллисекунду
	/*
	@ NVIС setup BEGIN			
	mov r0, 0x10000000 @ прерывание №28 - TIM2_IRQ
	ldr r1, =NVIC_ISER0 @ адрес регистра разрешения прерываний
	ldr r3, [r1] @ состояние регистра
	orr r3, r0 @ включаем прерывание №28
	str r3, [r1] @ запись в регистр ISER0
	ldr r1, =NVIC_PRI0 @ адреспервого байтового регистра приоритета
	ldrb r2, =0x10
	add r1, 28 
	strb r2, [r1] @ становка приоритета 1 для 28 прерывания
	@ NVIC setup END
	*/
	GetBBp r1, TIM2_CR1, 0 @ CEN bit - writing 1 enable timer
	str r0, [r1] @ таймер включается
	mov r0, 0
	str r0, [r1, 4] @ разрешается прерывание по Update
	pop {r0-r3, lr}
	bx lr

Delay: @ вход: r5, выход: r5
	push {r0-r3, lr}
	ldr r0, =timerActivated @ адрес флага активности таймера
	ldr r2, =timDelayValue
	eor r1, r1
	str r1, [r2]
	mov r1, 1
	ldr r3, [r0] @ получение значения флага
	cmp r3, 0   	@ сравнение с нулем
	bne del01 	@ если ноль то вызвать инициацию таймера, иначе перейти к отсчету задержки
	push {r5}
	bl tim2Init
	tst r5, r1 @ проверка включен ли таймер
	it ne 		@ если бит0 регистра TIM2_CR1 установлен
	strne r1, [r0]	@ то установить флаг активации таймера
	pop {r5}
del01:
	ldr r1, [r2]
	cmp r1, r5
	bne del01
	pop {r0-r3, lr}
	bx lr
	