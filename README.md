# Assembly_Project
Motor Cafe is a program written in assembly language, that simulate the gas station system.
The Project As Small Parts: 
- Data Structure and Initialization
  1. Store vehicle information (ID,fuel,price)
- User Input and Validation
  1. Display a menu to the user to select a vehicle
  2.  2. Validate
 3. How many liters?
 4. Validate
- Fuel Type Determination
  1. Diesel or Petrol or Gas?
- Cost Calculation
  1. The total cost of the fuel based on the quantity and price per liter.
- Output Display
  1. Calculate the total cost.
- Calculate Fueling Time
   1. 2 second/liter
   2. Store the result
- Implement An Alarm
  1. INT 1Ch interrupt to generate a system timer tick
  2. Set up a counter to count the time ticks
 3. When the counter reaches the fueling time, trigger the alarm
- Progress Bar Or Timer (if we have enough time)
