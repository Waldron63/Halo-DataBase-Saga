def main():
    m =[]
    for i in range(1000):
        line = input()
        m.append(line)
    print("fase 1")
    for j in range(1000):
        line = input()
        print(line[:67]+m[j]+line[67:])
main()
