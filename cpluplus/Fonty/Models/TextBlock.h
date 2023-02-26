#ifndef FONTY_TEXTBLOCK_H
#define FONTY_TEXTBLOCK_H

#include <vector>
#include "Substring.h"

class TextBlock
{

private:
    char * block; // null terminated string
    std::vector<Substring*> * substrings;
public:
    TextBlock();
    ~TextBlock();

    void addChange(Substring * substring);
};


#endif //FONTY_TEXTBLOCK_H
