import requests
from requests.auth import HTTPBasicAuth
import base64
import json
import os


class PentahoApiClient:
    pentahoHost = ''#'http://172.20.58.144:8080/pentaho/'
    pentahoUser = ''#'admin'
    pentahoPassword = ''#'<password>'
    

    def __init__(self, host, username, password, cert_path):
        self.pentahoHost = host
        self.pentahoUser = username
        self.pentahoPassword = password
        self.cert_path = cert_path

    def deploy(self, configFilePath):
        success = True

        print("Host:" + self.pentahoHost)
        print("User:" + self.pentahoUser)

        osConfig = json.load(open(configFilePath))
        for report in osConfig['canned_reports']['reports']:
            success &= self.uploadReport(report, osConfig['base_server_path'] + osConfig['canned_reports']["base_path"])

        for cube in osConfig['cubes']['mondrian']:
            success &= self.uploadCube(cube)

        if "dashboards" in osConfig.keys():
            for widget in osConfig['dashboards']['xdash']:
                success &= self.uploadWidget(widget, osConfig['base_server_path'] + osConfig['dashboards']["base_path"])

        if "analyzers" in osConfig.keys():
            for widget in osConfig['analyzers']['xanalyzer']:
                success &= self.uploadWidget(widget, osConfig['base_server_path'] + osConfig['analyzers']["base_path"])

        return success

    def uploadCube(self, cube):
        filename = os.path.basename(cube["file"]) if "name" not in cube.keys() else cube["name"]
        pentahoPath = 'plugin/data-access/api/datasource/analysis/catalog/' + filename
        payload = {
                    'overwrite': True,
                    'xmlaEnabledFlag': False,
                    'parameters': 'Datasource=OneshieldData;DynamicSchemaProcessor=com.oneshield.mondrian.dsp.OneshieldDSP'
                }
        files = {
                'uploadInput':open(cube["file"],'rb')
                }
        result = self.pentahoPut(pentahoPath, payload, {}, files)
        return result.status_code == 200 or result.status_code == 201

    def uploadReport(self, report, basePath):
        self.createDir(basePath + report["server_path"])
        filename = os.path.basename(report["file"]) if "name" not in report.keys() else report["name"]
        pentahoPath = 'api/repo/files/:' + self.buildFolderPath(basePath + report["server_path"]) + ':' + filename
        result = self.pentahoPutFile(pentahoPath, open(report["file"], "rb"))
        success = result.status_code == 200 or result.status_code == 201

        if success and "locale" in report.keys():
            for locale in report["locale"]:
                result = self.updateDisplayName(pentahoPath, locale)
                success = result.status_code == 200 or result.status_code == 201
        
        return success

    def uploadWidget(self, widget, basePath):
        self.createDir(basePath + widget["server_path"])
        filename = os.path.basename(widget["file"]) if "name" not in widget.keys() else widget["name"]
        pentahoPath = 'api/repo/files/:' + self.buildFolderPath(basePath + widget["server_path"]) + ':' + filename
        result = self.pentahoPutFile(pentahoPath, open(widget["file"], "rb"))
        success = result.status_code == 200 or result.status_code == 201

        if success and "locale" in widget.keys():
            for locale in widget["locale"]:
                result = self.updateDisplayName(pentahoPath, locale)
                success = result.status_code == 200 or result.status_code == 201
        
        return success

    def updateDisplayName(self, pentahoPath, locale):
        xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\
                    <stringKeyStringValueDtoes>\
                        <stringKeyStringValueDto>\
                            <key>file.title</key>\
                            <value>' + locale["display_name"] + '</value>\
                        </stringKeyStringValueDto>\
                        <stringKeyStringValueDto>\
                            <key>file.description</key>\
                            <value>' + locale["description"] + '</value>\
                        </stringKeyStringValueDto>\
                    </stringKeyStringValueDtoes>'
        headers = {
            "Content-Type":"application/xml",
        }
        return self.pentahoPut(pentahoPath + '/localeProperties?locale=' + locale["locale_name"], xml, headers)


    def createDir(self, basePath):
        self.pentahoPut('api/repo/files/:' + self.buildFolderPath(basePath) + '/createDir')

    def pentahoPutFile(self, url, fileHandle):
        data = fileHandle.read()
        headers = {
            "Content-Type":"application/binary",
        }
        return self.pentahoPut(url, data, headers)

    def pentahoPut(self, url, data={}, headers={}, files={}):
        print(self.pentahoHost + url)
        result = requests.put(self.pentahoHost + url, data=data, auth=HTTPBasicAuth(self.pentahoUser, self.pentahoPassword), headers=headers, files=files, verify=False)

        print('HTTP Status' + str(result.status_code))
        return result

    def buildFolderPath(self, path):
        print(path)
        path = path.replace("//", "/")
        if path.startswith("/"):
            path = path[1:]
        
        if path.endswith("/"):
            path = path[:len(path) - 1]

        return path.replace("/", ":")

