## Como instalar pippi (https://github.com/luvsound/pippi).
* Tener python 3 instalado en Ubuntu (Cambia según en sistema operativo)
* sudo apt-get install python3-pip 
* sudo apt-get install python3-venv libsndfile1-dev python3-dev
* sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
* Lo de arriba viene de https://stackoverflow.com/questions/34631806/fail-during-installation-of-pillow-python-module-in-linux
* Posicionarse en la carpeta del proyecto
* python3 -m venv venv
* source venv/bin/activate
* pip install numpy
* pip install cython
* pip install Pillow
* pip install pippi
* Listo