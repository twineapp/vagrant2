class wsgi 
{   
    package 
    { 
        "apache2-dev":
            ensure  => present,
            require => Exec['apt-get update']
    }

    exec 
    { 
        'wsgi-setup':
            command => '/var/www/vagrant2/src/scripts/wsgi.setup.sh',
            require => [    Package['apache2-dev'] ]
    }
}
