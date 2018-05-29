import sys

def get_frame(arquivo):
	linhas = []
	for i in range(13):
		linha = arquivo.readline()
		
		if linha == '':
			sys.exit()
		
		linhas.append(linha[6:len(linha) - 1])
	
	linhas[12] = linhas[12][:67]
	
	file_out = open('%d.txt' % identificacao, 'w')
	for i in range(len(linhas)):
		file_out.write(linhas[i] + ((67 - len(linhas[i])) * ' ') + '\n')	
	
	arquivo.readline()
	arquivo.readline()
	arquivo.readline()
	arquivo.readline()
	arquivo.readline()

#######################################
identificacao = 0
arquivo_completo = open("out.txt", "r")


while True:
	get_frame(arquivo_completo)
	identificacao += 1
	
