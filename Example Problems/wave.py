def wave(str):
    return print([str[:n].lower() + str[n:].capitalize() for n in range(len(str))])

wave("a b")
