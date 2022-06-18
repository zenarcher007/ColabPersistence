from google.colab import drive
import os
import subprocess
import ColabPersistence

#@staticmethod
def makeColabPersistent(datastoreName):
  if not os.path.isdir('/mnt/drive/MyDrive'):
    drive.mount('/mnt/drive')
  pdir = os.path.dirname(ColabPersistence.__file__)
  dPath = "/mnt/drive/MyDrive/COLAB/Persistence/" + datastoreName
  subprocess.check_call( ["chmod", "+x", pdir + "/makePersistent.sh"], stdout=subprocess.STDOUT, stderr=subprocess.STDERR)
  subprocess.check_call([pdir + "/makePersistent.sh", dPath], stdout=subprocess.STDOUT, stderr=subprocess.STDERR)