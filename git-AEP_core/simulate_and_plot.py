# hnn core
# https://hnnsolver.github.io/hnn-core/auto_examples/plot_simulate_evoked.html#sphx-glr-auto-examples-plot-simulate-evoked-py
# this just plots a bunch of moodels I did in hnn
#ipython
#-------------------------------------
#Init
#-------------------------------------
from neuron import h
h.nrn_load_dll('C:\\Users\\ckohl\\Miniconda3\\Lib\\site-packages\\hnn_core\\nrnmech.dll')
import os.path as op
import hnn_core
from hnn_core import simulate_dipole, Params, Network, read_params
import json
import numpy as np
import matplotlib.pyplot as plt
import sys        
sys.path.append('C:\\Users\\ckohl\\Documents\\HNN core code\\')
import my_hnn_core_functions as m
from pptx import Presentation #https://python-pptx.readthedocs.io/en/latest/user/quickstart.html
from pptx.util import Inches

saving_dpl=False
hnn_core_root = op.join(op.dirname(hnn_core.__file__), '..')
my_param_out_dir='C:\\Users\\ckohl\\hnn_out\\'
dump_dir="C:\\Users\\ckohl\\Desktop\\Current\\HNN Core\\"     


#-------------------------------------
#PPT init
#-------------------------------------
left = 0
top=Inches(0.25)
height = Inches(7)
width=Inches(10)
prs = Presentation()
title_slide_layout = prs.slide_layouts[0]
slide = prs.slides.add_slide(title_slide_layout)
title = slide.shapes.title
subtitle = slide.placeholders[1]
title.text = "NEW (r) fits"
subtitle.text = "plot_from_hnn.py"


# param_files=['NEW_manual1','NEW_manual2','NEW_manual1','NEW_manual3','NEW_manual4','NEW_manual5','NEW_manual6','NEW_manual7','NEW_manual8','NEW_manual9','NEW_manual10','NEW_manual11',
# param_files=[    'NEW_manual3_opt','NEW_manual3_opt2','NEW_manual3_opt3','NEW_manual10_opt','NEW_manual10_opt2','NEW_manual10_opt_temp','NEW_manual10_opt_temp1','NEW_manual10_opt_temp2','NEW_manual10_opt_temp3','NEW_manual10_opt_temp4','NEW_manual10_opt_temp4']
 # param_files=[    'NEW_manual10_opt_temp5_opt','NEW_manual10_opt_temp5_opt2','NEW_manual10_opt2_prox1opt','NEW_manual10_opt2_prox1opt_opt','NEW_manual10_opt_temp5_opt3']   


#param_files=['NEW_manual10_opt2_prox1opt_opt_step1','NEW_manual10_opt2_prox1opt_opt_step1_tweak1','NEW_manual10_opt2_prox1opt_opt_step1_tweak2','NEW_manual10_opt2_prox1opt_opt_step1_tweak3','NEW_manual10_opt2_prox1opt_opt_step1_tweak4','NEW_manual10_opt2_prox1opt_opt_step1_tweak5','NEW_manual10_opt2_prox1opt_opt_step1_opt', 'NEW_manual7_opt','NEW_manual7_opt2','NEW_manual7_opt3']
#param_files=['NEW_manual10_opt2_prox1opt_opt_step1_tweak5_opt']
#param_files=['best_new_0114']
#param_files=['NEW_manual10_opt_temp5_opt3']
#param_files=['NEW_manual7_opt10trials']

#param_files=['NEW_manual10_opt2_prox1opt_opt_step1_tweak5', 'NEW_manual10_opt', 'NEW_manual7_opt10trials','NEW_manual7_opt3','NEW_manual10_opt2_prox1opt_opt_step1_tweak5_opt','best_new_0114','NEW_manual10_opt_temp5_opt','NEW_manual10_opt_temp5_opt3']
param_files=['NEW_manual7_opt10trials']
param_files=['best_new_0114']
param_files=['Law_best_2401']
param_files=['Law_best_2401_opt10']
param_files=['NEW_manual7_opt10trials_ALLII80_opttime']
param_files=['710_NEW_closestthingihavetooriginal710_smallervalues']
param_files=['blake_aep_300_scale']
param_files=['710_tiinascale_opt_pdp']
param_files=['default_scale01']
for p in param_files:
        dict_param=m.get_dict_param(my_param_out_dir,p)
        base_params=[]
        these_params=[]
        base_params = Params(dict_param)
        these_params=Params(dict_param)
        net=[]
        dpls=[]
        net = Network(these_params)
        dpls = simulate_dipole(net, n_jobs=1, n_trials=1)
        m.plot_hnn_core_output(dpls,net,p,False,True,False,these_params)
        m.plot_hnn_core_output(dpls,net,p,True,False,True,param_oi_t,these_params,base_params)
        plt.pause(.1)
        plt.savefig(dump_dir+'\\temp.png')
        img_path = dump_dir+'\\temp.png'
        blank_slide_layout = prs.slide_layouts[6]
        slide = prs.slides.add_slide(blank_slide_layout)
        pic = slide.shapes.add_picture(img_path, left, top, height=height,width=width)
        plt.close()
prs.save(dump_dir+'\\blake_temp.pptx')





    dump_dir="C:\\Users\\ckohl\\Desktop\\Current\\HNN Core\\"
    import pickle
    f = open(dump_dir+p+'_dpl.txt', 'wb')
    pickle.dump(dpls, f)
    f.close()
    f = open(dump_dir+p+'_net.txt', 'wb')
    pickle.dump(net, f)
    f.close()