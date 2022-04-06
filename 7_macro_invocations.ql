import cpp

class MyMacro extends Macro {
    MyMacro() { this.getName().regexpMatch("^nto(hl|hll|hs)$")}
    override string toString(){ result = super.toString() }
}


from MyMacro m, MacroInvocation mc
where m = mc.getMacro()
select mc, "macro call"