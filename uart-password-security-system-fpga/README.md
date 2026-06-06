## UART-Based Password Security System on FPGA

## Overview

This project implements a UART-Based Password Security System using Verilog HDL on an FPGA. The system allows a user to enter a 4-digit password through a serial terminal, verifies the entered password against a stored password, and provides authentication feedback through UART communication.

To enhance security, the system tracks consecutive failed login attempts and enters a lock state after three incorrect password entries. The design also supports password updating through UART communication.


## Features

* UART-based password authentication
* 4-digit password verification
* SUCCESS and FAIL status messages
* Three-attempt lock mechanism
* Buzzer activation during lock state
* Password update through UART
* FSM-based control architecture
* Verilog HDL implementation
* FPGA verified



## System Architecture

The system consists of the following modules:

* UART Receiver
* RX Controller
* Comparator
* FSM Controller
* Counter
* Timer
* Message Controller
* UART Transmitter
* Buzzer Control

### Authentication Flow

1. User enters a password through a serial terminal.
2. UART Receiver receives serial data.
3. RX Controller forms the password.
4. Comparator verifies the password.
5. FSM determines SUCCESS, FAIL, or LOCK condition.
6. Message Controller generates status messages.
7. UART Transmitter sends responses back to the terminal.



## FSM States

* IDLE
* INPUT
* VERIFY
* SUCCESS
* FAIL
* LOCK
* UPDATE_VERIFY
* UPDATE_PASSWORD



## Password Update Flow

1. User sends update command (`U`).
2. System enters update mode.
3. Existing password is verified.
4. User enters a new password.
5. Stored password is updated.
6. New password is used for future authentication.

---

## Project Structure

```text
src/
├── main.v
├── uart.v
├── uart_receiver.v
├── rx_controller.v
├── comparator.v
├── fsm.v
├── counter.v
├── timers.v
└── message_controller.v
```



## Tools Used

* Verilog HDL
* Xilinx Vivado
* FPGA Development Board
* UART Serial Terminal


## Sample UART Output

Correct Password:

```text
2222
SUCCESS
```

Incorrect Password:

```text
1111
FAIL
```

Lock Condition:

```text
1111
1111
1111
LOCK
```

Password Update:

```text
u
2222
1111
PASSWORD UPDATED
```


## Future Enhancements

* ENTER PASSWORD prompt
* ENTER OLD PASSWORD prompt
* ENTER NEW PASSWORD prompt
* EEPROM/BRAM password storage
* LCD/OLED display interface
* Multiple user support
* Encrypted password storage



## Author

Vivek Saradhi
B.Tech – Electronics and Communication Engineering (ECE)



## License

This project is intended for educational and learning purposes.

