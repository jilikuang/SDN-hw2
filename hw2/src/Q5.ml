(* Refer to an example in
   https://gitbug.com/frenetic-lang/frenetic/blob/master/example/tree-2-2.kat *)
open NetKAT.Std

let pkg_sent = [| 0; 0; 0; 0 |]

let pkg_rcvd = [| 0; 0; 0; 0 |]

let inc_cnt arr idx = arr.(idx) <- arr.(idx) + 1

let h_switch =
    <:netkat<
        if switch = 1 then
            if port = 1 then port := 2
            else if port = 2 then port := 1
            else drop
        else if switch = 2 then
            if ethDst = 1 then port := 1
            else if ethDst = 2 then port := 2
            else if (ethDst = 3 || ethDst = 4) then port := 3
            else drop
        else if switch = 3 then
            if ethDst = 3 then port := 1
            else if ethDst = 4 then port := 2
            else if (ethDst = 1 || ethDst = 2) then port := 3
            else drop
        else drop
    >>

let _ = run_static h_switch
