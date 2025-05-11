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
