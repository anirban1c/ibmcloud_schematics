local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;


{
    resource: {

         [if "public_gateway" in  p.resources.vpc then "ibm_is_public_gateway" ] : {
            [p.resources.vpc.public_gateway] : {
                name : std.toString(p.resources.vpc.public_gateway),
                vpc : std.toString("${ibm_is_vpc."+p.resources.vpc.name+".id}"),
                zone : std.toString(p.resources.vpc.zone),
                depends_on : ["ibm_is_vpc."+p.resources.vpc.name]
            }
        },

        ibm_is_vpc_address_prefix : {
            [net.name + "-pfx"] : {
                name : std.toString(net.name),
                zone : std.toString(net.zone),
                vpc : std.toString("${ibm_is_vpc."+p.resources.vpc.name+".id}"),
                cidr : net.ipv4_cidr_block,

                depends_on : ["ibm_is_vpc."+p.resources.vpc.name]
            }
            for net in p.resources.subnets
        },

        ibm_is_subnet : {
            [net.name] : {
                name : net.name,
                vpc: std.toString("${ibm_is_vpc."+p.resources.vpc.name+".id}"),
                resource_group : "${data.ibm_resource_group.all_rg.id}",
                ipv4_cidr_block : std.toString("${ibm_is_vpc_address_prefix."+net.name+"-pfx.cidr}"),
                zone : net.zone,
                timeouts: net.timeouts,
                depends_on : ["ibm_is_vpc."+p.resources.vpc.name, "ibm_is_subnet."+net.name]
            },
            for net in p.resources.subnets

        },

    },


 }