provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "existing_rg" {
  name = "milanRG"
}

resource "azurerm_cognitive_account" "ziddy_openai" {
  name                = "ziddyopenaiacct"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  kind                = "OpenAI"
  sku_name            = "S0"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_cognitive_deployment" "ziddy_gpt" {
  name                 = "ziddy-gpt-deployment"
  cognitive_account_id = azurerm_cognitive_account.ziddy_openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo"
    version = "0613"
  }

  sku {
    name     = "S0"
    capacity = 1
  }

  scale_type = "Standard"
}
