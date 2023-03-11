#ifndef BANKA_V1_USER_ACCOUNT_H
#define BANKA_V1_USER_ACCOUNT_H

#include <vector>
#include "currency.h"

namespace bank::models
{
    class user_account
    {
        private:
                std::vector<currency*>* users_currencies;

        public:
                user_account();
                ~user_account();
    };
}

#endif //BANKA_V1_USER_ACCOUNT_H
