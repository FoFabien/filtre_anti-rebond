restart -f
force -freeze h 1 20, 0 {70 ps} -r 100
force -freeze comptage 1 0, 0 300 ps,  1 {500 ps}
virtual signal {AUX} N
radix -unsigned
run 100001000