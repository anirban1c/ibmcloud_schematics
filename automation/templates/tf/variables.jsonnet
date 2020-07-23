local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
    variable : {
               [if "source" != var then var] : {
                    default : std.toString(p.resources.modules.vpc_stack[var]),
               },
               for var in std.objectFields(p.resources.modules.vpc_stack)
               if "modules" in p.resources
    }


}