Class AOC.Day3 Extends AOC.Base
{

Method Part1() As %Integer
{
        set result = 0
        while ('..File.AtEnd){
            set line = ..File.ReadLine()
            set len = $LENGTH(line)
            set p1 = $EXTRACT(line,1,len/2)
            set p2 = $EXTRACT(line,len/2+1,*)
            set xx = $TRANSLATE(p1,p2,"")
            set xx = $EXTRACT($TRANSLATE(p1,xx,""),1)
            set prio = $ASCII(xx)
            if (prio < 96) {
                set prio = prio - 64 + 26
            }
            else {
                set prio = prio - 96
            }
            set result = result + prio
        }
        return result
}

Method Part2() As %Integer
{
    set result = 0
    while ('..File.AtEnd){
            set s1 = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set s2 = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set s3 = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")

            set c = ""
            for i=1:1:$LENGTH(s1) {
                set l = $EXTRACT(s1,i)
                if ((s2 [ l) && (s3 [ l)) { set c = l}
            }

            set prio = $ASCII(c)
            if (prio < 96) {
                set prio = prio - 64 + 26
            }
            else {
                set prio = prio - 96
            }
            set result = result + prio
        }
    return result
}

}
