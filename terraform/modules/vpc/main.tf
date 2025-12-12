resource "azurerm_virtual_network" "vpc" {
  name                = var.network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.network_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "backend_public_ip" {
  name                = "backend_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "backend_network_security_group" {
  name                = "backend_network_security"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "ssh_access_from_everywhere_to_backend"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "backend_network_interface" {
  name                = "backend_network_interface"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.backend_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "backend_nic_to_nsg_association" {
  network_interface_id      = azurerm_network_interface.backend_network_interface.id
  network_security_group_id = azurerm_network_security_group.backend_network_security_group.id
}

resource "azurerm_public_ip" "database_public_ip" {
  name                = "database_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "database_network_interface" {
  name                = "database_network_interface"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "db_ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.database_public_ip
  }
}

resource "azurerm_network_security_group" "database_network_security_group" {
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  name                = "database_network_security"

  security_rule {
    name                       = "SSH_from_everywhere_to_database"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Access_to_DB_from_backend"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3306"
    source_address_prefix      = azurerm_network_interface.backend_network_interface.private_ip_address
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "database_nic_to_nsg_association" {
  network_interface_id      = azurerm_network_interface.database_network_interface.id
  network_security_group_id = azurerm_network_security_group.database_network_security_group
}
