local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;


{

    resource: {
        ibm_is_vpc : {
            [p.resources.vpc.name] : {
                name : p.resources.vpc.name,
                resource_group : "${data.ibm_resource_group.all_rg.id}",
            }
        }

    }



}