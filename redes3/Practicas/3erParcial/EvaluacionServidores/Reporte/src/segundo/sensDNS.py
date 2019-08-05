import dns.resolver
import time
class sensDNS(object):

    def __init__(self):
        self.myAnswers = None
        self.valor = ""
        self.tiempo = 0.0
        self.status = ""

    def validate_ip(self,s):
        a = s.split('.')
        if len(a) != 4:
            return False
        for x in a:
            if not x.isdigit():
                return False
            i = int(x)
            if i < 0 or i > 255:
                return False
        return True

    def dnsServer(self,domain,peticiones=2,port=53,address="127.0.0.1"):
        smtp_start = time.time()



        myResolver = dns.resolver.Resolver()
        myResolver.port = int(port)
        myResolver.nameservers = [str(address)]
        try:
            if self.validate_ip(str(domain)):#checar si el es una ip o dominio
                for i in range(0,int(peticiones)):
                    req = '.'.join(reversed(domain.split("."))) + ".in-addr.arpa"
                    self.myAnswers = myResolver.query(str(req), "PTR")

                    for rdata in self.myAnswers:
                        self.valor = str(rdata)
                            #print("Ip: " + str(domain) + "\nDomain: " + str(rdata))
            else:
                for i in range(0,int(peticiones)):
                    self.myAnswers = myResolver.query(str(domain), "A")
                    for rdata in self.myAnswers:
                        self.valor = str(rdata)
                            #print("Domain: " + str(domain) + "\nIp: " + str(rdata))
            self.status = "up"

        except Exception as e:
            print(e)
            print("Query failed")
            self.valor = "down"
            self.status = "down"

        smtp_end = time.time()

        self.tiempo = smtp_end-smtp_start


    def getAnswer(self):
        return self.valor

    def getTiempo(self):
        return self.tiempo

    def getStatus(self):
        return self.status


#ip = input("Introduce la ip o el dominio\n")

#obj = sensDNS()
#obj.dnsServer(ip)
#print(obj.getAnswer())
#print(str(obj.getTiempo()))
