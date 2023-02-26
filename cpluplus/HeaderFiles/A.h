//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_A_H
#define POLOTOVARFACTORY_A_H


#include "Polotovar.h"

class A : public Polotovar
{

private:
    int *vyska; // privatni atributy ulozene jako pointery nedava moc smysl

public:
    explicit A(int *vyska);
    ~A() override;
    Polotovar* clone() ;
    char * print() override;
    char getTyp() override;
    int getVyska() const;
};


#endif //POLOTOVARFACTORY_A_H
