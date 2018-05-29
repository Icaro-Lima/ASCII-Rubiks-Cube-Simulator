for i in range(44):
	k = open('%d.txt' % i, 'r')
	
	if k.readline().find('\0') != -1:
		print('Ow!')
