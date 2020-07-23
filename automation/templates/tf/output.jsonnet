local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;


{
    output  : {


      [ if "datadog_readonly" in p.kapitan.labels then d] : {
            value : "tolist(${data.datadog_ip_ranges."+inv.parameters.kapitan.labels.datadog_readonly+"."+d+"})[0]"
        },
        for d in p.provider.datadog.ipv4_ranges
      },



}