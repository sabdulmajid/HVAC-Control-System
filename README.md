# SmartTemp HVAC Controller
SmartTemp HVAC Controller is a VHDL-based project designed to interface with and control HVAC systems, specifically tailored for educational purposes or prototype development. The project incorporates various components such as a 7-segment display, a binary counter, and logic to simulate temperature adjustments and displays. It is developed for use with FPGA boards, demonstrating how digital design principles can be applied to real-world applications like temperature control systems.

## Features

- **7-Segment Display Control**: Dynamically displays temperature readings or control states
- **User Input Handling**: Processes input from push-buttons and switches to adjust settings or display modes
- **Modular Design**: Utilizes VHDL components for easy modification or expansion
- **Simulation Compatibility**: Includes a simulation mode for testing and verification without the need for physical hardware

## Installation

Follow these steps to set up the SmartTemp HVAC Controller project:

1. **Clone the Repository**: `https://github.com/sabdulmajid/HVAC-Control-System`
2. **VHDL Development Environment**: Ensure you have a VHDL development environment (e.g., Vivado, Quartus) installed
3. **Open Project**: Use your VHDL development tool to open the project (I used Intel Quartus Prime)

## Usage
After installing and opening the project, you can simulate or upload the design to your FPGA board. The main operations include:

- **Adjusting Temperature**: Use the `switches (sw)` to set the desired temperature
- **Viewing Temperature**: The current temperature setting is displayed on the 7-segment display
- **Simulation**: Set `HVAC_SIM` to `TRUE` in the VHDL code to run simulations

## Contributing
Contributions are welcome! If you have suggestions for improvements or new features, please feel free to follow these steps:

1. Fork the repo
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request, and I will have a look as soon as possible!
