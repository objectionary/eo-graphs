graph1=$(cat src/test/resources/star.graph)
graph2=$(cat src/test/resources/star2.graph)
graph3=$(java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 0 10)

eo_prim_cmd="scripts/eo_run.sh prim.appPrim"
java_prim_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.prim.PrimMST"
cpp_prim_cmd="target/cpp/prim"

print_test_res() {
  if [ $? -eq 0 ]
  then
    echo "$@"
  else
    echo "Execution error"
  fi
}

echo "====================================== Prim's algorithm ======================================"

echo "Test 1(star.graph)"
echo "EO:"
print_test_res $($eo_prim_cmd $graph1 2> /dev/null)
echo "Java:"
print_test_res $($java_prim_cmd $graph1 2> /dev/null)
echo "C++:"
print_test_res $($cpp_prim_cmd $graph1 2> /dev/null)

echo -e "\nTest 2(star2.graph)"
echo "EO:"
print_test_res $($eo_prim_cmd $graph2 2> /dev/null)
echo "Java:"
print_test_res $($java_prim_cmd $graph2 2> /dev/null)
echo "C++:"
print_test_res $($cpp_prim_cmd $graph2 2> /dev/null)


echo -e "\nTest 3(random graph)"
echo "EO:"
print_test_res $($eo_prim_cmd $graph3 2> /dev/null)
echo "Java:"
print_test_res $($java_prim_cmd $graph3 2> /dev/null)
echo "C++:"
print_test_res $($cpp_prim_cmd $graph3 2> /dev/null)


echo "====================================== Dijkstra's algorithm ======================================"

eo_dijkstra_cmd="scripts/eo_run.sh dijkstra.main"
cpp_dijkstra_cmd="target/cpp/dijkstra"
dijkstra_graph1=$(cat src/test/resources/dijkstra.graph)
echo "Test 1(dijkstra.graph)"
echo "EO:"
print_test_res $($eo_dijkstra_cmd $dijkstra_graph1 2> /dev/null)
echo "C++:"
print_test_res $($cpp_dijkstra_cmd $dijkstra_graph1 2> /dev/null)