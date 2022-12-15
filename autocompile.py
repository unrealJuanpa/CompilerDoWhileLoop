import os

name = ''.join([x for x in os.listdir() if x.endswith('.y')]).split('.')[0]

os.system('cls')
os.system(f'bison -d {name}.y')
os.system(f'flex {name}.l')
# 
os.system(f'gcc lex.yy.c {name}.tab.c -L"C:\MinGW\msys\1.0\lib" -o {name}.exe')
os.system(f'{name}.exe < test2.txt')
#os.system(f'{name}.exe < test1.txt')
#os.system(f'{name}.exe < test2.txt')