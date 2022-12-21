Class AOC.Day20 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0
    set idx = 0
    set pidx = 0
    set lastIdx = 0
    while ('..TestFile.AtEnd) {
        set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set list(idx) = $LISTBUILD(pidx,line)
        set pidx = idx
        set lastIdx = idx
        set idx = idx + 1
    }
    set $LIST(list(0),1) = lastIdx

    merge nlist = list
    for idx=0:1:lastIdx {
        set value = $LIST(list(idx),2)
        set nidx = (idx + value) # lastIdx
        
        w nidx,!
        zw nlist
    }
    zw list
    
    Return result
}

}
