/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

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

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall fc |
        sink.asExpr() = fc.getArgument(2) |
        fc.getTarget().hasName("memcpy"))
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"