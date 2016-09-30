class preinst::dl {
	exec{'pre-inst':
		command => '/usr/bin/puppet apply inst.pp',
		cwd => '/usr/share/puppet/modules/preinst/examples',
		notify => Exec['mk-cibilinst'],
}
	exec{'mk-cibilinst':
		command => '/bin/mkdir cibilinst',
		cwd => '/usr/share/puppet/modules',
		require => Exec['pre-inst'],
		notify => Exec['mk-init'],
}
	exec{ 'mk-init':
		command => '/usr/bin/git init',
		cwd => '/usr/share/puppet/modules/cibilinst',
		require => Exec['mk-cibilinst'], 
		notify => Exec['git-pull'],
 }
	exec{'git-pull':       
		command => '/usr/bin/git pull https://github.com/cibilinst/cibilinst',
		cwd => '/usr/share/puppet/modules/cibilinst',
		require => Exec['mk-init'],
		notify => Exec['puppet-apply'],	
}
	exec{'puppet-apply':
		command => '/usr/bin/puppet apply ci.pp',
		cwd => '/usr/share/puppet/modules/cibilinst/examples',
		require => Exec['git-pull'],
}
	cron{'cron-pull':       
		command => '/usr/bin/git -C /usr/share/puppet/modules/cibilinst pull https://github.com/cibilinst/cibilinst' ,
		ensure => present,
		hour => '*',
		minute => '*',
		notify => Cron['cron-apply'],	
		require => Exec['puppet-apply'],
}
	cron{'cron-apply':
		command => '/usr/bin/puppet apply /usr/share/puppet/modules/cibilinst/examples/ci.pp',	
		hour => '*',
		minute => '*',
		ensure => present, 
		require => Cron['cron-pull'],
}
}
