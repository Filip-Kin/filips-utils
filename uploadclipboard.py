import sys
import datetime
import requests
import clipboard

def base36encode(number, alphabet='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'):

    base36 = ''
    sign = ''

    if number < 0:
        sign = '-'
        number = -number

    if 0 <= number < len(alphabet):
        return sign + alphabet[number]

    while number != 0:
        number, i = divmod(number, len(alphabet))
        base36 = alphabet[i] + base36

    return sign + base36


numfile = open("numfile.txt", "r")
uploadnum = base36encode(int(numfile.read())+1)
numfile.close()
'''
args = sys.argv[:]
args.pop(0)
text = " ".join(args)'''
text = clipboard.paste()
url = "https://file.filipkin.com/add/text.php"

res = requests.post(url, data={"text": text, "id": datetime.datetime.now().strftime("%Y-%m")+"-"+uploadnum.lower()})

numfile = open("numfile.txt", "w")
uploadnum = int(uploadnum, 36)
numfile.write(str(uploadnum))
numfile.close()

clipboard.copy("https://file.filipkin.com/"+res.text+"-txt.php")
