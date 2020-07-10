# ibmcloud_schematics
Automation : VPC on Gen 2 with VSI, subnets FIP and SG rules for access, Datadog &amp; ansible


Schematics: Terraform as service from IBM
Datadog agents installed for monitoring
example Ansible playbook for installing a cassandra cluster and default monitors
VPC with classic access - this allows networking with classic back place resources
3 regions, each with 3 zones and 1 VSI in each zone
1 block per VSI
1 public GW
1 bastion host with SG rules to access all the VSI's
Add defined ssh keys 
Add site specific IP's for public access

Framework to generate all environment specifc Terraform 
Config management of resources

TODO:

Create a DS for Datadog exposed IP's that can be referenced for all ACL/SG rules
