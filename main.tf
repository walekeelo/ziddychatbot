data "azurerm_resource_group" "milanRG" {
  name = "milanRG"
}

resource "azurerm_cognitive_account" "ziddy_openai" {
  name                = "ziddyopenai"  
  location            = data.azurerm_resource_group.milanRG.location
  resource_group_name = data.azurerm_resource_group.milanRG.name
  kind                = "OpenAI"  # Use OpenAI for deploying GPT models
  sku_name            = "S0"      # Adjust SKU based on your needs

  tags = {
    environment = "production"
  }
}

resource "azurerm_cognitive_deployment" "ziddy_gpt" {
  name                  = "ziddy-gpt-deployment"  # Name of the deployment
  cognitive_account_id  = azurerm_cognitive_account.ziddy_openai.id
  
  model {
    name                = "gpt-3.5-turbo"         # Specify the model (e.g., GPT-3.5 or GPT-4)
    version             = "2023-03-15"            # Version of the model
  }

  scale {
    type                = "Standard"              # Choose the scaling type as needed
  }
}
