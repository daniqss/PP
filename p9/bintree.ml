type 'a bintree = 
  Empty
  | Node of 'a * 'a bintree * 'a bintree;;

let rec in_order = function
  Empty -> []
  | Node (root, izq, drch) -> (in_order izq) @ [root] @ (in_order drch);;


let rec insert criterio tree x = match tree with
| Empty -> Node (x, Empty, Empty)
| Node (root, izq, drch) -> (match criterio x root with
                          | true -> Node (root, insert criterio izq x, drch)
                          | false -> Node (root, izq, insert criterio drch x)
                          );;


let bst criterio list =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (insert criterio acc h) t
  in aux Empty list

                 
