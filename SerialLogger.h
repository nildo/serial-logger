#ifndef SERIAL_LOGGER_H
#define SERIAL_LOGGER_H

enum {
  AM_SERIAL_LOG_MESSAGE = 0x71,
  SERIAL_TIMER_PERIOD_MILLI = 250,
};

typedef nx_struct serial_log_message {
  nx_uint16_t nodeid;
  nx_uint16_t sent;
  nx_uint16_t counter;
  nx_uint32_t timestamp;
} serial_log_message_t;

#endif
