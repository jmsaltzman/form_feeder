# form_feeder
Use an Amazon Dash button to dispense a sheet of paper from a network printer

### Wait, what?
Sometimes you just want a blank sheet of paper. Especially if you're 4-years-old.

This project uses a network-connected printer, a Raspberry Pi, and an Amazon Dash button to dispense a blank sheet of paper from the printer.

### Why "Form Feed"?

Dot matrix printers used to have a "Form Feed" button, which made them effective blank paper dispensers. For all the sophisticated technology in modern laser and inkjet printers, if you just want a piece of paper, you need to physically pull the paper drawer out, fish out a single piece of paper, and then close it again.


## What You Need

A few things:
1. A network-connected printer. This project was built and tested with a Brother HL-L2340DW, which was a special twist since Brother doesn't publish drivers that work on a Raspberry Pi. Thankfully, @pdewacht published some and when I used the driver for a Brother DCP-7030, it worked.
2. A Raspberry Pi on the LAN. This was built and tested on a Raspberry Pi Zero W 1.1 running Raspbian, with SSH access.
3. An Amazon Dash button. I know you can get the $5 back, and maybe I will, but it was $5, who cares?


## Installing stuff

Short version:

1. Set up printing from the Pi by (mostly) following the instructions at:
https://www.howtogeek.com/169679/how-to-add-a-printer-to-your-raspberry-pi-or-other-linux-computer/
The Brother drivers that CUPS came with didn't work, so I apt installed printer-driver-brlaser.
2. Set up Dash Button press intercepting by following the instructions here:
https://pypi.org/project/amazon-dash
I tried three other ways before that, but this was by far the simplest and it has been 100% reliable.
3. Write a script to print a blank page when the button is pressed, configuring that as the system command to run in the config file:
/etc/amazon-dash.yml
4. Feature creep the script! I added logging, message printing on the page, and Twilio SMS reporting.

More details including the scripts and step-by-step soon.
