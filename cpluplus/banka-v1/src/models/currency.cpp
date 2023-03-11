#include "headers/currency.h"

namespace bank::models
{

    currency::currency(std::string *type, long double *amount)
    {
        this->type = type;
        this->amount = amount;
    }

    currency::~currency()
    {
        delete this->type;
        delete this->amount;
    }


}