#include "mes_fonctions.h"

#define TIMELOW 0x23
#define TIMEHIGH 0xF4
#define TIMER3PRESC 0x05
#define TIMER3CR1 0x01

#define BP2MASK 0X80 /// bP2 port E ligne 0x80
#define LEDRED 0b1111000; /// masque pour les LED ROUGE
#define LEDGREEN 1; /// masque pour led verte 

#define BASETIME 2 /// temps d'appuis bouton 
#define REDTIME 8 /// dans le cas d'un appuis trop cours temps laisser les led allumé 

#define LETTRE_A 0xEE /// code afficheur lettre 
#define LETTRE_B 0x7A


u8 counter = 0;

void initTimer(void) /// initialisation du timer 3
{
    TIM3 -> ARRL = TIMELOW;
    TIM3 -> ARRH = TIMEHIGH;
    TIM3 ->PSCR = TIMER3PRESC;
    TIM3->IER = 1; /// activation de l'interrupte
}

char lireBP2(void)
{
    return GPIOE->IDR & BP2MASK; /// retourne la valeur du bouton
}

void incrementCounter(void)
{   /// fonction execute lors de l'interuption
    TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
    (counter) ++;
    (counter)%=10;
}

void rightTimePush(void){

    
    char ledRedOn = 0;
    char flag =0;
    /// initialisation timer et pin
    init_Port();
    initTimer();
    /// autorise les interuptions
    enableInterrupts();


    while(1)
    {
        if(lireBP2() && !flag) /// detecte l'appuis du bouton le flag sers dans le cas ou on a laché le bouton dans le cas d'un nouvelle appuis pas eteindre direct 
        {
            ///alume les différentes led 
            GPIOD -> ODR &=~LEDGREEN ;
            GPIOA -> ODR &=~LEDRED ; 
            TIM3 ->CR1 |= TIMER3CR1; /// lance le timer

            if(counter >=BASETIME)/// focntion pour savoir si on réalise le temps led rouge
            {
                ledRedOn = 0;
            }
            else
            {
                ledRedOn = 1;
            }
            
        }else
        {
            if(ledRedOn)
                flag = 1;   /// initialisation d'un flag pour bloquer un nouveau appuis
            
            GPIOD -> ODR |=LEDGREEN ;
        }
        

        if(ledRedOn && !lireBP2())
        {
            if(counter >= REDTIME) /// etteind au bout des 8s 
            {
                ledRedOn = 0;
                flag = 0;
                GPIOA -> ODR |=LEDRED ;
                counter =0;
                TIM3 ->CR1 &= ~TIMER3CR1;

            }
        }else if(!ledRedOn && !lireBP2()) /// dans le cas ou ou pas besoin de laisser allumé ou cas général
        {
            GPIOA -> ODR |=LEDRED ;
            flag = 0;
            counter =0;
            TIM3 ->CR1 &= ~TIMER3CR1;
        }
        

        if(ledRedOn || lireBP2())///affichage des lettre 
        {
          GPIOB->ODR = LETTRE_B; 
        }else
        {
            GPIOB->ODR = LETTRE_A;
        }
        
        
    }
    


}