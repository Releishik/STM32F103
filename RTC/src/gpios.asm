.syntax unified
.thumb
.cpu cortex-m3

.text
.align 2
.include "Registers.inc"

.global iPortClock
iPortClock:			@ port number in register R5
push  {r0-r3, lr}
	GetBBp r0, RCC_APB2ENR, 0 @ AFIOEN bit 
	mov r1, 1
	ldr r2, [r0] @ alternate function check
	cmp r2, r1 @ test on equal to 1
	it ne
	strne r1, [r0] @ if is not set - set AFIO
	add r2, r5, 2 @ bit number correction
	lsl r2, 2 @ bitband shift (2+r5)*4
	str r1, [r0, r2] @ port clock
pop {r0-r3, lr}
bx lr
.global PortClock
PortClock:			@ port number in register R5
push  {r0-r3, lr}
	GetBBp r0, RCC_APB2ENR, 0 @ AFIOEN bit 
	mov r1, 1
	add r2, r5, 2 @ bit number correction
	lsl r2, 2 @ bitband shift (2+r5)*4
	str r1, [r0, r2] @ port clock
pop {r0-r3, lr}
bx lr
.global PortConfigure
@ r0 = mod (00b-11b)
@ r1 = cnf (00b-11b)
@ r2 = 0 pull down, r2= 1 pull up
@ r3 - pin number
@ r4 - port number
PortConfigure:
push {r0-r6, lr}
	ldr r5, =GPIOA
	mov r6, 0x400
	mul r4, r6 @ port number correction to memory address
	add r5, r4 @ r5 = GPIO_CRL
	add r4, r5, 4 @ r4  = GPIO_CRH
	mov r6, r3
	cmp r3, 8
	bmi pin0_7
	sub r3, 8 @ correct pin number to hi control register
	mov r5, r4 @ R5 = CRH
pin0_7:
	@ take bit 0 of config section of CR register
	lsl r3, 2 @ r3 * 4
	lsl r1, 2 @ r1 * 4
	orr r0, r1 @ cnf+mod half byte
	lsl r0, r3 
	ldr r4, =0xfffffff0
	rsb r3, 32
	ror r4, r3
	ldr r1, [r5]
	and r1, r4
	orr r1, r0
	str r1, [r5] @ configure pin
	add r4, r5, 0x0C @ r4 = gpio_ODR
	lsl r4, 5 @ r4 * 32
	lsl r6, 2
	add r4, r6
	ldr r6, =PERIPH_BB_BASE
	add r4, r6 @ bit band ODR register r3 bit
	str r2, [r4]
pop {r0-r6, lr}
bx lr
.global SetInterrupt0_5
@ r0 - pin
@ r1 =1 rise / r1 = 0 fall
SetInterrupt0_5:
push {r0-r5, lr}
	cmp r0, 4
	bpl si_exit @ если номер пина больше 4 выход
	@ NVIC 0x7C0 - активация 6-10, 23,  - ISER0, 40 (8) - ISER1 внешние прерывания маска FF7FF83F
	ldr r2, =NVIC_ISER0
	ldr r4, =0xFFFFFFFE
	add r3, r0, 6 @ корректировка номера пина на 6 прерывание
	rsb r3, 32
	ror r4, r3
	mov r5, 1
	ror r5, r3
	ldr r3, [r2]
	and r3, r4
	orr r3, r5
	str r3, [r2]
	add r3, r0, 6
	mov r4, 0x20
	ldr r5, =NVIC_PRI0
	strb r4, [r5, r3]
	
	mov r2, 1
	GetBBp r3, EXTI_IMR, 0 @ interrupt mask
	lsl r0, 2
	str r2, [r3,r0] @ interrupt enable
	cmp r1, r2
	beq isRise
	GetBBp r3, EXTI_FTSR, 0 @ fall trigger
	str r2, [r3,r0]
pop {r0-r5, lr}
bx lr	
isRise:
	GetBBp r3, EXTI_RTSR, 0 @ rise trigger
	str r2, [r3,r0]
si_exit:
pop {r0-r5, lr}
bx lr

.global EXTI0_IRQHandler
.global EXTI1_IRQHandler
.global EXTI2_IRQHandler
.global EXTI3_IRQHandler
.global EXTI4_IRQHandler
EXTI0_IRQHandler: @ mode / select button
push {r0-r5, lr}
	mov r7, 0xb1
	@ interrupt bit cleaning
	mov r1, 1
	ldr r0, =EXTI_PR
	str r1, [r0]
pop {r0-r5, lr}
bx lr
EXTI1_IRQHandler: @ inc button
push {r0-r5, lr}
	mov r7, 0xb2
	@ interrupt bit cleaning
	mov r1, 2
	ldr r0, =EXTI_PR
	str r1, [r0]
pop {r0-r5, lr}
bx lr
EXTI2_IRQHandler: @ dec button
push {r0-r5, lr}
	mov r7, 0xb3
	@ interrupt bit cleaning
	mov r1, 4
	ldr r0, =EXTI_PR
	str r1, [r0]
pop {r0-r5, lr}
bx lr
EXTI3_IRQHandler: @ set button
push {r0-r5, lr}
	mov r7, 0xb4
	@ interrupt bit cleaning
	mov r1, 8
	ldr r0, =EXTI_PR
	str r1, [r0]
pop {r0-r5, lr}
bx lr
EXTI4_IRQHandler:
push {r0-r5, lr}
	mov r7, 0xb5
	@ interrupt bit cleaning
	mov r1, 16
	ldr r0, =EXTI_PR
	str r1, [r0]
pop {r0-r5, lr}
bx lr
