# Reference to the existing resource group (milanRG)
data "azurerm_resource_group" "milanRG" {
  name = "milanRG"
}

# Create a new Cognitive Account within the existing resource group
resource "azurerm_cognitive_account" "ziddy_openai" {
  name                = "ziddyopenai"  # Choose a unique name for your Cognitive Account
  location            = data.azurerm_resource_group.milanRG.location
  resource_group_name = data.azurerm_resource_group.milanRG.name
  kind                = "OpenAI"
  sku_name            = "S0"  # Adjust SKU based on your needs

  tags = {
    environment = "production"
  }
}

# Cognitive Deployment Resource using the newly created Cognitive Account
resource "azurerm_cognitive_deployment" "ziddy_gpt" {
  name                  = "ziddy-gpt"
  cognitive_account_id  = azurerm_cognitive_account.ziddy_openai.id
  
  model {
    format              = "OpenAI"
    name                = "gpt-35-turbo"  # Ensure the model name is correct
    version             = "0301"           # Version of the model (adjust as needed)
  }

  scale {
    type                = "Standard"
  }
}
