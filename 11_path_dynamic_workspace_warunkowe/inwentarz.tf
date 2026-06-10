resource "local_file" "inwentarz_ansible" {
  filename = "${path.module}/inwentarz/hostyaws.yaml"
 
  content = yamlencode({
    all = {
      children = {
        webservery = {
          hosts = merge(
            { for idx, srv in aws_instance.lekcja5_ec2_srv : "sztokholm-${idx}" => { ansible_host = srv.public_ip } },
            {
              frankfurt = { ansible_host = aws_instance.lekcja5_eu-central-1_ec2_srv.public_ip }
              londyn    = { ansible_host = aws_instance.lekcja5_eu-west-2_ec2_srv.public_ip }
            }
          )
          vars = {
            ansible_user                 = "ubuntu"
            ansible_ssh_private_key_file = "./testowyklucz"
            ansible_ssh_common_args      = "-o StrictHostKeyChecking=no"
            ansible_python_interpreter   = "/usr/bin/python3"
          }
        }
      }
    }
  })
}