data  "template_file" "k8s" {
  template = "${file("./inventory.tpl")}"
  vars {
    k8s_master_ip = "${aws_instance.k8s_masters.public_ip}"
    k8s_nodes_ip = "${join("\n",aws_instance.k8s_nodes.*.public_ip)}"
  }
}

resource "local_file" "k8s_file" {
  content  = "${data.template_file.k8s.rendered}"
  filename = "../kubeadm_create/hosts"
}
