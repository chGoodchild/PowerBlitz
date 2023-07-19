# Project Name: Raspberry Pi Integration with BraiinsOS++ Miner and Google Home Assistant

## Overview
This GitHub repository aims to facilitate the integration of a BraiinsOS++ Bitcoin miner into the RaspiBlitz system, allowing for demand response with solar panels. The primary objective is to utilize excess solar power by ramping up the miners whenever the batteries cannot store the surplus energy. Additionally, the project intends to implement job negotiation to verify the blocks that the miner is working on.

## Scripts in the Repository

### 1. `discover_miner.sh`
This script utilizes nmap to display the IP address of the connected miners. It aids in identifying the BraiinsOS++ miner's location on the network.

### 2. `setup_home_assistant.sh`
This script focuses on installing and configuring the Google Home Assistant on the RaspiBlitz. It enables seamless integration between the RaspiBlitz, BraiinsOS++ miner, and Google Home Assistant.

## Project Objective
The project's primary objective is to integrate the BraiinsOS++ Bitcoin miner with the RaspiBlitz and Google Home Assistant. By doing so, we enable demand response with solar panels. The RaspiBlitz system will efficiently utilize excess solar power by ramping up the miners when batteries cannot store the surplus energy. This integration enhances the overall energy efficiency of the system and optimizes Bitcoin mining operations.

## Note
Please be aware that some of the scripts in this repository might not be functioning as intended, as this project is a work in progress. The integration of the BraiinsOS++ miner with the RaspiBlitz and Google Home Assistant is an ongoing development, and efforts are being made to improve and enhance its functionality.

## Contribution
We welcome contributions from the community to further enhance the project's capabilities and functionality. If you encounter any issues or have ideas for improvements, feel free to submit pull requests or raise issues in this repository.

## Disclaimer
The scripts provided in this repository are intended for educational and experimental purposes. Users should exercise caution and understand the potential risks associated with using these scripts with real mining equipment. The project maintainers are not responsible for any damages or losses that may arise from the use of these scripts. Always ensure you have the necessary permissions and take appropriate safety measures when dealing with mining hardware and systems.

## License
This project is distributed under the terms of the MIT License. For more information, refer to the `LICENSE` file in this repository.
# BFGBlitz