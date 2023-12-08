(*
let rec factorial = function 0 -> 1 | n -> n * factorial(n-1);;
(* factorial : int -> int <fun> *)

factorial 0 + factorial 1 + factorial 2;;
(* int = 4 *)

factorial 10;;
(* int = 3628800 *)

factorial 100;;
(* int = 0 *)

factorial (-1);;
(* Recursión infinita *)
*)

let rec sumto = function 1 -> 1 | n -> n + sumto(n - 1);;

let rec exp10 = function 0 -> 1 | n -> 10 * exp10(n - 1);;

let rec num_cifras = function 0 -> 1 | n -> 1 + num_cifras(n / 10);;

let rec sum_cifras = function 0 -> 0 | n -> (n mod 10) + sum_cifras(n / 10);;