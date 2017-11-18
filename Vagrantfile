Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.provision "docker" do |docker|
    docker.pull_images "thomrick/click-count"
    docker.run "thomrick/click-count",
      args: "-p 80:8080"
  end
  config.vm.network :forwarded_port, guest: 80, host: 8080
end
