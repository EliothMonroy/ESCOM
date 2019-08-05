#!/usr/bin/env python
import httplib
import sys
def check_webserver(address, port, resource):
    #create connection
    if not resource.startswith('/'):
        resource = '/' + resource
    try:
        conn = httplib.HTTPConnection(address, port)
        print('HTTP connection created successfully')
        #make    request
        req = conn.request('GET', resource)
        print('request for %s successful' % resource)
        # get response
        response = conn.getresponse()
        print('response status: %s' % response.status)
    except sock.error as e:
        print ("HTTP connection failed: %s' % e")
        return False
    finally:
        conn.close()
        print ('HTTP connection closed successfully')
        if response.status in [200, 301]:
            return True
        else:
            return False