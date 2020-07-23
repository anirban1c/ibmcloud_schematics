
local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;


{
  "name": inv.parameters.schematics.workspace.name,
  "type": [inv.parameters.schematics.workspace.type],
  "description": inv.parameters.schematics.workspace.desc,
   "resource_group": inv.parameters.envs.vpcs.resource_group,
  "tags": [inv.parameters.tags],
  "template_repo": {
    "url": inv.parameters.schematics.workspace.url,
    "branch": inv.parameters.schematics.workspace.branch
  },
  "template_data": [
    {
      "folder": inv.parameters.schematics.workspace.folder,
      "type": inv.parameters.schematics.workspace.type,
      [ if "modules" in p.resources then "values_metadata" ]: [
              {
                  name : var,
                  type : "string",
                  //value : std.toString(p.resources.modules.vpc_stack[var]),
              },
              for var in std.objectFields(p.resources.modules.vpc_stack)
              if "modules" in p.resources
           ],

      [ if "modules" in p.resources then "variablestore" ]: [
        {
            name : var,
            value : std.toString(p.resources.modules.vpc_stack[var]),
        },
        for var in std.objectFields(p.resources.modules.vpc_stack)
        if "modules" in p.resources
      ]
    }
  ]
}


