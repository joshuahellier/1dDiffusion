import pyllist
dllist = pyllist.dllist

a = dllist([2.0])
a.appendleft(1.0)
a.appendright(3.0)
b = a.nodeat(1)
print(b)
c = b.prev()
print(c)
d = a.first()
print(d)
