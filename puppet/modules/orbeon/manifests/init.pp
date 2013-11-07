class orbeon 
{
    $packages = [
        "tomcat7", 
        "default-jdk"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => [ Exec['apt-get update'] ]
    }


    exec 
    { 
        'orbeon-setup':
            command => 'nohup /shared_folder/vagrant2/src/scripts/orbeon.setup.sh >> /var/log/vagrant_install.log',
            timeout => '0',
            require => [    Package['tomcat7'], 
                            Package['default-jdk'],
                            Package['unzip'] ]
    }

  
}
