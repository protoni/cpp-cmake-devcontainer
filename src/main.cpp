// Example program
#include <iostream>
#include <string>

/**
 * @brief Parsing status
*/
struct CommandLineParseStatus {
    enum class Code { Init, Ok, Error, VersionRequested, HelpRequested };

    Code code;
    std::string error;

    explicit CommandLineParseStatus(Code status, const std::string& err = "")
        : code(status), error(err) {}
};

/**
 * @brief Parse command line arguments
 * 
 * This is a test function to test returning a statust object from
 * a function scope.
 * @param opt Test option so that different objects can be returned to caller
 * @return Parsing status
*/
CommandLineParseStatus parse(int opt) {
    using Code = CommandLineParseStatus::Code;

    if (opt == 0)
        return CommandLineParseStatus(Code::Init);

    if (opt == 1)
        return CommandLineParseStatus(Code::Ok);

    return CommandLineParseStatus(Code::Error);
}

/**
 * @brief This is the main entrypoint
*/
int main() {
    CommandLineParseStatus status = parse(0);

    if (status.code == CommandLineParseStatus::Code::Init)
        std::cout << "OK" << std::endl;
}