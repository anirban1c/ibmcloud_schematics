local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
    data : {
        ibm_schematics_workspace : {
                output : {
                    workspace_id : p.provider.datadog.remote_ds.workspace_id,
                },
        },
        ibm_schematics_output : {
            output : {
                 workspace_id : p.provider.datadog.remote_ds.workspace_id,
                 template_id : "${data.ibm_schematics_workspace.output.template_id.0}",
            }
        },
    },
    output : {
          output_vars : {
                value : "${data.ibm_schematics_output.output.output_values}",
          },
    },

    resource : {
            ibm_is_security_group : {
                [grp.name] : {
                    name : grp.name,
                    [if "vpc" in p.resources then "vpc" ] : std.toString("${ibm_is_vpc."+p.resources.vpc.name+".id}"),
                    [if "modules" in p.resources then "vpc" ] : std.toString("${data.ibm_is_vpc.vpc1.id}"),

                    resource_group : "${data.ibm_resource_group.all_rg.id}",
                }
                for grp in p.resources.dd_sg_access
            },


            ibm_is_security_group_rule : {
                [rule.name+"-1"] : {
                    group : std.toString("${ibm_is_security_group."+grp.name+".id}"),
                    direction : rule.direction,
                    remote : "${data.ibm_schematics_output.output.output_values.agents_ipv4}",

                },
                for grp in p.resources.dd_sg_access
                for rule in grp.rules
           },
       },
}