Vagrant.configure("2") do |config|
  config.vm.define "db" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.provision "docker", images: [ "redis" ] do |docker|
      docker.run "redis",
      args: "-p 6379:6379"
    end
    node.vm.network "forwarded_port", guest: 6379, host: 6379
    node.vm.network :private_network, :ip => "192.168.0.1"
  end

  config.vm.define "web" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.provision "docker", images: [ "thomrick/click-count" ] do |docker|
      docker.run "thomrick/click-count",
        args: "-p 8080:8080 --add-host redis:192.168.0.1"
    end
    node.vm.network "forwarded_port", guest: 8080, host: 8080
    node.vm.network :private_network, :ip => "192.168.0.2"
    node.vm.provision :hosts do |provisioner|
      provisioner.autoconfigure = true
      provisioner.sync_hosts = true
      provisioner.add_host "192.168.0.1", [ "redis" ]
    end
  end
end
