# -*- mode: ruby -*-
# vim: set ft=ruby :

bootstrap = <<SCRIPT
  useradd -m jaels --groups wheel -s /bin/bash
  mkdir /home/jaels/.ssh && chown -R jaels:jaels /home/jaels/
  curl --silent https://github.com/renderqwerty.keys >> /home/jaels/.ssh/authorized_keys
  echo "%jaels ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jaels
  su -c "printf 'sudo su jaels\n' >> .bash_profile" -s /bin/sh vagrant
SCRIPT

MACHINES = {
  :otuslinux => {
        :box_name => "centos/7",
        :ip_addr => '192.168.11.101',
	:disks => {
		:sata1 => {
			:dfile => './sata1.vdi',
			:size => 250,
			:port => 1
		},
		:sata2 => {
                        :dfile => './sata2.vdi',
                        :size => 250, # Megabytes
			:port => 2
		},
                :sata3 => {
                        :dfile => './sata3.vdi',
                        :size => 250,
                        :port => 3
                },
                :sata4 => {
                        :dfile => './sata4.vdi',
                        :size => 250, # Megabytes
                        :port => 4
                }

	}

		
  },
}

Vagrant.configure("2") do |config|

MACHINES.each do |boxname, boxconfig|

config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        #box.vm.network "forwarded_port", guest: 3260, host: 3260+offset

        box.vm.network "private_network", ip: boxconfig[:ip_addr]
        box.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=775,fmode=664"]
        box.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", "1024"]
                needsController = false
                boxconfig[:disks].each do |dname, dconf|
                        unless File.exist?(dconf[:dfile])
                        vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                        needsController =  true
                        end

                end
                if needsController == true
                vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                boxconfig[:disks].each do |dname, dconf|
                        vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                end
                end
        end
        box.vm.provision "shell", inline: "#{bootstrap}", privileged: true
        box.vm.provision "shell", inline: <<-SHELL
        mkdir -p ~root/.ssh
        cp ~vagrant/.ssh/auth* ~root/.ssh
        yum install -y mdadm smartmontools hdparm gdisk
        SHELL
        box.vm.provision "ansible_local" do |ansible|
                ansible.become = true
                ansible.playbook = "ansible/site.yml"
                ansible.galaxy_role_file = "ansible/roles/requirements.yml"
                ansible.galaxy_roles_path = "/etc/ansible/roles"
                ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path}"
                ansible.limit = 'all,localhost'
                ansible.verbose = true
        end
      end
  end
end
