#!/bin/bash

read -e -p "Enter vSphere username: " vsphere_user
read -e -s -p "Enter vSphere password: " vsphere_password
echo    # New line after password input
read -e -p "Enter vSphere server: " vsphere_server
read -e -p "Enter vSphere datacenter: " vsphere_datacenter
read -e -p "Enter vSphere datastore: " vsphere_datastore
read -e -p "Enter vSphere host: " vsphere_host

# Ask for the number of networks
read -e -p "How many networks do you want? (1/2/3): " count_networks

case $count_networks in
	3)
		read -e -p "Enter vSphere network 1: " vsphere_network1
		read -e -p "Enter vSphere network 2: " vsphere_network2
		read -e -p "Enter vSphere network 3: " vsphere_network3
		;;
	2)
		read -e -p "Enter vSphere network 1: " vsphere_network1
		read -e -p "Enter vSphere network 2: " vsphere_network2
		;;
	1)
		read -e -p "Enter vSphere network: " vsphere_network1
		;;
	*)
		echo "Invalid choice. Exiting."
		exit 1
		;;
esac

read -e -p "Enter vSphere virtual machine name: " vsphere_virtual_machine_name
read -e -p "Enter vSphere virtual machine cpu (ex: 4): " vsphere_virtual_machine_cpu
read -e -p "Enter vSphere virtual machine memory (ex: 8192): " vsphere_virtual_machine_memory
read -e -p "Enter vSphere virtual machine guest id (ex: ubuntu64guest): " vsphere_virtual_machine_guest_id

# Ask for the number of disks
read -e -p "How many disks do you want? (1/2): " count_disks

case $count_disks in
	2)
                read -e -p "Enter vSphere virtual machine disk 1 size (ex: 30): " vsphere_virtual_machine_disk_size1
                read -e -p "Enter vSphere virtual machine disk 2 size (ex: 30): " vsphere_virtual_machine_disk_size2
                ;;
        1)
                read -e -p "Enter vSphere virtual machine disk 1 size (ex: 30): " vsphere_virtual_machine_disk_size1
                ;;
        *)
                echo "Invalid choice. Exiting."
                exit 1
                ;;
esac

read -e -p "Enter vSphere virtual machine image: (ex: ubuntu-20.04.5-live-server-amd64.iso) " vsphere_virtual_machine_image

# Apply configuration with tofu
tofu apply -var "vsphere_user=${vsphere_user}" -var "vsphere_password=${vsphere_password}" -var "vsphere_server=${vsphere_server}" -var "vsphere_datacenter=${vsphere_datacenter}" -var "vsphere_datastore=${vsphere_datastore}" -var "vsphere_host=${vsphere_host}" \
    -var "vsphere_network1=${vsphere_network1}" -var "vsphere_network2=${vsphere_network2}" -var "vsphere_network3=${vsphere_network3}" -var "vsphere_virtual_machine_name=${vsphere_virtual_machine_name}" -var "vsphere_virtual_machine_cpu=${vsphere_virtual_machine_cpu}" \
    -var "vsphere_virtual_machine_memory=${vsphere_virtual_machine_memory}" -var "vsphere_virtual_machine_guest_id=${vsphere_virtual_machine_guest_id}" -var "vsphere_virtual_machine_disk_size1=${vsphere_virtual_machine_disk_size1}" \
    -var "vsphere_virtual_machine_disk_size2=${vsphere_virtual_machine_disk_size2}" -var "vsphere_virtual_machine_image=${vsphere_virtual_machine_image}"

