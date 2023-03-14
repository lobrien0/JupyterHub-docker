# Configuration file for jupyterhub.

# Sets config
c = get_config() 

# Importing the native-authenticator and setting the filepaths
import os, nativeauthenticator
c.JupyterHub.template_paths = [f"{os.path.dirname(nativeauthenticator.__file__)}/templates/"]

# Setting JupyterHub's authenticator to native-authenticator
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'

# Pre-authorizing the user 'jupyteradmin' and making them admin
c.Authenticator.admin_users = {'jupyteradmin'}
