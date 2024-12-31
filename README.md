# Pianoteq on Raspberry Pi with VNC

This repository provides instructions and scripts for running Pianoteq on a Raspberry Pi using a VNC server, with performance optimizations for real-time audio processing.

# Description
The repository contains a configuration setup that:

* Runs Pianoteq through a VNC server for remote graphical interface access.
* Enhances performance using CPU frequency scaling (cpufreq) as described in the [Pianoteq Installation on Raspberry Pi 400](https://docs.google.com/document/d/14xbI4iKRR5cKc3n-qER9-9CAdx-utPxzewIEk4NgpTE/edit?tab=t.0#heading=h.ms8il4u2nm9g).
* Sets real-time priority limits (LimitMEMLOCK and LimitRTPRIO) to optimize audio processing, as recommended in the same guide.

# Setup Instructions
## Download and Install Pianoteq
1. Download the Pianoteq software for ARM from the official Modartt website.
2. Unpack the downloaded archive to a directory such as `/home/pianoteq/Pianoteq 8 STAGE/`.
3. Run the application in CLI mode to activate it:
```bash
cd /home/pianoteq/Pianoteq\ 8\ STAGE/arm-64bit
./Pianoteq\ 8\ STAGE --activate
```

## Configure `.vnc/xstartup`
1. Copy the [`pianoteq.sh`](scripts/pianoteq.sh) script into the home directory of the `pianoteq` user.
2. Place the [`xstartup`](scripts/xstartup) file into the `.vnc` directory under the home directory of the `pianoteq` user.
`pianoteq` user.
3. Check both files and make sure that the paths to the Pianoteq application and the pianoteq.sh script are correct.
4. Make both files executable:
```bash
chmod +x /home/pianoteq/pianoteq.sh
chmod +x /home/pianoteq/.vnc/xstartup
```

## 3. Create the `systemd` Service
1. Place the [`pianoteq.service`](systemd/pianoteq.service) file into the `/etc/systemd/system/` directory to create the systemd unit.
2. Reload `systemd` and enable the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable pianoteq.service
```

# Usage
* Start the Pianoteq Service:
```bash
sudo systemctl start pianoteq.service
```

* Stop the Pianoteq Service
```bash
sudo systemctl stop pianoteq.service
```

* View logs
```bash
sudo journalctl -t pianoteq
```

# References
* [Pianoteq Installation on Raspberry Pi 400](https://docs.google.com/document/d/14xbI4iKRR5cKc3n-qER9-9CAdx-utPxzewIEk4NgpTE/edit?tab=t.0#heading=h.ms8il4u2nm9g): A comprehensive guide detailing the installation process and performance optimization.
* [Pianoteq Forum: Running on Raspberry Pi](https://forum.modartt.com/viewtopic.php?id=7905): A forum discussion exploring user experiences and configurations.
* [Quick Installation and System Tweaks for Pianoteq on Raspberry Pi](https://github.com/youfou/pianoteq-pi/blob/main/setup.py?utm_source=chatgpt.com): A script to streamline the installation and optimization process.
* [Pianoteq 7.2 Running on Raspberry Pi 4](https://youtu.be/tyIvITxxwMs): A video demonstration of Pianoteq's performance on Raspberry Pi.