#EO implementaion of Prim's algorithm
/usr/bin/time -f "%e %E %M" scripts/eo_run.sh prim.appPrim $(< src/test/resources/star.graph) > /dev/null
/usr/bin/time -f "%e %E %M" scripts/eo_run.sh prim.appPrim $(< src/test/resources/star2.graph) > /dev/null

#C++ implementaion of Prim's algorithm
/usr/bin/time -f "%e %E %M" target/cpp/prim $(< src/test/resources/star.graph) > /dev/null
/usr/bin/time -f "%e %E %M" target/cpp/prim $(< src/test/resources/star2.graph) > /dev/null

