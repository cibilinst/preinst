
class test::dl {
	exec{'pre-inst':
		command => '/usr/bin/puppet apply inst.pp',
		cwd => '/usr/share/puppet/modules/test/examples',
		notify => Exec['mk-cowsayings'],
}
	exec{'mk-cowsayings':
		command => '/bin/mkdir cowsayings',
		cwd => '/usr/share/puppet/modules',
		require => Exec['pre-inst'],
		notify => Exec['mk-init'],
}
	exec{ 'mk-init':
		command => '/usr/bin/git init',
		cwd => '/usr/share/puppet/modules/cowsayings',
		require => Exec['mk-cowsayings'], 
		notify => Exec['git-pull'],
 }
	exec{'git-pull':       
		command => '/usr/bin/git pull https://github.com/jl0000285/cowsay',
		cwd => '/usr/share/puppet/modules/cowsayings',
		require => Exec['mk-init'],
		notify => Exec['puppet-apply'],	
}
	exec{'puppet-apply':
		command => '/usr/bin/puppet apply cowsay.pp',
		cwd => '/usr/share/puppet/modules/cowsayings/examples',
		require => Exec['git-pull'],
}

}
