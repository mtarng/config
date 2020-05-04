# Pipeline for onboarding a new tenant.
# First step, read from list of counties (Variable Group variable)
# For each country, check if there exists a keyvault secret
# If not, then create one
# Create new release for the country

set -uxo pipefail

# Source helper functions
. helper.sh

echo $KEYVAULT_NAME

echo $COUNTRIES
REQUIRED_VARIABLES="secret"
IFS=',' read -ra CON <<< "$COUNTRIES"
for c in "${CON[@]}"; do
  echo $c
  get_or_create_primero_secrets $KEYVAULT_NAME $c
done

