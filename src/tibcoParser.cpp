#include <iostream>

#include "tibcoParser.h"

namespace TibcoParser
{

Logger TibcoParser::_logger("TibcoParser");

void TibcoParser::parse(const std::string& message)
{
  _logger.info(message);
}

}
