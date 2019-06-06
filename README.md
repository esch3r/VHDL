# VHDL syntax basics 

## PRIMARY DESIGN UNIT MODEL STRUCTURE - 
Each VHDL design unit comprises an "entity" declaration and one or more "architectures". Each architecture defines a different implementation or model of a given design unit. The entity definition defines the inputs to, and outputs from the module, and any "generic" parameters used by the different implementations of the module.
Entity Declaration Format - Back To Top
    entity  name  is
        port( port definition list );-- input/output signal ports
        generic( generic list);   -- optional generic list
    end name;
Port declaration format: port_name: mode data_type;
The mode of a port defines the directions of the singals on that pirt, and is one of: in, out, buffer, or inout.

Port Modes:
An in port
can be read but not updated within the module, carrying information into the module. (An in port cannot appear on the left hand side of a signal assignment.)
An out port


