class test::rede{
	cron{'git-pull':       
		command => '/usr/bin/git -C /usr/share/puppet/modules/cowsayings pull https://github.com/jl0000285/cowsay' ,
		ensure => present,
		hour => '*',
		minute => '*',
		notify => Cron['puppet-apply'],	
}
	cron{'puppet-apply':
		command => '/usr/bin/puppet apply /usr/share/puppet/modules/cowsayings/examples/cowsay.pp',	
		hour => '*',
		minute => '*',
		ensure => present, 
		require => Cron['git-pull'],
}
}
