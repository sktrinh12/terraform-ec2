[webservers]
%{ for ip in ips ~}
${name} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=${path}
%{ endfor ~}
