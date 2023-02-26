//
// Created by rob on 12/13/22.
//

#include "Substring.h"

Substring::Substring(char *const start, char *const end, char *const change)
{
    this->start = start;
    this->end = end;
    this->change = change;
}

Substring::~Substring()
{
    delete start;
    delete end;
    delete change;
}
