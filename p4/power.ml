let rec power n exp =
        match exp with
        | 0 -> 1
        | _ -> n * power n (exp - 1)

let rec power' n exp =
    match n <= 0 with
    | true -> 1
    | false -> match exp mod 2 = 0 with
        | true -> power' (n*n) (exp/2) 
        | false -> n * power' (n*n) (exp/2)

let rec powerf n exp =
    match n <= 0. with
    | true -> 1.
    | false -> match exp mod 2 = 0 with
        | true -> powerf (n *. n) (exp/2) 
        | false -> n *. powerf (n *. n) (exp/2)

