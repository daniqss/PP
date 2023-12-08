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

let rec big_list n acc =
  if n = 0 then acc else big_list (n-1) (n :: acc)
;;

(*let bigl = big_list 100000000 [];;*)

let insert_t x l =
  let rec insert_aux acc = function
    | [] -> List.rev (x :: acc)
    | h :: t -> match x <= h with
                | true -> List.rev_append acc (x :: h :: t)
                | false -> insert_aux (h :: acc) t
  in
  insert_aux [] l
;;

let lista_chica  = 11::17::7::6::5::54::3::2::4::[];;
print_list (lista_chica);;
print_list (insert_t  lista_chica);;
