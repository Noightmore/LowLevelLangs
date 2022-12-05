//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_STROJ_H
#define POLOTOVARFACTORY_STROJ_H

#include <stack>
#include "Polotovar.h"
#include "A.h"
#include "B.h"
#include "C.h"

class Stroj
{

private:
    std::stack<Polotovar*> *stack;
    A *first_a;
    B *first_b;
    C *first_c;

    int checkDepthOfStack();
public:
    Stroj();
    ~Stroj();
    Stroj* clone();
    void addPolotovar(Polotovar *polotovar);
    Stroj *operator = (Stroj *stroj);
};


#endif //POLOTOVARFACTORY_STROJ_H
