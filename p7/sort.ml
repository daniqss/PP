(*
let rec insert x = function
[] -> [x]
| h::t -> if x <= h then x :: h :: t
else h :: insert x t;;

let rec isort = function
[] -> []
| h::t -> insert h (isort t);;

let print_list lst =
  let print_element elem = Printf.printf "%d " elem in
  List.iter print_element lst;
  Printf.printf "\n"
;;
*)

let rec big_list n acc =
  if n = 0 then acc else big_list (n-1) (n :: acc)
;;

let bigl = big_list 100000000 [];;

let insert_t x l =
  let rec insert_aux acc = function
    | [] -> List.rev (x :: acc)
    | h :: t -> match x <= h with
                | true -> List.rev_append acc (x :: h :: t)
                | false -> insert_aux (h :: acc) t
  in
  insert_aux [] l
;;

let isort_t l =
  let rec isort_aux acc = function
    | [] -> List.rev acc
    | h :: t -> isort_aux (insert_t h acc) t
  in isort_aux [] l

  let rlist n =
    let rec aux i l =
      if i = n then l
      else
        let x = Random.int (n * 10) in
        if List.mem x l then aux i l
        else aux (i + 1) (x :: l)
    in
    aux 0 []


let lc1 = rlist 10000;;
let lc2 = rlist 20000;;
let ld1 = List.rev lc1;;
let ld2 = List.rev lc2;;
let lr1 = rlist 10000;;
let lr2 = rlist 20000;;

let rec insert_g criterio x l =
  let rec insert_aux acc = function
    | [] -> List.rev (x :: acc)
    | h :: t -> match criterio x h with
                | true -> List.rev_append acc (x :: h :: t)
                | false -> insert_aux (h :: acc) t
  in
  insert_aux [] l

let isort_g criterio l =
  let rec isort_aux acc = function
    | [] -> List.rev acc
    | h :: t -> isort_aux (insert_g criterio h acc) t
  in isort_aux [] l

let bigl2 = List.init 1000000 (fun x -> x);;


let split_t l =
  let rec aux acc1 acc2 = function
    | h1::h2::t -> aux (h1::acc1) (h2::acc2) t
    | l -> List.rev_append acc1 (List.rev l), List.rev acc2
  in aux [] [] l


let merge_t (l1, l2) =
  let rec aux acc = function
    | [], l | l, [] -> List.rev_append acc l
    | h1::t1, h2::t2 ->
        if h1 <= h2 then aux (h1::acc) (t1, h2::t2)
        else aux (h2::acc) (h1::t1, t2)
  in aux [] (l1, l2)


(*
let lista_chica  = 11::17::7::6::5::54::3::2::4::[];;
print_list (lista_chica);;
print_list (insert_t  lista_chica);;
*)
