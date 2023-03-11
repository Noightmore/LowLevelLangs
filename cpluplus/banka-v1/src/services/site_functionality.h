#ifndef BANKA_V1_SITE_FUNCTIONALITY_H
#define BANKA_V1_SITE_FUNCTIONALITY_H

// purely virtual class

namespace bank::services
{
    class site_functionality
    {
        public:
            virtual void registerUser() = 0;
            virtual void loginUser() = 0;
            virtual void logoutUser() = 0;
            virtual void depositMoney() = 0;
            virtual void withdrawMoney() = 0;
            virtual void transferMoney() = 0;
            virtual void viewAccountBalance() = 0;
            virtual void viewAccountStatement() = 0;
            virtual void viewAccountStatementByDate() = 0;
            virtual void viewAccountStatementByType() = 0;
            virtual void viewAccountStatementByDateAndType() = 0;
            virtual void viewAccountStatementByDateRange() = 0;
    };
}

#endif //BANKA_V1_SITE_FUNCTIONALITY_H
