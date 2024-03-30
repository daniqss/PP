# Operaciones básicas

ocaml: runtime de ocaml
ocamlopt: produce código máquina
```ocaml
2. +. 4.4;;
# Resultado del Compilador
- : float = 6.4

"para" ^ "sol";;
# Resultado del Compilador
- : string = "parasol"
```

```ocaml
2 *. 3.4;;
Error: This expression has type int but an expression was expected of type
         float
  Hint: Did you mean `2.'?
```
Error en tiempo de compilación.  2 es int y 3.4 es float

```ocaml
# 2 / 0;;
Exception: Division_by_zero.
```
Error en tiempo de ejecución

## Definiciones

### Como dar nombre a los valores (definirlos): 

`let pi = 2. *. asin 1.;;` -> calcula el valor y una vez calculado deja asociado al nombre el valor, **OJO, SOLO EL VALOR, NO LA EXPRESIÓN DE LA FÓRMULA !!**
Una vez hecha la definición podemos operar con el nombre del valor directamente, sin tener que volver a poner la función, lo que supone una ventaja en ahorro de operaciones y de limpieza del código: P.E.: `2. . pi;;` // `pi /. 2.;;`
**OJO:** estos valores definidos no son variables, son solo definiciones, no podemos editarlas después.

### La expresión "let in":
`let x = 3 in x + 1;;` -> **NO** es una definición global, sino una definición local, no es una definición, es una expresión. El valor dado a la x solo tiene valor después del in, no en el resto del código. Si después preguntamos cuánto vale x, saldrá error, pues "no existe".

`let pi = 5 in 2 * pi;;` -> saldrá que pi vale 10, pero una vez volvamos a preguntar el valor de pi, saldrá que vale 3.14...
Podemos definir un let in dentro de un let:
- let x = (*con solo un let, x es una variable GLOBAL*)
`let y = 3 in y + 2;;` (*con un let in, y es una variable LOCAL*)
Lo que saldrá de esto es que el valor de x = 5, pero el valor de 'y' no existe, pues el 'x' estaba dentro de un let, mientras que la 'y' estaba dentro de un 'let in'.

`let x, y = x + y, x * y in x + y;;` es una expresión, no una definición (a pesar de que tiene una dentro), ya que devuelve un valor.
Primero evalúa x + y = 5, luego x * y = 6, luego asigna los valores a x e y, x = 5 e y = 6, y luego realiza la suma del in x + y = 11.
## Salida por pantalla
```ocaml
print_endline "daniel.queijo.seoane@udc.es";;
Printf.printf "%.15f\n" 3.14;;
```

# Declarar tipos
El compilador de ocaml inferirá los tipos de las definiciones por nosotros, pero lo podemos hacer manualmente
```ocaml
let absf (x:float) : float =
	if x < 0.0 then -.x
	else x
```

# Sistemas de evaluación

## Eager o lazy

En OCaml, "eager" y "lazy" se refieren a la evaluación de expresiones y cómo se lleva a cabo. Estos términos también se utilizan comúnmente en el contexto de la evaluación de expresiones en otros lenguajes de programación.

1. **Evaluación Eager (Impaciente o Ansiosa):**
    - En una evaluación eager, también conocida como evaluación ansiosa o impaciente, las expresiones se evalúan tan pronto como sea posible.
    - Esto significa que cuando se asigna un valor a una variable o se pasa una expresión como argumento a una función, la expresión se evalúa inmediatamente.
    - La mayoría de los lenguajes de programación imperativos, como C o Java, utilizan evaluación eager de manera predeterminada.
    
```ocaml
let suma x y = x + y;; let resultado = suma 3 4;;
(* La expresión "suma 3 4" se evalúa inmediatamente *)
```
    
2. **Evaluación Lazy (Perezosa o Tardía):**
    - En una evaluación lazy, también conocida como evaluación perezosa o tardía, las expresiones se evalúan solo cuando es necesario.
    - Esto significa que la evaluación se pospone hasta que el valor de la expresión es realmente necesario para realizar algún cálculo o para producir un resultado.
    - En OCaml, puedes lograr la evaluación lazy utilizando el tipo de datos `lazy`
    
```ocaml
let suma_lazy x y = lazy (x + y);; let resultado_lazy = Lazy.force (suma_lazy 3 4);;
(* La expresión se evalúa cuando se fuerza su evaluación *)
```
    
En este ejemplo, `suma_lazy` devuelve un valor de tipo `int lazy_t`, que es una expresión perezosa. La evaluación real se realiza cuando se utiliza `Lazy.force` para forzar la evaluación de la expresión.
    
La elección entre evaluación eager y lazy depende de las necesidades y requisitos del programa. La evaluación lazy puede ser útil en situaciones donde no todas las partes de una expresión son necesarias para producir un resultado, lo que puede ahorrar tiempo de cómputo en ciertos casos. Sin embargo, también puede introducir complejidad adicional en el control del flujo de programa y en la gestión de recursos.

## Curryficación
Ejemplo de aplicación: `(s 10) 2;;` o sin parénetsis: `s 10 2;;`
`s` solo tiene un argumento, 10, mientras que 2 es el argumento de `s 10`.
`s` funciona igual que la suma de enteros. Es posible interpretar la suma binaria de enteros como una función.
Lo que permite reducir las operaciones binarias a funciones (lo que recibe el nombre de "a la Curry" o "de Curry", por Haskell Curry).
```ocaml
let s = function x -> function y -> x + y;;
(*También se puede escribir como*)
let s x = function y -> x + y;;
(*y como*)
let s x y = x + y;;
(*se utiliza como*) s 2 3;;
```

**OPERADORES INFIJOS COMO FUNCIONES CURRY:**
```ocaml
(+) (*int -> int -> int = <fun>*)
(^) (*string -> string -> string*)
( * ) (*int -> int -> int*)
( ** ) (*float -> float -> float*)
(<=) (*'a -> 'a -> bool = <fun>*)
(=) (*'a -> 'a -> bool = <fun>*)
(||) (*bool -> bool -> bool = <fun>*)
(&&) (*bool -> bool -> bool = <fun>*)
```

No existen las funciones de dos argumentos, sino las funciones que reciben un argumento de un par de enteros.
**CURRYFICAR (CURRY):** pasar una función que tiene esta forma A x B -> C, a otra de esta forma A -> B -> C
**DESCURRYFICAR (UNCURRY):** pasar de esta función A -> B -> C a esta otra A x B -> C
curry(A * B -> C) -> (A -> B -> C)
# Polimorfismo en pattern matching
```ocaml
let all_to_true = function _ -> true;;
(* val all_to_true : 'a -> bool = <fun> *)
```

# Lambda expresiones

### Sustituir if/else con lambda expresiones

Si `<b>` es una expresión correcta de tipo bool en OCaml y `<e1>` y `<e2>` son también dos expresiones correctas en OCaml (ambas del mismo tipo), entonces: 
```ocaml
if <b> then <e1> else <e2> 
es una expresión correcta en OCaml, del mismo tipo que <e1> y <e2>, que se evalúa igual que 
(function true -> <e1> | false -> <e2>) <b>
```

```ocaml
(*if x > y then "first is greater" else "second is greater";;*)
(function true -> "first is greater"
	| false -> "second is greater")
(x>y);;

(* if x > 0 then x else -x;; *)
(function true -> x | false -> -x) (x>0);;

(* if x > 0 then x else if y > 0 then y else 0;; *)
(function true -> x |
	false -> (function true -> y
		| false -> 0)
	(y>0))
(x>0);;

(* if x > y then if x > z then x else z 
	else if y > z then y
	else z;; *)
(function true -> (function true -> x | false -> z) (x>z)
	| false -> (function true -> y | false -> z) (y>z))
(x>y);;
```

# Tuplas

```ocaml
int * int -> 2,3
(int * int) * int -> (2, 3), 1 
(* una dupla de numeros cuya primera componente también es una dupla *)
int * int * int -> 2, 3, 1
```

#### Tuplas con componentes tupla
```ocaml
true, 0, "trio";;
(* - : bool * int * string = (true, 0, "trio") *)
(true, 0), "falso trio";;
(* - : (bool * int) * string = ((true, 0), "falso trio") *)
```
#### Tipo de la x?
```ocaml
let x = (true, abs);;
(* val x : bool * (int -> int) = (true, <fun>) *)
```
fst y snd nos permite obtener toda la información de un par:
(snd x) (-7);;
`(* - : int = 7 *)`

Las funciones fst y snd ya vienen definidas, pero si tuviéramos que definirlas:
```ocaml
let fst (x, y) = x;;
let fst (x, _ ) = x;; 
(*no le damos nombre a la segunda componente porque no se usa para obtener el resultado*)
```

# Listas

### Length

```ocaml
let length l = List.fold_left (fun n _ -> n + 1) 0 l;;
```

- `let length l = ...` : Esta línea define una función llamada `length` que toma un argumento `l`, que se espera que sea una lista.

- `List.fold_left` es una función de la biblioteca estándar de OCaml que toma tres argumentos:
	- El primer argumento es una función anónima `(fun n _ -> n + 1)`. Esta función toma dos argumentos: `n` (que es el acumulador para el recuento) y `_` (que es un marcador para el elemento actual de la lista que no se usa en este caso, por eso se usa el guion bajo). La función incrementa el contador `n` en 1 cada vez que se llama, lo que efectivamente cuenta los elementos de la lista.
	- El segundo argumento es el valor inicial del acumulador, que es `0` en este caso.
	- El tercer argumento es la lista `l` sobre la cual se está operando.

Entonces, lo que hace esta función es recorrer la lista `l` y, para cada elemento, incrementa un contador en 1, comenzando desde 0. Al final del recorrido, devuelve el valor final del contador, que es la longitud total de la lista `l`.

### Sorted
sorted: 'a list -> bool
non compila
```ocaml
let rec sorted l = function 
	[] -> true
	| _::[] -> true (*simplifica si tienen mismo nombre*)
	| h1::h2::t -> h1 <= h2 && sorted (h2::t)
```

g_sorted: ('a -> 'a -> bool)
```ocaml
let rec g_sorted l = function 
	[] -> _::[] -> true (*simplifica si tienen mismo nombre*)
	| h1::h2::t -> h1 ord h2 && g_sorted ord (h2::t);;
```

### Insert

este insert no es recursivo terminal
```ocaml
let rec insert x = function
	[] -> [x]
	| h::t -> if x <= h then x::h::t
			  else h::insert x t

```


### Isort ()

este insertion sort no es recursivo terminal
```ocaml
let rec isort = function 
	[] -> []
	| h::t -> insert h (isort t);;



```ocaml
[1; 2; 3; 4; 5];;
- : int list = [1; 2; 3; 4; 5]
  
[6; 0];;
- : int list = [6; 0]

['a'];;
- : char list = ['a']
  
[true; true];;
- : bool list = [true; true]
  
[1,2];;
- : (int * int) list = [(1, 2)]
  
[()];;
- : unit list = [()]  

[(); ()]
- : unit list = [(); ()]
  
[];;
- : 'a list = []
```
Las seuencias deben ser finitas, 0 o más elementos todos del mismo tipo, es decir, las listas son homogéneas.

### Funciones de Orden Superior

Se puede escribir una función `map` que aplique otra función a cada elemento de una lista, generando una nueva lista. Esta función es un ejemplo de función de orden superior:

```ocaml
# let rec map f l = match l with
	| [] -> []
	| h :: t -> f h :: map f t
;;
(* val map : ('a -> 'b) -> 'a list -> 'b list = <fun> *)
```


### Listas y Recursión Terminal

Para evitar desbordamientos de pila en funciones que operan en listas largas, es común usar recursión de cola. Por ejemplo, la función `length` se puede redefinir para ser tail-recursiva:


```ocaml
# let length l = 
	let rec length_inner acc l = 
	match l with
	| [] -> acc
	| _ :: t -> length_inner (acc + 1) t
	in length_inner 0 l
;;
(* val length : 'a list -> int = <fun> *)
```

#### Append recursivo terminal

```ocaml
let rec rev_append l1 l2 = match l1 with
	[] -> l2
	| h::t -> rev_append t (h::l2);;

let rev l = rev_append l [];;

let append' l1 l2 = rev_append (rev l1) l2;;
```

#### Varias funciones recursivas terminales


```ocaml
let rec divide = function (*Divide una lista*)
	[] -> [], []
	| h::[] -> [h], []
	| h1::h2::t -> let t1, t2 = divide t
			       in (h1::t1, h2::t2)
;;

let divide_ter l =
  let rec aux l acc1 acc2 = match l with
    [] -> acc1, acc2
    | h::[] -> h::acc1, acc2
    | h1::h2::t -> aux t (h1::acc1) (h2::acc2)

  in aux l [] []
;;

let divide_ter l =
  let rec aux l acc1 acc2 =
    match l with
    | [] -> List.rev acc1, List.rev acc2
    | h::[] -> List.rev (h::acc1), List.rev acc2
    | h1::h2::t -> aux t (h1::acc1) (h2::acc2)
  in aux l [] []
;;

let comb fn list =
	let rec aux fn list acc = match list with
		| [] -> acc
		| h::[] -> h::acc
		| h1::h2::t -> aux fn t (fn h1 h2::acc)
	in List.rev (aux fn list [])
;;
```

# Excepciones

```ocaml
Failure "hd";;
(* - : exn = Failure "hd" *)

Invalid_argument "ese argumento no vale";;
(* - : exn = Invalid_argument "ese argumento no vale" *)

Failure "no seas burro!";;
(* - : exn = Failure "no seas burro!" *)

Division_by_zero;;
(* - : exn = Division_by_zero *)
```
Tanto `Failure` como `Invalid_argument` pueden crear tantos valores como strings haya.

Pero `Division_by_zero` no acepta strings, por tanto solo puede devolver un valor posible.

```ocaml
let rec last = function
	[] -> raise (Failure "last")
	| h::[] -> h
	| _::t -> last t;;
```

## Intervención de excepciones

```ocaml
try <e> with

<p1> -> <e1>

|

.

| <pn> -> <en>

```
# Options

```ocaml
# None;;
- : 'a option = None
# Some 3;;
- : int option = Some 3
# Some true;;
- : bool option = Some true
# [Some 2; Some 3; None];;
- : int option list = [Some 2; Some 3; None]
```

Ejemplos de funciones que utilizan Options
```ocaml
let print_first_pos = 
	match List.find_opt((<) 0) l with
	None -> print_endline "No hay ningun positivo"
	| Some n -> print_endline (string_of_int n)
;;

let rec find_opt f l =
	match l with
	| [] -> None
	| h::t -> if f h then h else find_opt f t
;;
(* Devuelve un 'a option *)
```


# Palabra reservada `ref`

En OCaml, la palabra clave `ref` se utiliza para crear referencias mutables.
En este caso, `contador` es una referencia mutable que inicialmente contiene el valor `0`. Puedes acceder y modificar el valor utilizando las funciones `!` y `:=` respectivamente:

```ocaml
let contador = ref 0;;
let valor_actual = !contador;; 
(* Obtiene el valor actual *)
contador := 10;;
(* Asigna un nuevo valor *)`
```

Esta forma de referencia mutable es útil cuando necesitas actualizar y compartir valores mutables en diferentes partes de tu programa. Por ejemplo, podrías usarlo para mantener un contador que se actualiza en varias funciones.

Aquí hay un ejemplo más completo utilizando un contador:
```ocaml
let contador = ref 0;;  let incrementar_contador () =   contador := !contador + 1;;  let obtener_valor_contador () =   !contador;;  let reiniciar_contador () =   contador := 0;;
```

En este caso, `incrementar_contador` aumenta el valor del contador, `obtener_valor_contador` devuelve el valor actual, y `reiniciar_contador` restablece el contador a cero.
# Structs

```ocaml
type person = {
	name: string;
	age: int;
}

let p1 = { name = "Pepe"; age = 42; };;
let p2 = { name = "Juan"; age = 23; };;

  
let older p = {
	p with age = p.age + 1;
}
(* Crea otro struct igual pero con un año más *)

let ord p1 p2 =
	p1.age < p2.age ||
	p1.age = p2.age && p1.name <= p2.name
;;
```


## Mutabilidad

```ocaml
(* Mismo struct pero con campo mutable *)

type person = {
	name: string;
	mutable age: int;
}

  
let aged p = p.age <- p.age + 1;;

(* val aged : person -> unit = <fun> *)
```

## Constructor de tipos mutable

Implementación de 'a ref en ocaml (sirve para crear referencias mutables)

```ocaml
type 'a var = {
	mutable valor: 'a
};;

  
let init_var x = {
	valor = x
};;

  
(* Implementación de re *)
let (!!) v = v.valor;;
let (<<) v x = v.valor <- x;;
```


# Módulos

counter.ml
```ocaml
let n = ref 0;;
(* val n : int ref = {contents = 0} *)

let next () =
	n := !n + 1;
	!n
(* val next : unit -> int = <fun> *)

let reset () =
	n := 0


```

counter.mli
```ocaml
val next : unit -> int
val reset : unit -> unit
```

Compilación
```bash
ocamlc -c counter.mli counter.ml
ocamlc -o mi_programa counter.cmo # compila el programa
```

Uso
```ocaml
(* Cargar el módulo Counter *)
#load "counter.cmo";;
(* Importar las funciones desde el módulo *)
open Counter;;
```

## Functores

```ocaml
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
```

1. **Uso del Functor:**

```ocaml
(* functor () -> sig val next : unit -> int val reset : unit -> unit end *)
```

Este comentario muestra cómo se usa el functor `Contador`. Al aplicar el functor con `()`, se obtiene un módulo que satisface la firma especificada en `sig`.

2. **Ejemplo de Uso del Módulo Generado por el Functor:**


```ocaml
let contador_modulo = Contador ();; (* Crear un módulo usando el functor *)
contador_modulo.next ();;           (* Incrementar el contador *) contador_modulo.reset ();;          (* Reiniciar el contador *)
```

Aquí, `contador_modulo` es un módulo generado por `Contador`, y puedes usar las funciones `next` y `reset` proporcionadas por el módulo. Este enfoque es útil cuando deseas tener múltiples contadores independientes en tu programa y no quieres que compartan el mismo estado.


# Orientación a objetos

No tienes que explicitar el tipo, lo infiere el compilador

El tipo de un objeto lo determina los tipos de sus atributos y sus métodos
Este objeto es inmediato, no esta en una clase.
```ocaml
(* Otro puto contador pero esta vez con POO *)

let counter = object
	val mutable n = 0
	method next: int = n <- n + 1; n
	method reset: unit = n <- 0
end;;

counter#next
(* - : int = 1 *)
```

## Clases

```ocaml
class counter = object
	val mutable n = 0
	method next: int = n <- n + 1; n
	method reset: unit = n <- 0
end;;

let c1 = new counter
and c2 = new counter;;
(*
val c1 : counter = <obj>
val c2 : counter = <obj>
*)
```

`counter` es un alias de `object val mutable n : int method next : int method reset : unit end`

## Herencia

```ocaml
class counter_with_set = object
	inherit counter
	method set x = n <- x
end;;

let c3 = new counter_with_set;;
(* val c3 : counter_with_set = <obj> *)
(c3 :> counter);;
(* - : counter = <obj> *)

let list = [c1; c2; (c3 :> counter)];;
(* val list : counter list = [<obj>; <obj>; <obj>] *)


```

Podemos restringir un objeto a la clase de la que hereda, podiendo hacer cosas como una lista de objetos de clase (y por ende tipo) diferentes, porque en la lista metes la "instancia" del objeto heredado

## Clases abstractas

```ocaml
class virtual foo1 = object
	method virtual m: int
end;;

let o = new foo1;;
(* Error: Cannot instantiate the virtual class foo1 *)

class foo2 = object
	inherit foo1
	method m = 0
end;;



let example = new foo2;;
example#m;;
(* - : int = 0 *)
(example :> foo1)#m;;
# (example :> foo1)#m;;
(* - : int = 0 *)

```

## Encapsulamiento

```ocaml
class foo3 = object
	val o = new foo2
	method m = o#m     
end;;
(* LLamamos al metodo del objeto de dentro *)

```

## Construir con parámetros y inicializador

Volvemos al contador

```ocaml
class counter_with_init ini = object (self)
	inherit counter_with_set
	method reset = self#set ini    (* n <- ini *)
	
	initializer self#reset
end;;
```


## Herencia múltiple

En Ocaml hay herencia múltiple y los inicializadores se ejecutan en orden según se hereden. Los métodos de las clases padre no se eliminan al sobreescribirse, se ocultan y se puede acceder a ellos con los aliases de los padres

```ocaml
class counter_with_step = object (self)
	inherit counter_with_init 0 as super
	val mutable step = 1
	method next = n <- n + step; n
	method set_step s = step <- s
	method reset = super#reset; self#set_step 1
end;;
```

## Clases polimórficas

```ocaml
exception EmptyStack;;

class ['a] stack = object 
	val mutable l = ([]: 'a list)
	method push x =
		l <- x :: l
	method pop = 
		match l with
		| [] -> raise EmptyStack
		| h::t -> l <- t; h
	 method peek =
		 match l with
		 | [] -> raise EmptyStack
		 | h::_ -> h
end;;
```

`['a]` es comparable con 
```ocaml
type 'a bintree =
	Empty
	| Node of 'a * 'a bintree * 'a bintree;;
```

# Arrays

To create an array in OCaml, you can use the `[| ...; ... |]` syntax, which allows you to specify the values of each element directly. For example, to create an array with the values 1, 2, 3, 4, and 5, you will write `[| 1; 2; 3; 4; 5 |]`:

```ocaml
# [| 1; 2; 3; 4; 5 |];;
- : int array = [|1; 2; 3; 4; 5|]
```

Alternatively, you can create an array using the `Array.make` function, which takes two arguments: the length of the array and the initial value of each element. For example, to create an array of length 5 with all elements initialised to 0, you can write:

```ocaml
# let zeroes = Array.make 5 0;;
val zeroes : int array = [|0; 0; 0; 0; 0|]
```

`Array.init` generates an array of a given length by applying a function to each index of the array, starting at 0. The following line of code creates an array containing the first 5 even numbers using a function which doubles its argument:

```ocaml
# let even_numbers = Array.init 5 (fun i -> i * 2);;
val even_numbers : int array = [|0; 2; 4; 6; 8|]
```

## Array Elements

You can access individual elements of an array using the `.(index)` syntax, with the index of the element you want to access. The index of the first element is 0, and the index of the last element is one less than the size of the array. For example, to access the third element of an array `even_numbers`, you would write:

```ocaml
# even_numbers.(2);;
- : int = 4
```

## Array Elements

To modify an element in an array, we simply assign a new value to it using the indexing operator. For example, to change the value of the third element of the array `even_numbers` created above to 42, we have to write:

```ocaml
# even_numbers.(2) <- 42;;
- : unit = ()
```

Note that this operation returns `unit`, not the modified array. `even_numbers` is modified in place as a side effect.

## Standard Library `Array` Module

OCaml provides several useful functions for working with arrays. Here are some of the most common ones:

### Length of an Array

The `Array.length` function returns the size of an array:

```ocaml
# Array.length even_numbers;;
- : int = 5
```

### Iter on an Array

`Array.iter` applies a function to each element of an array, one at a time. The given function must return `unit`, operating by side effect. To print all the elements of the array `zeroes` created above, we can apply `print_int` to each element:

```ocaml
# Array.iter (fun x -> print_int x; print_string " ") zeroes;;
0 0 0 0 0 - : unit = ()
```

Iterating on arrays can also be made using `for` loops. Here is the same example using a loop:

```ocaml
# for i = 0 to Array.length zeroes - 1 do
    print_int zeroes.(i);
    print_string " "
  done;;
0 0 0 0 0 - : unit = ()
```

### Map an Array

The `Array.map` function creates a new array by applying a given function to each element of an array. For example, we can get an array containing the square of each number in the `even_numbers` array:

```ocaml
# Array.map (fun x -> x * x) even_numbers;;
- : int array = [|0; 4; 1764; 36; 64|]
```

### Folding an Array

To combine all the elements of an array into a single result, we can use the `Array.fold_left` and `Array.fold_right` functions. These functions take a binary function, an initial accumulator value, and an array as arguments. The binary function takes two arguments: the accumulator's current value and the current element of the array, then returns a new accumulator value. Both functions traverse the array but in opposite directions. This is essentially the same as `List.fold_left` and `List.fold_right`.

Here is the signature of `Array.fold_left`:

```ocaml
# Array.fold_left;;
val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b array -> 'a = <fun>
```

`fold_left f init a` computes `f (... (f(f init a.(0)) a.(1)) ...) a.(n-1)`

Similarly, we can use the `Array.fold_right` function, which switches the order of its arguments:

```ocaml
# Array.fold_right;;
val fold_right : ('b -> 'a -> 'a) -> 'b array -> 'a -> 'a = <fun>
```

`fold_right f a init` computes `f a.(0) (f a.(1) ( ... (f a.(n-1) init) ...))`

These functions derive a single value from the whole array. For example, they can be used to find the maximum element of an array:

```ocaml
# Array.fold_left Int.max min_int even_numbers;;
- : int = 42
```

### Sort an Array

To sort an array, we can use the `Array.sort` function. This function takes as arguments:

- a comparison function
- an array It sorts the provided array in place and in ascending order, according to the provided comparison function. Sorting performed by `Array.sort` modifies the content of the provided array, which is why it returns `unit`. For example, to sort the array `even_numbers` created above, we can use:

```ocaml
# Array.sort compare even_numbers;;
- : unit = ()
# even_numbers;;
- : int array = [|0; 2; 6; 8; 42|]
```

## Part of an Array into Another Array

The `Array.blit` function efficiently copies a contiguous part of an array into an array. Similar to the `array.(x) <- y` operation, this function modifies the destination in place and returns `unit`, not the modified array. Suppose you wanted to copy a part of `ones` into `zeroes`:

```ocaml
# let ones = Array.make 5 1;;
val ones : int array = [|1; 1; 1; 1; 1|]
# Array.blit ones 0 zeroes 1 2;;
- : unit = ()
# zeroes;;
- : int array = [|0; 1; 1; 0; 0|]
```

This copies two elements of `ones`, starting at index `0` (this array slice is `[| 1; 1 |]`) into `zeroes`, starting at index `1`. It is your responsibility to make sure that the two indices provided are valid in their respective arrays and that the number of elements to copy is within the bounds of each array.

We can also use this function to copy part of an array onto itself:

```ocaml
# Array.blit zeroes 1 zeroes 3 2;;
- : unit = ()
# zeroes;;
- : int array = [|0; 1; 1; 1; 1|]
```

This copies two elements of `zeroes`, starting at index `1` into the last part of `zeroes`, starting at index `3`.


# Árboles

```ocaml
type 'a bintree =
	Empty
	| Node of 'a * 'a bintree * 'a bintree
;;

let rec in_order = function
	Empty -> []
	| Node (root, izq, drch) ->
			(in_order izq) @ [root] @ (in_order drch)
;;  

let rec insert criterio tree x = match tree with
	| Empty -> Node (x, Empty, Empty)
	| Node (root, izq, drch) -> (match criterio x root with
		| true -> Node (root, insert criterio izq x, drch)
		| false -> Node (root, izq, insert criterio drch x)
	)
;;

let bst criterio list =
	let rec aux acc = function
	[] -> acc
	| h :: t -> aux (insert criterio acc h) t
	in aux Empty list
;;

let qsort criterio = function
	[] -> []
	| h :: t -> in_order (bst criterio (h :: t))
;;

```

Funciones hechas en clase:
```ocaml
let rec nnodos = function
	Empty -> 0
	| Node (_, i, d) -> 1 + nnodos i + nnodos d;;

let rec altura = function
	Empty -> 0
	| Node (_, l, r) -> 1 + max (altura i) (altura d);;

let rec tmax = function
Empty -> raise (Invalid_argument "tmax")
	| Node (r, Empty, Empty) -> r
	| Node (r, Empty, rama) | Node (r, rama, Empty) ->
		max r (tmax rama)
	| Node (r, i, d) -> max r (max (tmax i) (tmax d));;

let rec preorden = function
	Empty -> []
	| Node (r, i, d) -> t :: (preorden i) @ (preorden d);; 

let rec hojas = function
	Empty -> []
	| Node (r, Empty, Empty) -> [r]
	| Node (r, i, d) -> hojas i @ hojas d;;
```

### Creando un árbol binario

```ocaml
# Empty;;
- : 'a bintree = Empty

# Node (5, Empty, Empty);;
- : int bintree = Node (5, Empty, Empty)

# let t5 = Node (5, Empty, Empty);;
val t5 : int bintree = Node (5, Empty, Empty)

# Node (1, t5, Empty);;
- : int bintree = Node (1, Node (5, Empty, Empty), Empty)

# let t11 = Node (2, Empty, Empty);;
val t11 : int bintree = Node (2, Empty, Empty)

val h : 'a -> 'a bintree = <fun>

# let t11 = h 2;;
val t11 : int bintree = Node (2, Empty, Empty)

# let t12 = Node (6, h 5, h 11);;
val t12 : int bintree = Node (6, Node (5, Empty, Empty), Node (11, Empty, Empty))

# let t22 = Node (9, h 4, Empty);;
val t22 : int bintree = Node (9, Node (4, Empty, Empty), Empty)

# let e = Empty;;
val e : 'a bintree = Empty

# let t1 = Node (7, t11, t12);;
val t1 : int bintree =
	Node (7, Node (2, Empty, Empty),
	Node (6, Node (5, Empty, Empty), Node (11, Empty, Empty)))
```

### Árbol estrictamente binario

Árboles estrictamente binarios con valores 'a en los nodos:
```ocaml
type 'a st_bintree =
Node of 'a * 'a st_bintree * 'a st_bintree
| Leaf of 'a;;

(* Definimos un nodo 'E' con sus respectivos hijos (hojas), 'F' y 'G' *)
# let t_e = Node ('E', Leaf 'F', Leaf 'G');;
val t_e : char st_bintree = Node ('E', Leaf 'F', Leaf 'G')

(* Definimos un nodo 'B' con sus hijos 'D' y t_e *)
# let t_b = Node ('B', Leaf 'D', t_e);;
val t_b : char st_bintree =
Node ('B', Leaf 'D', Node ('E', Leaf 'F', Leaf 'G'))

(* Definimos el árbol entero t *)
# let t = Node ('A', t_b, Leaf 'C');;
val t : char st_bintree =
Node ('A', Node ('B', Leaf 'D', Node ('E', Leaf 'F', Leaf 'G')), Leaf 'C')
```

# Resultados del compilador

**`expr.ml`, práctica 1**
```ocaml
();;
(* unit = () *)
  
2 + 3 * 5;;
(* int = 17 *)
  
1.25 *. 2.;;
(* float = 2.5 *)
  
(* 2 - 2. *);;
(* This expression has type float but an expression was expected of type int *)
  
(* 2. + 3. *);;
(* Error: This expression has type float but an expression was expected of type int *)

5 / 3;;
(* int = 1 *)

5 mod 3;;
(* int = 2 *)
  
2.0 *. 3.0 ** 2.0;;
(* int = 18 *)

2.0 ** 3.0 ** 2.0;;
(* int = 512 *)
  
sqrt;;
(* float -> float = <fun> *)

(* sqrt 4 *);;
(* This expression has type int but an expression was expected of type float *) 

int_of_float;;
(* float -> int = <fun> *)

float_of_int;;
(* int -> float = <fun> *)

(* int_of_float -2.9;; *)
(* Error de tipo derivado de un error de sintaxis *)

int_of_float 2.1 + int_of_float (-2.9);;
(* int = 0 *)

truncate;;
(* float -> int = <fun> *)

truncate 2.1 + truncate (-2.9);;
(* int = 0 *)

floor;;
(* float -> float = <fun> *)

floor 2.1 +. floor (-2.9);;
(* float = -1 *)

ceil;;
(* float -> float = <fun> *)

ceil 2.1 +. ceil (-2.9);;
(* float = 1 *)

int_of_char;;
(* char -> int = <fun> *)

int_of_char 'A';;
(* int = 65*)

char_of_int;;
(* int -> char = <fun> *)

char_of_int 66;;
(* char = 'B'*)

Char.code;;
(* char -> int = <fun> *)

Char.code 'B';;
(* int = 66 *)

Char.chr;;
(* int -> char = <fun> *)

Char.chr 67;;
(* char = 'C' *)

'\067';;
(* char = 'C' *)

Char.chr (Char.code 'a' - Char.code 'A' + Char.code 'M');;
(* char = 'm' *)

Char.lowercase_ascii;;
(* char -> char = <fun> *)

Char.lowercase_ascii 'M';;
(* char = 'm' *)

Char.uppercase_ascii;;
(* char -> char = <fun> *)

Char.uppercase_ascii 'm';;
(* char = 'M' *)

"this is a string";;
(* string = "this is a string";; *)

String.length;;
(* string -> int = <fun> *)

String.length "longitud";;
(* int = 8 *)

(* "1999" + "1";; *)
(* This expression has type string but an expression was expected of type int *)

"1999" ^ "1";;
(* string = "19991" *)

int_of_string;;
(* string -> int = <fun> *)

int_of_string "1999" + 1;;
(* int = 2000 *)

"\065\066";;
(* string = "AB" *)

string_of_int;;
(* int -> string = <fun> *)

string_of_int 010;;
(* string = "10" *)
  
not true;;
(* bool = false *)

true && false;;
(* bool = false *)
  
true || false;;
(* bool = false *)
  
(1<2) = false;;
(* bool = false *)
  
"1" < "2";;
(* bool = true *)

2 < 12;;
(* bool = true *)

"2" < "12";;
(* bool = false *)

"uno" < "dos";;
(* bool = false *)

if 3 = 4 then 0 else 4;;
(* int = 4 *)

if 3 = 4 then "0" else "4";;
(* string = "4" *)

(* if 3 = 4 then 0 else "4";; *)
(* This expression has type string but an expression was expected of type int *)

(if 3 < 5 then 8 else 10) + 4;;
(* int = 12 *)
```

**`frases4.ml`, práctica 4**
```ocaml
let p = (1 + 1, asin 1.), true;;
(* val p : (int * float) * bool = ((2, 1.57079632679489656), true) *)
  
let (x, y), z = p;;
(*
val x : int = 2
val y : float = 1.57079632679489656
val z : bool = true
*)

let p1, p2 = p in let p11, _ = p1 in (p2, 2 * p11);;
(* - : bool * int = (true, 4) *)

let f (x, y) = 2 * x + y;;
(* val f : int * int -> int = <fun> *)

let f2 x y z = x + 2 * y + 3 * z;;
(* val f2 : int -> int -> int -> int = <fun> *)
  
let g x y z = x (y, z);;
(* val g : ('a * 'b -> 'c) -> 'a -> 'b -> 'c = <fun> *)
  
g fst 1 "hola";;
(* - : int = 1 *)

g snd fst true;;
(* - : bool = true *)

g f 2 3;;
(* - : int = 7 *)

g (function (f, x) -> f (f x)) (function x -> x*x) 3;;
(* - : int = 81 *)

let x, y, z= 1, 2, 3;;
(*
val x : int = 1
val y : int = 2
val z : int = 3
*)

f2 x y z;;
(* - : int = 14 *)

let x, y, z= y, z, x in f2 x y z;;
(* - : int = 11 *)

f2 x y z;;
(* - : int = 14 *)

let swap (x,y) = y,x;;
(* val swap : 'a * 'b -> 'b * 'a = <fun> *)

let p = 1, 2;;
(* val p : int * int = (1, 2) *)

f p;;
(* - : int = 4 *)

let p = swap p in f p;;
(* - : int = 5 *)

f p;;
(* - : int = 4 *)
```
