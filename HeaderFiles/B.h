//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_B_H
#define POLOTOVARFACTORY_B_H


#include "Polotovar.h"

class B : public Polotovar
{
private:
    int *sirka;
public:
    explicit B(int *sirka);
    ~B() override;
    Polotovar* clone() override;
    void print() override;
    char getTyp() override;
    int getSirka() const;
};


#endif //POLOTOVARFACTORY_B_H
