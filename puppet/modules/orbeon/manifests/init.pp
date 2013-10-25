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
            command => '/var/www/vagrant2/src/scripts/orbeon.setup.sh',
            require => [    Package['tomcat7'], 
                            Package['default-jdk'],
                            Package['unzip'] ]
    }

  
}
