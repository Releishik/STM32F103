.syntax unified
.thumb
.cpu cortex-m3
.text
.align 2
.include "Registers.inc"
.global Reset_Handler

/*
 Алгоритм:
 Включить HSE
 Включить буфер предварительной выборки FLASH
 Задать латентность FLASH
 Настроить делители и PLL
 Включить PLL
 Указать PLL как источник системной частоты
 */

Reset_Handler:
     bl SystemInit72
	 bl tim2Init
	 /*
	 eor r1, r1
	 ldr r0, =timDelayValue
	 str r1, [r0]
	 ldr r0, =timerActivated
	 str r1, [r0]
	 mov r1, 1
	 GetBBp r0, RCC_APB2ENR, 4
	 str r1, [r0]
	 GetBBp r0, GPIO_CRH_C, 21
	 str r1, [r0]
	 GetBBp r0, GPIO_ODR_C, 13
	 */
	 GetBBp r0, TIM2_SR, 0
mainLoop:
	ldr r1, =TIM2_ARR
	ldr r2, =10000
	strh r2, [r1]
isSteelCount:
	ldr r2, [r0]
	cmp r2, 1
	bne isSteelCount
	mov r2, 0
	strh r2, [r1]
	str r2, [r0]
	ldr r3, =0xDEADBEEF
/*
ldr r4, [r0]
eor r4, 1
str r4, [r0]
ldr r5, =500
*/
@ bl Delay
b mainLoop
     
.global Default_Handler
Default_Handler:
ldr r6, =NVIC_ICSR
ldr r6, [r6]
bx lr

.end
