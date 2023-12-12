type matrix = int option array array;;
let m: matrix = [|[|Some 1; None; Some 3|]; [|None; Some 5; Some 6|]|];;

let print_matrix m =
  Array.iter (fun i ->
    Array.iter (fun j ->
      match j with
      | Some x -> Printf.printf "%d " x
      | None -> Printf.printf "0 "
    ) i;
    print_newline ()
  ) m
;;

let rec dijkstra (m: matrix) = 
  let n = Array.length m in
  let dist = Array.make n max_int in
  let visited = Array.make n false in
  
  let valid m = Array.iter (fun i ->
    if i = None || i < 0 || Array.length i <> n then raise Invalid_argument "dijkstra"
    ) m in valid m;
  
  Array.iter (fun i ->
    Array.iter (fun j ->
      match j with
        | Some x -> Printf.printf "%d " x
        | None -> Printf.printf "0 "
      ) i;
    ) m;
  
  
;;



(* 
void dijkstra( matriz M, matriz D, int size) {
  int m = 0, i = 0, j = 0, v = 0, w = 0, min = 0;
  int* noVisitados = malloc(size*sizeof(int));
  
  for (m = 0; m < size; m++) {
      for(i = 0; i < size; i++){ 
          noVisitados[i] = 1;
          D[m][i] = M [m][i];
      }
      noVisitados[m] = 0;
      i = size - 2;
      while( i > 0){
          min = -1;
          v = m;
          for(j = 0; j < size; j++){
              if(noVisitados[j] && (D[m][j] < min || min == -1)){
                  min = D[m][j];
                  v = j;
              }
          }

          noVisitados[v] = 0;

          for (w = 0; w < size; w++) {
              if(noVisitados[w]){
                  if (D[m][w] > (D[m][v] + M[v][w])) {
                      D[m][w] = (D[m][v] + M[v][w]);    
                  }
              }
          }
          i--;
      }
  }
  free(noVisitados);
}
*)
