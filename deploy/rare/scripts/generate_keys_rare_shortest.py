from polka.tools import calculate_routeid


def _main():
    print("================================================")
    print("#       PARIS-> FRK -> AMS -> SLOUGHT          #")
    print("================================================")
    s = [
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
    ]
    o = [[1], [1, 1]]

    routeID = calculate_routeid(s, o, debug=False)
    print("Length {} RouteID: {}".format(len(routeID), routeID))

    print("================================================")
    print("#        SLOGHT -> AMS -> FRK -> PARIS         #")
    print("================================================")
    s = [
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
    ]
    o = [[1], [1, 1]]

    routeID = calculate_routeid(s, o, debug=False)
    print("Length {} RouteID: {}".format(len(routeID), routeID))


if __name__ == "__main__":
    _main()
