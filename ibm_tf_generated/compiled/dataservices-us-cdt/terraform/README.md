

# AO IBMCLOUD Platform 
### IBM Cloud Schematics Workspace

> Project :  dataservices-us-cdt
> Environment :   cdt
> Region : us-east


### VPC Stack
    
    VPC with classic access enabled : dataservices-us-cdt   
    3 VSI on each zone in Region : us-east    
    3 Subnets     
    1 Jump Host
    1 VPC public gateway
    
    Pre-defined CIDR's and prefixes :
       
         

###Pre-defined CIDR's and prefixes : 

```json
        {'eu-de': {'cidrs': {'eu-de-1': '10.116.1.0/24', 'eu-de-2': '10.116.2.0/24', 'eu-de-3': '10.116.3.0/24'}}, 'jp-tok': {'cidrs': {'jp-tok-1': '10.116.4.0/24', 'jp-tok-2': '10.116.5.0/24', 'jp-tok-3': '10.116.6.0/24'}}, 'us-east': {'cidrs': {'us-east-1': '10.116.7.0/24', 'us-east-2': '10.116.8.0/24', 'us-east-3': '10.116.9.0/24'}}}
```



### Module source
    source : ../../../tf-modules/tf-vpc-module-with-bastion
     

#### Terrafrom Directory structure 

Each project has a standard structure

Repo : https://eu-de.git.cloud.ibm.com/iaas/dataservices 

```commandline
compiled/dataservices-us-cdt % tree .
.
├── scripts
│   ├── schematics.sh
│   └── terraform.sh (Do not use this, for testing only)
└── terraform
    ├── access.tf.json
    ├── data.tf.json
    ├── modules.tf.json
    ├── provider.tf.json
    ├── schematics.json
    └── variables.tf.json

2 directories, 8 files
```

Workspace name : dataservices-us-cdt

Entire Schematics workspace is generated, 
(manual changes will be lost, if not checked into templates) 

```commandline
── terraform
    ├── schematics.json
```

Project subfolder compiled/dataservices-us-cdt/terraform

(a) Security Groups are listed in

```commandline
── terraform
    ├── access.tf.json
```

(b) Read only datasources

```commandline
── terraform
    ├── data.tf.json
```
(c) IBM Provider

```commandline
── terraform
    ├── provider.tf.json
``` 

(d) Modules and their parameters 

```commandline
── terraform
    ├── modules.tf.json
```

### passing in values to override each variable can be
### done in UI setting tab or updating the templates to
### generate the entire project structure itself. 

( Using a locally built docker image, details in iaas/docker folder)

Docker image : anirban1c/ic-schematics

Environment keys exported via -e

Running schematics workspace cli
```commandline
% docker run -it \
  -e X_FEATURE_SANDBOX=true \
  -e SCHEMATICSGITTOKEN=$IBM_GITLAB_PAT \
  -e IBMCLOUD_API_KEY=$TF_CDT_IBMCLOUD_APIKEY \
  -v "$(pwd):$(pwd)" \
  -w $(pwd) \
  --user $(id -u):$(id -g) \
  anirban1c/ic-schematics <commands>

```

## Terraform IaaS module resource access:
    1. Create a SSH key via the console.ibm.com UI or CLI
    2. Update settings -> variable (vpc_ssh_keys) to list 
        all the values
    3. Save, Plan and then Apply to update VSI's
    4. Get the bastion/jump host external IP from UI or CLI
    5. ssh into the VSI hosts 
        ssh -v -F ~/.ssh/ibmcloud_config -i ~/.ssh/id_rsa  \
                -J root@1<jump host IP> root@<zoned VSI IP>
 
 
 Author: @anirban.chatterjee
 Date Built: []
 References: []