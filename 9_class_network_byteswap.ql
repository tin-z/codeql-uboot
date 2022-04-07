import cpp


class MyMacro extends Macro {
    MyMacro() { this.getName().regexpMatch("^nto(hl|hll|hs)$")}
    override string toString(){ result = super.toString() }
}

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    exists(MacroInvocation mc | 
        mc.getMacro() instanceof MyMacro 
        | mc.getExpr() = this
    )
  }
}

from NetworkByteSwap n
select n, "Network byte swap"


/* ref: https://codeql.github.com/docs/writing-codeql-queries/find-the-thief/#more-advanced-queries
import tutorial

from Person t
where 
   t.getHeight() > 150 and 
   exists(string c | t.getHairColor() = c) and 
   t.getHairColor().regexpMatch("(brown|black)") and
   t.getAge() >= 30 and
   t.getLocation() = "east" and
   (not (t.getHeight() > 180 and t.getHeight() < 190)) and
   t.getAge() < max(int i | exists(Person p | i = p.getAge()) | i) and
   t.getHeight() < max(int i | exists(Person p | i = p.getHeight()) | i) and
   t.getHeight() < sum(int i | exists(Person p | i = p.getHeight()) | i) and
   t.getAge() = max(int i | exists(Person p | p.getLocation() = "east" | i = p.getAge()) | i)
select t
*/