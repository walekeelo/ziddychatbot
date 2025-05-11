provider "azurerm" {
  features {}
}

# Get existing resource group
data "azurerm_resource_group" "milanRG" {
  name = "milanRG"
}

# Create the Azure OpenAI cognitive account
resource "azurerm_cognitive_account" "ziddy_openai" {
  name                = "ziddyopenai"
  location            = data.azurerm_resource_group.milanRG.location
  resource_group_name = data.azurerm_resource_group.milanRG.name
  kind                = "OpenAI"
  sku_name            = "S0"

  tags = {
    environment = "production"
  }
}

# Deploy the GPT model
resource "azurerm_cognitive_deployment" "ziddy_gpt" {
  name                 = "ziddy-gpt"
  cognitive_account_id = azurerm_cognitive_account.ziddy_openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo"
    version = "0613" # Adjust to the version you want, if available
  }

  sku {
    name     = "Standard"
    capacity = 1
  }
}
