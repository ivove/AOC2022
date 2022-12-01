Class AOC.Day1 Extends AOC.Base
{

Method Part1() As %Integer
{
        set result = 0
        set elf = 0
        while ('..File.AtEnd){
                set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
                set result = result + line
                if line = "" {
                        set elf = elf + 1
                        set load(elf) = result
                        set result = 0
                }
        }
        set load(elf) = result
        set elf = $ORDER(load(""),1,value)
        set max = 0
        while (elf '= "") {
                if value > max { set max = value }
                set elf = $ORDER(load(elf),1,value)
        }

        Return max
}

Method Part2() As %Integer
{
        set result = 0
        set elf = 0
        while ('..File.AtEnd){
                set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
                set result = result + line
                if line = "" {
                        set elf = elf + 1
                        set load(elf) = result
                        set loadIdx(result,elf) = ""
                        set result = 0
                }
        }
        set load(elf) = result
        
        set load = $ORDER(loadIdx(""),-1)
        set max = load
        set load = $ORDER(loadIdx(load),-1)
        set max = max + load        
        set load = $ORDER(loadIdx(load),-1)
        set max = max + load

        Return max
}

}
