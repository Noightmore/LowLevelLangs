//
// Created by rob on 12/13/22.
//

#ifndef FONTY_COLORSETTER_H
#define FONTY_COLORSETTER_H

#include "Substring.h"

class ColorSetter
{
    virtual Substring * setColor(char * start, char * end) = 0;
};

#endif //FONTY_COLORSETTER_H
