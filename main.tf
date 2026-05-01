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

    access_type           = "CONFIDENTIAL"
    standard_flow_enabled = true
    implicit_flow_enabled = false
    valid_redirect_uris = [
        "http://localhost:3000/api/openid-callback",
        "http://localhost:3000/api/auth/openid-callback",
        "http://localhost:3000/api/auth/callback",

    ]

    login_theme = "keycloak"

    extra_config = {
    }
}
