//
// Created by rob on 12/1/22.
//

#ifndef POLOTOVARFACTORY_POLOTOVAR_H
#define POLOTOVARFACTORY_POLOTOVAR_H

// abstract class
class Polotovar
{

private:
    char *value;
public:
    Polotovar(char* value);
    virtual ~Polotovar() = default;
    virtual Polotovar* clone() = 0;
    [[maybe_unused]] virtual void print() = 0;

};


#endif //POLOTOVARFACTORY_POLOTOVAR_H
