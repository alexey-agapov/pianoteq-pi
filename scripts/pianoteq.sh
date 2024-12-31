#!/bin/bash

log_message() {
    logger -t pianoteq "[Pianoteq] $1"
}

log_message "Starting Pianoteq script..."

# Trap for cleanup on exit or termination signals
trap 'log_message "Received termination signal. Reverting CPU frequency..."; \
      sudo cpufreq-set -c 0 -g ondemand; \
      sudo cpufreq-set -c 1 -g ondemand; \
      sudo cpufreq-set -c 2 -g ondemand; \
      sudo cpufreq-set -c 3 -g ondemand; \
      log_message "Cleanup complete."; exit' SIGTERM SIGINT

# Set CPU to performance mode
log_message "Setting CPU frequency to performance mode."
sudo cpufreq-set -c 0 -g performance
sudo cpufreq-set -c 1 -g performance
sudo cpufreq-set -c 2 -g performance
sudo cpufreq-set -c 3 -g performance

# Run Pianoteq
log_message "Starting Pianoteq application."
/home/pianoteq/Pianoteq\ 8\ STAGE/arm-64bit/Pianoteq\ 8\ STAGE --multicore max --fullscreen

# Log completion (this will only be reached if Pianoteq exits cleanly)
log_message "Pianoteq application exited."
