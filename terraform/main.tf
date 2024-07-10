data "vkcs_compute_flavor" "compute" {
  name = var.compute_flavor
}

data "vkcs_images_image" "compute" {
  name = var.image_flavor
}

resource "vkcs_compute_instance" "master" {
  name              = "master"
  flavor_id         = data.vkcs_compute_flavor.compute.id
  key_pair          = var.key_pair_name
  security_groups   = ["all", "default", "ssh"]
  availability_zone = var.availability_zone_name

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 50
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = vkcs_networking_network.network.id
  }

  depends_on = [
    vkcs_networking_network.network,
    vkcs_networking_subnet.subnetwork
  ]
}

resource "vkcs_networking_floatingip" "fip1" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_compute_floatingip_associate" "fip1" {
  floating_ip = vkcs_networking_floatingip.fip1.address
  instance_id = vkcs_compute_instance.master.id
}

output "instance_fip1" {
  value = vkcs_networking_floatingip.fip1.address
}


resource "vkcs_compute_instance" "worker1" {
  name              = "worker1"
  flavor_id         = data.vkcs_compute_flavor.compute.id
  key_pair          = var.key_pair_name
  security_groups   = ["all", "default", "ssh"]
  availability_zone = var.availability_zone_name

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 50
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = vkcs_networking_network.network.id
  }

  depends_on = [
    vkcs_networking_network.network,
    vkcs_networking_subnet.subnetwork
  ]
}

resource "vkcs_networking_floatingip" "fip2" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_compute_floatingip_associate" "fip2" {
  floating_ip = vkcs_networking_floatingip.fip2.address
  instance_id = vkcs_compute_instance.worker1.id
}

output "instance_fip2" {
  value = vkcs_networking_floatingip.fip2.address
}
