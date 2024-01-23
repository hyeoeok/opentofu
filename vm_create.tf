provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network1" {
  name          = var.vsphere_network1
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network2" {
  name          = var.vsphere_network2
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network3" {
  name          = var.vsphere_network3
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_virtual_machine_name
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.vsphere_virtual_machine_cpu
  memory           = var.vsphere_virtual_machine_memory
  guest_id         = var.vsphere_virtual_machine_guest_id

  network_interface {
    network_id = data.vsphere_network.network1.id
  }

  network_interface {
    network_id = data.vsphere_network.network2.id
  }

  network_interface {
    network_id = data.vsphere_network.network3.id
  }

  disk {
    label = "disk0"
    size  = var.vsphere_virtual_machine_disk_size1
    unit_number = 0
  }

  disk {
    label = "disk1"
    size  = var.vsphere_virtual_machine_disk_size2
    unit_number = 1
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path        = var.vsphere_virtual_machine_image
  }
}

