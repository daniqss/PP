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
