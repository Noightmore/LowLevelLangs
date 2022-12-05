//
// Created by rob on 12/5/22.
//

#include <iostream>
#include "../HeaderFiles/C.h"

C::C(int *hloubka)
{
    this->hloubka = hloubka;
}

C::~C()
{
    delete hloubka;
}

void C::print()
{
    std::cout << "C: " << *hloubka << std::endl;
}

int C::getHloubka() const
{
    return *this->hloubka;
}

char C::getTyp()
{
    return 'C';
}
