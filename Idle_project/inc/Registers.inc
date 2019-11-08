.include "Bases.inc"
.section .rodata
.equ FLASH_ACR, (AHB_BASE + 0x2000)

.equ RCC              	,(AHB_BASE + 0x1000) @ регистры RCC
.equ RCC_CR		,(RCC+0x00) @ регистр контрол€ частоты (здесь разрешаем внешнее/внутреннее тактирование)

.equ RCC_CFGR,  (RCC+0x04) @ регистр конфигурации тактировани€ (здесь настраиваем предделители)

/*маски битовых полей регистра конфигурации*/
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

.equ RCC_CIR	,(RCC+0x08) @ регистр прерываний тактировани€

.equ RCC_APB2_RST			,(RCC+0x0C) @ регистр сброса периферии APB2

.equ RCC_APB1_RST			,(RCC+0x10) @ регистр сброса периферии APB1

.equ RCC_AHBENR	,(RCC+0x14) @ регистр включени€ тактирвани€ AHB

.equ RCC_APB2ENR				,(RCC+0x18) @ регистр включени€ тактирвани€ APB2

.equ RCC_APB1ENR				,(RCC+0x1C) @ регистр включени€ тактирвани€ APB1

.equ RCC_BDCR				,(RCC+0x20) @ регистр контрол€ области резервного хранени€

.equ RCC_CSR					,(RCC+0x24) @ регистр управлени€/состо€ни€

.equ CR—,           (AHB_BASE + 0x3000) @ регистры CRC
.equ CRC_DR,    (CRC + 0x00) @ 32битный регистр данных
.equ CRC_IDR,   (CRC + 0x04) @ 8битный независимый регистр данных
.equ CRC_CR,    (CRC + 0x08) @ 1битный регистр сбрса загружает 0xFFFFFFFF в CRC_DR

.equ PWR,   (APB1_BASE + 0x7000) @–егистры  управлени€ питанием
.equ PWR_CR, (PWR + 0x00) @ –егистр управлени€ питанием
.equ PWR_CSR,   (PWR + 0x04) @ регистр статуса/управлени€

.equ BKP,   (APB1_BASE + 0x6C00) @–егистры резервного хранени€
/* 42 16битных регистра данных резервного хранени€ */
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
.equ BKP_RTCCR, (BKP + 0x2C) @ регистр калибровки часов реального времени
.equ BKP_CR, (BKP + 0x30) @регистр контрол€
.equ BKP_CSR, (BKP + 0x34) @регистр контрол€/статуса

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

.macro GetBB reg, base, p, bit @ макрос загрузки адреса области прив€зки битов в регистр
   ldr \reg,=(\base+(\p*32+\bit*4))
.endm
.macro GetBBp reg, p, bit @ макрос загрузки адреса области прив€зки битов периферии в регистр
    ldr \reg, =(PERIPH_BB_BASE + (\p*32+\bit*4))
.endm

.equ AFIO, APB2_BASE @ регистры альтернативной функции ввода-вывода
.equ AFIO_EVCR, (AFIO+0x0) @ регистр контрол€ событий
.equ AFIO_MAPR, (AFIO+0x04) @ регистр переопределени€ и отладки конфигураций ввода-вывода
.equ AFIO_EXTICR1, (AFIO+0x08) @ 1 регистр конфигурации внешних прерываний
.equ AFIO_EXTICR2, (AFIO+0x0C) @ 2 регистр конфигурации внешних прерываний
.equ AFIO_EXTICR2, (AFIO+0x10) @ 3 регистр конфигурации внешних прерываний
.equ AFIO_EXTICR2, (AFIO+0x14) @ 4 регистр конфигурации внешних прерываний
.equ AFIO_MAPR2, (AFIO + 0x1C) @ 2 регистр переопределени€ и отладки конфигураций ввода-вывода

/*контроллер прерываний*/
