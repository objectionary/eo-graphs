cmd_input="java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator"

eo_prim_cmd="scripts/eo_run.sh prim.appPrim"
java_prim_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.prim.PrimMST"
cpp_prim_cmd="target/cpp/prim"

echo "====================================== Prim's algorithm ======================================"
echo -e "\nC++:"
/usr/bin/time -f "%E %M" $cpp_prim_cmd $($cmd_input 0 10) > /dev/null
/usr/bin/time -f "%E %M" $cpp_prim_cmd $($cmd_input 0 30) > /dev/null
/usr/bin/time -f "%E %M" $cpp_prim_cmd $($cmd_input 0 50) > /dev/null

echo -e "\nJava:"
/usr/bin/time -f "%E %M" $java_prim_cmd $($cmd_input 0 10) > /dev/null
/usr/bin/time -f "%E %M" $java_prim_cmd $($cmd_input 0 30) > /dev/null
/usr/bin/time -f "%E %M" $java_prim_cmd $($cmd_input 0 50) > /dev/null

echo -e "\nEO:"
/usr/bin/time -f "%E %M" $eo_prim_cmd $($cmd_input 0 10) > /dev/null
/usr/bin/time -f "%E %M" $eo_prim_cmd $($cmd_input 0 30) > /dev/null
/usr/bin/time -f "%E %M" $eo_prim_cmd $($cmd_input 0 50) > /dev/null





