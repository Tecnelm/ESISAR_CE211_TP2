/**
  ******************************************************************************
  * @file fonctions_TP_utiles.h
  * @brief This file contains 
  * @author Bernard Glossi
  * @version V2
  * novembre 2018
 
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __FONCTIONS_TP_UTILES_H
#define __FONCTIONS_TP_UTILES_H

// prototype des fonctions du fichier mes_fonctions_juillet_2016.c

void init_Ports(void); // inséré le 31 aout 2017

u8 lire_Etat_BP2(void);

 void init_UART2(void);

u8 afficher_TIL321(u8 valeur);

void afficher_Digit_HDLX1(u8 numero, u8 caractere);
void afficher_Digit_HDLX2(u8 numero, u8 caractere);

void afficher_Module_HDLX1(u8* chaine);
void afficher_Module_HDLX2(u8* chaine);
void afficher_Modules_HDLX(u8 *adresse);

  
void conv_BCD_ASCII(u8 valeur_BCD, u8 *adresse);
void conv1_BCD_ASCII(u16 valeur_BCD, u8 *adresse);
void conv_Bin_ASCII(u8 valeur_binaire, u8 *adresse);  // revoir les termes et U16
u16 Ajustement_BCD(u16 valeur, u16 valeur_pre);
u16 Bin_BCD (u8 valeur); // modif 28/11/16


#endif __FONCTIONS_TP_UTILES_H