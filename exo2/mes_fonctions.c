#include "mes_fonctions.h"

#define TIMELOW 0x23
#define TIMEHIGH 0xF4
#define TIMER3PRESC 0x05
#define TIMER3CR1 0x01

#define BP2MASK 0X80 /// bP2 port E ligne 0x80

u8 counter = 0;

void initTimer(void)
{
    TIM3 -> ARRL = TIMELOW;
    TIM3 -> ARRH = TIMEHIGH;
    TIM3 ->PSCR = TIMER3PRESC;
    TIM3->IER = 1;
}

u8 lireBP2(void)
{
    return GPIOE->IDR & BP2MASK;
}

void initPort(void)
{
    init_Ports();
    GPIOE ->DDR =0x00 ;
    GPIOE ->CR1 = BP2MASK;
}

void intertiming(void)
{
    char flag =0;
    initPort();
    initTimer();
    afficher_TIL321(counter);
    enableInterrupts();

    while(1)
    {
        if(lireBP2() && !flag)
        {
            TIM3 ->CR1 ^= TIMER3CR1;
            counter = 0;
            flag = 1;
        }else if(!lireBP2() && flag )
        {
            flag = 0;
        }

    }
}

void incrementCounter(void)
{
    TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
    (counter) ++;
    (counter)%=10;
    afficher_TIL321(counter);

}