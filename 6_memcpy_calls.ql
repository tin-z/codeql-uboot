import cpp

class MemcpyFunc extends Function {
    MemcpyFunc() { this.getName() = "memcpy"}
}

from MemcpyFunc f, FunctionCall fc
where f = fc.getTarget()
select fc, "Memcpy() call found"