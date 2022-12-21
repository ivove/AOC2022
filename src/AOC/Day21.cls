Class AOC.Day21 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = ""

    while ('..File.AtEnd) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set monkey = $PIECE(line,": ")
        set operation = $PIECE(line,": ",2)
        set map(monkey) = operation
    }

    set monkey = $ORDER(map(""),1,operation)
    while ((monkey '= "") && (result = "")) {
        if ('(operation?.N)) {
            set a = $PIECE(operation," ")
            set b = $PIECE(operation," ",3)
            set op = $PIECE(operation," ",2)

            if ((map(a)?.N) && (map(b)?.N)) {
                set r = 0
                if (op = "+") { set r = map(a) + map(b) }
                elseif (op = "-") { set r = map(a) - map(b) }
                elseif (op = "*") { set r = map(a) * map(b) }
                elseif (op = "/") { set r = map(a) / map(b) }
                set map(monkey) = r
            }

            if (monkey = "root") {
                if (map(monkey)?.N) { set result = map(monkey) }
            }
        }

        set monkey = $ORDER(map(monkey),1,operation)
        if (monkey = "") { set monkey = $ORDER(map(monkey),1,operation) }
    }
    return result
}

Method Part2() As %Integer
{
    set result = ""

    while ('..File.AtEnd) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set monkey = $PIECE(line,": ")
        set operation = $PIECE(line,": ",2)
        set map(monkey) = operation
    }

    set todo = map("root")
    kill map("root")
    set map("humn") = "xxx"

    set monkey = $ORDER(map(""),1,operation)
    set changed = 0
    while ((monkey '= "")) {
        if ('(operation?.N) && (operation '= "xxx")) {
            set a = $PIECE(operation," ")
            set b = $PIECE(operation," ",3)
            set op = $PIECE(operation," ",2)

            if ((map(a)?.N) && (map(b)?.N)) {
                set changed = 1
                set r = 0
                if (op = "+") { set r = map(a) + map(b) }
                elseif (op = "-") { set r = map(a) - map(b) }
                elseif (op = "*") { set r = map(a) * map(b) }
                elseif (op = "/") { set r = map(a) / map(b) }
                set map(monkey) = r
            }
        }

        set monkey = $ORDER(map(monkey),1,operation)
        if ((monkey = "") && (changed)) { 
            set monkey = $ORDER(map(monkey),1,operation) 
            set changed = 0
        }
    }

    set a = $PIECE(todo," + ")
    set b = $PIECE(todo," + ",2)
    if (map(a)?.N) { 
        set toCalc = map(a)
        set var = b
    }
    elseif (map(b)?.N) { 
        set toCalc = map(b)
        set var = a
    }

    while (result = "") {
        set operation = map(var)
        set a = $PIECE(operation," ")
        set b = $PIECE(operation," ",3)
        set op = $PIECE(operation," ",2)
        //w !,operation,*9,toCalc
        if (map(a)?.N) { 
            set a = map(a) 
            if (op = "+") { set toCalc = toCalc - a }
            elseif (op = "-") { set toCalc = a - toCalc }
            elseif (op = "*") { set toCalc = toCalc / a }
            elseif (op = "/") { set toCalc = a / toCalc } 
            set var = b
        }
        elseif (map(b)?.N) { 
            set b = map(b) 
            if (op = "+") { set toCalc = toCalc - b }
            elseif (op = "-") { set toCalc = toCalc + b }
            elseif (op = "*") { set toCalc = toCalc / b }
            elseif (op = "/") { set toCalc = toCalc * b } 
            set var = a
        }
        //w *9,a,*9,b,!
        if (var = "humn") { set result = toCalc }

    }

    /*w !,toCalc,*9,var,!
    zw map*/

    return result
}

}
