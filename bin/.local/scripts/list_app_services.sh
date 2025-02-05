#!/bin/bash

# To find VM's in a resource group
# az vm list --output table

# Function to select a resource group using fzf
select_resource_group() {
  echo "Fetching resource groups..."
  resource_group=$(az group list --query '[].name' -o tsv | fzf --prompt="Select a resource group: ")
  if [ -z "$resource_group" ]; then
    echo "No resource group selected. Exiting."
    exit 1
  fi
  echo "Selected resource group: $resource_group"
}

# Function to list app services in the selected resource group and select one using fzf
select_app_service() {
  echo "Fetching app services in resource group: $resource_group..."
  app_service=$(az webapp list --resource-group $resource_group --query '[].name' -o tsv | fzf --prompt="Select an app service: ")
  if [ -z "$app_service" ]; then
    echo "No app service selected. Exiting."
    exit 1
  fi
  echo "Selected app service: $app_service"
}

# Function to connect to the selected app service using SSH
connect_to_app_service() {
  echo "Connecting to app service: $app_service"
  az webapp ssh --resource-group $resource_group --name $app_service
}

# Function to get the SSH information for the selected app service
get_ssh_info() {
  echo "Fetching SSH information for app service: $app_service"
  ssh_user="root" # Default SSH user for Azure App Services
  ssh_host=$(az webapp show --resource-group $resource_group --name $app_service --query 'defaultHostName' -o tsv)
  if [ -z "$ssh_host" ]; then
    echo "Failed to retrieve SSH host information. Exiting."
    exit 1
  fi
  echo "SSH user: $ssh_user"
  echo "SSH host: $ssh_host"
}

# Function to get SSH connection details
get_ssh_details() {
  # Get the SSH connection details using Azure CLI
  SSH_DETAILS=$(az webapp create-remote-connection --resource-group "$RESOURCE_GROUP" --name "$APP_SERVICE" --query "[ip, port]" -o tsv)
  SSH_IP=$(echo "$SSH_DETAILS" | awk '{print $1}')
  SSH_PORT=$(echo "$SSH_DETAILS" | awk '{print $2}')
  echo "SSH IP: $SSH_IP"
  echo "SSH Port: $SSH_PORT"
}
# network_watcher() {
# 	# Utföra felsökning direkt från CLI: Felsök nätverk, trafik eller status för tjänster:
# 	az webapp show --name <app-name> --resource-group <resursgrupp-namn>
# 	az network watcher test-connectivity --source-resource <app-id> --destination-port 443
# }

# Function to mount the remote filesystem using sshfs and open it with Neovim
mount_and_edit() {
  # Create a temporary directory
  TMP_DIR=$(mktemp -d)
  echo "Created temporary directory: $TMP_DIR"
  # local mount_point=~/remote_mount
  # mkdir -p $mount_point

  echo "Mounting remote filesystem..."
  # sshfs $ssh_user@$ssh_host:/home $mount_point
  sshfs -p "$SSH_PORT" "$SSH_USER@$SSH_IP:/home" "$TMP_DIR"

  if [ $? -ne 0 ]; then
    echo "Failed to mount the file system"
    rmdir "$TMP_DIR"
    exit 1
  fi

  # echo "Mounted Azure App Service file system to $TMP_DIR"
  echo "Opening remote filesystem with Neovim..."
  vv $TMP_DIR

  echo "Unmounting remote filesystem..."
  fusermount -u $mount_point
}

tail_appservice_log() {
  echo "Tailing app service log"
  az webapp log tail --name $app_service --resource-group $resource_group --verbose
}

list_appsettings() {
  echo "Listing appsettings for $app_service"
  az webapp config appsettings list --name $app_service --resource-group $resource_group
}
# # Function to list app services in the selected resource group
# list_app_services() {
#   echo "Listing app services in resource group: $resource_group"
#   az webapp list --resource-group $resource_group --query '[].{name:name, state:state}' -o table
# }

# Function to list resources in the selected resource group and select one using fzf
select_resource() {
  echo "Fetching resources in resource group: $resource_group..."
  resource=$(az resource list --resource-group $resource_group --query '[].{name:name, type:type}' -o tsv | fzf --prompt="Select a resource: ")
  if [ -z "$resource" ]; then
    echo "No resource selected. Exiting."
    exit 1
  fi
  echo "Selected resource: $resource"
}

list_old_resources() {
  # Beräkna datum ett år tillbaka
  one_year_ago=$(date -d "-1 year" +%Y-%m-%d)
  "Fetching resources not updated since $one_year_ago"
  # Använd detta datum i din az cli-fråga
  az resource list --resource-group $resource_group --query "[?tags.lastUpdated < '${one_year_ago}']"
}

monitor_network() {
  echo "Monitoring network for resource: $resource ..."
  az monitor metrics list --resource-group $resource_group --resource $resource --metric "Network In" --interval PT1M
}
# Function to show details of the selected resource
show_resource_details() {
  resource_name=$(echo $resource | awk '{print $1}')
  resource_type=$(echo $resource | awk '{print $2}')
  echo "Fetching details for resource: $resource_name"
  az resource show --resource-group $resource_group --name $resource_name --resource-type $resource_type -o json | jq .
}

# 1. select resource
# 2. select app_service
# 3. select action: list appsettings, tail log, connect (ssh)
#
# Main script execution
select_resource_group
select_app_service
connect_to_app_service
# mount_and_edit
# list_old_resources
#select_resource
#monitor_network
#select_resource
#show_resource_details
#tail_appservice_log
#list_appsettings
