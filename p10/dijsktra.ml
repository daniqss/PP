type ('a, 'b) queue = Empty | Node of 'a  * 'b * ('a, 'b) queue * ('a, 'b) queue

let empty = Empty

let rec insert queue prio elt =
  match queue with
  | Empty -> Node (prio, elt, Empty, Empty)
  | Node (p, e, left, right) ->
    if prio < p
    then Node (prio, elt, queue, Empty)
    else Node (p, e, left, insert right prio elt)
    
let rec rebuild left right = match (left, right) with
    Empty, t | t, Empty -> t
  | Node (lprio, lv, lleft, lright), Node (rprio, rv, rleft, rright) ->
         if lprio <= rprio
            then Node (lprio, lv, rebuild lleft lright, right)
            else Node (rprio, rv, left, rebuild rleft rright)
    
let extract = function
      Empty -> None
    | Node (prio, elt, left, right) -> Some (prio, elt, rebuild left right)
;;

type matrix = int option array array;;


let dijkstra (m: matrix) : matrix =
  let size = Array.length m in
  let d = Array.make_matrix size size None in
  let q = ref empty in

  for i = 0 to size - 1 do
    d.(i).(i) <- Some 0;  (* Inicializar la distancia desde un nodo a sí mismo como 0 *)
    q := insert !q 0 i
  done;

  while !q <> Empty do
    match extract !q with
    | None -> failwith "extract returned None"
    | Some (prio, u, q') ->
      q := q';
      for v = 0 to size - 1 do
        match m.(u).(v), d.(0).(u) with
        | Some w, Some du ->
          (match d.(0).(v) with
           | Some dv when dv > du + w ->
             d.(0).(v) <- Some (du + w);
             q := insert !q (du + w) v  (* Actualizar la cola de prioridad con la nueva distancia *)
           | None ->
             d.(0).(v) <- Some (du + w);
             q := insert !q (du + w) v  (* Agregar el nuevo nodo a la cola de prioridad *)
           | _ -> ());
        | _ -> ()
      done
  done;
  d
;;

let v1 = 
  [|[|Some 2; Some 1; Some 2|]; 
    [|Some 3; Some 0; None|];
    [|Some 0; Some 2; None|]|];;
    
let sol1 =
[|[|Some 0; Some 1; Some 2|]; 
  [|Some 3; Some 0; Some 5|];
  [|Some 0; Some 1; Some 0|]|];;
   
let print_matrix m =
  Array.iter (fun i ->
    Array.iter (fun j ->
      match j with
      | Some x -> Printf.printf "%d " x
      | None -> Printf.printf "0 "
    ) i;
    print_newline ();
  ) m;
  print_newline ()
;;

let check_result result expected =
  let aux = ref true in
  Array.iteri (fun i row ->
    Array.iteri (fun j value ->
      if result.(i).(j) <> expected.(i).(j) then aux := false
    ) row;
  ) result;
  !aux
;;


print_matrix v1;;
let result = dijkstra v1 in print_matrix result;;
