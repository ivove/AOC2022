Class AOC.Day10 Extends AOC.Base
{

Method Part1()
{
    set result = 0
    set x = 1
    set i = 1
    while ('..File.AtEnd) {
        set line = ..File.ReadLine()
        set instructions(i) = line
        set i = i + 1
    }
    set nr = ""
    set wait = 0
    for i=1:1:220 {
        if (wait = 0) {
            if ($PIECE($GET(inst)," ") = "addx") {
                set x = x + $PIECE(inst," ",2)
            }
            set nr = $ORDER(instructions(nr))
            if nr = "" { set nr = $ORDER(instructions(nr)) }
            set inst = instructions(nr)
        }
        if ($PIECE(inst," ") = "addx") {
            if (wait > 0) { 
                set wait = wait - 1
            } else { set wait = 1 }
        }
        if i < 21 {
            w $GET(inst),*9,wait,*9,i,*9,x,!
        }
        if ((i = 20) || (i = 60) || (i = 100) || (i = 140) || (i = 180) || (i = 220)){
            write i,*9,x,*9,x*i,!
            set result = result + (x*i)
        }
    }
    Return result
}

Method Part2()
{
    set result = 0
    set x = 1
    set i = 1
    while ('..File.AtEnd) {
        set line = ..File.ReadLine()
        set instructions(i) = line
        set i = i + 1
    }
    set nr = ""
    set wait = 0
    for l=0:1:5 {
        for i=0:1:39 {
            if (wait = 0) {
                if ($PIECE($GET(inst)," ") = "addx") {
                    set x = x + $PIECE(inst," ",2)
                }
                set nr = $ORDER(instructions(nr))
                if nr = "" { set nr = $ORDER(instructions(nr)) }
                set inst = instructions(nr)
            }
            if ($PIECE(inst," ") = "addx") {
                if (wait > 0) { 
                    set wait = wait - 1
                } else { set wait = 1 }
            }
            set d = "."
            if ((i >= (x-1)) && (i <= (x+1))) { set d = "#" }
            s display(l,i) = d
            /*if i < 21 {
                w $GET(inst),*9,wait,*9,i,*9,x,!
            }
            if ((i = 20) || (i = 60) || (i = 100) || (i = 140) || (i = 180) || (i = 220)){
                write i,*9,x,*9,x*i,!
                set result = result + (x*i)
            }*/
        }
    }
    for l=0:1:5 {
        for i=0:1:39 {
            write display(l,i)
        }
        write !
    }
    write !
    Return result
}

}
