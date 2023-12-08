let p x = 
    if x <= 0.0 then
        0.0
    else 
        x *. 4.0 *. asin 1.0

let area x = 
    if x <= 0.0 then
        0.0
    else
        x *. x *. 2.0 *. asin 1.0

let absf (x:float) : float =
  if x < 0.0 then
    -.x
  else
    x

let even x = x mod 2 = 0

let next3 x = 
    if (x mod 3) != 0 then
        x + (3 - (x mod 3)) 
    else
        x

let is_a_letter x = 
    if int_of_char x >= int_of_char 'a' && int_of_char x <= int_of_char 'z' then
        true
    else
        if int_of_char x >= int_of_char 'A' && int_of_char x <= int_of_char 'Z' then
            true
        else 
            false
        
let string_of_bool = function false -> "falso" | true -> "verdadero"