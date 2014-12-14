#include "SerialLogger.h"
#include "Timer.h"

module SerialLoggerP {
  provides {
    interface SerialLogger;
  }
  uses {
    interface Timer<TMilli>;
    interface AMSend as SerialSend;
  }
}

implementation {
  uint16_t sentA = 0;
  uint16_t counterA = 0;
  
  uint16_t sent = 0;
  uint16_t counter = 0;
  
  message_t sBuf;
  
  command void SerialLogger.incrementSent() {
    sent++;
  }
  
  command void SerialLogger.incrementCounter() {
    counter++;
  }
  
  command uint16_t SerialLogger.getSent() {
    return sent;
  }
  
  command uint16_t SerialLogger.getCounter() {
    return counter;
  }
  
  command void SerialLogger.start() {
    call Timer.startPeriodic(SERIAL_TIMER_PERIOD_MILLI);
  }
  
  command void SerialLogger.stop() {
    call Timer.stop();
  }
  
  event void Timer.fired() {
    if (sent != sentA || counter != counterA) {
      serial_log_message_t * s_msg = (serial_log_message_t *) call SerialSend.getPayload(&sBuf, sizeof(serial_log_message_t));
      s_msg->nodeid = TOS_NODE_ID;
      s_msg->sent = sent;
      s_msg->counter = counter;
      s_msg->timestamp = call Timer.getNow();
      call SerialSend.send(AM_BROADCAST_ADDR, &sBuf, sizeof(serial_log_message_t));
      sentA = sent;
      counterA = counter;
    }
  }
  
  event void SerialSend.sendDone(message_t * msg, error_t error) {
  }
  
  //default command void Timer.startPeriodic(uint32_t dt) { }
}
