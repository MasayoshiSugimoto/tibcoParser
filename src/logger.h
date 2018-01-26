#ifndef __LOGGER__
#define __LOGGER__

#include <string>

namespace TibcoParser
{

class Logger
{
  private:
    const std::string _className;

  public:
    Logger(const std::string& className);
    void info(const std::string& message);
};

}

#endif
