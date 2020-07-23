local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p =  inv.parameters;

#This file can be modifed to enforce the necessary convention
{
    module: {
      [module]: p.resources.modules[module],

      for module in std.objectFields(p.resources.modules)

    }
}