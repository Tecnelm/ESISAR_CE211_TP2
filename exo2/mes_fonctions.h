#include "stm8s.h"
#include "carte_accueil_TP.h"
#include "fonctions_TP_utiles.h"

void initTimer(void);
void initPort(void);
void incrementCounter(void);
void intertiming (void);


void chenillardLed(void);
void allumLed(u8 value);
u8 getButtonStart(void);
u8 getButtonStop(void);
u8 lireBP2(void);
