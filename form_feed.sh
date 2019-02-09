#!/bin/bash

FF_DIR="$HOME/form_feed"  # directory for form feed files

RC_FILE="$FF_DIR/ffrc"  # resource file
PAYLOAD_FILE="$FF_DIR/payload.txt"  # payload to print
LOG_FILE="$FF_DIR/ff.log"  # log file

# Source resource file
if [ -f $RC_FILE ]; then
  echo "RC file found"
  source $RC_FILE
else
  echo "RC file $RC_FILE not found"
  exit 1
fi

# Form the message
FF_MESSAGE=""
if [ "$PRINT_MESSAGE" = true ]; then
  if [ "$PRINT_PREFIX" = true ]; then
    FF_MESSAGE+=$PREFIX
    FF_MESSAGE+=" "
  fi
  if [ "$PRINT_DATE" = true ]; then
    FF_MESSAGE+=`date $DATE_FORMAT`
    FF_MESSAGE+=" "
  fi
  if [ "$PRINT_SUFFIX" = true ]; then
    FF_MESSAGE+=$SUFFIX
  fi
fi
#echo $FF_MESSAGE

# Create payload file
echo $FF_MESSAGE | tee $PAYLOAD_FILE

# Log usage
LOG_MESSAGE="Form fed at "
LOG_MESSAGE+=`date`
echo $LOG_MESSAGE
if [ -f $LOG_FILE ]; then
  echo $LOG_MESSAGE >> $LOG_FILE
else
  echo $LOG_MESSAGE > $LOG_FILE
fi
if ! [[ $FF_MESSAGE = "" ]]; then
  echo "  Payload = \"$FF_MESSAGE\"" >> $LOG_FILE
fi

# Send a text
TWILIO_COMMAND="twilio-sms"
if [ "$SEND_TWILIO_SMS" = true ]; then
  echo "SEND_TWILIO_SMS is true..."
  echo "TWILIO_COMMAND is $TWILIO_COMMAND"
  #if [[ -x $TWILIO_COMMAND ]]; then
  #  echo "Sending SMS via Twilio to $SMS_RECEIVER"
    echo "$LOG_MESSAGE" | $TWILIO_COMMAND $SMS_RECEIVER
  #else
  #  echo "Failed -x test for $TWILIO_COMMAND"  
  #fi
else
  echo "SEND_TWILIO_SMS is NOT true (???)"
fi

# Print payload file
lp -d $PRINTER_NAME $PAYLOAD_FILE

# Clean up
sleep 2
rm $PAYLOAD_FILE
