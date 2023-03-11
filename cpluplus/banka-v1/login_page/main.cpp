#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

// the logins page route should be http://localhost/cgi-bin/login_page.cgi
#define USER_ACCOUNT_ROUTE "/cgi-bin/banka_v1.cgi"

// get the current devices ip address
std::string get_private_ip_address()
{
        struct ifaddrs *ifap, *ifa;
        struct sockaddr_in *sa;
        char *addr;

        if (getifaddrs(&ifap) == -1)
        {
                std::cerr << "Error getting network interfaces.\n";
                return "";
        }

        for (ifa = ifap; ifa != nullptr; ifa = ifa->ifa_next)
        {
                if (ifa->ifa_addr->sa_family != AF_INET) continue;

                sa = (struct sockaddr_in*) ifa->ifa_addr;
                addr = inet_ntoa(sa->sin_addr);

                if (std::strcmp(addr, "127.0.0.1") == 0) continue;

                // found a non-loopback address
                std::string ip_address(addr);
                freeifaddrs(ifap);
                return ip_address;
        }

        freeifaddrs(ifap);
        std::cerr << "Error finding non-loopback address.\n";
        return "";
}

int main()
{
        std::string ip_address = get_private_ip_address();

        std::cout << "Content-Type: text/html\n\n";
        std::cout << "<html lang=\"en\">\n";
        std::cout << "<head>\n";
        std::cout << "<meta charset=\"UTF-8\">\n";
        std::cout << "<title>Bank</title>\n";
        std::cout << "<style>\n";
        std::cout << "body {\n";
        std::cout << "  background-color: #f2f2f2;\n";
        std::cout << "  font-family: Arial, sans-serif;\n";
        std::cout << "}\n";
        std::cout << "h1 {\n";
        std::cout << "  color: #3d3d3d;\n";
        std::cout << "}\n";
        std::cout << "p {\n";
        std::cout << "  font-size: 18px;\n";
        std::cout << "  color: #606060;\n";
        std::cout << "}\n";
        std::cout << "label {\n";
        std::cout << "  display: block;\n";
        std::cout << "  margin-bottom: 10px;\n";
        std::cout << "  color: #3d3d3d;\n";
        std::cout << "}\n";
        std::cout << "input[type=\"text\"] {\n";
        std::cout << "  padding: 10px;\n";
        std::cout << "  font-size: 16px;\n";
        std::cout << "  border: none;\n";
        std::cout << "  border-radius: 5px;\n";
        std::cout << "  background-color: #f9f9f9;\n";
        std::cout << "  box-shadow: inset 1px 1px 3px rgba(0,0,0,0.1);\n";
        std::cout << "}\n";
        std::cout << "input[type=\"submit\"] {\n";
        std::cout << "  background-color: #4CAF50;\n";
        std::cout << "  color: white;\n";
        std::cout << "  padding: 12px 20px;\n";
        std::cout << "  border: none;\n";
        std::cout << "  border-radius: 5px;\n";
        std::cout << "  font-size: 16px;\n";
        std::cout << "  cursor: pointer;\n";
        std::cout << "}\n";
        std::cout << "input[type=\"submit\"]:hover {\n";
        std::cout << "  background-color: #3e8e41;\n";
        std::cout << "}\n";
        std::cout << "</style>\n";
        std::cout << "</head>\n";
        std::cout << "<body>\n";
        std::cout << "<h1>Welcome To The Bank</h1>\n";
        std::cout << "<p>Please login</p>\n";
        std::cout << "<form action=\"http://" + ip_address + USER_ACCOUNT_ROUTE + "\" method=\"post\">\n";
        std::cout << "<label for=\"name\">Name:</label>\n";
        std::cout << "<input type=\"text\" name=\"name\" id=\"name\">\n";
        std::cout << "<label for=\"password\">Password:</label>\n";
        std::cout << "<input type=\"text\" name=\"password\" id=\"password\">\n";
        std::cout << "<input type=\"submit\" value=\"Submit\">\n";
        std::cout << "</form>\n";
        std::cout << "</body>\n";
        std::cout << "</html>\n";

        return 0;
}




