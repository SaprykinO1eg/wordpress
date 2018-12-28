Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
	# host_1 WEB
  config.vm.define "web" do |web|
	web.vm.box = "ubuntu/xenial64"
	web.vm.hostname = "web"
	web.vm.network "private_network", ip: "192.168.100.10"
	
	config.vm.provider "virtualbox" do |web|
	  web.name = "web"
	  web.cpus = "1"
	  web.memory = "1024"
	end
	web.vm.provision "shell", path: "web.sh"  
  end
  
  # host-2 DB
  config.vm.define "db" do |db|
	db.vm.box = "ubuntu/xenial64"
	db.vm.hostname = "db"
	db.vm.network "private_network", ip: "192.168.100.11"
	
	config.vm.provider "virtualbox" do |db|
	  db.name = "db"
	  db.cpus = "1"
	  db.memory = "1024"
	end  
	db.vm.provision "shell", path: "db.sh"  
  end
end
