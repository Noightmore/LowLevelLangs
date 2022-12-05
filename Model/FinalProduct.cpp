//
// Created by rob on 12/5/22.
//

#include <cstdlib>
#include <string>
#include "../HeaderFiles/FinalProduct.h"

FinalProduct::FinalProduct(int *vyska, int *sirka, int *hloubka)
{
    this->vyska = vyska;
    this->sirka = sirka;
    this->hloubka = hloubka;
}

FinalProduct::~FinalProduct()
{
    delete vyska;
    delete sirka;
    delete hloubka;
}

char *FinalProduct::print()
{

    // convert all integers to string with each of them separated by spaces
    char svyska =  *std::to_string(*this->vyska).c_str();
    char ssirka = *std::to_string(*this->sirka).c_str();
    char shloubka = *std::to_string(*this->hloubka).c_str();

    // create string with all integers
    char * output = (char *) malloc(sizeof(svyska) + sizeof(ssirka) + sizeof(shloubka) + 3);
    for(char i=0; i<3; i++)
    {

    }

    return "";
}


