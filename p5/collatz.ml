let f n = if n mod 2 = 0 then n / 2 else 3 * n + 1;;

let rec orbit n = 
    match n with
    | 0 -> raise(Failure("orbit"))
    | 1 -> "1"
    | _ -> string_of_int(n) ^ "," ^ orbit(f n);; 

let rec length n = 
    match n with
    | 0 -> raise(Failure("length"))
    | 1 -> 1
    | _ -> 1 + length(f n);; 

let rec top n =
  match n with
  | 0 -> raise (Failure "top")
  | 1 -> 1
  | _ -> max n (top (f n));;

let rec length'n'top n =
  match n with
  | 0 -> raise (Failure "length'n'top")
  | 1 -> (1, 1)
  | _ ->
    let (len, t) = length'n'top (f n) in
    (1 + len, max n t);;

let rec longest_in m n =
  if m > n then raise (Failure "longest_in")
  else if m = n then (m, length m)
  else
    let (len1, _) = length'n'top m in
    let (len2, _) = longest_in (m + 1) n in
    if len1 >= len2 then (m, len1) else (m + 1, len2);;

let rec highest_in m n =
  if m > n then raise (Failure "highest_in")
  else if m = n then (m, top m)
  else
    let (_, t1) = length'n'top m in
    let (_, t2) = highest_in (m + 1) n in
    if t1 >= t2 then (m, t1) else (m + 1, t2);;