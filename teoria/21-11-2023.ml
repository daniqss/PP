(*
    TIPOS
*)

type numero =
    I of int 
    | F of float;;

let rec first_int = function
    [] -> raise Not_found
    | I n :: _ -> numero
    | _ :: t -> first_int t;;
    
type otroint = Otro of int;;

type doble_int = L of int | R of int;; | V of int;;

type intoption = Int of int | Nada;;
(*# type intoption = Int of int | Nada;;
type intoption = Int of int | Nada
# Int 3;;
- : intoption = Int 3   *)

(*
let (//) i1 i2 = match (i1, i2) with 
    (_, Int 0) -> Nada
    | (Int n1, Int n2) -> Int (n1 / n2)
    | _ -> Nada;;
  
    
let (//) i1 i2 = match (i1, i2) with 
    (Int n1, Int n2) -> try Int (n1 / n2) with
    Division_by_zero -> Nada
    | _ -> Nada;;
    CUIDADO CON LA IDENTACION
*)

let (//) i1 i2 = match (i1, i2) with 
    (Int n1, Int n2) -> (try Int (n1 / n2) with
                        Division_by_zero -> Nada)
    | _ -> Nada;;

(*///////////////////*)

type boolean = True | False;;+
type palo = Corazon | Diamante | Pica | Trebol;;

let (!!) = function True -> False | False -> True;;
let es_rojo = function
    Corazon | Diamante -> True
    | _ -> False;;
let es_negro = ! (es_rojo p);;

(*///////////////////*)

type entero = One | Succ of entero;;
(*# type entero = One | Succ of entero;;
type entero = One | Succ of entero
# One;;
- : entero = One
# let dos = Succ One;;
val dos : entero = Succ One
# let tres = Succ dos
  ;;
val tres : entero = Succ (Succ One)*)
let rec entero_of_int = function
  1 -> One
  | n -> Succ (entero_of_int (n - 1));;



