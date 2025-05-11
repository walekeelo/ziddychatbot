provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "milanRG" {
  name     = "milanRG"
  location = "Canada Central"
}

# Azure OpenAI Resource
resource "azurerm_cognitive_account" "openai" {
  name                = "ziddyopenai"
  location            = azurerm_resource_group.milanRG.location
  resource_group_name = azurerm_resource_group.milanRG.name
  kind                = "OpenAI"
  sku_name            = "S0"
}

# Deployment of GPT model (e.g., gpt-35-turbo)
resource "azurerm_cognitive_deployment" "ziddy_gpt" {
  name                 = "ziddygpt"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format = "OpenAI"
    name   = "gpt-35-turbo"
    version = "0613"
  }
  scale {
    type = "Standard"
  }
}
