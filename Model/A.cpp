//
// Created by rob on 12/5/22.
//

#include <iostream>
#include "../HeaderFiles/A.h"

A::A(int *vyska) : Polotovar()
{
    this->vyska = vyska;
}

A::~A()
{
    delete vyska;
}

Polotovar* A::clone()
{
    return new A(new int(*vyska));
}

void A::print()
{
    std::cout << "A: " << *vyska << std::endl;
}

int A::getVyska() const
{
    return *this->vyska;
}

char A::getTyp()
{
    return 'A';
}
