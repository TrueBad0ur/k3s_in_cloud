# Setup

```bash
cd terraform
tofu apply
```

Then change ip in inventory.yml

The first one from which you got after applying terraform

You also should put it onto the 23-rd line in the inventory file

```bash
cd k3s-ansible
ansible-playbook playbooks/site.yml -i inventory.yml
```

Copy ~/kube/kubeconfig from amster node to local

Change 127.0.0.1 to your master node ip there

That's it!