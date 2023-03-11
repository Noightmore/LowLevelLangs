#ifndef BANKA_V1_BUSINESS_LOGIC_H
#define BANKA_V1_BUSINESS_LOGIC_H

#include "site_functionality.h"

namespace bank::services
{
    class business_logic : public site_functionality
    {
        public:
            business_logic();
            ~business_logic();
    };
}


#endif //BANKA_V1_BUSINESS_LOGIC_H
