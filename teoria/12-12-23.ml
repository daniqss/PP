type person = {
  name: string;
  age: int;
}

let p1 = { name = "Pepe"; age = 42; };;
let p2 = { name = "Juan"; age = 23; };;
p2.age <- 24;;

let older p = {
  p with age = p.age + 1;
}
(* Crea otro struct igual pero con un año más *)

let ord p1 p2 = 
  p1.age < p2.age ||
  p1.age = p2.age && p1.name <= p2.name
;;

(*================================================*)

(* Mismo struct pero con campo mutable *)
type person = {
  name: string;
  mutable age: int;
}

let aged p = p.age <- p.age + 1;;
(* val aged : person -> unit = <fun> *)

(*================================================*)

(* Constructor de tipos mutable *)

type 'a var = {
  mutable valor: 'a
};;

let init_var x = {
  valor = x
};;

(* Implementación de  *)
let (!!) v = v.valor;;
let (<<) v x = v.valor <- x;;

(*================================================*)

let next, reset = 
  let n = ref 0 in
  (fun () -> n := !n + 1; !n),
  (fun () -> n := 0)
;;

let n = ref 0;;
(* val n : int ref = {contents = 0} *)

let next () =
  n := !n + 1;
  !n

let reset () =
  n := 0


(*    Uso
# #load "counter.cmo";; (* carga el código *) 
# Counter.next ();;
(* En un programa *)

*)

(*================================================*)

module Contador () : sig
  val next : unit -> int
  val reset : unit -> unit
end = struct
    let n = ref 0;;
    let next () =
      n := !n + 1;
      !n
    let reset () =
      n := 0
end;;
(* functor () -> sig val next : unit -> int val reset : unit -> unit end *)

