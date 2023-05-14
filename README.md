Source file locations
=====================
The five pipeline stages are contained in:
```
.\VstageProcessor\src\main\scala\ChiselRISC\stages
```
All the sub components such Hazard Control, Forwarding Unit, etc. are found in:
```
.\VstageProcessor\src\main\scala\ChiselRISC\components
```
In the above folder there is also a subfolder:
```
.\components\memory
```
Which contains, InstructionMemory, InstructionMemoryFPGA, which is used for FPGA implementation

The interfaces and instEnum, where the later contains the different decoded instructions definitions
are located in:
```
.\VstageProcessor\src\main\scala\ChiselRISC\utilities
```
Found in this folder is also how, function that converts binary files to sequences of big ints.

Test file locations
===================
The five pipeline stage unit tests are contained in:
```
.\VstageProcessor\src\test\scala\ChiselRISC\stages
```
All the unit tests for both the sub components and the memories are found in:
```
.\VstageProcessor\src\test\scala\ChiselRISC\test_components
```
In the utilities folder, are functions that help taking assembly code and write it directly to
instruction memory for testing purposes.
```
.\VstageProcessor\src\test\scala\ChiselRISC\utilities
```

Verilog files and constraints
=============================
These files are found in:
```
.\VstageProcessor\Verilog
```

Assembly Programs
=================
These files are found in:
```
.\VstageProcessor\asm
```

Running the Simulation
======================
The current implementation uses sbt, as such navigating to the directory .\VStageProcessor and typing:
```
sbt test
```
Would compile and execute all the included unit tests.

Implementing VStageProcessor on an FPGA
==============================
First navigate to:
``` 
.\VstageProcessor\src\main\scala\ChiselRISC\stages\IF.scala
```
In this Chisel code, comment out:
``` 
val instMem = Module(new InstructionMemory(depth, datawidth))
```
And then uncomment:
``` 
val instMem = Module(new InstructionMemoryFPGA(depth, datawidth, init))
```
To implement and synthesize VStageProcessor for an FPGA, it is done as follows:
First generate the Verilog code by navigating to .\VStageProcessor and typing:
```
sbt "runMain TopFile --target-dir Verilog"  
```
The verilog code will then be generated and contained in .\VStageProcessor\Verilog
In this folder will be both the Verilog code and the Xilinx Basys3 constraints file, that allows for
FPGA implementation on the Basys3 FPGA board.

Using Xilinx Vivado to synthesise the FPGA implementation is neccessary.
