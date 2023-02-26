//
// Created by rob on 12/5/22.
//

#ifndef POLOTOVARFACTORY_STROJ_H
#define POLOTOVARFACTORY_STROJ_H

#include <stack>
#include <chrono>
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
    //std::chrono::time_point<std::chrono::system_clock> start_time;

    int checkDepthOfStack();
public:
    Stroj();
    ~Stroj();
    Stroj* clone() const;
    void addPolotovar(Polotovar *polotovar);
    Stroj *operator = (const Stroj *stroj);
};


#endif //POLOTOVARFACTORY_STROJ_H
