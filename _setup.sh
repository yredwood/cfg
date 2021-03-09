# tensorflow virtual env script 
#deactivate first
mkdir -p ~/virtual_env
cd ~/virtual_env

vname=muse

virtualenv --system-site-packages -p $PYENV_ROOT/versions/3.8.4/bin/python3.8 $vname
#virtualenv --system-site-packages -p $PYENV_ROOT/versions/3.6.4/bin/python3.6 $vname
source ~/virtual_env/${vname}/bin/activate
#ln -snf ~/virtual_env/${vname} ~/virtual_env/venv

#pip install -U tensorflow-gpu
#pip install torch torchvision
#
#pip install Pillow
#pip install jupyter
#pip install opencv-python
##pip install "h5py==2.8.0rc1"
#pip install easydict
#pip install matplotlib
#pip install scipy
#pip install sklearn
#pip install pyyaml
#pip install seaborn
#pip install librosa
#pip install tqdm
#pip install sentencepiece
