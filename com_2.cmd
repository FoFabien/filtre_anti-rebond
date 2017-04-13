restart -f
force -freeze sim:/sequenceur/h 1 10, 0 {35 ps} -r 50
force -freeze sim:/sequenceur/fin_comptage 1 0, 0 300 ps,  1 {500 ps}
force -freeze sim:/sequenceur/entrée 0 0, 1 10, 0 20, 1 40, 0 60, 1 {200 ps} -r 300
force -freeze sim:/sequenceur/r 1 0, 0 {20}
run 10000