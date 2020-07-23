import json
import yaml
from addict import Dict
from kapitan.utils import flatten_dict
from kapitan.inputs import kadet

class TFVars(kadet.BaseObj):
    def body(self):
        pass

def main():
    obj = kadet.BaseObj()
    obj.root.vars = TFVars()
    return obj