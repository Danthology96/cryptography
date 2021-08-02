import random
from math import pow
a=random.randint(2,10)
#Para encontrar el gran común divisor de 2 números
def gcd(a,b):
    if a<b:
        return gcd(b,a)
    elif a%b==0:
        return b
    else:
        return gcd(b,a%b)
#Para generación de clave
def gen_key(q):
    key= random.randint(pow(10,20),q)
    while gcd(q,key)!=1:
        key=random.randint(pow(10,20),q)
    return key
def power(a,b,c):
    x=1
    y=a
    while b>0:
        if b%2==0:
            x=(x*y)%c;
        y=(y*y)%c
        b=int(b/2)
    return x%c

#Para encriptación asimétrica
def encryption(msg,q,h,g):
    ct=[]
    k=gen_key(q)
    s=power(h,k,q)
    p=power(g,k,q)
    for i in range(0,len(msg)):
        ct.append(msg[i])
    print("g^k usado= ",p)
    print("g^ak usado= ",s)
    for i in range(0,len(ct)):
        ct[i]=s*ord(ct[i])
    return ct,p
    
#desencriptar
def decryption(ct,p,key,q):
    pt=[]
    h=power(p,key,q)
    for i in range(0,len(ct)):
        pt.append(chr(int(ct[i]/h)))
    return pt
msg=input("Ingrese el mensaje: ")
q=random.randint(pow(10,20),pow(10,50))
g=random.randint(2,q)
key=gen_key(q)
h=power(g,key,q)
print("g usada=",g)
print("g^a usada=",h)
ct,p=encryption(msg,q,h,g)
print("[-] Mensaje original: ",msg)
print("[-] Mensaje encriptado: ",ct)
pt=decryption(ct,p,key,q)
d_msg=''.join(pt)
print("[*] Mensaje desencriptado: ",d_msg)