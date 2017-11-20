Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"

  config.vm.define "staging" do |node|
    node.vm.provision "docker", images: [ "thomrick/click-count" ] do |docker|
      docker.run "thomrick/click-count",
        args: "-p 80:8080"
    end
    node.vm.network "forwarded_port", guest: 80, host: 8080
  end

  config.vm.define "production" do |node|
    node.vm.provision "docker", images: [ "thomrick/click-count" ] do |docker|
      docker.run "thomrick/click-count",
        args: "-p 80:8080"
    end
    node.vm.network "forwarded_port", guest: 80, host: 8081
  end
end
