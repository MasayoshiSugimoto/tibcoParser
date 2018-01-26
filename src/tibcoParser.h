#ifndef __TIBCO_PARSER__
#define __TIBCO_PARSER__

#include <string>

#include "logger.h"

namespace TibcoParser
{

class TibcoParser
{
  private:
    static Logger _logger;

  public:
    void parse(const std::string& message);
};

}

#endif
