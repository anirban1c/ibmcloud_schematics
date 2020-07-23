local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;


{
     resource: {
         ibm_is_instance : {
             [i.name] : {
                 name : i.name,
                 vpc: std.toString("${ibm_is_vpc."+p.resources.vpc.name+".id}"),
                 resource_group : "${data.ibm_resource_group.all_rg.id}",
                 zone : i.zone,
                 profile: i.profile,
                 primary_network_interface : {
                    subnet : std.toString("${ibm_is_subnet."+i.net_primary+".id}"),
                 },

                 network_interfaces : {
                    name : "eth1",
                    subnet : std.toString("${ibm_is_subnet."+i.net_secondary+".id}"),
                 },

                 keys : ["${data.ibm_is_ssh_key.ssh_key1.id}"],
                 image : "${data.ibm_is_image.ds_image.id}",
                 timeouts: i.timeouts
             }
             for i in p.resources.vsis
         }
     },

  }