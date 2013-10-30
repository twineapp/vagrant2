class enketo 
{      

    package { 'php5-xsl':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    package { 'libapache2-mod-auth-mysql':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    exec 
    { 
        'enketo-setup':
            command => '/var/www/vagrant2/src/scripts/enketo.setup.sh',
            timeout => '0',
            require => [    Package['php5-xsl'], 
                            Package['libapache2-mod-auth-mysql'],
                            Exec[set-mysql-password] ]
    }

}
