//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_C_H
#define POLOTOVARFACTORY_C_H


#include "Polotovar.h"

class C : public Polotovar
{
    private:
        int *hloubka; // privatni atributy ulozene jako pointery nedava moc smysl
    public:
        explicit C(int *hloubka);
        ~C() override;
        char * print() override;
        char getTyp() override;
        int getHloubka() const;

};


#endif //POLOTOVARFACTORY_C_H
