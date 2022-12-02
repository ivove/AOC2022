Class AOC.Day2 Extends AOC.Base
{

Method Part1() As %Integer
{
        set result = 0
        while ('..File.AtEnd) {
            set line = ..File.ReadLine()
            set op = $EXTRACT(line,1)
            set me = $EXTRACT(line,3)
            set result = result + ..Play(op,me)
        }
        return result
}

Method Play(opp As %String, me As %String) As %Integer
{
    /*
        rock A X
        paper B Y
        scissors C Z
    */
    if (opp = "A") { set opp = "X" }
    if (opp = "B") { set opp = "Y" }
    if (opp = "C") { set opp = "Z" }

    set result = 1
    if (me = "Y") { set result = 2 }
    if (me = "Z") { set result = 3 }

    if (me = opp) { set result = result + 3 }
    else {
        if ((me = "X") && (opp = "Z")) { set result = result + 6 }
        elseif ((me = "Y") && (opp = "X")) { set result = result + 6 }
        elseif ((me = "Z") && (opp = "Y")) { set result = result + 6 }
    }

    return result
}

Method Part2() As %Integer
{
        set result = 0
        while ('..File.AtEnd) {
            set line = ..File.ReadLine()
            set op = $EXTRACT(line,1)
            set res = $EXTRACT(line,3)
            set result = result + ..Play2(op,res)
        }
        return result
}

Method Play2(opp As %String, res As %String) As %Integer
{
    set result = 0
     /*
        rock A 
        paper B 
        scissors C 
        win Z
        lose X
        draw Y
    */
    if (res = "Y") { set me = opp }
    elseif (res = "X") {
        if (opp = "A") { set me = "C" }
        elseif (opp = "B") { set me = "A" }
        else { set me = "B" }
    }
    else {
        if (opp = "A") { set me = "B" }
        elseif (opp = "B") { set me = "C" }
        else { set me = "A" }
    }


    if (me = "A") { set me = "X" }
    if (me = "B") { set me = "Y" }
    if (me = "C") { set me = "Z" }

    return ..Play(opp,me)
}

}
