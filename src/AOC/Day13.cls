Class AOC.Day13 Extends AOC.Base
{

Method Part1() As %Integer
{
        set result = 0
        set idx = 1
        while ('..TestFile.AtEnd) {
            set line1 = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
            set line2 = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
            set empty = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")

            if (..IsRightOrderString(line1,line2)) { set result = result + idx }

            set idx = idx + 1
        }
        Return result
}

Method IsRightOrderString(line1, line2) As %Boolean [ PublicList = (l1, l2) ]
{
    set l1 = ""
    set l2 = ""

    set @("l1="_line1)
    set @("l2="_line2)

    Return ..IsRightOrder(l1,l2)
}

Method IsRightOrder(l1, l2) As %Boolean
{
    set ok = 1

    set s1 = l1.%Size()
    set s2 = l2.%Size()
    set len = s1
    if (len > s2) { set len = s2 }

    set i = 0
    while (ok && (i<len)) {
        w i,*9,l1.%Get(i),*9,l2.%Get(i),!
        if ($ISVALIDNUM(l1.%Get(i)) && $ISVALIDNUM(l2.%Get(i))) {
            if (l1.%Get(i) > l2.%Get(i)) { set ok = 0 }
        }
        else {
            
        }
        set i = i + 1
    }

    Return ok
}

}
