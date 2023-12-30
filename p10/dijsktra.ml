type ('a, 'b) queue = Empty | Node of 'a  * 'b * ('a, 'b) queue * ('a, 'b) queue;;

let empty = Empty;;

(* val insert : ('a, 'b) queue -> 'a -> 'b -> ('a, 'b) queue = <fun> *)
let rec insert queue prio elt =
    match queue with
      Empty -> Node (prio, elt, Empty, Empty)
    | Node (p, e, left, right) ->
        if prio < p
        then Node (prio, elt, insert right p e, left)
        else Node (p, e, insert right prio elt, left)
;;
    
let rec rebuild left right = match (left, right) with
    Empty, t | t, Empty -> t
  | Node (lprio, lv, lleft, lright), Node (rprio, rv, rleft, rright) ->
         if lprio <= rprio
            then Node (lprio, lv, rebuild lleft lright, right)
            else Node (rprio, rv, left, rebuild rleft rright)
;;
    
let extract = function
      Empty -> None
    | Node (prio, elt, left, right) -> Some (prio, elt, rebuild left right)
;;





type matrix = int option array array;;

let valid (m: matrix) : unit = 
  let n = Array.length m in
  Array.iter (fun i ->
    Array.iter (fun j ->
      match j with
      | Some x -> if x < 0 then raise (Invalid_argument "dijkstra")
      | None -> ()
    ) i;
    if Array.length i <> n then raise (Invalid_argument "dijkstra")
  ) m;
  ()
;;

let print_matrix m =
  Array.iter (fun i ->
    Array.iter (fun j ->
      match j with
      | Some x -> Printf.printf "%d " x
      | None -> Printf.printf "None "
    ) i;
    print_newline ();
  ) m;
  print_newline ()
;;

let dijkstra (m: matrix) : matrix =
  valid m;
  let size = Array.length m in
  let d = Array.make_matrix size size None in
  let q = ref empty in

  Array.iteri (fun i row ->
    d.(i).(i) <- Some 0;   (* Inicializar la distancia desde un nodo a sí mismo como 0 *)
    q := insert !q 0 i  
  ) d;

  while !q <> Empty do
    match extract !q with
    | None -> failwith "extract returned None"
    | Some (prio, u, q') ->
      q := q';
      Array.iteri (fun v row ->
        match m.(u).(v), d.(u).(u) with
        | Some w, Some du ->
          (match d.(u).(v) with
           | Some dv when dv > du + w ->
             d.(u).(v) <- Some (du + w);
             q := insert !q (du + w) v  (* Actualizar la cola de prioridad con la nueva distancia *)
           | None ->
             d.(u).(v) <- Some (du + w);
             q := insert !q (du + w) v  (* Agregar el nuevo nodo a la cola de prioridad *)
           | _ -> ());
        | _ -> ()
      ) d;
  done;
  d
;;
   
(*
====================
   TESTS 
   La función falla en los casos en los que no hay un camino entre dos nodos.
====================
*)
let v1 = 
  [|[|Some 2; Some 1; Some 2|]; 
    [|Some 3; Some 0; None|];
    [|Some 0; Some 2; None|]|]
;;
    
 let sol1 =
 [|[|Some 0; Some 1; Some 2|]; 
   [|Some 3; Some 0; Some 5|];
   [|Some 0; Some 1; Some 0|]|]
;;

let result = dijkstra v1;;
Printf.printf "====== TEST 1 ======\n";;
print_matrix v1;;
print_matrix sol1;;
print_matrix result;;


let v2 = 
  [|[|None;   Some 0; Some 2; Some 3|]; 
    [|None;   Some 1; Some 8; Some 8|];
    [|None;   Some 5; None;   Some 2|]; 
    [|Some 0; Some 3; Some 5; None|]|]
;;
   
  let sol2 =   
  [|[|Some 0; Some 0; Some 2; Some 3|]; 
    [|Some 8; Some 0; Some 8; Some 8|];
    [|Some 2; Some 2; Some 0; Some 2|]; 
    [|Some 0; Some 0; Some 2; Some 0|]|]
;;

let result = dijkstra v2;;
Printf.printf "====== TEST 2 ======\n";;
print_matrix v2;;
print_matrix sol2;;
print_matrix result;;
