
local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();


{
  provider: {
    ibm: {
      version: inv.parameters.provider.ibm.required_version,
      generation: inv.parameters.provider.ibm.vpc.generation,
      region: inv.parameters.region
    },
    [ if "datadog_readonly" in inv.parameters.kapitan.labels then "datadog"] : {
        validate : false,
        api_key : "",
        app_key : ""
    }
  },


  terraform: {
      required_version: inv.parameters.provider.ibm.required_version,
    },
}