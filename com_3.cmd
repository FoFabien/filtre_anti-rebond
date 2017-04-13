restart -f
force -freeze sim:/filtre_anti_rebond//h 1 0 ns, 0 {50 ps} -r 100 ps
force -freeze sim:/filtre_anti_rebond//entree 0 0, 1 {27 us} -r 54 us
force -freeze sim:/filtre_anti_rebond//r 1 0, 0 {10}
run 100000000
