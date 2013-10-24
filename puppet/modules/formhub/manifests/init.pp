class formhub 
{
    $packages = [
        "default-jre", 
        "gcc",
        "git",
        "python-dev",
        "python-virtualenv",
        "libjpeg-dev",
        "libfreetype6-dev",
        "zlib1g-dev",
        "rabbitmq-server",
        "libxml2-dev",
        "libxslt1-dev"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => [ Exec['apt-get update'] ]
    }


    exec 
    { 
        'formhub-setup':
            command => '/var/www/vagrant/src/scripts/formhub.setup.sh',
            require => [    Package['default-jre'], 
                            Package['gcc'], 
                            Package['git'], 
                            Package['python-dev'], 
                            Package['python-virtualenv'], 
                            Package['libjpeg-dev'], 
                            Package['libfreetype6-dev'], 
                            Package['zlib1g-dev'], 
                            Package['rabbitmq-server'],
                            Package['mongodb-10gen'],
                            Package['libxml2-dev'],
                            Package['libxslt1-dev'] ]
    }

  
}
