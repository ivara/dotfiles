#!/bin/bash

CACHE_FILE="$HOME/.cache/azure-apps.json"
REFRESH_SCRIPT="$HOME/.cache/refresh-azure-apps.sh"

mkdir -p "$(dirname "$CACHE_FILE")"

# Om ingen cache finns, visa "laddar ..."

if [[ ! -f "$CACHE_FILE" ]]; then
  echo "Fetching App Services from Azure for the first time..."
  az webapp list --query "[].{name:name, rg:resourceGroup}" -o json >"$CACHE_FILE"
fi

# Skapa refresh-script om den inte finns
if [[ ! -f "$REFRESH_SCRIPT" ]]; then
  cat >"$REFRESH_SCRIPT" <<EOF
#!/bin/bash
az webapp list --query "[].{name:name, rg:resourceGroup}" -o json >"$CACHE_FILE"
EOF
  chmod +x "$REFRESH_SCRIPT"
  nohup "$REFRESH_SCRIPT" >/dev/null 2>&1 &
fi

# Kör uppdatering i bakgrunden, tyst
"$REFRESH_SCRIPT" >/dev/null 2>&1 &

# Läs från cache
apps=$(jq -r '.[] | "\(.name)\t\(.rg)"' "$CACHE_FILE")

# Om det inte finns några appar, visa "inga appar"
if [[ -z "$apps" ]]; then
  echo "No App Services found."
  exit 1
fi

# FZF-meny för att välja app
selected_app=$(echo "$apps" | fzf --height 40% --reverse --inline-info --header "Select an App Service")

# Om inget valdes, avsluta
if [[ -z "$selected_app" ]]; then
  echo "No App Service selected."
  exit 1
fi

# Extrahera namn och resursgrupp
app_name=$(echo "$selected_app" | cut -f1)
app_rg=$(echo "$selected_app" | cut -f2)

# Anslut till appen med SSH
az webapp ssh --name "$app_name" --resource-group "$app_rg"
