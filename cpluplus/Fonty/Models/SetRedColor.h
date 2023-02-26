//
// Created by rob on 12/13/22.
//

#ifndef FONTY_SETREDCOLOR_H
#define FONTY_SETREDCOLOR_H


#include "ColorSetter.h"

class SetRedColor : public ColorSetter
{
private:
    char * color = reinterpret_cast<char *> ('r');
public:
    Substring * setColor(char *start, char *end) override;
};


#endif //FONTY_SETREDCOLOR_H
