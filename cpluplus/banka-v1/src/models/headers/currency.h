#ifndef BANKA_V1_CURRENCY_H
#define BANKA_V1_CURRENCY_H

#include <string>

namespace bank::models
{
    class currency
    {
        private:
                std::string* type;
                long double* amount;

        public:
                currency(std::string* type, long double* amount);
                ~currency();
    };

}
#endif //BANKA_V1_CURRENCY_H
