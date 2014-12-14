#include "SerialLogger.h"

configuration SerialLoggerC {
  provides interface SerialLogger;
}

implementation {
  components SerialLoggerP;
  
  components new TimerMilliC();
  SerialLoggerP.Timer -> TimerMilliC;
  
  components new SerialAMSenderC(AM_SERIAL_LOG_MESSAGE);
  SerialLoggerP.SerialSend -> SerialAMSenderC;
  
  SerialLogger = SerialLoggerP.SerialLogger;
}
