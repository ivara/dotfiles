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

# Function to mount the remote filesystem using sshfs and open it with Neovim
mount_and_edit() {
  local mount_point=~/remote_mount
  mkdir -p $mount_point

  echo "Mounting remote filesystem..."
  sshfs $ssh_user@$ssh_host:/home $mount_point

  echo "Opening remote filesystem with Neovim..."
  nvim $mount_point

  echo "Unmounting remote filesystem..."
  fusermount -u $mount_point
}

# Function to connect to the selected app service using SSH
connect_to_app_service() {
  echo "Connecting to app service: $app_service"
  az webapp ssh --resource-group $resource_group --name $app_service
}

# Function to list app services in the selected resource group
list_app_services() {
  echo "Listing app services in resource group: $resource_group"
  az webapp list --resource-group $resource_group --query '[].{name:name, state:state}' -o table
}

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

# Function to show details of the selected resource
show_resource_details() {
  resource_name=$(echo $resource | awk '{print $1}')
  resource_type=$(echo $resource | awk '{print $2}')
  echo "Fetching details for resource: $resource_name"
  az resource show --resource-group $resource_group --name $resource_name --resource-type $resource_type -o json | jq .
}

# Main script execution
select_resource_group
select_resource
show_resource_details

#connect_to_app_service
