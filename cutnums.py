import re
data = open("countrycodesraw","r").read()
parseddata = re.sub("\D", " ", data)
parseddata = re.sub(' +','\n',parseddata)
writefile = open("countrycodesparsed","w")
writefile.write(parseddata)
