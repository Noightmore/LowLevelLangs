#ifndef BANKA_V1_EXCHANGERATES_H
#define BANKA_V1_EXCHANGERATES_H


#include "Currency.h"

namespace bank::models
{
    class ExchangeRates : public Currency
    {
        public:
            ExchangeRates();
            ~ExchangeRates();
    };
}


#endif //BANKA_V1_EXCHANGERATES_H
