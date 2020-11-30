from polka.tools import calculate_routeid, print_poly


def _main():
    print("================================================")
    print("# PARIS-> FRK -> BUD -> POZ -> AMS -> SLOUGHT  #")
    print("================================================")
    s = [
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
    ]
    o = [
        [1, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 0, 0, 1, 0, 0],
        [1, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 1, 0, 1, 0, 0],
    ]

    routeID = calculate_routeid(s, o, debug=False)
    print_poly(routeID)
    # print("Length {} RouteID: {}".format(len(routeID), routeID))

    print("================================================")
    print("# SLOGHT -> AMS -> POZ -> BUD -> FRK -> PARIS  #")
    print("================================================")
    s = [
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1],
    ]
    o = [
        [1, 0, 0, 0, 1, 1, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 0, 1, 0, 0, 0],
    ]

    routeID = calculate_routeid(s, o, debug=False)
    print_poly(routeID)
    # print("Length {} RouteID: {}".format(len(routeID), routeID))


if __name__ == "__main__":
    _main()
