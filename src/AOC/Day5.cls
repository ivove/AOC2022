Class AOC.Day5 Extends AOC.Base
{

Method Part1() As %String
{
        set result = ""
        set stacks = 0
        set numberOfStacks = 0
        set h = ..GetStackHeight()
        while ('..File.AtEnd) {
            set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set len = $LENGTH(line)
            if (len '= 0) {
                if ('stacks && (h >= 0)) {
                    set numberOfStacks = (len + 1) / 4
                    for stacknr = 1:1:numberOfStacks {
                        set pos = 2 + ((stacknr - 1) * 4)
                        set container = $EXTRACT(line,pos)
                        set map(stacknr,h) = container
                        if ((container '= " ") && ($DATA(map(stacknr)) = 10)) { set map(stacknr) = h }
                    }
                    set h = h - 1
                }
                elseif (stacks) {
                    set moves = $PIECE(line," ",2)
                    set from = $PIECE(line," ",4)
                    set to = $PIECE(line," ",6)
                    for i=1:1:moves {
                        set map(to) = map(to) + 1
                        set map(to,map(to)) = map(from,map(from))
                        set map(from,map(from)) = " "
                        set map(from) = map(from) - 1
                    }
                }
            }
            else { set stacks = 1 }
        }
        for i=1:1:numberOfStacks {
            set result = result_map(i,map(i))
        }
        return result
}

Method GetStackHeight() As %Integer
{
    set stack = 0
    set height = 0
    while ('..File.AtEnd && 'stack) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        if (len = 0) { set stack = 1 }
        else {
            set height = height + 1
        }
    }
    do ..File.Rewind()
    return (height - 2)
}

Method Part2() As %String
{
        set result = ""
        set stacks = 0
        set numberOfStacks = 0
        set h = ..GetStackHeight()
        while ('..File.AtEnd) {
            set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set len = $LENGTH(line)
            if (len '= 0) {
                if ('stacks && (h >= 0)) {
                    set numberOfStacks = (len + 1) / 4
                    for stacknr = 1:1:numberOfStacks {
                        set pos = 2 + ((stacknr - 1) * 4)
                        set container = $EXTRACT(line,pos)
                        set map(stacknr,h) = container
                        if ((container '= " ") && ($DATA(map(stacknr)) = 10)) { set map(stacknr) = h }
                    }
                    set h = h - 1
                }
                elseif (stacks) {
                    set moves = $PIECE(line," ",2)
                    set from = $PIECE(line," ",4)
                    set to = $PIECE(line," ",6)
                    for i=1:1:moves {
                        set map(to) = map(to) + 1
                        set map(to,map(to)) = map(from,map(from)-(moves-i))
                        set map(from,map(from)-(moves-i)) = " "
                    }
                    set map(from) = map(from) - moves
                }
            }
            else { set stacks = 1 }
        }
        for i=1:1:numberOfStacks {
            set result = result_map(i,map(i))
        }
        return result
}

}
