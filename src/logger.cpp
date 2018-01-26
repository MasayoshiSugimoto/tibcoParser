#include <string>
#include <iostream>

#include "logger.h"

namespace TibcoParser
{

Logger::Logger(const std::string& className): _className(className) { }

void Logger::info(const std::string& message)
{
  std::cout << '[' << _className << "] " << message << "\n";
}

}
