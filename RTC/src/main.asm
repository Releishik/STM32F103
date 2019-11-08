.syntax unified
.thumb
.cpu cortex-m3

.text
.align 2
.include "Registers.inc"
.global Reset_Handler

Reset_Handler:
    bl SystemInit72
	@***********************
	mov r1, 0
	mov r0, 1
	GetBBp r2, RCC_APB2ENR, 4
	str r0, [r2]
	GetBBp r2, GPIO_CRH_C, 21
	str r0, [r2]
	@***********************
	bl RTC_init
	ldr r0, =day
	mov r1, 10
	strb r1, [r0]
	ldr r0, =month
	mov r1, 12
	strb r1, [r0]
	ldr r0, =year
	mov r1, 2018
	str r1, [r0]
	ldr r0, =seconds
	eor r1, r1
	strb r1, [r0]
	ldr r0, =minutes
	mov r1, 42
	strb r1, [r0]
	ldr r0, =hours
	mov r1, 8
	strb r1, [r0]
	bl timeToPosixWithData
	ldr r0, =RTC_CNTL @ младшее полуслово в r2
	ldr r1, [r0] 
	mov r2, r1
	ldr r1, [r0, -4] @ старшее полуслово в r2
	lsl r1, 16
	orr r2, r1
	cmp r2, r5
	bpl counterOK
	bl setRTC_Counter
counterOK:
	bl RTC_Clock
	bl RTC_setInterrupt
	mov r5, 0 @ port A
	bl iPortClock
	mov r5, 4
	mov r0, 0 @ mod = 00 b(input)
	mov r1, 2 @ cnf = 10b (pull up/down)
	mov r2, 0 @ pull down
	mov r3, 0 @ pin #0
	mov r4, 0 @ port A
ports:	
	bl PortConfigure
	add r3, 1
	sub r5, 1
	cmp r5, 0
	bne ports
	mov r5, 4	
	mov r0, 0 @ port A
	mov r1, 1 @ rise trigger
ports_interrupt:
	bl SetInterrupt0_5
	add r0, 1
	sub r5, 1
	cmp r5, 0
	bne ports_interrupt
	/*
	mov r0, r5, lsr 16
	and r5, 0xFFFF
	ldr r2, =RTC_CNTL
	strh r5, [r2]
	ldr r2, =RTC_CNTH
	strh r0, [r2]
	*/
mainLoop:
/*
	ldr r2, =RTC_PRLL
	ldr r2, [r2]
	ldr r0, =hours
	ldrb r0, [r0]
	ldr r1, =minutes
	ldrb r1, [r1]
	ldr r2, =seconds
	ldrb r2, [r2]
	*/
	mov r5, 10
	ldr r0, =hours
	ldrb r0, [r0]
	udiv r3, r0, r5
	mul r4, r3, r5
	sub r0, r4
	lsl r3, 4
	orr r0, r3
	lsl r0, 16
	ldr r1, =minutes
	ldrb r1, [r1]
	udiv r3, r1, r5
	mul r4, r3, r5
	sub r1, r4
	lsl r3, 4
	orr r1, r3
	lsl r1, 8
	ldr r2, =seconds
	ldrb r2, [r2]
	udiv r3, r2, r5
	mul r4, r3, r5
	sub r2, r4
	lsl r3, 4
	orr r2, r3
	orr r0, r1
	orr r0, r2
	mov r6, r0
b mainLoop
     
.global Default_Handler
Default_Handler:
push {r0,r1,lr}
ldr r6, =NVIC_ICSR
ldr r6, [r6]
and r6, 0xFF
sub r6, 0x10
pop {r0,r1,lr}
bx lr


.end

/* breakpoint
eor r0, r0
infLoop:
cmp r0, 1
bne infLoop
*/

 