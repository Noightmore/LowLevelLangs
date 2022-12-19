//
// Created by rob on 12/13/22.
//

#ifndef FONTY_SUBSTRING_H
#define FONTY_SUBSTRING_H


class Substring
{
    char * start;
    char * end;
    char * change;
public:
    Substring(char * start, char * end, char * change);
    ~Substring();
};


#endif //FONTY_SUBSTRING_H
