
# coding: utf-8


def main():

    file = open('../data/sample.txt', 'r').read()
    team = input("Enter word: ")
    count = file.count(team)

    print(count)


main()
