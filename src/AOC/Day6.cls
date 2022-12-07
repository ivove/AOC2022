Class AOC.Day6 Extends AOC.Base
{

Method Part1()
{
        set result = 0
        set line = ..File.ReadLine()
        return ..FindStart(line)
}

Method Part2()
{
        set result = 0
        set line = ..File.ReadLine()
        return ..FindStart(line,14)
}

Method FindStart(buffer As %String, length As %Integer = 4)
{
    set start = 0
    set len = $LENGTH(buffer)
    set found = 0
    while ('found && (start <= (len-length))) {
        set sub = $EXTRACT(buffer,start,start + length)
        set found = ..TestStart(sub)
        if ('found) { set start = start + 1 }
    }
    return start + length-1
}

Method TestStart(part As %String) As %Boolean
{
    set ok = 1
    while (ok && ($LENGTH(part) > 1)) {
        set len = $LENGTH(part) - 1
        set test = $EXTRACT(part,1)
        set part = $EXTRACT(part,2,*)
        set part = $TRANSLATE(part,test,"")
        if ($LENGTH(part) '= len ) { set ok = 0 }
    }
    return ok
}

}
