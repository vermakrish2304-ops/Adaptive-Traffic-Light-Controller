# 🚦 4-Way Adaptive Traffic Light Controller

> A Moore FSM-based adaptive traffic light controller with 
> emergency vehicle override, implemented in Verilog HDL.

---

## 📌 Overview

This project implements a 4-way intersection traffic light 
controller as a **Moore Finite State Machine** in Verilog. 
The controller dynamically adjusts green signal duration based 
on real-time traffic density and includes an emergency vehicle 
override mechanism with direction-aware control.

---

## ✨ Features

- ✅ 4-directional control — North, South, East, West
- ✅ Adaptive green time based on traffic density
  - 🟢 Low traffic → 3 clock cycles
  - 🟡 Normal traffic → 6 clock cycles
  - 🔴 High traffic → 9 clock cycles
- ✅ Emergency vehicle override with directional green signal
- ✅ Synchronous reset
- ✅ 9-state FSM with clean state transitions

---

## 🧠 FSM Design

| Parameter | Details |
|-----------|---------|
| FSM Type | Moore Machine |
| Total States | 9 |
| State Encoding | 4-bit binary |
| Clock | Synchronous |
| Reset | Active High |

### States
| State | Description |
|-------|-------------|
| north_green_s | North green, others red |
| north_yellow_s | North yellow, others red |
| south_green_s | South green, others red |
| south_yellow_s | South yellow, others red |
| east_green_s | East green, others red |
| east_yellow_s | East yellow, others red |
| west_green_s | West green, others red |
| west_yellow_s | West yellow, others red |
| emergency_s | Direction-aware emergency override |

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| AMD Vivado | RTL Design, Simulation, Synthesis |
| Verilog HDL | Hardware Description Language |

---

## 📁 File Structure
4-Way-Traffic-Light-Controller/

│

├── traffic_light.v          # Main RTL design module

├── traffic_light_tb.v       # Testbench for simulation

├── traffic_light_tb_behav.wcfg  # Vivado waveform config

└── README.md

---

## ▶️ How to Run

1. Open **AMD Vivado** and create a new project
2. Add `traffic_light.v` as design source
3. Add `traffic_light_tb.v` as simulation source
4. Run **Behavioral Simulation**
5. Load `traffic_light_tb_behav.wcfg` to view waveforms

---

## 📊 Module I/O

### Inputs
| Signal | Width | Description |
|--------|-------|-------------|
| clk | 1-bit | System clock |
| reset | 1-bit | Active high reset |
| traffic_low | 1-bit | Low traffic condition |
| traffic_normal | 1-bit | Normal traffic condition |
| traffic_high | 1-bit | High traffic condition |
| emergency_vehicle | 1-bit | Emergency override trigger |
| emergency_direction | 2-bit | Direction of emergency vehicle |

### Outputs
| Signal | Width | Description |
|--------|-------|-------------|
| north/south/east/west_red | 1-bit each | Red signals |
| north/south/east/west_green | 1-bit each | Green signals |
| north/south/east/west_yellow | 1-bit each | Yellow signals |

---

## 🏫 About

**Institution:** Birla Institute of Technology, Mesra
**Department:** Electronics & Communication Engineering
**Batch:** 2028
