# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']

MACHINES = {
  :otuslinux => {
        :box_name => "centos/7",
        :ip_addr => '192.168.11.101',
	:disks => {
		:sata1 => {
			:dfile => home + '/VirtualBox VMs/sata1.vdi',
			:size => 250,
			:port => 1
		},
		:sata2 => {
                        :dfile => home + '/VirtualBox VMs/sata2.vdi',
                        :size => 250, # Megabytes
			:port => 2
		},
                :sata3 => {
                        :dfile => home + '/VirtualBox VMs/sata3.vdi',
                        :size => 250,
                        :port => 3
                },
                :sata4 => {
                        :dfile => home + '/VirtualBox VMs/sata4.vdi',
                        :size => 250, # Megabytes
                        :port => 4
                },
                :sata5 => {
                        :dfile => home + '/VirtualBox VMs/sata5.vdi',
                        :size => 250, # Megabytes
                        :port => 5
                }
	}
  }
}

Vagrant.configure("2") do |config|
        if Vagrant.has_plugin?("vagrant-vbguest")
                config.vbguest.auto_update = false
        end

MACHINES.each do |boxname, boxconfig|

config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s
        #box.vm.network "forwarded_port", guest: 3260, host: 3260+offset
        box.vm.network "private_network", ip: boxconfig[:ip_addr]
        box.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ['.git*', '*.vdi'], rsync__verbose: "true"
        box.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "4", "--cpuexecutioncap", "70"]
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
        box.vm.provision "ansible_guest", type: "ansible_local" do |ansible_guest|
                ansible_guest.become = true
                ansible_guest.playbook = "ansible/site.yml"
                ansible_guest.galaxy_role_file = "ansible/roles/requirements.yml"
                ansible_guest.galaxy_roles_path = "/etc/ansible/roles"
                #ansible_guest.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path}"
                ansible_guest.limit = 'all,localhost'
                ansible_guest.verbose = true
        end
        box.vm.provision "raid_array", type: "shell", path: "raid/create_raid_array.sh"
        box.vm.provision "unit_upload", type: "file", source: "raid/raid.mount", destination: "/tmp/raid.mount"
        box.vm.provision "systemd_unit", type: "shell", path: "raid/create_systemd_unit.sh"
        box.vm.provision "show_result", type: "shell", path: "raid/check.sh"
      end
  end
end
