try:
    from iscan_server.settings.local import *
except ImportError:
    from iscan_server.settings.base import *
