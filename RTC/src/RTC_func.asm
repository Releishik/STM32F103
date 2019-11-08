.syntax unified
.thumb
.cpu cortex-m3
.include "Registers.inc"
.align 4
.bss
seconds:
.byte 0
minutes:
.byte 0
hours:
.byte 0
day:
.byte 0
month:
.byte 0
year:
.word 0
JDN:
.word 0
posixTime:
.word 0
.data
JDshift:
.word 0x258208 @ начало отсчета 01.01.2018
@ variables
.global seconds
.global minutes
.global hours
.global day
.global month
.global year
.global JDN
.global JDshift
.global posixTime
@ functions
.global RTC_init
.global posixToTime
.global timeToPosix
.global dataToJDN
.global timeToPosixWithData
.global posixToData
.global setRTC_Counter
.global RTC_Clock

.data
serVar:
.word 32045
.word 146097
.word 1461
.byte 153

.align 2
.text
RTC_init:
push {r0-r4, lr}
	mov r1, 1
	 GetBBp r2, RCC_APB1ENR, 27
	 str r1, [r2] @  Backup interface clock enable (BKPEN bit)
	 str r1, [r2,4] @ Power interface clock enable (PEREN bit)
	 GetBBp r2, PWR_CR, 8
	 str r1, [r2] @ Disable backup domain write protection (DBP bit)
	 GetBBp r2, RTC_CRL, 3 @ RTC RSF bit (sync counter, alarm)
sync01: @ wait for syncronization
	ldr r3, [r2]
	cmp r3, r1
	bne sync01
pop {r0-r4, lr}
bx lr

RTC_Clock:
push {r0-r5, lr}
mov r1, 1
GetBBp r0, RCC_BDCR, 0 @ Попытка включить внешний кварц для часов
	 str r1, [r0]  @ 1 в бит LSEON
	 add r5, r0, 4 @ Адрес битовой привязки для бита LSERDY в регистр r5
	 bl wait @ ожидание установки бита LSERDY в 1
	itt pl @ если установлено
	strpl r1, [r0, 8*4] @ RTCSEL [0] в 1 - тактирование от LSE
	bpl rtc_LSE
	GetBBp r2, RCC_CR, 17
	ldr r2, [r2]
	cmp r2, 1
	bne L_LSI
	GetBBp r3, RTC_CRL, 5 @ бит RTOFF
isZero01: 			@ проверка и ожидание установки бита в единицу
	ldr r4, [r3]
	cmp r4, 1
	bmi isZero01
	str r1, [r3, -4] @ 1 в бит CNF для входа в режим редактирования
	str r1, [r0, 8*4] @ если LSE отключен, а HSE включен, то тактироват от HSE/128
	str r1, [r0, 9*4]
	ldr r4, =RTC_PRLL @ установка предделителя для HSE/128 0xF423 или 62499 для HSE 8МГц
	ldr r5, =0xF423
	str r5, [r4]
	b rtc_LSE
L_LSI:
	str r1, [r0, 9*4] @ если HSE отключен, то тактированть отLSI
rtc_LSE:
	GetBBp r3, RTC_CRL, 5 @ бит RTOFF
isZero03: 			@ проверка и ожидание установки бита в единицу
	ldr r4, [r3]
	cmp r4, 1
	bmi isZero03
	str r1, [r3, -4] @ 1 в бит CNF для входа в режим редактирования
	ldr r4, =RTC_PRLL @ установка предделителя для LSI 0x7FFF или 32767 для LSE 32768Гц
	ldr r5, =0x7FFF
	str r5, [r4]
OUT:
	eor r5, r5
	str r5, [r3, -4] @ бит 0 в CNF для завершения конфигурирования
isZero02: 			@ проверка и ожидание установки бита в единицу
	ldr r4, [r3]
	cmp r4, 1
	bmi isZero02	 @ ожидание установки RTOFF в 1
	str r1, [r0, 15*4] @ 1 в RTCEN  - включение часов
pop {r0-r5, lr}
bx lr
@ input in r5 register
posixToTime:
push {r0-r3, lr}
	ldr r5, =posixTime
	ldr r5, [r5]
	ldr r1, =86400
	udiv r2, r5, r1
	mul r2, r1
	sub r5, r2
	mov r1, 3600
	udiv r2, r5, r1
	ldr r3, =hours
	strb r2, [r3]
	mul r2, r1
	sub r5, r2
	mov r1, 60
	udiv r2, r5, r1
	ldr r3, =minutes
	strb r2, [r3]
	mul r2, r1
	sub r5, r2
	ldr r3, =seconds
	strb r5, [r3]
pop {r0-r3, lr}
bx lr
@ output in r5
timeToPosix:
push {r0-r3, lr}
	eor r5, r5
	ldr r0, =hours
	ldrb r0, [r0]
	ldr r1, =3600
	mul r5, r0, r1 @ r5 = hours * 3600
	ldr r0, =minutes
	ldrb r0, [r0]
	ldr r1, =60
	mul r3, r0, r1 @ r3 = minutes * 60
	add r5, r3
	ldr r0, =seconds
	ldrb r0, [r0]
	add r5, r0 @ r5 = 3600 * hours + 60 * minutes + seconds
	ldr r0, =posixTime
	str r5, [r0]
pop {r0-r3, lr}
bx lr
@ data to JDN
dataToJDN:
push {r0-r4, lr}
@ r0 = a = (14 - month)/12
	ldr r2, =month
	ldrb r2, [r2]
	mov r3, 12
	rsb r0, r2, 14
	sdiv r0, r3
@ r1 = y = year +4800-a
	ldr r1, =year
	ldr r1, [r1]
	add r1, 4800
	sub r1, r0
@ r2 = m = month + 12a - 3
	mul r3, r0
	sub r3, 3
	add r2, r3
@                                2                     3               4            5                6             1
@ JDN = day + |(153* r2+2)/5| + 365* r1 + (r1/4) - (r1/100) +  (r1/400) - 32045
	ldr r3, =day
	ldrb r3, [r3]
	push {r3} @ ************************ 1
	ldr r4, =-32045
	push {r4} @ ************************ 2
	mov r3, 153
	mov r4, 5
	mul r3, r2
	add r3, 2
	sdiv r3, r4
	push {r3} @ ************************ 3
	ldr r3, =365
	mul r3, r1
	push {r3} @ ************************ 4
	mov r3, 4
	sdiv r3, r1, r3
	push {r3} @ ************************ 5
	mov r3, -100
	sdiv r3, r1, r3
	push {r3} @ *********************** 6
	ldr r3, =400
	sdiv r5, r1, r3 
	mov r3, 6
summ:
	pop {r4}
	add r5, r4
	subs r3, 1
	bne summ
	ldr r3, =JDshift
	ldr r3, [r3]
	sub r5, r3 @ нормализация к дате 01.01.2018
	ldr r3, =JDN
	str r5, [r3]
pop {r0-r4, lr}
bx lr
@ out in r5
timeToPosixWithData:
push {r0, r1, lr}
	bl dataToJDN
	ldr r0, =86400 @ seconds in day
	mul r0, r5 @ jdn to seconds
	bl timeToPosix
	add r5, r0
	ldr r0, =posixTime
	str r5, [r0]
pop {r0, r1, lr}
bx lr
posixToData:
push {r0-r3, lr}
	ldr r0, =posixTime
	ldr r0, [r0]
	ldr r1, =86400
	udiv r0, r1
	ldr r1, =JDshift
	ldr r1, [r1]
	add r1, r0 @ нормализованную JDN  в стандартную
	ldr r0, =serVar
@ Coefficient A (r1)
	ldr r2, [r0] @ r2 = 32044
	add r1, r2 @ r1 = JDN + 32044
@ Coefficient B (r3)
	mov r2, 4
	mul r3, r1, r2 @ r3 = 4 * A
	add r3, 3 @ r3 = 4 * A + 3
	ldr r4, [r0,4] @ r4 = 146097
	udiv r3, r4 @ r3 = (4 * A + 3) / 146097
	push {r3}
@ Coefficient C (r1)
	mul r3, r4 @ r3 = 146097 *  b
	udiv r3, r2 @ r3 = r3 / 4
	sub r1, r3 @ r1 = A - (146097 * b) / 4
@ Coeficient D (r3)
	mul r3, r1, r2 @ r3 = 4 * c
	add r3, 3 @ r3 = 4* c + 3
	ldr r4, [r0,8] @ r4 = 1461
	udiv r3, r4 @ r3 = r3  / 1461
@ Coefficient E (r1)
	mul r4, r3 @ r4 = 1461 * d
	udiv r4, r2 @ r4 = r4 / 4
	sub r1, r4 @ r1 = c - (1461 * d) / 4
@ Coefficient M (r5)
	ldrb r4, [r0,12] @ r4 = 153
	mov r2, 5 @ r2 = 5
	mul r5, r1, r2 @ r5 = 5 * e
	add r5, 2 @ r5 = 5*e + 2
	udiv r5, r4 @ r5 = (5 * e +2) / 153
@ DAY
	mul r4, r5
	add r4, 2
	udiv r4, r2
	sub r1, r4
	ldr r2, =day
	strb r1, [r2]
@ MONTH
	mov r4, 10
	udiv r4, r5, r4
	mov r2, 12
	mul r2, r4
	add r5, 3
	sub r5, r2
	ldr r2, =month
	strb r5, [r2]
@ YEAR
	mov r1, 100
	pop {r5}
	mul r1, r5
	add r1, r3
	sub r1, 4800
	add r1, r4
	ldr r2, =year
	str r1, [r2]
	pop {r0-r3, lr}
bx lr

setRTC_Counter:
push {r0-r4, lr}
	mov r0, 0
	mov r1, 1
	GetBBp r2, RTC_CRL, 5 @ бит RTOFF
counter01: 			@ проверка и ожидание установки бита в единицу
	ldr r3, [r2]
	cmp r3, 1
	bmi counter01
	str r1, [r2, -4] @ 1 в бит CNF для входа в режим редактирования
	ldr r3, [r2, -4]
	ldr r3, [r2]
	ldr r3, =RTC_CNTL
	strh r5, [r3]
	lsr r5, 16
	strh r5, [r3, -4]
	str r0, [r2, -4] @ 0 в бит CNF для выхода из режима редактирования
	ldr r0, [r2, -4]
counter02: 			@ проверка и ожидание установки бита в единицу
	ldr r3, [r2]
	cmp r3, 1
	bmi counter02
pop {r0-r4, lr}
bx lr

.global RTC_IRQHandler
RTC_IRQHandler:
push {r0-r5, lr}
	mov r0, 0
	mov r1, 1
	@***************************
	GetBBp r5, GPIO_ODR_C, 13
	@***************************
	GetBBp r2, RTC_CRL, 5 @ бит RTOFF
irqRTC01: 			@ проверка и ожидание установки бита в единицу
	ldr r3, [r2]
	cmp r3, 1
	bmi irqRTC01
	str r1, [r2, -4] @ 1 в бит CNF для входа в режим редактирования
@ irqSeconds	
	ldr r3, [r2, -20] @бит 0 SECF секундный флаг
	cmp r3, 0
	beq irqAlert
	@*****************
	ldr r3, [r5]
	eor r3, 1
	str r3, [r5]
	@*****************
	ldr r3, =RTC_CNTH
	ldr r4, [r3]
	lsl r4, 16
	ldr r3, =RTC_CNTL
	ldrh r3, [r3]
	orr r4, r3
	ldr r3, =posixTime
	str r4, [r3]
	bl posixToTime
irqAlert:
	ldr r3, [r2, -16] @бит 0 SECF секундный флаг
	cmp r3, 0
	beq irqOverflow
	
irqOverflow:
	ldr r3, [r2, -12] @бит 0 SECF секундный флаг
	cmp r3, 0
	beq irqExit
	
irqExit:
	str r0, [r2, -20] @ сброс флага секундного прерывания
	str r0, [r2, -16] @ сброс флага будильника
	str r0, [r2, -12] @ сброс флага переполнения
	
	str r0, [r2, -4] @ 0 в бит CNF для выхода из режима редактирования
irqRTC02: 			@ проверка и ожидание установки бита в единицу
	ldr r3, [r2]
	cmp r3, 1
	bmi irqRTC02
pop {r0-r5, lr}
bx lr
.global RTC_setInterrupt
RTC_setInterrupt:
push {r0-r5, lr}
	mov r0, 0
	mov r1, 1
	GetBBp r2, RTC_CRL, 5 @ бит RTOFF
iset01: 			@ проверка и ожидание установки бита в единицу
	ldr r3, [r2]
	cmp r3, 1
	bmi iset01
	str r1, [r2, -4] @ 1 в бит CNF для входа в режим редактирования
	push {r2}
	
	GetBBp r2, RTC_CRH, 0 @ SECIE
	str r1, [r2]
	str r1, [r2,4]
	str r1, [r2,8]
	
	pop {r2}
	str r0, [r2, -4] @ 0 в бит CNF для выхода из режима редактирования
iset02: 			@ проверка и ожидание установки бита в единицу
	ldr r3, [r2]
	cmp r3, 1
	bmi iset02
	
	ldr r2, =NVIC_ISER0
	ldr r3, [r2]
	orr r3, 8
	str r3, [r2]
	ldr r2, =NVIC_PRI0
	mov r3, 0x10
	str r3, [r2, 3*4]
	
	
pop {r0-r5, lr}
bx lr
