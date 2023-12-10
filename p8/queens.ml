let valid (x1, y1) (x2, y2) =
  x1 = x2 || y1 = y2 ||
  abs (x2-x1) = abs (y2 - y1);;

let compatible p path =
   not (List.exists (valid p) path);;

let queens n =
    let rec queens_aux path i j =
        if i > n then [path]    (* devolvemos el camino como una lista *)
        else if j > n then []   (* devolvemos una lista vacía *)
        else if compatible (i, j) path
            then    (* concatenamos la solución actual con el resto de soluciones *)
              (queens_aux ((i, j) :: path) (i+1) 1) @ (queens_aux path i (j+1))
        else queens_aux path i (j+1)     (* seguimos buscando en la misma fila *)
    in queens_aux [] 1 1;;


let is_queens_sol n l =
    if List.length l <> n then false
    else
        let rec check_range l =
        match l with
        | [] -> true
        | (i, j) :: tail ->
            if i < 1 || i > n || j < 1 || j > n then false
            else check_range tail
        in
        if not (check_range l) then false
        else
        let rec check_attack l =
            match l with
            | [] -> true
            | p :: tail ->
            if not (compatible p tail) then false
            else check_attack tail
        in
        check_attack l
;;





