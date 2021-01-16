

resource "azurerm_kubernetes_cluster" "example" {
  name                = "${var.prefix}-k8s"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"
  dns_prefix          = "${var.prefix}-k8s"
  kubernetes_version  = "1.19.3"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
  }

  

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = "fserise"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size               = "Standard_F4s"
  node_count            = 1

  tags = {
    Environment = "kube"
  }
}

