//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_FINALPRODUCT_H
#define POLOTOVARFACTORY_FINALPRODUCT_H


#include "Polotovar.h"

class FinalProduct : Polotovar
{
    private:
        int *vyska;
        int *sirka;
        int *hloubka;
    public:
        explicit FinalProduct(int *vyska, int *sirka, int *hloubka);
        ~FinalProduct() override;
        char* print() override;
        char getTyp() override;
};



#endif //POLOTOVARFACTORY_FINALPRODUCT_H
