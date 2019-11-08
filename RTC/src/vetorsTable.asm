.syntax unified
.thumb
.cpu cortex-m3
.section .vectors
.align 4
  .word              0x20005000					@ 0
  .word              Reset_Handler+1			@ 1
  .word              NMI_Handler+1				@ 2
  .word              HardFault_Handler+1		@ 3
  .word	MemManage_Handler+1						@ 4
  .word	BusFault_Handler+1						@ 5
  .word	UsageFault_Handler+1					@ 6
  .word	0										@ 7
  .word	0										@ 8
  .word	0										@ 9
  .word	0										@ 10
  .word	SVC_Handler+1							@ 11
  .word	DebugMon_Handler+1						@ 12
  .word	0										@ 13
  .word	PendSV_Handler+1						@ 14
  .word	SysTick_Handler+1						@ 15
  .word	WWDG_IRQHandler+1           			/* Window Watchdog interrupt                      IRQ#0  */
  .word	PVD_IRQHandler+1            			/* PVD through EXTI line detection interrupt      IRQ#1  */
  .word	TAMPER_IRQHandler+1         			/* Tamper interrupt                               IRQ#2  */
  .word	RTC_IRQHandler+1            			/* RTC global interrupt                           IRQ#3  */
  .word	FLASH_IRQHandler+1          			/* Flash global interrupt                         IRQ#4  */
  .word	RCC_IRQHandler+1            			/* RCC global interrupt                           IRQ#5  */
  .word	EXTI0_IRQHandler+1          			/* EXTI Line0 interrupt                           IRQ#6  */
  .word	EXTI1_IRQHandler+1          			/* EXTI Line1 interrupt                           IRQ#7  */
  .word	EXTI2_IRQHandler+1          			/* EXTI Line2 interrupt                           IRQ#8  */
  .word	EXTI3_IRQHandler+1          			/* EXTI Line3 interrupt                           IRQ#9  */
  .word	EXTI4_IRQHandler+1          			/* EXTI Line4 interrupt                           IRQ#10  */
  .word	DMA1_Channel1_IRQHandler+1  			/* DMA1 Channel1 global interrupt                 IRQ#11  */
  .word	DMA1_Channel2_IRQHandler+1  			/* DMA1 Channel2 global interrupt                 IRQ#12  */
  .word	DMA1_Channel3_IRQHandler+1  			/* DMA1 Channel3 global interrupt                 IRQ#13  */
  .word	DMA1_Channel4_IRQHandler+1  			/* DMA1 Channel4 global interrupt                 IRQ#14  */
  .word	DMA1_Channel5_IRQHandler+1  			/* DMA1 Channel5 global interrupt                 IRQ#15  */
  .word	DMA1_Channel6_IRQHandler+1  			/* DMA1 Channel6 global interrupt                 IRQ#16 */
  .word	DMA1_Channel7_IRQHandler+1  			/* DMA1 Channel7 global interrupt                 IRQ#17  */
  .word	ADC1_2_IRQHandler+1         			/* ADC1 and ADC2 global interrupt                 IRQ#18  */
  .word	USB_HP_CAN_TX_IRQHandler+1  			/* USB High Priority or CAN TX interrupts         IRQ#19  */
  .word	USB_LP_CAN_RX0_IRQHandler+1 			/* USB Low Priority or CAN RX0 interrupts         IRQ#20  */
  .word	CAN_RX1_IRQHandler+1        			/* CAN RX1 interrupt                              IRQ#21  */
  .word	CAN_SCE_IRQHandler+1        			/* CAN SCE interrupt                              IRQ#22  */
  .word	EXTI9_5_IRQHandler+1        			/* EXTI Line[9:5] interrupts                      IRQ#23  */
  .word	TIM1_BRK_IRQHandler+1       			/* TIM1 Break interrupt                           IRQ#24 */
  .word	TIM1_UP_IRQHandler+1        			/* TIM1 Update interrupt                          IRQ#25  */
  .word	TIM1_TRG_COM_IRQHandler+1   			/* TIM1 Trigger and Commutation interrupts        IRQ#26  */
  .word	TIM1_CC_IRQHandler+1        			/* TIM1 Capture Compare interrupt                 IRQ#27  */
  .word	TIM2_IRQHandler+1           			/* TIM2 global interrupt                          IRQ#28  */
  .word	TIM3_IRQHandler+1           			/* TIM3 global interrupt                          IRQ#29  */
  .word	TIM4_IRQHandler+1           			/* TIM4 global interrupt                          IRQ#30  */
  .word	I2C1_EV_IRQHandler+1        			/* I2C1 event interrupt                           IRQ#31  */
  .word	I2C1_ER_IRQHandler+1        			/* I2C1 error interrupt                           IRQ#32  */
  .word	I2C2_EV_IRQHandler+1        			/* I2C2 event interrupt                           IRQ#33  */
  .word	I2C2_ER_IRQHandler+1        			/* I2C2 error interrupt                           IRQ#34  */
  .word	SPI1_IRQHandler+1           			/* SPI1 global interrupt                          IRQ#35  */
  .word	SPI2_IRQHandler+1           			/* SPI2 global interrupt                          IRQ#36  */
  .word	USART1_IRQHandler+1         			/* USART1 global interrupt                        IRQ#37  */
  .word	USART2_IRQHandler+1         			/* USART2 global interrupt                        IRQ#38  */
  .word	USART3_IRQHandler+1         			/* USART3 global interrupt                        IRQ#39  */
  .word	EXTI15_10_IRQHandler+1      			/* EXTI Line[15:10] interrupts                    IRQ#40  */
  .word	RTCAlarm_IRQHandler+1       			/* RTC Alarms through EXTI line interrupt           */
  .word	0                         			/* Reserved                                         */
  .word	TIM8_BRK_IRQHandler+1       			/* TIM8 Break interrupt                             */
  .word	TIM8_UP_IRQHandler+1        			/* TIM8 Update interrupt                            */
  .word	TIM8_TRG_COM_IRQHandler+1   			/* TIM8 Trigger and Commutation interrupts          */
  .word	TIM8_CC_IRQHandler+1        			/* TIM8 Capture Compare interrupt                   */
  .word	ADC3_IRQHandler+1           			/* ADC3 global interrupt                            */
  .word	FSMC_IRQHandler+1           			/* FSMC global interrupt                            */
  .word	SDIO_IRQHandler+1           			/* SDIO global interrupt                            */
  .word	TIM5_IRQHandler+1           			/* TIM5 global interrupt                            */
  .word	SPI3_IRQHandler+1           			/* SPI3 global interrupt                            */
  .word	UART4_IRQHandler+1          			/* UART4 global interrupt                           */
  .word	UART5_IRQHandler+1          			/* UART5 global interrupt                           */
  .word	TIM6_IRQHandler+1           			/* TIM6 global interrupt                            */
  .word	TIM7_IRQHandler+1           			/* TIM7 global interrupt                            */
  .word	DMA2_Channel1_IRQHandler+1  			/* DMA2 Channel1 global interrupt                   */
  .word	DMA2_Channel2_IRQHandler+1  			/* DMA2 Channel2 global interrupt                   */
  .word	DMA2_Channel3_IRQHandler+1  			/* DMA2 Channel3 global interrupt                   */
  .word	DMA2_Channel4_5_IRQHandler+1			/* DMA2 Channel4 and DMA2 Channel5 global interrupt */
  
    .weak	NMI_Handler
    .thumb_set NMI_Handler,Default_Handler

    .weak	HardFault_Handler
	.thumb_set HardFault_Handler,Default_Handler

  	.weak	MemManage_Handler
	.thumb_set MemManage_Handler,Default_Handler

  	.weak	BusFault_Handler
	.thumb_set BusFault_Handler,Default_Handler

	.weak	UsageFault_Handler
	.thumb_set UsageFault_Handler,Default_Handler
	
	.weak	SVC_Handler
	.thumb_set SVC_Handler,Default_Handler

	.weak	DebugMon_Handler
	.thumb_set DebugMon_Handler,Default_Handler
	
	.weak	PendSV_Handler
	.thumb_set PendSV_Handler,Default_Handler

	.weak	SysTick_Handler
	.thumb_set SysTick_Handler,Default_Handler

	.weak	WWDG_IRQHandler
	.thumb_set WWDG_IRQHandler,Default_Handler
	
	.weak	PVD_IRQHandler
	.thumb_set PVD_IRQHandler,Default_Handler
	
	.weak	TAMPER_IRQHandler
	.thumb_set TAMPER_IRQHandler,Default_Handler
	
	@.weak	RTC_IRQHandler
	@.thumb_set RTC_IRQHandler,Default_Handler
	
	.weak	FLASH_IRQHandler
	.thumb_set FLASH_IRQHandler,Default_Handler
	
	.weak	RCC_IRQHandler
	.thumb_set RCC_IRQHandler,Default_Handler
	/*
	.weak	EXTI0_IRQHandler
	.thumb_set EXTI0_IRQHandler,Default_Handler
	
	.weak	EXTI1_IRQHandler
	.thumb_set EXTI1_IRQHandler,Default_Handler
	
	.weak	EXTI2_IRQHandler
	.thumb_set EXTI2_IRQHandler,Default_Handler
	
	.weak	EXTI3_IRQHandler
	.thumb_set EXTI3_IRQHandler,Default_Handler
	
	.weak	EXTI4_IRQHandler
	.thumb_set EXTI4_IRQHandler,Default_Handler
	*/
	.weak	DMA1_Channel1_IRQHandler
	.thumb_set DMA1_Channel1_IRQHandler,Default_Handler
	
	.weak	DMA1_Channel2_IRQHandler
	.thumb_set DMA1_Channel2_IRQHandler,Default_Handler
	
	.weak	DMA1_Channel3_IRQHandler
	.thumb_set DMA1_Channel3_IRQHandler,Default_Handler
	
	.weak	DMA1_Channel4_IRQHandler
	.thumb_set DMA1_Channel4_IRQHandler,Default_Handler
	
	.weak	DMA1_Channel5_IRQHandler
	.thumb_set DMA1_Channel5_IRQHandler,Default_Handler
	
	.weak	DMA1_Channel6_IRQHandler
	.thumb_set DMA1_Channel6_IRQHandler,Default_Handler
	
	.weak	DMA1_Channel7_IRQHandler
	.thumb_set DMA1_Channel7_IRQHandler,Default_Handler
	
	.weak	ADC1_2_IRQHandler
	.thumb_set ADC1_2_IRQHandler,Default_Handler
	
	.weak	USB_HP_CAN_TX_IRQHandler
	.thumb_set USB_HP_CAN_TX_IRQHandler,Default_Handler
	
	.weak	USB_LP_CAN_RX0_IRQHandler
	.thumb_set USB_LP_CAN_RX0_IRQHandler,Default_Handler
	
	.weak	CAN_RX1_IRQHandler
	.thumb_set CAN_RX1_IRQHandler,Default_Handler
	
	.weak	CAN_SCE_IRQHandler
	.thumb_set CAN_SCE_IRQHandler,Default_Handler
	
	.weak	EXTI9_5_IRQHandler
	.thumb_set EXTI9_5_IRQHandler,Default_Handler
	
	.weak	TIM1_BRK_IRQHandler
	.thumb_set TIM1_BRK_IRQHandler,Default_Handler
	
	.weak	TIM1_UP_IRQHandler
	.thumb_set TIM1_UP_IRQHandler,Default_Handler
	
	.weak	TIM1_TRG_COM_IRQHandler
	.thumb_set TIM1_TRG_COM_IRQHandler,Default_Handler
	
	.weak	TIM1_CC_IRQHandler
	.thumb_set TIM1_CC_IRQHandler,Default_Handler
	
	.weak	TIM2_IRQHandler
	.thumb_set TIM2_IRQHandler,Default_Handler
	
	.weak	TIM3_IRQHandler
	.thumb_set TIM3_IRQHandler,Default_Handler
	
	.weak	TIM4_IRQHandler
	.thumb_set TIM4_IRQHandler,Default_Handler
	
	.weak	I2C1_EV_IRQHandler
	.thumb_set I2C1_EV_IRQHandler,Default_Handler
	
	.weak	I2C1_ER_IRQHandler
	.thumb_set I2C1_ER_IRQHandler,Default_Handler
	
	.weak	I2C2_EV_IRQHandler
	.thumb_set I2C2_EV_IRQHandler,Default_Handler
	
	.weak	I2C2_ER_IRQHandler
	.thumb_set I2C2_ER_IRQHandler,Default_Handler
	
	.weak	SPI1_IRQHandler
	.thumb_set SPI1_IRQHandler,Default_Handler
	
	.weak	SPI2_IRQHandler
	.thumb_set SPI2_IRQHandler,Default_Handler
	
	.weak	USART1_IRQHandler
	.thumb_set USART1_IRQHandler,Default_Handler
	
	.weak	USART2_IRQHandler
	.thumb_set USART2_IRQHandler,Default_Handler
	
	.weak	USART3_IRQHandler
	.thumb_set USART3_IRQHandler,Default_Handler
	
	.weak	EXTI15_10_IRQHandler
	.thumb_set EXTI15_10_IRQHandler,Default_Handler
	
	.weak	RTCAlarm_IRQHandler
	.thumb_set RTCAlarm_IRQHandler,Default_Handler
	
	.weak	TIM8_BRK_IRQHandler
	.thumb_set TIM8_BRK_IRQHandler,Default_Handler
	
	.weak	TIM8_UP_IRQHandler
	.thumb_set TIM8_UP_IRQHandler,Default_Handler
	
	.weak	TIM8_TRG_COM_IRQHandler
	.thumb_set TIM8_TRG_COM_IRQHandler,Default_Handler
	
	.weak	TIM8_CC_IRQHandler
	.thumb_set TIM8_CC_IRQHandler,Default_Handler
	
	.weak	ADC3_IRQHandler
	.thumb_set ADC3_IRQHandler,Default_Handler
	
	.weak	FSMC_IRQHandler
	.thumb_set FSMC_IRQHandler,Default_Handler
	
	.weak	SDIO_IRQHandler
	.thumb_set SDIO_IRQHandler,Default_Handler
	
	.weak	TIM5_IRQHandler
	.thumb_set TIM5_IRQHandler,Default_Handler
	
	.weak	SPI3_IRQHandler
	.thumb_set SPI3_IRQHandler,Default_Handler
	
	.weak	UART4_IRQHandler
	.thumb_set UART4_IRQHandler,Default_Handler
	
	.weak	UART5_IRQHandler
	.thumb_set UART5_IRQHandler,Default_Handler
	
	.weak	TIM6_IRQHandler
	.thumb_set TIM6_IRQHandler,Default_Handler
	
	.weak	TIM7_IRQHandler
	.thumb_set TIM7_IRQHandler,Default_Handler
	
	.weak	DMA2_Channel1_IRQHandler
	.thumb_set DMA2_Channel1_IRQHandler,Default_Handler
	
	.weak	DMA2_Channel2_IRQHandler
	.thumb_set DMA2_Channel2_IRQHandler,Default_Handler
	
	.weak	DMA2_Channel3_IRQHandler
	.thumb_set DMA2_Channel3_IRQHandler,Default_Handler
	
	.weak	DMA2_Channel4_5_IRQHandler
	.thumb_set DMA2_Channel4_5_IRQHandler,Default_Handler
