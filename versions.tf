terraform {
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.7.0"
    }
  }
}

provider "keycloak" {
  # Configuration options
  client_id = var.local_keycloak_client_id
  client_secret = var.local_keycloak_client_secret
  url = "http://keycloak.localtest.me:8081"
}
