//
// Created by rob on 12/5/22.
//

#include "../HeaderFiles/Stroj.h"

Stroj::Stroj()
{
    // we do not initialize fields a, b, c by choice
    // malloc pointer to stack
    this->stack = new std::stack<Polotovar*>();
}

Stroj::~Stroj()
{
    // dotaz 1
    delete stack;
    first_a->~A();
    first_b->~B();
    first_c->~C();
}

void Stroj::addPolotovar(Polotovar *polotovar) // nebylo by zde lepsi kopirovani???
{
    if (polotovar->getTyp() == 'A')
    {
        if (first_a == nullptr)
        {
            first_a = (A *) polotovar;
        }
    }
    else if (polotovar->getTyp() == 'B')
    {
        if (first_b == nullptr)
        {
            first_b = (B *) polotovar;
        }
    }
    else if (polotovar->getTyp() == 'C')
    {
        if (first_c == nullptr)
        {
            first_c = (C *) polotovar;
        }
    }
    // is stack depth 10?
    if (this->checkDepthOfStack() == 10)
    {
        this->stack->pop();
    }
    this->stack->push(polotovar);

    if(first_a != nullptr && first_b != nullptr && first_c != nullptr)
    {
        // dotaz 2

    }

}

int Stroj::checkDepthOfStack()
{
    return this->stack->size(); // ???????????????????
}

Stroj *Stroj::clone() // vraci ukazatel na novy stroj
{
    // malloc space for new stroj
    auto *new_stroj = (Stroj *) malloc(sizeof(Stroj));
    *new_stroj = *this;
    new_stroj->stack->~stack(); // musime marknout stary stack k dealokaci
    new_stroj->stack = new std::stack<Polotovar*>();
    new_stroj->first_a->~A();
    new_stroj->first_b->~B();
    new_stroj->first_c->~C();

    return new_stroj; // if malloc does not fail else nullptr
}

Stroj *Stroj::operator=(Stroj *stroj) // nestaci pouzivat proste pointery oproti referencim?
{
    Stroj *str = stroj->clone();
    return str;
}



