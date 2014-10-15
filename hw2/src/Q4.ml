open NetKAT.Std

let flood : policy =
    <:netkat<
        port := 1 + port := 2 + port := 3 + port := 4
    >>

let pol_https_gate : policy =
    <:netkat<
        if tcpDstPort = 443 && (ethDst = 1 || ethDst = 2 || ethDst = 3) then drop
        else $flood
    >>

let learning_switch : policy =
    <:netkat<
        if port = 1 then $pol_https_gate
        else if port = 2 then $pol_https_gate
        else if port = 3 then $pol_https_gate 
        else if port = 4 then $flood
        else drop
    >>

let _ = run_static learning_switch
