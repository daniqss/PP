let queens n = 
    let valid_position position used =
        let valid_position_aux position used =
            match used with
            | [] -> true
            | h::t -> if fst position = fst h 
                    || snd position = snd h
                    || abs (fst position - fst h) = abs (snd position - snd h)
                        then false
                    else valid_position_aux position t
        in valid_position_aux position used

    in let rec queens_aux n used =
        

    in queens_aux n []


(*
let rec is_queens_solve n l = 
    match l with
    | [] -> false
    | h::
*)