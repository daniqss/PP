(*  FUNCIONES SOBRE LISTAS CON ESTILO IMPERATIVO *)
    
let length list = 
    let mutable_list = ref list in
    let n = ref 0 in
    while !mutable_list <> [] do
        mutable_list := List.tl !mutable_list;
        n := !n + 1;
    done;
    !n
;;

let last list = 
    let mutable_list = ref list in
    let aux = ref (List.hd !mutable_list) in
    if !mutable_list = [] then failwith "La lista está vacía"
    else
        while !mutable_list <> [] do
            aux := List.hd !mutable_list;
        done;
    !aux
;;

let nth list n =
    let mutable_list = ref list in
    let aux = ref (List.hd !mutable_list) in
    if !mutable_list = [] then failwith "La lista está vacía"
    else
        for i = 1 to n do
            aux := List.hd !mutable_list;
            mutable_list := List.tl !mutable_list;
        done;
    !aux 
;;

let rev list =
    let mutable_list = ref list in
    let aux = ref [] in
    while !mutable_list <> [] do
        aux := List.hd !mutable_list :: !aux;
        mutable_list := List.tl !mutable_list;
    done;
    !aux
;;

let append list1 list2 = 
    let mutable_list1 = ref list1 in
    let mutable_list2 = ref list2 in
    let aux = ref [] in
    while !mutable_list1 <> [] do
        aux := List.hd !mutable_list1 :: !aux;
        mutable_list1 := List.tl !mutable_list1;
    done;
    while !mutable_list2 <> [] do
        aux := List.hd !mutable_list2 :: !aux;
        mutable_list2 := List.tl !mutable_list2;
    done;
    rev !aux
;;

let concat (list : 'a list list) = 
    let mutable_list = ref list in
    let mutable_head = ref [] in
    let aux = ref [] in
    while !mutable_list <> [] do
        mutable_head := List.hd !mutable_list;
        while !mutable_head <> [] do
            aux := List.hd (!mutable_head) :: !aux;
            mutable_head := List.tl !mutable_head;
        done;
        mutable_list := List.tl !mutable_list;
    done;
    rev !aux
;;

(*
let mayor_5 x = x > 5;;
let mayorigual_5 x = x >= 5;;
*)

let for_all (fn: 'a -> bool) (list: 'a list) =
    let mutable_list = ref list in
    let aux = ref true in
    while !mutable_list <> [] do
        if not (fn (List.hd !mutable_list)) then aux := false;
        mutable_list := List.tl !mutable_list;
    done;
    !aux
;;

let exists (fn: 'a -> bool) (list: 'a list) =
    let mutable_list = ref list in
    let aux = ref false in
    while !mutable_list <> [] do
        if fn (List.hd !mutable_list) then aux := true;
        mutable_list := List.tl !mutable_list;
    done;
    !aux
;;

let find_opt = 
    let mutable_list = ref list in
    let aux = ref None in
    while !mutable_list <> [] do
        if fn (List.hd !mutable_list) then aux := Some (List.hd !mutable_list);
        mutable_list := List.tl !mutable_list;
    done;
    !aux
;;

(*
let print_int x = Printf.printf "%d\t" x;;
let print_char x = Printf.printf "%c\t" x;;
*)

let iter (fn: 'a -> unit) (list: 'a list): unit  =
    let mutable_list = ref list in
    while !mutable_list <> [] do
        fn (List.hd !mutable_list);
        mutable_list := List.tl !mutable_list;
    done;
;;

let fold_left (fn: 'a -> 'b -> 'a) (list: 'b list) (acc: 'a) =
    let mutable_list = ref list in
    let mutable_acc = ref acc in
    while !mutable_list <> [] do
        mutable_acc := fn !mutable_acc (List.hd !mutable_list);
        mutable_list := List.tl !mutable_list;
    done;
    !mutable_acc
;;