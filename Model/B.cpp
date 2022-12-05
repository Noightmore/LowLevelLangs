//
// Created by rob on 12/5/22.
//

#include <iostream>
#include "../HeaderFiles/B.h"

B::B(int *sirka) : Polotovar()
{
    this->sirka = sirka;
}

B::~B()
{
    delete sirka;
}

Polotovar* B::clone()
{
    return new B(new int(*sirka));
}

void B::print()
{
    std::cout << "B: " << *sirka << std::endl;
}

int B::getSirka() const
{
    return *this->sirka;
}

char B::getTyp()
{
    return 'B';
}
