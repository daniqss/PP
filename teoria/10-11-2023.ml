let crono f x =
    let t = Sys.time() in
    let _ = f x in
    Sys.time () -. t;;


let rlist n =
    let r = 4 * n in
    List.init n (fun _ -> Random.int r)

let rec split = function
  	[] -> [], []
  	| h::[] -> [h], []
  	| h1::h2::t -> let t1, t2 = split t in (h1::t1, h2::t2);;

let rec merge l1 l2 = function
  	h1::t1, h2::t2 -> if h1 < h2 then h1::merge l1 l2 (t1, h2::t2)
                      else h2::merge l1 l2 (h1::t1, t2)
    | [], l | l, [] -> l;;

let rec msort = function
    [] -> []
    | l -> let l1, l2 = split l in
           merge (msort l1, msort l2);;