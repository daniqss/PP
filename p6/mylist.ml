(* La mitad de las funciones no son tail recursive, cuidado💀 *)

let hd = function
[] -> raise(Failure "hd")
| head::_ -> head

let tl = function
[] -> raise(Failure "tl")
| _::tail -> tail
;;

let rec length l = 
    match l with
    [] -> 0
    | head::tail -> 1 + length tail
;;

let rec compare_lengths l1 l2 = 
    match (l1, l2) with
    ([], []) -> 0
    | ([], _) -> -1
    | (_, []) -> 1
    | (_::tail1, _::tail2) -> compare_lengths tail1 tail2
;;

let rec compare_length_with l n = 
    match (l, n) with
    ([], 0) -> 0
    | ([], _) -> -1
    | (_::tail, _) -> compare_length_with tail (n-1)
;;

let rec append a b=
 match a with 
  | []->b
  | h::t->h::append t b
;;

let rec rev l=
    match l with
    | []->[]
    | h::t->append (rev t) [h]
;;

let rev_append l1 l2=
    append (rev l1) l2
;;

(*
let rec init len f =
    if len<0 then raise(Invalid_argument "init")
    else match len with
    0 -> []
    | _ -> (init (len-1) f)::(f (len-1))
    NO ES RECURSIVA TERMINAL
*)

let init len f =
    if len < 0 then raise (Invalid_argument "init")
    else let rec init_aux len acc =
        match len with
        | 0 -> rev acc
        | _ -> init_aux (len - 1) (f (len - 1) :: acc)
        in init_aux len []
;;

let nth l n =
    if n < 0 then raise (Invalid_argument "nth")
    else let rec nth_aux l n =
            match l with
                | [] -> raise (Failure "nth")
                | h::t -> if n = 0 then h else nth_aux t (n-1)
            in nth_aux l n
;;

let rec concat = function
    [] -> []
    | l::r -> append l (concat r)
;;

let flatten = concat
;;

let rec split l =
    match l with
    | [] -> ([], [])
    | (a, b)::l -> let (l1, l2) = split l in (a::l1, b::l2)

let rec split l =
    match l with
    | [] -> ([], [])
    | (a, b)::l -> let (l1, l2) = split l in (a::l1, b::l2)
;;

let rec combine l1 l2 =
    match (l1, l2) with
    | ([], []) -> []
    | (a::l1, b::l2) -> (a, b)::(combine l1 l2)
    | _ -> raise (Invalid_argument "combine")
;;

let rec map f l = 
    match l with
    | [] -> []
    | h::t -> (f h)::(map f t)
;;

let rec map2 f l1 l2 =
    match (l1, l2) with
    | ([], []) -> []
    | (a::l1, b::l2) -> (f a b)::(map2 f l1 l2)
    | _ -> raise (Invalid_argument "map2")
;;

let rev_map f l = rev(map f l)
;;

let rec for_all f l = 
    match l with
    | [] -> true
    | h::t -> f h && for_all f t
;;

let rec exists f l = 
    match l with    
    | [] -> false
    | h::t -> f h || exists f t
;;

let rec mem aux l =
    match l with
    | [] -> false
    | h::t -> 
        match aux = h with
        | true -> true
        | false -> mem aux t
;;

let rec find f l =
    match l with
    | [] -> raise Not_found
    | h::t -> if f h then h else find f t
;;

(*
let rec filter f l = 
    match l with
    | [] -> []
    | h::t -> if f h then h::(filter f t) else filter f t
    NO RECURSIVA TERMINAL
*)

let rec filter f l = 
    let rec filter_aux acc = function
    | [] -> rev acc
    | h::t -> if f h then filter_aux (h::acc) t else filter_aux acc t
    in filter_aux [] l
;;

let find_all = filter
;;

let partition f l = (filter f l, filter (fun x -> not (f x)) l)
;;

let rec fold_left f acc l =
    match l with
    | [] -> acc
    | h::t -> fold_left f (f acc h) l
;;

let rec fold_right f l acc =
    match l with
    | [] -> acc
    | a::l -> f a (fold_right f l acc)
;;

let rec assoc x l =
    match l with 
    | [] -> raise Not_found
    | (a,b)::t -> match a = x with
                    | true -> b
                    | false -> assoc x t
;;

let rec mem_assoc x l =
    match l with
    | [] -> false
    | (a,b)::t -> match a = x with
                    | true -> true
                    | false -> mem_assoc x t
;;

let rec remove_assoc x l =
    match l with
    | [] -> []
    | (a,b)::t -> match a = x with
                    | true -> t
                    | false -> (a,b)::remove_assoc x t
;;