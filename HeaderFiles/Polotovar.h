#ifndef POLOTOVARFACTORY_POLOTOVAR_H
#define POLOTOVARFACTORY_POLOTOVAR_H

// abstract class
class Polotovar
{

private:
    //char *value;
public:
    Polotovar();
    virtual ~Polotovar() = default;
    //virtual Polotovar* clone() = 0; // abstract copy constructor
    [[maybe_unused]] virtual void print() = 0; // abstract print method

    //virtual char getValue() const = 0;
    virtual char getTyp();
};


#endif //POLOTOVARFACTORY_POLOTOVAR_H
