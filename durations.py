import os
import pandas as pd

files = [f for f in os.listdir('./logs') if f.endswith('csv')]
print(files)