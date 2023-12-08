let is_prime n =
    let rec check_from i =
        i >= n ||
        (n mod i <> 0 && check_from (i+1))
    in check_from 2;;

let next_prime n =
    let rec check_from i =
        if is_prime i then
            i
        else
            check_from (i+1)
    in check_from (n+1);;

let last_prime_to n =
    let rec check_from i =
        if is_prime i then
            i
        else
            check_from (i-1)
    in check_from (n);;

let is_prime2 n =
  let rec check i =
    i * i > n || (n mod i <> 0 && check (i + 2))
  in
  n <= 1 || (n = 2) || (n mod 2 = 1 && check 3)

(*
        let rec append a b =
            match a with
            | [] -> b
            | h :: t -> h :: append t b

*)