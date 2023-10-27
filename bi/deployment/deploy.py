import requests
import time
from requests.auth import HTTPBasicAuth
import xml.etree.ElementTree as ET
import base64
import json
import os
import sys, getopt
from OSPentaho import PentahoApiClient
from OSSFTP import SFTPClientConnection

def main(argv):
    success = True
    regionDefXmlPath = ''
    biPath=''
    currentWorkingDirectory = ''

    try:
        opts, args = getopt.getopt(argv,"h",["regiondefinition=", "bipath="])
    except getopt.GetoptError:
        print ('usage deploy.py --regiondefinition="path_to_regiondefinition_xml_file" --bipath="path_to_bi_repository_to_publish"')
        sys.exit(-1)
    for opt, arg in opts:
        if opt == '-h':
            print ('usage deploy.py --regiondefinition="path_to_regiondefinition_xml_file"')
            sys.exit()
        elif opt in ("--regiondefinition"):
            regionDefXmlPath = arg
        elif opt in ("--bipath"):
            biPath = arg
    
    if regionDefXmlPath == '' or biPath == '':
        print("Missing Configurations")
        print ('usage deploy.py --regiondefinition="path_to_regiondefinition_xml_file"  --bipath="path_to_bi_repository_to_publish"')
        sys.exit()

    regDef = ET.parse(regionDefXmlPath)
    root = regDef.getroot()
    biServer = root.find('BIServer')
    pentahoApiServer = root.find('PentahoAPIServer')

    if biServer is None or pentahoApiServer is None:
        print('BIServer or PentahoAPIServer definitions missing from RegionDefinition.xml')
        sys.exit(-1)

    print('Fetched Region Definition file')

    biServerArray = []
    for node in biServer.find('Nodes').findall('Node'):
        sftpHost = '' if node.find('HostName') is None or node.find('HostName').text is None else node.find('HostName').text.strip()
        sftpUser = '' if node.find('UserName') is None or node.find('UserName').text is None else node.find('UserName').text.strip()
        sftpPassword = '' if node.find('Password') is None or node.find('Password').text is None else node.find('Password').text.strip()
        appRoot = '' if node.find('ApplicationRoot') is None or node.find('ApplicationRoot').text is None else node.find('ApplicationRoot').text.strip()

        if sftpHost == '' or sftpUser == '' or sftpPassword == '' or appRoot == '':
            print("Missing BIServer Configurations in node")
            sys.exit(-1)
        else:
            biServerArray.append({'sftpHost' : sftpHost, 'sftpUser' : sftpUser, 'sftpPassword' : sftpPassword, 'appRoot':appRoot})
        
    pentahoServerArray = []
    for node in pentahoApiServer.find('Nodes').findall('Node'):
        pHost = '' if node.find('URL') is None or node.find('URL').text is None else node.find('URL').text.strip()
        pUser = '' if node.find('UserName') is None or node.find('UserName').text is None else node.find('UserName').text.strip()
        pPassword = '' if node.find('Password') is None or node.find('Password').text is None else node.find('Password').text.strip()

        if pHost == '' or pUser == '' or pPassword == '':
            print("Missing PentahoApiServer Configurations in node")
            sys.exit(-1)
        else:
            pentahoServerArray.append({'pentahoHost' : pHost, 'pentahoUser' : pUser, 'pentahoPassword' : pPassword})
        
    #Make sure servers are up and running before trying to upload
    for pentahoServerNode in pentahoServerArray:
        connected = False

        for i in range(3):
            print('Trying to connect:' + pentahoServerNode['pentahoHost'])
            try:
                httpResult = requests.get(pentahoServerNode['pentahoHost'])
                if httpResult.status_code == 200:
                    print("Successfully connected to server:" + pentahoServerNode['pentahoHost'])
                    connected = True
                    break
            except:
                print("Attempt " + str(i+1) + " failed")

            if i < 2:
                print('Wait 30sec before next attempt')
                time.sleep(30)
        if connected == False:
            print("Failed to connect to host:" + pentahoServerNode['pentahoHost'])
            sys.exit(-1)

    currentWorkingDirectory = os.getcwd()

    print("Switching current directory from \"" + currentWorkingDirectory + "\" to \"" + biPath + "/deployment/" + "\" to ");

    os.chdir(biPath + "/deployment/")
    for pentahoServerNode in pentahoServerArray:
        pentahoClient = PentahoApiClient(pentahoServerNode['pentahoHost'], pentahoServerNode['pentahoUser'], pentahoServerNode['pentahoPassword'])
        success &= pentahoClient.deploy(biPath + '/deployment/os_standard.json')
        success &= pentahoClient.deploy(biPath + '/deployment/os_custom.json')

    for biServerNode in biServerArray:
        sftpClient = SFTPClientConnection(biServerNode['sftpHost'], biServerNode['sftpUser'], biServerNode['sftpPassword'])
        sftpClient.create_sftp_client_ssh();
        
        sftpClient.upload_file(biPath + '/os_standard/reports/pdf.prptstyle', biServerNode['appRoot'] + "public/os_resources/pdf.prptstyle")
        sftpClient.upload_file(biPath + '/os_standard/reports/excel.prptstyle', biServerNode['appRoot'] + "public/os_resources/excel.prptstyle")
        sftpClient.upload_file(biPath + '/os_custom/resources/logo.png', biServerNode['appRoot'] + "public/os_resources/logo.png")

    print("Restoring working directory to \"" + currentWorkingDirectory + "\"")
    os.chdir(currentWorkingDirectory)


    if success:
        print("Successfully completed deployment")
        sys.exit(0)
    else:
        print("There was a problem during deployment. Please go through the printed log and fix the errors.")
        sys.exit(-1)





if __name__ == '__main__':
    main(sys.argv[1:])