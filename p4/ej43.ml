let rec reverse n =
    let rec count_digits acc num =
        match num < 10 with
        | true -> acc + 1
        | false -> count_digits (acc + 1) (num / 10)
    in let rec power m exp =
        match exp with
        | 0 -> 1
        | _ -> m * power m (exp - 1)
    in
    if n < 10 then n
    else
        n mod 10 * power 10 (count_digits 0 n - 1) + reverse (n / 10)



let rec palindromo str = 
    if str = "" then
        true
    else if str.[0] = str.[String.length str - 1] then
        if String.length str = 1 then
            true
        else
            palindromo (String.sub str 1 ((String.length str) - 2))
    else
        false

let rec mcd (a, b) =
  match b = 0 with
  | true -> a
  | false -> mcd (b, a mod b)


