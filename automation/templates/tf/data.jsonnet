local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
    data : {
            ibm_resource_group : {
                all_rg : {
                    name : p.resources.data.resource_group
                }
            },
            ibm_is_image : {
                ds_image : {
                    name : p.resources.data.image,
                 }
            },
            [if "ssh_key" in p.resources.data then "ibm_is_ssh_key" ]  : {
                ssh_keys : {
                    //count : std.length(p.resources.data.ssh_keys),
                    name : p.resources.data.ssh_keys.key,
                 }
            },
            [if "ssh_key1" in p.resources.data then "ibm_is_ssh_key" ]  : {
                    ssh_key1 : {
                    //count : std.length(p.resources.data.ssh_keys),
                    name : p.resources.data.ssh_key1.key,
                    }
             },
            [if "modules" in p.resources then "ibm_is_vpc" ] : {
                vpc1 : {
                    name : p.resources.modules.vpc_stack.vpc_name
                }
            },

            [ if "datadog_readonly" in inv.parameters.kapitan.labels then "datadog_ip_ranges"] : {
                    [inv.parameters.kapitan.labels.datadog_readonly] : {

                }
              },

        },

}




