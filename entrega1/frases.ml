(*x - y;;*)
(*Error al no encontrar x*)

let x = 1;;
(*Definición val x : int = 1*)

(*x - y;;*)
(*Error al no encontrar y*)

let y = 2;;
(*Definición val y : int = 2*)

(*x - y;;*)
(*Devuelve int : -1*)

let x = y in x - y;;
(*Expresión que devuelve int = 0 *)

x - y;;
(*Expresión q devuelve -1*)

(*z;;*)
(*Error al no encontrar z*)

let y = 5 in x + y;;
(*Expresión que devuelve int = 6*)

(*let x = x + y in let y = x * y in x + y + z;;*)
(*Error z no está definido*)

(*x + y + z;;*)
(*Error z no está definido*)

function x -> 2 * x;;
(*Declaración de función int -> int = <func>*)

(function x -> 2 * x) (2 + 1);;
(*Expresión que devuelve int = 6*)

(function x -> 2 * x) 2 + 1;;
(*Expresión que devuelve int = 5*)

let f = function x -> 2 * x;;
(*Definición de función que devuelve el doble de un int con la forma f : int->int = <func>*)

f;;
(*Devuelve como es la función, f : int -> int = <func>*)

f (2+1);;
(*Expresión que devuelve int = 6*)

f 2 + 1;;
(*Expresión que devuelve int = 5*)

f x;;
(*Expresión que devuelve int = 2*)

let x = 100;;
(*Definición de x : int = 100*)

f x;;
(*Expresión que devuelve int = 200*)

let m = 1000;;
(*Definición de m : int = 1000*)

let g = function x -> x + m;;
(*Definición de función g : int -> int = <func>*)

g;;
(*Expresión que nos dice la forma de g, g : int -> int = <func>*)

g 3;;
(*Expresión que devuelve int = 1003*)

(*
let istrue = function true -> true;;
(*Definición de función istrue : bool -> bool = <func>*)
(*Lanza un Warning ya que la función no acepta el valor bool false*)

istrue;;
(*Expresión que nos dice la forma de istrue, istrue : true -> true = <func>*)

istrue (1 < 2);;
(*Expresión que devuelve bool = true*)

istrue (2 < 1);;
(*Fallo de sintáxis ya que la función no acepta valoras booleanos false*)
(*Lanza una excepción porque el parámetro es false y no encaja con el valor de entrada de la función, true*)

(*istrue 0;;*)
(*Error ya que la función esperaba un bool y la entrada es un int*)
*)

(*
let iscero_v1 = function 0 -> true;;
(*Definición de función iscero_v1 : int -> bool = <func> pero lanza Warning xa que sólo espera como parámetro el int 0*)

iscero_v1 0;;
(*Expresión que devuelve bool = true*)

(*iscero_v1 0.;;*)
(*Error ya que la función esperaba un int y la entrada es un float*)

iscero_v1 1;;
(*Lanza una excepción porque el parámetro es 1 y no encaja con el valor de entrada de la función, 0, aunque sean del mismo tipo*)
*)

let iscero_v2 = function 0 -> true | _ -> false;;
(*Definición de función iscero_v2 : int -> bool = <func> que devuelve 0 -> true o cualquier otro número entero -> false*)

iscero_v2 0;;
(*Expresión que devuelve bool = true*)

iscero_v2 1;;
(*Expresión que devuelve bool = false*)

(*iscero_v2 0.;;*)
(*Error ya que la función esperaba un int y la entrada es un float*)

let all_to_true = function true -> true | false -> true;;
(*Definición de función all_to_true : bool -> bool = <func> que devuelve true -> true o false -> true*)

all_to_true (1 < 2);;
(*Expresión que devuelve bool = true*)

all_to_true (2 < 1);;
(*Expresión que devuelve bool = true*)

(*all_to_true 0;;*)
(*Error ya que la función esperaba un bool y la entrada es un int*)

let first_all_to_true = all_to_true;;
(*Definición de función first_all_to_true : bool -> bool = <func> que devuelve true -> true o false -> true*)

let all_to_true = function x->true;;
(*Definición de función all_to_true : int -> bool = <func>*)
(*Definición de función all_to_true : 'a -> bool = <func>, siendo 'a (alfa) cualquier tipo*)

all_to_true (1 < 2);;
(*Expresión que devuelve bool = true*)

all_to_true (2 < 1);;
(*Expresión que devuelve bool = true*)

all_to_true 0;;
(*Expresión que devuelve bool = true*)

(*first_all_to_true 0;;*)
(*Expresión que devuelve bool = true*)
(*Al definirse esta función antes de la reasignación de all_to_true mantiene bool -> bool
por lo que falla ya que espera un bool y la entrada es un int*)

