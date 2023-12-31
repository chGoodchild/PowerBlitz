# Project Name: RaspberryBlitz Integration with BraiinsOS++ Miner and Google Home Assistant

## Overview
This GitHub repository was initially created for integrating a BraiinsOS++ miner with a RaspiBlitz, enabling demand response with solar panels. The primary objective was to utilize excess solar power by ramping up the miners whenever the batteries couldn't store surplus energy. While the project was started, development shifted to a fork of a charge controller interface for faster results.

## Future Plans
This repository is now intended for future integration work, specifically a nixified setup for integrating the BraiinsOS++ miner into Home Assistant. The other repo will house a nixified integration of the charge controller into Home Assistant so that it can be used to drive the miner in a modular fashion.

## Repository Contents

### 1. `discover_miner.sh`
This script utilizes nmap to display the IP address of connected miners, aiding in identifying the BraiinsOS++ miner's location on the network.

### 2. `setup_home_assistant.sh`
This script focuses on installing and configuring Home Assistant on the RaspiBlitz. It aims to establish seamless integration between the RaspiBlitz, BraiinsOS++ miner, and the charge controller interface.

## Project Objectives
* The primary objective is to demonstrate demand response in a home setting and gather data around performance, cost savings, efficiency and the amount of stranded energy that was monetized.
* A secondary objective is to use StratumV2 job negotiation to point the hashrate at block headers from the RaspiBlitz while still getting frequent payouts from a pool.


## Note
Please be aware that some scripts in this repository might not function as intended, as this project is a work in progress. The integration of the BraiinsOS++ miner and the charge controller interface with Home Assistant is ongoing, with continuous efforts to improve and enhance functionality.

## Contribution
Community contributions are welcome to further enhance the project's capabilities. If you encounter issues or have ideas for improvements, feel free to submit pull requests or raise issues in this repository.

## Disclaimer
The scripts provided in this repository are intended for educational and experimental purposes. Users should exercise caution and understand the potential risks associated with using these scripts with real mining equipment and charge controllers. The project maintainers are not responsible for any damages or losses that may arise from the use of these scripts. Always ensure you have the necessary permissions and take appropriate safety measures when dealing with mining hardware and systems.

## License
This project is distributed under the terms of the MIT License. For more information, refer to the `LICENSE` file in this repository.
