# ColabPersistence
A utility for making jupyter Colab journals semi-persistent

Do not use this on any device except for Google Colab. This has the potential to damage your computer, and is only applicable for sandboxed docker VMs.

Usage:
Basically, paste this script in a cell in your notebook, and run it immedately after starting the runtime instance (verbose output is supressed):  

%cd /tmp
!git clone 'https://github.com/zenarcher007/ColabPersistence.git' 2> /dev/null
%cd ColabPersistence
!pip3 install ipynbname > /dev/null
import ipynbname
from ColabPersistence import persistence as cop
cop.makeColabPersistent(ipynbname.name())
%cd
%cd /content
