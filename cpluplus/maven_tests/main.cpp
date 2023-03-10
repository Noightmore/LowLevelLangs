#include <iostream>
using namespace std;

int main () {

        std::string input;
        std::getline(std::cin, input);

        std::string name;
        std::size_t pos = input.find("name=");
        if (pos != std::string::npos) {
                name = input.substr(pos + 5); // Skip "name=" prefix
        }

        cout << "content-type: text/html\r\n\r\n";
        cout << "<html>\n";
        cout << "<head>\n";
        cout << "<title>Hello World - First CGI Program</title>\n";
        cout << "</head>\n";
        cout << "<body>\n";
        cout << "<h2>Hello" + name + "</h2>\n";
        cout << "</body>\n";
        cout << "</html>\n";

        return 0;
}