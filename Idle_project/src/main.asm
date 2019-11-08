.syntax unified
.thumb
.cpu cortex-m3
.text
.align 2
.include "Registers.inc"
.global Reset_Handler
.equ timeout, 12

/*
 Alrorithm:
 Enable HSE
 Enable FLASH prefetch buffer
 Set FLASH latency
 Setup prescaler (PLL)
 Enable PLL
 Set PLL as system clock
 */

Reset_Handler:
     mov r0, 1 @ one for bitband
     ldr r1, =RCC_CFGR @ RCC_CFGR address
	 GetBBp r2, RCC_CR, 0 @ bitband for RCC_CR
	 GetBBp r3, RCC_CFGR, 0 @ bitband for RCC_CFGR
	 GetBBp r4, FLASH_ACR, 0 @ bitband for FLASH_ACR
	 
	 str r0, [r2, 16*4] @ HSEON bit setup
	 add r5, r2, (17*4) @ HSERDY bitband address loading in r5
	 push {r5} @ save HSERDY address in stack
	 bl wait @ wait until HSE not ready
	 add sp, 4 @ reset stack pointer
	 
	 ldr r5, [r1] @ RCC_CFGR value
	 ldr r6, =(SW_AHB1 | SW_APB1_2 | SW_APB2_1 | SW_ADC6 | SW_PLLMUL9 | SW_PLLFROMHSE) @ AHB-/1  APB1-/2 APB2-/1 ADC-/6 PLL-*9 PLL from HSE USB /1.5
	 orr r5, r6 @ CONFIGURATION SETUP
	 str r5, [r1] @ write back RCC_CFGR value
	 
	 str r0, [r4, 16] @ enable prefetch buffer
	 str r0, [r4, 4] @ set latensy by 2
	 
	 str r0, [r2, 24*4] @ set PLLON bit
	 add r5, r2, (25*4) @ PLLRDY bitband address loading in r5
	 push {r5} @ save PLLRDY address in stack
	 bl wait @ wait until PLL not ready
	 add sp, 4 @ reset stack pointer
	 
	 str r0, [r3, 4] @ set PLL as system clock (SW bit 1)
	 add r5, r3, (3*4) @ SWS bitband address loading in r5
	 push {r5} @ save SWS bit 3 address in stack
	 bl wait @ wait until system clock not ready
	 add sp, 4 @ reset stack pointer
	 
	 
mainLoop:
	
b mainLoop
     
.global Default_Handler
Default_Handler:
    bx lr
@ input by stack   
wait:
    push {r2, r3, r4} 			@ save registers
	ldr r2, [sp,12] 			@ take input param
	mov r3, 1 				@ unit in r4
    add r3, r3, r3, lsl timeout	@ timer set
bittst:
    subs r3,1
    beq wend 
    ldr r4, [r2] @ check
    tst r4, 1
    beq bittst
    pop {r2, r3, r4}
    bx lr
wend:
    mov r6, -1
	pop {r2, r3, r4}
    bx lr   
    
.end
