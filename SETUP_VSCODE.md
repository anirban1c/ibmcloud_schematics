Settings:
    docker.host = ssh://<user>@<docker hostname>

Install ssh remote container and check connection
Install Docker (install on remote container) vscode extensions
Mount remote host dir with sshfs
Checkout https://github.com/anirban1c/ibmcloud_schematics.git


Remote container setup (in dir .devcontainer )
    Update devcontainer.json with project specific details:
    ```
    // abs path to the folder on remote host
    "workspaceMount": "source=/mnt/sde1/apps/oss/ibmcloud_schematics,target=/ibmcloud_schematics,type=bind,consistency=delegated",

    // mount volumes for vscode server extensions
    "mounts": [
		"source=ibmcloud_schematics-vol--here,target=/home/anirban/.vscode-server/extensions,type=volume",
		"source=ibmcloud_schematics-vol--here-insiders,target=/home/anirban/.vscode-server-insiders/extensions,type=volume",
	],
    
    ```