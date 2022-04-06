import cpp

from Function f
where f.getName().regexpMatch("^memcpy$")
select f, "memcpy found"