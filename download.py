import urllib.request
response = urllib.request.urlopen('http://comtrade.un.org/api/get?max=50000&type=C&freq=M&px=HS&ps=all&r=826&p=0&rg=all&cc=27&fmt=csv&head=M')
parseddata = ''
for line in response:
        parseddata += str(line) + '\n'
writefile = open("UNOILDATA.CSV","w")
writefile.write(parseddata)
