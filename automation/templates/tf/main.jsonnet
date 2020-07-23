local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

local modules = import "modules.jsonnet";
local provider = import "provider.jsonnet";
local data = import "data.jsonnet";
local schematics = import "schematics.jsonnet";
local access = import "access.jsonnet";
local vpc = import "vpc.jsonnet";
local subnets = import "subnets.jsonnet";
local fips = import "fips.jsonnet";
local vsis = import "vsis.jsonnet";
local variables = import "variables.jsonnet";
local output = import "output.jsonnet";
local dd_sg_access = import "dd_sg_access.jsonnet";


local name_in_resources(name) = "resources" in p && name in p.resources;
local needs_dd_acces(name) = "dd_sg_access" in p.resources && name in p.resources;

{
    "schematics" : schematics,
    "provider.tf": provider,
    "output.tf" : output,
    [if name_in_resources("data") then "data.tf"] : data,
    [if name_in_resources("access") then "access.tf"] : access,
    [if needs_dd_acces("dd_sg_access") then "dd_sg_access.tf"] : dd_sg_access,
    [if name_in_resources("vpc") then "vpc.tf"] : vpc,
    [if name_in_resources("subnets") then "subnets.tf"] : subnets,
    [if name_in_resources("vsis") then "vsis.tf"] : vsis,
    [if name_in_resources("fips") then "fips.tf"] : fips,
    //[if "access" in p.resources then "access.tf"] : access,
    [if "modules" in p.resources then "modules.tf"]: modules,
    [if "modules" in p.resources then "variables.tf"]: variables
}