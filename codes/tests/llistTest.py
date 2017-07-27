import pyllist
sllist = pyllist.sllist
a = sllist([])
a.append(1.0)
a.append(2.0)
a.appendright(3.0)
a.appendright(4.0)
b = a.nodeat(0)
c = b.next()
print(c)
