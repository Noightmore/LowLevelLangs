#ifndef BANKA_V1_BANK_H
#define BANKA_V1_BANK_H

#include <vector>
#include "user_account.h"

namespace bank::models
{
    class bank
    {
        private:
            std::vector<user_account*>* users;
            std::vector<currency*>* available_currencies;

    };
}

#endif //BANKA_V1_BANK_H
