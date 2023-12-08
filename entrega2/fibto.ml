let rec fib n =
    if n <= 1 then n
    else fib (n-1) + fib (n-2)
in if Array.length(Sys.argv) = 2 then
    let n = int_of_string Sys.argv.(1) in
    let rec fib_print i =
        if fib i <= n then begin
            print_int (fib i);
            print_newline ();
            fib_print (i + 1)
        end
    in fib_print 0
else print_string "fibto: Invalid number of arguments\n"
