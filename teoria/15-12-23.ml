(*  REGISTROS *)

type counter = {
  next: unit -> int;
  reset: unit -> unit
};;

let counter = 
    let n = ref 0 in {
        next = (function () -> n := !n + 1; !n);
        reset = (function () -> n := 0)
    }
;;

let new_counter () = 
    let n = ref 0 in {
        next = (function () -> n := !n + 1; !n);
        reset = (function () -> n := 0) 
    }
;;

(* ================================== *)

(* Orientación a objetos en Ocaml *)

let counter = object
    val mutable n = 0
    method next: int = n <- n + 1; n
    method reset: unit = n <- 0
end;;
