def challenge(obj,key):
    for i in key.split('/'):
        obj = obj[i]
    print(obj)
    #return obj

#input
key = "a/b/c"
obj = {"a":{"b":{"c":"d"}}}

#calling the module
challenge(obj,key)