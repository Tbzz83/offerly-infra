locals {
  client_name = "offerly"
}

data "keycloak_realm" "realm" {
    realm = "homelab"
}

resource "keycloak_openid_client" "openid_client" {
    realm_id  = data.keycloak_realm.realm.id
    client_id = local.client_name

    name    = local.client_name
    enabled = true
    full_scope_allowed = false

    access_type           = "CONFIDENTIAL"
    standard_flow_enabled = true
    implicit_flow_enabled = false
    valid_redirect_uris = [
        "http://localhost:3000/api/openid-callback",
        "http://localhost:3000/api/auth/openid-callback",
        "http://localhost:3000/api/auth/callback",
    ]

    login_theme = "keycloak"
    consent_required = true

    extra_config = {
    }
}

resource "keycloak_realm" "realm" {
  realm   = "my-realm"
  enabled = true
}

resource "keycloak_openid_client_scope" "offers_scope" {
  realm_id               = data.keycloak_realm.realm.id
  name                   = "offers.get"
  include_in_token_scope = true
}

resource "keycloak_openid_client_optional_scopes" "client_optional_scopes" {
  realm_id  = data.keycloak_realm.realm.id
  client_id = keycloak_openid_client.openid_client.id
  optional_scopes = [
    keycloak_openid_client_scope.offers_scope.name
  ]
}
