local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;


{

    resource: {
        ibm_is_floating_ip : {
            [p.resources.fips.name] : {
                name : p.resources.fips.name,
                resource_group : "${data.ibm_resource_group.all_rg.id}",
                target: std.toString("${ibm_is_instance."+p.resources.fips.target+".primary_network_interface.0.id}"),
                timeouts: p.resources.fips.timeouts
            }
        }
    }

}