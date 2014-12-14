interface SerialLogger {
  command void incrementSent();
  command void incrementCounter();
  command uint16_t getSent();
  command uint16_t getCounter();
  command void start();
  command void stop();
}
