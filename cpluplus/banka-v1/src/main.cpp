#include "services/SiteFunctionality.h"
#include "services/BusinessLogic.h"

// sonar cloud = free code analyzer
// add maven to project


    int main()
    {
            bank::services::SiteFunctionality* website;
            website = new bank::services::BusinessLogic();

            website->run();

            return 0;
    }

