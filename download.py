import time
import urllib.request
countrycodes = open("countrycodesparsed","r")
parseddata = ''
for line in countrycodes:
        print(line.strip())
        while 1:
                try:
                        response = urllib.request.urlopen('http://comtrade.un.org/api/get?max=50000&type=C&freq=M&px=HS&ps=all&r='+ line.strip() +'&p=0&rg=all&cc=27&fmt=csv&head=M')
                        time.sleep(1)
                        break
                except:
                        time.sleep(10)
        next(response)
        for line2 in response:
                parseddata += str(line2) + '\n'
writefile = open("UNOILDATA.CSV","w")
writefile.write(parseddata)
