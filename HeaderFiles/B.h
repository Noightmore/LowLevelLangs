//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_B_H
#define POLOTOVARFACTORY_B_H


#include "Polotovar.h"

class B : public Polotovar
{
private:
    int *sirka; // privatni atributy ulozene jako pointery nedava moc smysl
public:
    explicit B(int *sirka);
    ~B() override;
    Polotovar* clone() ;
    char * print() override;
    char getTyp() override;
    int getSirka() const;
};


#endif //POLOTOVARFACTORY_B_H
