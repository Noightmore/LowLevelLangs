#include "SetRedColor.h"
#include "Substring.h"

Substring * SetRedColor::setColor(char *const start, char *const end)
{
    auto *substring = new Substring(start, end, this->color);
    return substring;
}
