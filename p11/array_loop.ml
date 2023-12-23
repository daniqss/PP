let append array1 array2 =
  let len = Array.length array1 + Array.length array2 in
  let choose i =
    if i < Array.length array1 then array1.(i)
    else array2.(i - Array.length array1)
  
  in Array.init len (choose)
;;

let sub array i j =
  if i < 0 || j < 0 || i > j || j > Array.length array then
    raise (Invalid_argument "sub")
  else
    let len = j - i in
    let aux = Array.init len (fun i -> array.(i)) in
    for k = 0 to len - 1 do
      aux.(k) <- array.(i + k)
    done;
    aux
;;

let copy array =
  let len = Array.length array in
  let aux = Array.init len (fun i -> array.(i)) in
  aux
;;

let fill array pos len x = 
  if pos < 0 || len < 0 || pos + len > Array.length array then
    raise (Invalid_argument "fill")
  else
    for i = pos to pos + len - 1 do
      array.(i) <- x
    done
;;

let blit src src_pos dst dst_pos len =
  if src_pos < 0 || dst_pos < 0 || len < 0 || src_pos + len > Array.length src || dst_pos + len > Array.length dst then
    raise (Invalid_argument "blit")
  else
    for i = 0 to len - 1 do
      dst.(dst_pos + i) <- src.(src_pos + i)
    done
;;

let to_list array =
  let len = Array.length array in
  if len = 0 then
    []
  else
    let aux = ref [] in
    for i = len - 1 downto 0 do
      aux := array.(i) :: !aux
    done;
    !aux
;;

let iter fn array = 
  let len = Array.length array in
  for i = 0 to len - 1 do
    fn array.(i)
  done
;;

let fold_left fn acc array =
  let len = Array.length array in
  let aux = ref acc in
  for i = 0 to len - 1 do
    aux := fn !aux array.(i)
  done;
  !aux
;;

let for_all fn array =
  let len = Array.length array in
  let aux = ref true in
  for i = 0 to len - 1 do
    aux := !aux && fn array.(i)
  done;
  !aux
;;

let exists fn array =
  let len = Array.length array in
  let aux = ref false in
  for i = 0 to len - 1 do
    aux := !aux || fn array.(i)
  done;
  !aux
;;

let find_opt fn array =
  let len = Array.length array in
  let aux = ref None in
  let i = ref 0 in
  while !aux = None && !i < len - 1 do
    if fn array.(!i) then
      aux := Some array.(!i);
    i := !i + 1
  done;
  !aux
;;