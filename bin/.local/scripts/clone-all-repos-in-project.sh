#!/bin/bash
VERBOSE_MODE=false;
DRY_RUN=false;
BACKUP_SUCCESS=true;

#Get all parameters
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -d|--directory)
      CLONE_ROOT_PATH="$2"
      shift # past argument
      shift # past value
      ;;
    -o|--organization)
      ORGANIZATION="$2"
      shift # past argument
      shift # past value
      ;;
    -p|--project)
      PROJECT="$2"
      shift # past argument
      shift # past value
      ;;
#    -r|--retention)
#      RETENTION_DAYS="$2"
#      shift # past argument
#      shift # past value
#      ;;
    -v|--verbose)
      VERBOSE_MODE=true
      shift # past argument
      ;;
    -x|--dryrun)
      DRY_RUN=true
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
echo "=== Clone all repositories in project ==="
echo "=== v.0.0.1 =="

set -- "${POSITIONAL[@]}" # restore positional parameters

echo "=== Script parameters"
#echo "PAT               = ${PAT}"
echo "ORGANIZATION_URL  = ${ORGANIZATION}"
echo "BACKUP_ROOT_PATH  = ${BACKUP_ROOT_PATH}"
echo "RETENTION_DAYS    = ${RETENTION_DAYS}"
echo "DRY_RUN           = ${DRY_RUN}"
echo "PROJECT_WIKI      = ${PROJECT_WIKI}"
echo "VERBOSE_MODE      = ${VERBOSE_MODE}"

#Store script start time
start_time=$(date +%s)

#Install the Devops extension
#echo "=== Install DevOps Extension"
#az extension add --name 'azure-devops'

#Set this environment variable with a PAT will 'auto login' when using 'az devops' commands
#echo "=== Set AZURE_DEVOPS_EXT_PAT env variable"
#export AZURE_DEVOPS_EXT_PAT=${PAT} 
#Store PAT in Base64
#B64_PAT=$(printf "%s"":${PAT}" | base64)

#echo "=== Get project list"
echo "Cloning all repos for project '${PROJECT}' in organization '${ORGANIZATION}'"
ReposList=$(az repos list --organization ${ORGANIZATION} --project ${PROJECT})

#Create backup folder with current time as name
#BACKUP_FOLDER=$(date +"%Y%m%d%H%M")
#BACKUP_DIRECTORY="${BACKUP_ROOT_PATH}/${BACKUP_FOLDER}"
#mkdir -p "${BACKUP_DIRECTORY}" && cd $_
#echo "=== Backup folder created [${BACKUP_DIRECTORY}]"

# TODO: check if folder already exists
#mkdir ${PROJECT}

#Initialize counters
REPO_COUNTER=0

for repo in $(echo "${ReposList}" | jq -r '.[] | @base64'); do
    _jqR() {
    	echo ${repo} | base64 -d | jq -r ${1}
    }
    
    echo $(_jqR '.name')
    # Use Base64 PAT in header to authenticate on Git Repository?
    git clone $(_jqR '.webUrl')
done

