
class test::ci{
	exec{'/usr/bin/puppet apply cowsay.pp':
		cwd => '/usr/share/puppet/modules/cowsayings/examples',
}

}
