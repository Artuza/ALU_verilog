transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/add_with_carry_32bit.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/full_adder.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/and_gate.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/ands_32bit.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/multiplier_32bit.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/or_gate.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/orrs_32bit.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/complement_to_two.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/rsbs_32bit.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/full_subtractor.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/subtractor_32bit.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/alu.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/ProgramCounter.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/ProgramMemory.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/CPU.v}
vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/testbench_CPU.v}

vlog -vlog01compat -work work +incdir+D:/Logica\ programable/ALU {D:/Logica programable/ALU/testbench_CPU.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench_CPU

add wave *
view structure
view signals
run -all
