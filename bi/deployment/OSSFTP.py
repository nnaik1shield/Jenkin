import paramiko
import os
import sys
from stat import S_ISDIR, S_IFREG


class SFTPClientExtended(paramiko.SFTPClient):

    def put_dir(self, source, target):
        ''' Uploads the contents of the source directory to the target path. The
            target directory needs to exists. All subdirectories in source are
            created under target.
        '''
        try:
            for item in os.listdir(source):
                if os.path.isfile(os.path.join(source, item)):
                    self.put(os.path.join(source, item), '%s/%s' % (target, item))
                else:
                    self.mkdir('%s/%s' % (target, item), ignore_existing=True)
                    self.put_dir(os.path.join(source, item), '%s/%s' % (target, item))
        except Exception as ex:
            print("Error occured while uploading the contents to SFTP. %s" % ex)
            raise

    def mkdir(self, path, mode=511, ignore_existing=False):
        ''' Augments mkdir by adding an option to not fail if the folder exists  '''
        try:
            super(SFTPClientExtended, self).mkdir(path, mode)
        except IOError:
            if ignore_existing:
                pass
            else:
                raise


class SFTPClientConnection():

    def __init__(self, host, username, password, port=22, keyfilepath=None, keyfiletype=None):
        """

        :param host:
        :param username:
        :param password:
        :param port:
        :param keyfilepath:
        :param keyfiletype:
        """
        super().__init__()
        self.__host = host
        self.__port = port
        self.__username = username
        self.__password = password
        self.__keyfilepath = keyfilepath
        self.__keyfiletype = keyfiletype
        self.__sftp = None
        self.__transport = None
        self.__ssh = None

    def __get_private_key(self):
        """
        :param keyfilepath: Path to the key file
        :param keyfiletype: Type of key DSA or RSA
        :return:
        """
        key = None

        try:
            if self.__keyfilepath is not None:
                if os.path.isfile(self.__keyfilepath):
                    # Get private key used to authenticate user.

                    if self.__keyfiletype == 'DSA':
                        # The private key is a DSA type key.
                        key = paramiko.DSSKey.from_private_key_file(self.__keyfilepath)
                    else:
                        # The private key is a RSA type key.
                        key = paramiko.RSAKey.from_private_key_file(self.__keyfilepath)
                else:
                    print("Private key file does not exists at specified location... Terminating the process!!!")
                    sys.exit(-1)
            return key

        except Exception as ex:
            print('An error occurred getting loading key file: %s: %s' % (ex.__class__, ex))
            sys.exit(-1)

    def create_sftp_client_transport(self):
        """
        create_sftp_client(host, port, username, password, keyfilepath, keyfiletype) -> SFTPClient

        Creates a SFTP client connected to the supplied host on the supplied port authenticating as the user with
        supplied username and supplied password or with the private key in a file with the supplied path.
        If a private key is used for authentication, the type of the keyfile needs to be specified as DSA or RSA.
        :rtype: SFTPClient object.
        """

        try:
            # key = self.get_private_key(self.__keyfilepath, self.__keyfiletype)
            key = self.__get_private_key()
            # Create Transport object using supplied method of authentication.
            self.__transport = paramiko.Transport(self.__host, self.__port)
            self.__transport.connect(None, self.__username, self.__password, key)

            self.__sftp = SFTPClientExtended.from_transport(self.__transport,window_size=2147483647)

            return self.__sftp

        except paramiko.AuthenticationException as authenticationException:
            print("Authentication failed, please verify your credentials: %s: " % authenticationException)
            self.close_sftp_transport_ssh_connections()
        except paramiko.SSHException as sshException:
            print("Unable to establish SSH connection: %s: " % sshException)
            self.close_sftp_transport_ssh_connections()
        except paramiko.BadHostKeyException as badHostKeyException:
            print("Unable to verify server's host key: %s" % badHostKeyException)
            self.close_sftp_transport_ssh_connections()
        except Exception as e:
            print('An error occurred creating SFTP client: %s: %s' % (e.__class__, e))
            self.close_sftp_transport_ssh_connections()

    def close_sftp_transport_ssh_connections(self):
        try:
            if self.__sftp is not None:
                self.__sftp.close()
            if self.__transport is not None:
                self.__transport.close()
            if self.__ssh is not None:
                self.__ssh.close()
            sys.exit(-1)
        except Exception as ex:
            print("Unable to close connection: %s: " % ex)
            sys.exit(-1)

    def create_sftp_client_ssh(self):
        """
        create_sftp_client(host, port, username, password, keyfilepath, keyfiletype) -> SFTPClient

        Creates a SFTP client connected to the supplied host on the supplied port authenticating as the user with
        supplied username and supplied password or with the private key in a file with the supplied path.
        If a private key is used for authentication, the type of the keyfile needs to be specified as DSA or RSA.
        :rtype: SFTPClient object.
        """

        try:
            # key = self.get_private_key(self.__keyfilepath, self.__keyfiletype)
            key = self.__get_private_key()

            # Connect SSH client accepting all host keys.
            # self.__ssh = SFTPClientExtended.SSHClient()
            self.__ssh = paramiko.SSHClient()
            self.__ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            self.__ssh.connect(self.__host, self.__port, self.__username, self.__password, key)

            # Using the SSH client, create a SFTP client.
            self.__sftp = self.__ssh.open_sftp()

            # Keep a reference to the SSH client in the SFTP client as to prevent the former from
            # being garbage collected and the connection from being closed.
            self.__sftp.sshclient = self.__ssh

            return self.__sftp

        except paramiko.AuthenticationException as authenticationException:
            print("Authentication failed, please verify your credentials: %s: " % authenticationException)
            self.close_sftp_transport_ssh_connections()
        except paramiko.SSHException as sshException:
            print("Unable to establish SSH connection: %s: " % sshException)
            self.close_sftp_transport_ssh_connections()
        except paramiko.BadHostKeyException as badHostKeyException:
            print("Unable to verify server's host key: %s" % badHostKeyException)
            self.close_sftp_transport_ssh_connections()
        except Exception as e:
            print('An error occurred creating SFTP client: %s: %s' % (e.__class__, e))
            self.close_sftp_transport_ssh_connections()

    def upload_dir(self, source, destination):

        try:
            self.__sftp.mkdir(destination, ignore_existing=True)
            self.__sftp.put_dir(source, destination)
        except Exception as ex:
            print(ex)
            sys.exit(-1)

    def mk_dir(self, dirname):

        try:
            self.__sftp.mkdir(dirname, ignore_existing=True)
        except Exception as ex:
            print(ex)
            sys.exit(-1)

    def __sftp_walk(self, remotepath):
        # method to collect information for all the files and directive recursively
        path = remotepath
        files = []
        folders = []
        for file in self.__sftp.listdir_attr(remotepath):
            if S_ISDIR(file.st_mode):
                folders.append(file.filename)
            else:
                files.append(file.filename)
        # print (path,folders,files)
        yield path, folders, files

        for folder in folders:
            new_path = os.path.join(remotepath, folder)
            for x in self.__sftp_walk(new_path):
                yield x

    def download_directory(self, remotepath, localpath):
        #  recursively download a full directory
        #
        # For the record, something like this would generally be faster:
        # ssh user@host 'tar -cz /source/folder' | tar -xz

        self.__sftp.chdir(os.path.split(remotepath)[0])
        parent = os.path.split(remotepath)[1]
        try:
            os.mkdir(localpath)
        except:
            pass

        for walker in self.__sftp_walk(parent):
            # print(walker)
            try:
                os.mkdir(os.path.join(localpath, walker[0]))
            except:
                pass

            for file in walker[2]:
                self.__sftp.get(os.path.join(walker[0], file), os.path.join(localpath, walker[0], file))

    def upload_file(self, source, destination):
        try:
            self.__sftp.put(source, destination)
            print("File uploaded successfully from " + source + " to " + destination)
        except Exception as ex:
            print("Error occured while uploading the file %s" % ex)
            sys.exit(-1)

    def check_file_folder_exists_on_sftp_location(self, remotepath):
        try:
            if self.__isdir(remotepath):
                print("Directory exists")
                return True
            elif self.__sftp.stat(remotepath):
                print("File " + remotepath + " exists")
                return True
            elif not self.__sftp.stat(remotepath):
                print("File not found at " + remotepath + ".")
                return False
        except FileNotFoundError as ex:
            print("File not found at " + remotepath + ".\n")
            return False

    def download_file(self, remotepath, localpath):

        try:
            if self.__sftp.stat(remotepath):
                print("Found the file " + remotepath + " and downloading it.")
                self.__sftp.get(remotepath, localpath)
                print("Downloaded successfully.")
            else:
                print("File not found at " + remotepath + ". Terminating the process!!!")
                sys.exit(-1)
        except FileNotFoundError as ex:
            print("File not found at " + remotepath + ". Terminating the process!!!\n%s" % (ex))
            sys.exit(-1)

    def __isdir(self, path):
        try:
            return S_ISDIR(self.__sftp.stat(path).st_mode)
        except IOError:
            return False

    def remove_dir(self, path):
        try:
            files = self.__sftp.listdir(path=path)

            for file in files:
                filepath = os.path.join(path, file).replace(os.sep, '/')
                # filepath = os.path.join(path, file) for windows
                # print(filepath)
                if self.__isdir(filepath):
                    self.remove_dir(filepath)
                    # print("Here removing empty directory " + filepath)
                    self.__sftp.rmdir(filepath)
                else:
                    # print("Remove "+filepath)
                    self.__sftp.remove(filepath)

        except Exception as ex:
            print("Something went wrong while deleting contents %s" % ex)

    def remove_file(self, path):

        try:
            if self.__sftp.stat(path):
                print("File " + path + " exists")
                self.__sftp.remove(path)
        except Exception as ex:
            print("Something went wrong while deleting file %s" % ex)

    def check_connection(self):

        if self.__transport.is_active():
            return True
