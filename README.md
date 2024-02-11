# SmartTemp HVAC Controller
SmartTemp **HVAC** (Heating, Ventilation, and Air Conditioning) Controller is a **VHDL-based** project designed to interface with and control HVAC systems, specifically tailored for prototype development. The project incorporates various components such as a **7-segment display**, a **binary counter**, and logic to simulate temperature adjustments and displays. It is developed for use with FPGA boards, demonstrating how digital design principles can be applied to real-world applications like temperature control systems.

## Features

- **7-Segment Display Control**: Dynamically displays temperature readings or control states
- **User Input Handling**: Processes input from push-buttons and switches to adjust settings or display modes
- **Modular Design**: Utilizes VHDL components for easy modification or expansion
- **Simulation Compatibility**: Includes a simulation mode for testing and verification without the need for physical hardware

## System Overview

  ![image](https://github.com/sabdulmajid/HVAC-Control-System/assets/85283195/1d1f7295-95dc-4977-bd44-494c4bc2d1ee)


## Installation

Follow these steps to set up the SmartTemp HVAC Controller project:

1. **Clone the Repository**: `https://github.com/sabdulmajid/HVAC-Control-System`
2. **VHDL Development Environment**: Ensure you have a VHDL development environment (e.g., Vivado, Quartus) installed
3. **Open Project**: Use your VHDL development tool to open the project (I used Intel Quartus Prime)

## State Machine Diagram

  ![StateDiagram](https://github.com/sabdulmajid/HVAC-Control-System/assets/85283195/fb87ea4b-c93c-4d53-9f47-1c9ad5d70f6f)

The provided diagram is a visual representation of the state machine for the HVAC system's control program. Each node, denoted by a circle, corresponds to a distinct state the system may enter during its operation cycle. These nodes are interconnected by directional arrows, which symbolize the potential transitions between states. Such transitions are triggered by specific system events or conditions being met.

In essence, the diagram acts as a blueprint for the system's sequential flow and decision-making process.

## Usage
After installing and opening the project, you can simulate or upload the design to your FPGA board. The main operations include:

- **Adjusting Temperature**: Use the `switches (sw)` to set the desired temperature
- **Viewing Temperature**: The current temperature setting is displayed on the 7-segment display
- **Simulation**: Set `HVAC_SIM` to `TRUE` in the VHDL code to run simulations

## Configuration

To configure the SmartTemp HVAC Controller for usage, follow these guidelines:

- **Temperature Range**: Customize the temperature range within the VHDL code to match HVAC system requirements
- **Display Settings**: Adjust the 7-segment display settings to accommodate your preference for temperature units (Celsius or Fahrenheit) and display brightness
- **Input Settings**: Map the physical push-buttons and switches on your FPGA board to the project's input handling logic for temperature adjustments and mode selections

## Hardware Compatibility

The SmartTemp HVAC Controller is designed to be compatible with a wide range of FPGA boards. It has been tested on the **Intel Cyclone V SoC** FPGA board, but the code is cross-compatible with other FPGA boards. If you are using a different FPGA board, adjustments may be required for pin configurations or resource allocations. Please refer to your board's documentation for specific adaptation instructions.

## Contributing
Contributions are welcome! If you have suggestions for improvements or new features, please feel free to follow these steps:

1. Fork the repo
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request, and I will have a look as soon as possible!
