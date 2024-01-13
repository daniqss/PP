(* APUNTES DE SUSANA VILARNOVO ALLAL - UDC (PP) *)


Escribir "ledit ocaml" antes de abrir ocaml para poder moverse entre las líneas de comandos y editarlos más fácilmente.


2 * 1.5;; -> Error de tipos (compilación)
2 / 0;; -> Error de tipos (ejecución)
2 *;; // 2 3 *;; // x;; -> Error léxico, de sintaxis (compilación)


Comillas simples: 'a' es un tipo char;
Comillas dobles: "a", es un tipo string;


Si operamos entre distintos tipos de datos salta un fallo en tiempo de compilación -> P.E.: 'a' = "a";;


asin 1.0;; == asin (1.0);; == asin (0.5 +. 0.5);; == arcoseno 1.0 (este solamente en la versión 5.0) != asin 0.5 +. 0.5;;


4 / 3;; -> va a devolver como resultado un entero -> si escribes una operación entre enteros devolverá enteros, si escribes operaciones entre floats devolverá floats... etc.
4 / 3 + 1 != 4 / (3 + 1);;


función abs -> función valor absoluto:
- si ponemos "abs -3;;" realizará: función -3, como una resta, lo que resulta en un error de compilación, la forma correcta es "abs (-3);;".


print_endline -> función que recibe un string y devuelve un tipo unit y escribe el string en pantalla.


STRINGS:
- "para" ^ "sol";; -> da como resultado el string "parasol".
- 12345 ^ 678;; -> da como resultado un error de compilación, pues la expresión es de tipo int pero el compilador espera un tipo string.
- "char_of_int 65;;" -> devolverá el caracter 65 de la tabla ASCII, la 'A'.
- "int_of_char 'A';;" -> devolverá como resultado el valor entero asociado al caracter 'A', el 65.
- En los dos comandos anteriores, en caso de poner un caracter o un número no asociados a la tabla ASCII devolverá un error de ejecución.
- int_of_char 'A';; == Char.code 'A';;

float_of_int 2;; -> devuelve el valor float (2.) del valor entero dado (2).
Una forma de solucionar el error de sintaxis (1 +. 2.5;;) es poniendo (float_of_int 1 +. 2.5;;).


COMO DAR NOMBRE A LOS VALORES (DEFINIRLOS): se realiza con la sintaxis "let".
let pi = 2. *. asin 1.;; -> calcula el valor y una vez calculado deja asociado al nombre el valor, OJO, SOLO EL VALOR, NO LA EXPRESIÓN DE LA FÓRMULA !!
Una vez hecha la definición podemos operar con el nombre del valor directamente, sin tener que volver a poner la función, lo que supone una ventaja en ahorro de operaciones y de limpieza del código: P.E.: 2. *. pi;; // pi /. 2.;;
OJO: estos valores definidos no son variables, son solo definiciones, no podemos editarlas después.
Aunque es posible, NO ASIGNAR nombres de funciones a valores, pues puede llevar a confusiones, además, a la hora de utilizar la función Ocaml lo tomará como el valor definido, no como la función.
Si asigno el mismo nombre a dos valores diferentes, quedará vigente la última asignada:
- let no = not;;
- let no = 0;; -> quedará asignado el valor 0 al not, queda descartado el valor not.

La expresión "let in":
let x = 3 in x + 1;; -> NO es una definición global, sino una definición local, no es una definición, es una expresión. El valor dado a la x solo tiene valor después del in, no en el resto del código. Si después preguntamos cuánto vale x, saldrá error, pues "no existe".
let pi = 5 in 2 * pi;; -> saldrá que pi vale 10, pero una vez volvamos a preguntar el valor de pi, saldrá que vale 3.14...
Podemos definir un let in dentro de un let:
- let x = (*con solo un let, x es una variable GLOBAL*)
	let y = 3 in y + 2;; (*con un let in, y es una variable LOCAL*)
Lo que saldrá de esto es que el valor de x = 5, pero el valor de 'y' no existe, pues el 'x' estaba dentro de un let, mientras que la 'y' estaba dentro de un 'let in'.


-----------------------22/09/23----------------------

let x = 10;;
val x : int = 10

let x = 2 * x in let x = x + 1 in x * x * x;;
(*let x = 2 * 10 in let x = 20 + 1 in 21 * 21 * 21;; -> siempre cogerá el valor de x más cercano*)
- : int = 9261


DEFINIR FUNCIONES (LAMBDA EXPRESIÓN):
function true -> false | false -> true;; (*NO ESTAMOS DEFINIENDO, solamente estamos representando la expresión de una operación*)
- : bool -> bool = <fun>

function true -> false;; (*Es una función válida, pero saltará un warning al no definir el caso false*)

APLICAR FUNCIONES:
(function true -> false | false -> true) true;;
- : bool = false

(function true -> false | false -> true) 2 < 3;; (*ESTÁ MAL, LA FUNCIÓN TRABAJA CON VALORES BOOLEANOS, NO CON INTS
 PARA QUE SEA CORRECTA APLICAMOS PARÉNTESIS:*)
(function true -> false | false -> true) (2 < 3);;
- : bool = false

(function true -> false) (2 < 3);;
Warning (etc, ejecutar para ver el warning)
- : bool = false


Se pueden aplicar valores a funciones:
let no = function true -> false | false -> true;; (*EN ESTE CASO SÍ ESTAMOS DEFINIENDO UNA FUNCIÓN*)
val no : bool -> bool = <fun>

no (2 < 3);;
- : bool = false



COMODÍN EN LAS FUNCIONES (POLIMORFISMO):
let all_to_true = function _ -> true;; (*la barra baja _ es el comodín, de esta forma no asignamos un tipo específico*)
val all_to_true : 'a -> bool = <fun> (*'a -> valor polimórfico (fenómeno: polimorfismo), es un tipo pero admite muchos otros*)

Aplicación:
all_to_true (2 < 3);;
- : bool = true

all_to_true 2;;
- : bool = true

EN EL CÓDIGO DE LAS FUNCIONES SE PUEDEN HACER ANOTACIONES DE TIPO:
let alltrue = function (x: bool) -> true;; (*RESTRINGE EL TIPO DE X, de esta forma el compilador sabe que x debe ser un bool*)
let alltrue = function x -> true;; (*DE ESTA FORMA EL COMPILADOR NO RESTRINGE EL TIPO DE ENTRADA, acepta cualquier tipo 'a*)

También se puede escribir así:
let alltrue: bool -> bool = function x -> true;; (*No se usa mucho debido a la falta de paréntesis, que lleva a confusión*)

En vez de llamar al tipo de dato de entrada 'x', se puede utilizar el comodín: _, pero solo en la parte izquierda de la función
Poniendo el comodín se entiende que no utilizaremos el valor para nada, en cambio si le asignamos un nombre como 'x' parece que sí utilizaremos el valor

La primera regla de la siguiente función ya le marca el tipo a la función:
let notzero = function 0 -> false
					   _ -> true;;
val notzero : int -> bool = <fun>
(*La primera regla va de int -> bool, por tanto el compilador entiende que en la segunda regla igual aunque no hayamos asignado un tipo específico*) 	
Ejemplo del funcionamiento de esta función:
notzero (1-1);;
- : bool = false
notzero (1+1);;
- : bool = true
(*Por tanto, en esta función el comodín no representa CUALQUIER tipo, sino cualquier entrada de TIPO INT*)

¿Qué ocurre si cambiamos las reglas de orden? -> Siempre dará true
let notzero = function _ -> true
					   0 -> false;;
(*Dará siempre true ya que la primera regla admite CUALQUIER tipo entero, y por tanto saltará un warning avisando de que la segunda regla es redundante (pues es un int), pues no se usará, siempre se va a aplicar la primera regla
Compila, pero salta un warning, en cambio, si quitamos la segunda regla pasará a ser una función polimórfica, NO SOLO DE ENTEROS*)


SISTEMAS DE EVALUACIÓN:
- eager
- lazy


03/10/23------------------------------------------

QUÉ TIPO TIENE:
- (int -> int) -> int (de int en int)
	Para declarar un tipo de este tipo:
	let v0 = function f -> 2 * f 1;;
	v0 recibe como parámetro funciones que llevan un int a otro int 
	v0: (int -> int) -> int

	v0 recibe una función y devuelve el doble del valor de la función en 1 (un buen ejemplo se ve ejecutando v0 abs;;).

	Si ponemos:
		let v1 = function f -> f 1;;
		El valor de v1 es:
			v1: (int -> 'a) -> 'a
		El compilador no interpreta que debe ser de int a int.

NOTA: función "succ", dado un int devuelve su siguiente. Función "pred", dado un int devuelve su anterior.


QUÉ TIPO TIENE:
- int -> (int -> int)
	Para declarar un tipo de este tipo:
	let s = function n -> (function i -> n + i);; (*No tiene por qué ir con paréntesis*)
	s: int -> (int -> int)

	Ejemplo de aplicación: (s 10) 2;; o sin parénetsis: s 10 2;;
	s solo tiene un argumento, 10, mientras que 2 es el argumento de s 10.
	s funciona igual que la suma de enteros. Es posible interpretar la suma binaria de enteros como una función.
	Lo que permite reducir las operaciones binarias a funciones (lo que recibe el nombre de "a la Curry" o "de Curry", por Haskell Curry).


¡! NOTA: Las funciones solo tienen un argumento ¡!.

let suc = (+) 1;;
De esta forma hemos creado la función succ.

let pre = (+) -1;;
De esta forma hemos creado la función pred.
No se define "let pre = (-) 1", porque sino realiza la operación "1 - n", en vez de "n - 1", por tanto es más práctico sumar -1 directamente.

let saluda_a = (^) "Hola, ";; (*función de string -> string -> string = <fun>*)
	saluda_a "Pepe";; -> devuelve "Hola, Pepe".


---------------------06/10/23---------------------

let s = function x -> function y -> x + y;;
(*También se puede escribir como*)
let s x = function y -> x + y;;
(*y como*)
let s x y = x + y;;
(*se utiliza como*) s 2 3;;

OPERADORES INFIJOS COMO FUNCIONES CURRY:
(+) (*int -> int -> int = <fun>*)
(^) (*string -> string -> string*)
( * ) (*int -> int -> int*)
( ** ) (*float -> float -> float*)
(<=) (*'a -> 'a -> bool = <fun>*)
(=) (*'a -> 'a -> bool = <fun>*)
(||) (*bool -> bool -> bool = <fun>*)
(&&) (*bool -> bool -> bool = <fun>*)

AVISO: EN OCAML LA COMPARACIÓN DE VALORES NO ES CON ==, SINO CON <>

El riesgo de utilizar || y && es que no se comportan como funciones, por ejemplo si ejecutamos:
(&&) false (1 / 0 > 0);;
Debería dar un error de ejecución, pues no se puede dividir entre 0, pero devuelve:
- : bool = false
En cambio el producto de enteros, por ejemplo:
( * ) 0 (1 / 0), sí que salta la excepción, el error de ejecución, pero en la conjunción y disyunción de booleanos no (&&), (||).

<b1> && <b2>;;
Se evalúa primero b1, y si b1 da falso ya no se ejecuta b2, se devuelve falso directamente.
La conjunción es equivalente a escribir:
if <b1> then <b2> else false;; <- Esta es la manera correcta de pensarlo

<b1> || <b2>;;
Si alguno de los dos, b1 o b2, da true, ya devuelve true sin ejecutar la otra.
La disyunción es equivalente a escribir:
if <b1> then true else <b2>;; <- Esta es la manera correcta de pensarlo

Escribir: if <b> then true else false;;
es lo mismo que escribir solamente la expresión booleana.
if <b> then true else false;; es equivalente a <b>;;


Esta definición:
let f = function (x, y) -> 2 * x + y;;
También se puede escribir así:
let f (x,y) = 2 * x + y;;
Que es una función f de tipo:
val f: int * int -> int = <fun>         (R x R ->  R, de un conjunto de números reales por otro conjunto de reales a otro), el producto cartesiano de tipos

PRODUCTO CARTESIANO DE TIPOS: R x R
(2, 3);;
- : int * int = (2, 3)

2 + 1, true;;
- : int * bool = (3, true)

let s' (x, y) = x + y;;
val s': int * int -> int = <fun>

s' (2, 3);;
- : int = 5

No existen las funciones de dos argumentos, sino las funciones que reciben un argumento de un par de enteros.

CURRYFICAR (CURRY): pasar una función que tiene esta forma A x B -> C, a otra de esta forma A -> B -> C
DESCURRYFICAR (UNCURRY): pasar de esta función A -> B -> C a esta otra A x B -> C

curry(A * B -> C) -> (A -> B -> C)

EJERCICIO: Con este tipo y este nombre, qué hace la función fst?
fst;;
- : 'a * 'b -> 'a = <fun>
Recibe un par de elementos y devuelve el primer elemento.
fst ("hola", 2);;
- : string = "hola"

snd;;
- : 'a * 'b -> 'b = <fun>

Tipo de la x?
let x = (true, abs);;
val x : bool * (int -> int) = (true, <fun>)

fst y snd nos permite obtener toda la información de un par:
(snd x) (-7);;
- : int = 7

Las funciones fst y snd ya vienen definidas, pero si tuviéramos que definirlas:
let fst (x, y) = x;;
let fst (x, _) = x;; (*no le damos nombre a la segunda componente porque no se usa para obtener el resultado*)



------------------------10/10/23--------------------------
TIPOS DE DATOS:
int * int -> 2,3
(int * int) * int -> (2, 3), 1 (una dupla de numeros cuya primera componente también es una dupla)
int * int * int -> 2, 3, 1

true, 0, "trio" -> bool * int * string 
(true, 0), "falso trio" -> (bool * int) * string 

let p = (true, 0), "falso trio";; -> a partir de ahora, donde ponga p, pongo ese valor.
fst p;;
- : bool * int = (true, 0)
snd p;;
- : string = "falso trio"

let x, y = p (es una definición, donde en vez de haber un nombre, hay un patrón)
Primero se evalúa el valor de p ((true, 0), "falso trio"), y luego se evalúa si es posible asociar x e y con esos valores: x = (true, 0) e y = "falso trio".

Definimos la función let s'(x, y) = x + y, de tipo int * int -> int. Esta forma es la manera abreviada de escribir: let s' = function (x,y) -> x + y


EJERCICIO:
let 0 = 1 - 1;; -> ¿compila?
El compilador verifica primero que el valor de 1-1 pueda guardarse en la constante 0, es decir, que sea un int -> int.
Como sí es posible, compila. No obstante, al ejecutar salta un warning, ya que al ejecutar se evalúa el posible valor de 1-1 (esa zona de la función), y avisa de que esa operación puede ser distinta de 0.

Ocurre lo mismo con: let 0 = 1+1;;

Sin embargo, con let "hola" = 1 - 1;; -> no compila, pues hay un error de tipos.
Ídem con let x, y = 0;; -> hemos puesto un int donde debería ir un 'a * 'b.

let x, y = x + y, x * y in x + y;; es una expresión, no una definición (a pesar de que tiene una dentro), ya que devuelve un valor.
Primero evalúa x + y = 5, luego x * y = 6, luego asigna los valores a x e y, x = 5 e y = 6, y luego realiza la suma del in x + y = 11.

NOTA: cuando se compila no se evalúa nada NUNCA.


EJERCICIO:
let f x y z = x + 2*y + z*z;; -> definimos f (*modo no abreviado*)
Tipo de f: int -> int -> int -> int = <fun> (x -> y -> z -> resultado)

Otra forma de implementar la misma función:
let f' (x, y , z) = x + 2*y + z*z;; -> definimos f' con una terna
Tipo de f' = int * int * int -> int = <fun>

Escribimos una función de tipo: sp: int -> int -> int * int.
let sp x y = x + y, x * y;;

Escribimos una función de tipo: sp': int * int -> int * int.
let sp' (x, y) = x + y, x * y;;

Analiza:
let per_area r =
		let pi = 2 *. asin 1. in
		2. *. pi *. r,
		pi *. r *. r;;

	Es una definición con una expresión dentro (hay un let in dentro de un let).
	Los únicos valores que definimos dentro es per_area. r no está definida, es solamente el parámetro de la función. pi es una variable local, no global, entonces no queda definida para el resto del código.
	Además, tiene tipo: float -> float * float = <fun>.
	Si en vez de definir pi dentro, pongo directamente la operación, cada vez que ejecute la operación per_area, el valor se calcula 2 veces. En cambio, definiéndolo solo se calcula 1 vez.
	No obstante, pi siempre da el mismo valor, entonces calcularlo cada vez que ejecutamos la función se vuelve a calcular, dos posibles soluciones a esto:
		- Definir pi de forma global.
		- Definir pi de forma local de forma que se calcule solamente una vez: (IMPORTANTE !!!)
			let per_area = 
				let pi = 2. *. asin 1. in
				function r -> 
				2. *. pi *. r,
				pi *. r *. r;;

			Definimos el let in ANTES de la frase function, ahora se evalúa cuando se define la función.




--------------------17/10/23---------------------

let rec quo x y = (* x >= 0, y > 0 *)
	if x < y then 0
	else 1 + quo (x - y) y;;

TIPO: asocia con quo un valor de int -> int -> int == int -> (int -> int) (función en forma Curry).
Cuando hay varias flechas y no hay paréntensis se entiende que están por la derecha.

Si quo estuviera definido así: let rec quo (x, y) su tipo sería int*int -> int.

Ejemplo de uso: quo 7 3;; -> devolverá -: int = 2.
La función quo representa el cociente de la división entera.

En la función (última línea) se ejecutan 3 operaciones:
	1º la resta
	2º la aplicación recursiva de quo 
	3º la suma de 1

	En cada paso recursivo se añaden operaciones pendientes:
	quo 10 2;; -> 1 + quo 8 2;; -> 1 + (1 + quo 6 2);; -> 1 + (1 + (1 + quo 4 2));; -> ... -> RESULTADO 5
	Esto puede acabar siendo un problema, el espacio utilizado para la recursión (pila de recursividad, stack) tiene un límite, que cuando se sobrepasa salta un error: "stack overflow".

	A este tipo de recursividad, que deja cuentas pendientes, se le llama RECURSIVIDAD NO FINAL
---

let rec rem x y = (* x >= 0, y > 0 *)
	if x < y then x
	else rem (x - y) y;;

TIPO: int -> int -> int
Uso: rem 7 3;; -> devuelve 1
Esta función implementa el resto de la división entera.

En la función (última línea) se ejecutan 2 operaciones:
	1º la resta
	2º la aplicación recursiva de rem

	En cambio, en rem no se añaden operaciones pendientes:
	rem 10 2;; -> rem 8 2;; -> rem 6 2;; -> rem 4 2;; -> rem 2 2;; -> rem 0 2;; -> RESULTADO 0

	A este tipo de recursividad, que no deja cuentas pendientes, se le llama RECURSIVIDAD FINAL, RECURSIVIDAD TERMINAL O TAIL RECURSION


 --------------------------------------------------------------------------------------------------------------------
| NOTA: las constantes enteras se pueden escribir con guión bajo para facilitar su lectura: 10_000 en vez de 10000.  |
 --------------------------------------------------------------------------------------------------------------------

Si ponemos: quo 10_000_000 1;; -> Stack overflow during evaluation
Si ponemos: rem 100_000_000 1;; -> hace la operación

Cuanto más aumentemos los valores mandados a rem tardará cada vez más en hacer la operación, pero siempre, SIEMPRE, devolverá el resultado al ser terminal.
En cambio, quo salta un stack overflow ya que es NO TERMINAL.

¡! Es importante diferenciar la importancia entre recursividad TERMINAL y NO TERMINAL. ¡!


---

let div x y = quo x y, rem x y;;
TIPO: int -> int -> int * int = <fun>

div 7 2;; -> -: int * int = (3, 1)

Esta no es la forma más eficiente de declarar div, ya que quo y rem hacen el mismo nº de pasos.

Para no hacer los mismos pasos dos veces, declaramos div como una función recursiva:

let rec div x y =
	if x < y then (0, x)
	else 1 + fst (div (x - y) y), snd (div (x - y), y);;

	Desde el punto de vista matemático, esta implementación es correcta, pero desde el punto de vista computacional es extremadamente malo, pues estamos calculando 2 veces lo mismo (div (x - y) y), algo que NUNCA debe hacerse.
	Por ejemplo, nunca terminará de calcular div 60 1;;

Implementación correcta, operando div (x-y) y SOLO UNA VEZ:

let rec div x y =
	if x < y then (0, x)
	else let qr = div (x - y) y in 1 + fst qr, snd qr;;

Esta implementación sí es capaz de ejecutar div 60 1 correctamente;;

Otra forma de implementarlo para definir q y r por separado, en vez de qr todo junto:

let rec div x y =
	if x < y then (0, x)
	else let (q, r) = div (x - y) y in 1 + q, r;;

Esta es la forma más correcta de escribirlo, y la más profesional (usando fst y snd canta que eres un novato).

PRÁCTICAS:
let suma x y = x + y;;
let suma = function x -> (function y -> x + y);;
let mas1 = suma 1 -> (function y -> 1 + y);;

mas1 5;;



-------------------20/10/23-------------------

(*FIBONACCI*)
let rec fib n = (* n >= 0 *)
	if n <= 1 then n
	else fib (n - 1) + fib (n - 2);;

Esta versión tiene recursividad doble, entonces creamos una que ya devuelva el fibonacci de n y de n-1, usando solamente una llamada recursiva:

let rec fib2 = function
	1 -> (1, 0) 
	| n -> let f1, f2 = fib2 (n-1) in (* f1 = fib(n-1) // f2 = fib(n-2) *)
		(f1 + f2, f1)

TIPO DE LA FUNCIÓN: val fib2 : int -> int * int = <fun>
Esta función no es recursiva terminal, pues la última operación que realiza es la suma (f1 + f2, f1), no la llamada a recursividad.
Ahora la única operación que hace son sumas, por lo que su tiempo computacional es mucho menor que en la primera versión.

let fib n = fst (fib2 n);;


CALCULAR LOS TIEMPOS DE EJECUCIÓN EN OCAML:
Usando la función Sys.time;;

EJEMPLO:
Sys.time ();;
Devuelve el tiempo en segundos que lleva consumido de CPU el proceso de Ocaml.
- : float = 0.0291220000000000021
NO devuelve el tiempo actual.

Para saber cuánto tiempo tarda en ejecutar código medimos el sys.time antes de compilar y después:
let t = Sys.time();;
fib 40;;
Sys.time() -. t;; -> devuelve la diferencia de tiempo.

Creamos una función para calcular los tiempos:
La función tendrá tipo: crono ('a -> 'b) -> 'a -> float
Si no tiene este tipo cuando la compilemos, es que está mal hecha.

let crono f x =
	let t = Sys.time() in
	let _ = f x in
	Sys.time() -. t;;

EJEMPLO DE USO: crono fib 40;;


-----------------24/10/23------------------
let rec div x y =
	if x < y then (0,x)
	else 1 + fst (div(x -y) y),
	snd (div (x - y) y);;

let rec fib n = (* n >= 0 *)
	if n <= 1 then n
	else fib (n - 1) + fib (n - 2);;

let crono f x = 
	let t = Sys.time () in
	let _ = f x in 
	Sys.time () -. t;;

let rec fib2 = function (* n > 0 *)
	1 -> (1,0)
	| n -> let f1, f2 = fib2 (n-1) in 
		(f1 + f2, f1);;


let ffib n = fst (fib2 n);; -> Esta función así sola causa stack overflow en el caso de ffib 0.

Para arreglarlo:

let rec fib2 = function (* n > 0 *)
	0 -> (0,1) (* *)
	| n -> let f1, f2 = fib2 (n-1) in 
		(f1 + f2, f1);;


La siguiente función se calcula de forma terminal, mediante la siguiente manera:
i(int) 		f(fibonacci) 	a(anterior)
  0				  0				1
  1				  1	(f+a)		0 (f)
  2				  1	(f+a)		1 (f)
  3				  2	(f+a)		1 (f)

let fib' n =
	let rec aux (i, f, a) =
		if i = n then f
		else aux (i + 1, f + a, f);;
	in aux (0, 0, 1);; (* porque empezamos siempre en 0, 0, 1 *)

La recursividad está solo en la función aux. Es terminal, hay una suma, una suma, y por último una terna.
Hace n pasos todos de la misma complejidad, entonces complejidad O(n).
La función fib2 daba stack overflow al hacer el fibonacci de 1_000_000, en cambio este da el resultado (mod 2 elevado a 63, por eso da negativo).


EJERCICIO:
Crear una función "rep n f x" que aplique n veces f a x.
rep : int -> ('a -> 'b) -> 'a -> unit

let rec rep n f x =
	if n = 0 then () (* devuelve unit *)
	else let _ = f x in
		rep (n - 1) f x;;

IMPORTANTE: para medir el tiempo de rep, hay que poner paréntensis: crono (rep 1000 ffib) 250_000;;
Ya que sino los argumentos de crono son: 1. rep, 2. 1000, y 3.ffib, y no lee el 250_000.


NUEVO TIPO DE DATOS:
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

Las seuencias deben ser finitas, 0 o más elementos todos del mismo tipo, es decir, las listas son homogéneas.

let l1 = [1; 2; 3];;
let l2 = [5; 0];;

List.hd;; (* list head *)
- : 'a list -> 'a = <fun>
List.hd l1;;
- : int = 1

List.tl;; (* list tail *)
- : 'a list -> 'a list = <fun>
List.tl l1;;
- : int list = [2; 3];;

Las listas son inmutables, no se pueden editar.

(@);; (* concatenación*)
- : 'a list -> 'a list -> 'a list = <fun>
l1 @ l2;;
- : int list = [1; 2; 3; 5; 0];;

Estas funciones no editan las listas, las listas son inmutables, sino que crean unas nuevas.

QUÉ PASA SI APLICO LIST.HD O LIST.TL A LA LISTA VACÍA??

EJERCICIO: Crear una función que dada una lista dé su longitud.
Una vez implementada la función, preguntarse si es terminal, y si no lo es crear otra definición que sí lo sea.
length: 'a list -> int



---------------------31/10/23----------------------
Es usual que las funciones que se aplican sobre listas sean recursivas, pues las propias listas son recursivas.


List.append;;
- : 'a list -> 'a list -> 'a list = <fun>

let rec append l1 l2 = match l1 with
	[] -> l2 (*si la primera lista esta vacia devolvemos l2*)
	| h::t -> h::append t l2;; (*usando append t(cola de l1) y l2 hacemos la función recursiva*)
	(*l1 tiene cabeza h y cola t, entonces la cola del append tiene que ser append de l2*)

La recursividad en esta función NO es terminal. Dependiendo del nº de veces que haya que hacer append (depende de la longitud de la primera lista), puede hasta llegar a dar stack overflow.



List.rev_append;; (*igual que append, pero se invierte la primera lista antes del append*)
- : 'a list -> 'a list -> 'a list = <fun>

let rec rev_append l1 l2 = match l1 with
	[] -> l2
	| h::t -> rev_append t (h::l2);;

La recursividad en esta función SÍ es terminal. 



List.rev;; (*invierte una lista*)
- : 'a list -> 'a list = <fun>

let rev l = rev_append l [];;

Recursiva indirectamente terminal con O(n) sobre la longitud de la lista.



let append' l1 l2 = rev_append (rev l1) l2;;

Esta versión del append es recursiva terminal, el problema es que puede tardar un poco más (aunque es díficil de comprobar).



List.nth;; (*se aplica a un entero y devuelve el elemento correspondiente a la posicion del entero*)


NUEVO TIPO DE DATO: exn (exception)

Failure "hd";;
- : exn = Failure "hd"

Invalid_argument "ese argumento no vale";;
- : exn = Invalid_argument "ese argumento no vale"

Failure "no seas burro!";;
- : exn = Failure "no seas burro!"

Division_by_zero;;
- : exn = Division_by_zero

Tanto Failure como Invalid_argument pueden crear tantos valores como strings haya.
Pero Division_by_zero no acepta strings, por tanto solo puede devolver un valor posible.


FUNCIÓN (POLIMÓRFICA):
raise;;
- : exn -> 'a = <fun>

La única manera de definir una función que pasa de algo a alfa ('a) es haciendo que nunca llegue a devolver nada.

EJEMPLO:

raise Division_by_zero;;
Exception: Division_by_zero.

1 + raise (Failure "Orror!!");;
Exception: Failure "Orror!!".



let rec last = function
	[] -> raise (Failure "last")
	| h::[] -> h 
	| _::t -> last t;;



------------------03/11/23-------------------

let rec lmax = function
	[] -> raise (Failure "lmax") (* Caso de lista vacia *)
	| h::[] -> h
	| h::t -> if h >= lmax t then h
			  else lmax t;;

Problemas: calculamos dos veces el mismo valor (lmax t), por tanto tarda 2^(longitud de la lista).
Tipo: val lmax : 'a list -> 'a = <fun>
Es una función que aplicada a una lista, devuelve el mayor de sus elementos.
Es recursiva no terminal, deja cálculos pendientes, primero hace la recursividad de lmax t y después realiza el if-then-else.

SOLUCIONADO: (solucionamos con una declaración local, ahora la función tarda solo la longitud de la lista.)

let rec lmax2 = function
	[] -> raise (Failure "lmax")
	| h::[] -> h
	| h::t -> let m = lmax2 t in
			  if h >= m then h
			  else m;;

El truco de raise es que nunca devuelve nada, entonces puede devolver cualquier tipo.


Para una lista de 1000 elementos, la primera versión de la lista tarda 2^1000 y la segunda solo 1000.
La primera tiene complejidad exponencial, y la segunda lineal.

----------------------------------------------------------------------
Para crear una lista de 10 elementos, siendo estos (1, 2, 3, ..., 10):
let l10 = List.init 10 succ;;
----------------------------------------------------------------------

Para que dé stack overflow, el nº máximo de llamadas recursivas que hacen cola es 10.

----------------------------------------------------------------------

Ahora hacemos la segunda función recursiva terminal para evitar el stack overflow, manteniendo guardado un contador con el máximo encontrado mientras recorremos la lista:

let lmax3 = function
	[] -> raise (Failure "lmax")
	| h::t -> let rec loop m = function (* Caso de lista no vacia, tiene cabeza y cola *)
				  [] -> m
				  | h::t -> loop (max m h) t (* Esta h y esta t son distintas que las de la línea 749 *)
				in loop h t;; (* Esta h y esta t son las mismas que las de la línea 749 *)  

El nº de veces que se hace loop depende de la longitud de la lista.


let rec lmax = function
	[] -> raise (Failure "lmax") (* Primer caso, lista vacía *)
	| h::[] -> h (* Segundo caso: lista con un solo elemento *)
	| h1::h2::t -> lmax (max h1 h2 :: t);; (* Tercer caso, lista con 2 o más elementos *)

La recursividad es terminal, primero se aplica max a h1 y h2, luego se construye la lista con esa cabeza y con la cola t, y luego se aplica la recursividad.
Hacemos el lmax de otra lista en el que hemos eliminado el segundo elemento que no es máximo.

En la primera función, solo verifica 1 vez que la lista está vacía, ya que la recursividad empieza en loop,
sin embargo, en la segunda función, si la lista tiene 1_000_000 de elementos, verifica 1_000_000 de veces si la lista está vacía.
Para casos no vacíos, la segunda función es mejor, pero para casos de lista vacía es mejor la primera.

----------------------

PRÁCTICA 6:

List.fold_left;;
- : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a = <fun>

List.fold_left (+) 7 [2; 3; 4];;
- : int = 16

fold_left es recursiva terminal, pero el fold_right NO.


let sumlist l = List.fold_left (+) 0 l;; -> FUNCIÓN PARA SUMAR TODOS LOS ELEMENTOS DE LA LISTA

EJERCICIO: definir length usando solamente List.fold_left.


-----------------------07/11/23-------------------------
ejercicio, definir length usando solamente el fold_left!!!!!

# 
let length l =
    List.fold_left (fun n _ -> n+1) 0 l;;
val length : 'a list -> int = <fun>

sorted : 'a list -> bool
let rec sorted = function
    [] | _::[] -> true 
    | h1::h2::t -> h1 <= h2 && sorted (h2::t);;

# sorted ['a';'b';'c'];;
- : bool = true

sorted_general ('a -> 'a -> bool) -> 'a list -> bool

let rec sorted_general ord = function
    [] | _::[] -> true 
    | h1::h2::t -> ord  h1 h2 && sorted_general ord (h2::t);;

# sorted_general (>=) ['a';'e';'u'];;
- : bool = false
porqie no estan de mayor a menor_que

let sorted l =sorted_general (<=) l;;

let sorted' l =sorted_general (>=) l;;

**ORDENACION POR INSERCION

insert : 'a -> 'a list -> 'a list = <fun>

let rec insert x = function
    [] -> [x]
    | h::t -> if x <= h then x::h::t
              else h::insert x t;;


insort : 'a list -> 'a list = <fun>
let rec insort = function
    [] -> []
    | h::t -> insert h (isort t);;

----------------------10/11/23-----------------------

LOGARITMOS DE ORDENACIÓN:

let crono f x =
	let t = Sys.time () in
	let _ = f x in 
	Sys.time () -. t;;

let rec divide = function (*Divide una lista*)
	[] -> [], []
	| h::[] -> [h], []
	| h1::h2::t -> let t1, t2 = divide t 
			       in (h1::t1, h2::t2);;

EJERCICIO: hacer el divide terminal.


let rec merge = function (*Mezcla dos listas, solo se puede aplicar si las listas están ordenadas*)
	[], l | l, [] -> l
	| h1::t1, h2::t2 -> if h1 <= h2 then h1::merge (t1, h2::t2)
						else h2 :: merge (h1::t1, t2);;

EJERCICIO: hacer merge terminal.


Donde: 'a list -> 'a list * 'a list
merge: 'a list * 'a list -> 'a list
msort: 'a list -> 'a list

let rec msort = function (*ORDENACION POR FUSION*)
	[] -> []
	| l -> let l1, l2 = divide l
		   in merge (msort l1, msort l2);;

Esta implementación está mal, acaba dando stack overflow.

No es suficiente con que una función tenga una regla NO recursiva, necesitamos 
saber que vamos a llegar a ella para que no se llame recursivamente de forma 
infinita a la funcion.

La implementación anterior de msort ESTÁ MAL, pues no es cierto el razonamiento
de "como divide siempre da dos listas más cortas, siempre llegamos al caso vacío",
pues NO ES CIERTO que divide siempre devuelve dos listas más pequeñas, pues cuando
la lista solo tiene 1 elemento, devuelve una lista vacía y la propia lista mandada
de 1 elemento, por tanto la regla en msort no sirve para listas de 1 elemento.

Arreglamos añadiendo el caso de 1 elemento en la lista:

let rec msort = function
	[] -> [] | [h] -> [h]
	| l -> let l1, l2 = divide l
		   in merge (msort l1, msort l2);;

Si divide y merge fueran terminales, msort sería terminal?
No, pero una vez arregladas las otras dos (pues con listas muy grandes daría problemas),
incluso sin cambiar msort, no habría problema en listas grandes.

EJERCICIO: hacer quicksort.



--------------------------14/11/23---------------------------

Constructores:
None : 'a option
None;;
- : 'a option = None

Some a : 'a option
Some 3;;
- : int option = Some 3
Some true;;
- : bool option = Some true

[Some 2; Some 3; None];;
- : int option list = [Some 2; Some 3; None]

¿Cuántos valores de bool option hay en OcamL?
3 -> Some true, Some false y None

-------------------------------------------
| List.find ((<) 0) [0; 1; -1];;          |
|                                         |
| ¿Cómo funciona (<) 0?                   |
| (<) 0 (-1) -> 0 < -1 devuelve false     |
|                                         |
| Entonces la salida de esta entrada es:  |
| - : int = 1                             |
-------------------------------------------

List.find_opt ((<) 0) [0; 1; -1];;
- : int option = Some 1
List.find_opt ((<) 0) [0; -1; -1];;
- : int option = None

EJERCICIO
Una función que dada una lista de enteros escriba en la pantalla el primero mayor que 0:

let print_first_pos l = 
	print_endline (string_of_int (List.find ((<) 0) l));;

val print_first_pos : int list -> unit = <fun>

No obstante si el resultado es None, puede dar problemas:
let print_first_pos l =
	match List.find_opt ((<) 0) l with
		None -> print_endline "No había ningún positivo"
		| Some n -> print_endline (string_of_int n);;

EJERCICIO
Problema de las 8 reinas: crea una función que dadas dos posiciones, diga si las reinas se amenazan entre sí:

let come (i1, j1) (i2, j2) =
	i1 = i2 || j1 = j2 || abs(i2 - i1) = abs (j2 - j1);; (* se comen cuando están en la misma fila, en la misma columna o en la misma diagonal *)
	(* Están en la misma diagonal si la distancia entre filas es igual a la distancia horizontal *)

let compatible p l =
	not (List.exists (come p) l);; (* Miramos si es posible poner una reina en una casilla sin que resulte amenazada *)

let queens n =
	let rec completa path i j =
		if i > n then Some path
		else if j > n then None
		else if compatible (i, j) path (* si esa casilla no es compatible, entonces pasamos a la siguiente casilla y miramos si esa sí es compatible *)
			then match completa ((i, j)::path) (i+1) 1 with (* si la casilla es compatible con el path, intentamos completarla con la casilla en la fila siguiente, PROBLEMA: no es lo mismo que dé un valor Some que un valor None, no debería dar None, arreglar eso *)
				None -> completa path i (j+1) (* probamos con la siguiente casilla *)
				| Some s -> Some s (* Some de algo devuelve esa solucion *)
			else completa path i (j+1)
	in completa [] 1 1;; (* que intente la solución vacía a partir de la casila (1,1), todas las soluciones están basadas en esta *)

# queens 1;;
- : (int * int) list option = Some [(1,1)] -> Queens tiene solución en la casilla (1,1)

Implementamos la función de forma que salte una excepción si no se ha encontrado solución:

let queens n =
	let rec completa path i j =
		if i > n then path
		else if j > n then raise Not_found
		else if compatible (i, j) path
			then try completa ((i, j)::path) (i+1) 1 with
				Not_found -> completa path i (j+1) (* escribimos lo que se quiere que se evalue en caso de que se produzca el error *)
			else completa path i (j+1)
	in completa [] 1 1;;



----------------------17/11/23----------------------


INTERVENCIÓN DE EXCEPCIONES
ESTRUCTURA "TRY WITH":
Siempre tiene la siguiente forma:
try <e> with
	<p1> -> <e1>
	|
	.
	.
	.
	| <pn> -> <en>

Se intenta evaluar e, si da un valor es la solución
Si mientras se evalua salta una excepción, se mira si coincide con alguno de los patrones definidos
y se evalua la condición tratada para ese caso
En caso de no coincidir con ninguno de los valores, se detiene el programa.
IMPORTANTE: e1 debe ser del mismo tipo que e, sino dará error de compilación

Implementamos la función "List.find_opt":
let find_opt p l =
	try List.find p l with
		Not_found -> None;;

Esta opción NO es válida ya que None no es del mismo tipo que List.find p l
En este caso no da error de compilación por error de tipos, pero sigue estando mal (el compilador supone
que recibe una lista de option al ver que tiene que devolver ese tipo).
Corregimos:

let find_opt p l =
	try Some (List.find p l) with
		Not_found -> None;;

find_opt (fun i -> 10 / i > 3) [1; 0];;
- : int option = Some 1
find_opt (fun i -> 10 / i > 3) [8; 9];;
- : int option = None
find_opt (fun i -> 10 / i > 3) [0; 9];;
Exception: Division_by_zero.


Implementamos "List.nth_opt"
let nth_opt l n =
	try Some (List.nth l n) with
		Failure _ = None (* si ponemos Failure "nth" intercepta solo ese error, en cambio con el comodín intercepta todos los tipos de Failure *)
		| Invalid_argument _ -> None;;



PARA DEFINIR UN TIPO DE DATO:

type numero = int | float (* creamos un tipo numero que puede ser un int o un float *)
(* Necesitamos diferenciar numero int de numero float, lo hacemos con constructores *)
Para crear un constructor ponemos primero cómo se llama el constructor y la palabra reservada of:
type numero = I of int | F of float;;

F 1.0;;
- : numero = F 1.
F 2.5;;
- : numero = F 2.5
I 1 ;;
- : numero = I 1
I 1 = F 1.0;;
- : bool = false
I 1 = I 2;;
- : bool = false

En OcamL no se puede crear una lista que contenga ints y floats a la vez, pero
sí podemos crear una lista que contiene solo el tipo de dato numero:
[I 1; F 2.6; F 1.5; I 2];;
- : numero list = [I 1; F 2.6; F 1.5; I 2]



----------------------------21/11/23------------------------------

type numero =
	I of int |
	F of float;;

let rec first_int = function
	[] -> raise Not_found
	| I n :: _ -> n
	| _ :: t -> first_int t;;

type otroint = Otro of int;;
# Otro 5;;
- : otroint = Otro 5

# Otro 5 = 5;;
Error de tipos.
This expression has type int but an expression was expected of type otroint

type doble_int = L of int | R of int | V of int;; (* el argumento de los constructores es el mismo tipo *)

type intoption = Some of int | None;;

Los constructores que llevan argumento se llaman "constructores variables" (Some) y los que no se llaman
"constructores constantes" (None).

Usar Some y None como los nombres de los constructores no es buena idea, ya que
ahora ya no son el tipo de 'a option de antes, sino el tipo intoption.

Solucionamos cambiándoles el nombre:
type intoption = Int of int | Na;;


let div i1 i2 = function
	(_, Int 0) -> Na (* cuando el argumento corresponde al 0, no hago nada *)
	| (Int n1, Int n2) -> Int (n1/n2)
	| _ -> Na;; (* todos los que no sean de alguna de las formas anteriores, no hacemos Nada *)


Otra opción:
let div i1, i2 = match (i1, i2) with
	(_, Int 0) -> Na
	| (Int n1, Int n2) -> Int (n1/n2)
	| _ -> Na;;

(* DEFINICION CON SIMBOLOS INFIJOS *)
let (//) i1 i2 = match (i1, i2) with
	(Int n1, Int n2) -> (try Int (n1/n2) with 
						 Division_by_zero -> Na)
	| _ -> Na;;

De esta forma en vez de hacer:
# div (Int 12) (Int 2);;
Podemos hacer:
# Int 12 // Int 2;;

type boolean = True | False;;

type palo = Corazon | Trebol | Pica | Diamante;;

let esrojo = function
	Corazon | Diamante -> True
	| _ -> False;;

let (!) = function True -> False | False -> True (* funcion NOT BOOLEAN *)

let esnegro p = ! (esrojo p);;


type entero = One | Succ of entero;;

let nat_of_int = function (* PRECONDICIÓN: n es mayor que 0 *)
	1 -> One
	| n -> Succ (nat_of_int (n-1));;

Esta función, tal como está, en un int grande y en un número negativo provocaría
un stack overflow.

Redefinimos el tipo entero:
type entero = Zero | Pos of nat | Neg of nat;;

Función que de un entero da su valor absoluto: (int -> int)
let absoluto = function
	Neg n -> Pos n
	| e -> e;; (* cualquier otro numero e, daría e *)

Función para definir el opuesto de un nat:
let opuesto = function
	Neg n -> Pos n
	| Pos n -> Neg n
	| Zero -> Zero;;

let entero_of_int n = function
	0 -> Zero
	| n -> if n > 0 then Pos (nat_of_int n)
		   else Neg (nat_of_int (-n));;


type 'a option = None | Some of 'a;;
De esta forma definimos una infinidad de tipos, option es un constructor de tipos.
Si mandamos un int, devolverá None o Some of int
Si mandamos un String, devolverá None o Some of String
... etc.


Función parametrizada y recursiva a la vez:
type 'a lista = Vacia | Cons of 'a * 'a lista;;

# Vacia;;
- : 'a lista = Vacia
# Cons (2, Vacia);;
- : int lista = Cons (2, Vacia)
# let 13 = Cons (3, Vacia);;
val 13 : int lista = Cons (3, Vacia)
# let 133 = Cons (3, 13);;
val 133 : int lista = Cons (3, Cons (3, Vacia))



---------------------------24/11/23----------------------------

ÁRBOLES BINARIOS

type 'a bintree =
	Empty
	| Node of 'a * 'a bintree * 'a bintree;; (* 'a es el tipo de las etiquetas de los nodos *)

Es una definición recursiva, pues la definición de bintree aparece en la propia definición.
Un árbol que no sea vacío se caracteriza por 3 partes: raíz, rama derecha y rama izquierda.


DEFINIMOS un tipo como el bintree pero no vacío:
type 'a ne_bintree =
	Node of 'a * 'a ne_bintree option * ne_bintree option;;

(* En vez de poner los 3 casos (rama izq, rama der, vacio), usamos option *)

(* CREAMOS UN ÁRBOL *)
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
val t12 : int bintree =
  Node (6, Node (5, Empty, Empty), Node (11, Empty, Empty))
# let t22 = Node (9, h 4, Empty);;
val t22 : int bintree = Node (9, Node (4, Empty, Empty), Empty)
# let e = Empty;;
val e : 'a bintree = Empty
# let t1 = Node (7, t11, t12);;
val t1 : int bintree =
  Node (7, Node (2, Empty, Empty),
   Node (6, Node (5, Empty, Empty), Node (11, Empty, Empty)))



Función para saber el nº de nodos:
let rec nnodos = function
	Empty -> 0
	| Node(_, i, d) -> 1 + nnodos i + nnodos d;;


Función para saber la altura de un nodo:
let rec altura = function
	Empty -> 0
	| Node (_, i, d) -> 


Función para saber el nodo máximo de un árbol:
let rec tmax = function
	Empty -> raise (Invalid_argument "tmax")
	| Node (r, Empty, Empty) -> r
	| Node (r, rama, Empty) | Node (r, Empty, rama) -> max r (tmax rama) (* si no llamamos rama en ambas, no saca la conclusión, habría que hacer casos separados *)
	| Node (r, rama, Empty) -> max r (tmax rama)
	| Node (r, i, d) -> max r (max tmax i) (tmax d));;


Lista de los nodos del árbol en preorden:
let rec preorden = function
	Empty -> []
	| Node (r, i, d) -> r :: preorden i @ preorden d;;


Lista de las hojas de izquierda a derecha:
let rec hojas = function
	Empty -> []
	| Node (r, Empty, Empty) -> [r]
	| Node (r, i, d) -> hojas i @ hojas d;;




-------------------------28/11/23-------------------------

Árboles estrictamente binarios con valores 'a en los nodos:

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

Queda algo así:

               A
              / \
             B   C
            / \ 
           D   E
              / \
              F  G

Con este tipo no podemos definir árboles como el siguiente, NO ES POSIBLE:
                A
              /   \
             B     C
            / \   /
           D   E  H
              / \
              F  G


Definimos la función hojas (no es válida para el segundo árbol):

let rec hojas = function
	Leaf v -> [v]
	| Node (_, i, d) -> hojas i @ hojas d;;



IMPORTAR FUNCIONES COMO UNA LIBRERIA EN OCAML:
(en terminal)
ls st* st_bintree.ml

ocamlc -c st_bintree.ml

ls st* st_bintree.cmi st_bintree.cmo st_bintree.ml

Ahora entramos en ocaml:

# #load "st_bintree.cmo";;
#St_bintree.hojas;;

Y ahora reconoce la función.

# open St_bintree;; (* si no hacemos open, habría que poner siempre St_bintree.funcion *)
hojas;;

NOTA: no existe el árbol vacío en este tipo.
¿Y si necesitase que el árbol vacío estuviera en el tipo de dato?
Sería: empty o no empty (st_bintree) o con empty(st_bintree option)


IMPLEMENTAMOS UN NUEVO TIPO PARA ESTE TIPO DE ÁRBOL (árbol no binario):

             2
            / \
           7   5
         / | \  \
        2 10  6  9
             / | |
            5 11 4


type 'a tree =
	T of 'a * 'a tree list;; (* El nodo por una lista de árboles de este tipo *)

Si la lista es vacía este constructor no es recursivo.

IMPLEMENTAMOS COMO SI FUERA UN MÓDULO:
(* en terminal *)
ls tree* tree.ml

ocamlc -c tree.ml

ls tree* tree.cmi tree.cmo tree.ml

(* en ocaml *)
# #load "tree.cmo";;
# open Tree;;

(* IMPLEMENTAMOS EL ÁRBOL ANTERIOR *)

# let r v = T(v, []);;
val r : 'a -> 'a Tree.tree = <fun>

let t_6 = T(6, [r 5; r 11]);;
val t_6 : int Tree.tree = T (6, [T (5, []); T (11, [])])

let t_7 = T (7, [r 2; r 10; t_6]);;
val t_7 : int Tree.tree = T (7, [T (2, []); T (10, []); T (6, [])])
(* ACABAR *)


FUNCIONES:

let rec nnodos (T (_, lr)) = 
	List.fold_left (+) 1 (List.map nnodos lr) (* List.map da la lista con todos los nodos, y List.fold_left da la suma de la longitud de esta lista, sumando de izq a der desde 1 *)
(* Empieza la suma en 1 para imitar el 1 + recursivo *)

Esta no es recursiva terminal ya que List.map no lo es, pero si usamos List.rev_map sí lo es.

¿Es posible hacerla solo con fold_left?
let rec nnodos (T, (_, lr)) =
	List.fold_left (fun n t -> n + nnodos t) 1 lr;;


¿Existe una manera fácil de dividir el árbol anterior en 2 sin que se solapen las divisiones?
Si lo dividimos basta con sumar el nº de nodos de uno y de otro y sumarlas, mucho más fácil 
que de la otra forma.

let rec nnodos' = function
	T (_, []) -> 1 (* árbol con cualquier nº de ramas y lista vacía, solo tendrá la raíz, 1 *)
	| T (r, h::t) -> nnodos' h + nnodos' (T (r, t));;

Esta manera es mucho más fácil de entender y no recurre al módulo List.