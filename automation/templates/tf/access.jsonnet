local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
    //data : {
    //    ibm_resource_group : {
    //        all_rg : {
    //            name : p.envs.vpcs.resource_group
    //        }
    //    },
    //    ibm_is_vpc : {
    //        vpc1 : {
    //            name : p.name
    //        }
    //    }
    //},

    resource : {
        ibm_is_security_group : {
            [grp.name] : {
                name : grp.name,
                [if "vpc" in p.resources then "vpc" ] : std.toString("${ibm_is_vpc."+p.resources.vpc.name+".id}"),
                [if "modules" in p.resources then "vpc" ] : std.toString("${data.ibm_is_vpc.vpc1.id}"),

                resource_group : "${data.ibm_resource_group.all_rg.id}",
            }
            for grp in p.resources.access
        },


        ibm_is_security_group_rule : {
            [rule.name] : {
                group : std.toString("${ibm_is_security_group."+grp.name+".id}"),
                direction : rule.direction,
                remote : rule.remote,
                [if "proto" in rule then rule.proto] : {
                    "port_min" : rule.port_min,
                    "port_max" : rule.port_max
                }
            }
            for grp in p.resources.access
            for rule in grp.rules

        },

    },




}
