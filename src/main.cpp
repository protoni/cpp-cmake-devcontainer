// Example program
#include <iostream>
#include <string>

struct CommandLineParseStatus {
    enum class Code { Init, Ok, Error, VersionRequested, HelpRequested };

    Code code;
    std::string error;

    explicit CommandLineParseStatus(Code status, const std::string& err = "")
        : code(status), error(err) {}
};

CommandLineParseStatus parse(int opt) {
    using Code = CommandLineParseStatus::Code;

    if (opt == 0)
        return CommandLineParseStatus(Code::Init);

    if (opt == 1)
        return CommandLineParseStatus(Code::Ok);

    return CommandLineParseStatus(Code::Error);
}

int main() {
    CommandLineParseStatus status = parse(0);

    if (status.code == CommandLineParseStatus::Code::Init)
        std::cout << "OK" << std::endl;
}