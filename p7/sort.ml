let rec insert x = function
[] -> [x]
| h::t -> if x <= h then x :: h :: t
else h :: insert x t;;

let rec isort = function
[] -> []
| h::t -> insert h (isort t);;

(* let print_list lst =
  let print_element elem = Printf.printf "%d " elem in
  List.iter print_element lst;
  Printf.printf "\n"
;; *)

let rec big_list n acc =
  if n = 0 then acc else big_list (n-1) (n :: acc)
;;

let bigl = big_list 99999999 [];;
(* let bigl_rev = List.rev bigl;; *)

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
;;

let crono f x =
  let t = Sys.time () in
  let _ = f x in
  Sys.time () -. t

let lc1 = List.init 10000 (fun x -> x);;
let lc2 = List.init 20000 (fun x -> x);;
let ld1 = List.rev lc1;;
let ld2 = List.rev lc2;;
let lr1 = rlist 10000;;
let lr2 = rlist 20000;;


(* isort_t no funciona :( *)
let compare_and_print_result list_type list1 list2 =
  let result = isort_t list1 = isort list1 in
  Printf.printf "isort_t %s: %b\n" list_type result;
  if not result then
    Printf.printf "Mismatch for %s\n" list_type

let time_and_print_result list_type list =
  let time_isort = crono isort list in
  let time_isort_t = crono isort_t list in
  Printf.printf "isort - %s: %.6f seconds\n" list_type time_isort;
  Printf.printf "isort_t - %s: %.6f seconds\n" list_type time_isort_t


let () =
  compare_and_print_result "lc1" lc1 lc1;
  compare_and_print_result "lc2" lc2 lc2;
  compare_and_print_result "ld1" ld1 ld1;
  compare_and_print_result "ld2" ld2 ld2;
  compare_and_print_result "lr1" lr1 lr1;
  compare_and_print_result "lr2" lr2 lr2;

  time_and_print_result "lc1" lc1;
  time_and_print_result "lc2" lc2;
  time_and_print_result "ld1" ld1;
  time_and_print_result "ld2" ld2;
  time_and_print_result "lr1" lr1;
  time_and_print_result "lr2" lr2

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
  let rec split_aux acc1 acc2 = function
    | h1::h2::t -> split_aux (h1::acc1) (h2::acc2) t
    | l -> List.rev_append acc1 (List.rev l), List.rev acc2
  in split_aux [] [] l


let merge_t (l1, l2) =
  let rec merge_aux acc = function
    | [], l | l, [] -> List.rev_append acc l
    | h1::t1, h2::t2 ->
        if h1 <= h2 then merge_aux (h1::acc) (t1, h2::t2)
        else merge_aux (h2::acc) (h1::t1, t2)
  in merge_aux [] (l1, l2)

let msort' l =
  let rec msort_aux acc = function
    | [] | [_] as l -> merge_t (l, acc)
    | l -> let l1, l2 = split_t l in
            msort_aux (merge_t (msort_aux [] l1, acc)) l2
  in msort_aux [] l

let bigl3 = List.init 1000000 (fun x -> x);;

let msort_g criterio l =
  let merge_t criterio (l1, l2) =
    let rec merge_aux criterio acc = function
      | [], l | l, [] -> List.rev_append acc l
      | h1::t1, h2::t2 ->
          if criterio h1 h2 then merge_aux criterio (h1::acc) (t1, h2::t2)
          else merge_aux criterio (h2::acc) (h1::t1, t2)
    in merge_aux criterio [] (l1, l2)
  in let rec msort_aux criterio acc l = match l with
    [] | [_] as l -> merge_t criterio (l, acc)
    | l -> let l1, l2 = split_t l in
            msort_aux criterio (merge_t criterio (msort_aux criterio [] l1, acc)) l2 (* modificado *)
  in msort_aux criterio [] l


(*
let lista_chica  = 11::17::7::6::5::54::3::2::4::[];;
*)
