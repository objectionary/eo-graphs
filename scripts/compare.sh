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
java_dijkstra_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.dijkstra.Dijkstra"
cpp_dijkstra_cmd="target/cpp/dijkstra"

dijkstra_graph1=$(cat src/test/resources/dijkstra.graph)
dijkstra_graph2=$(java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 1 10)

echo "Test 1(dijkstra.graph)"
echo "EO:"
print_test_res $($eo_dijkstra_cmd $dijkstra_graph1 2> /dev/null)
echo "Java:"
print_test_res $($java_dijkstra_cmd $dijkstra_graph1 2> /dev/null)
echo "C++:"
print_test_res $($cpp_dijkstra_cmd $dijkstra_graph1 2> /dev/null)

echo -e "\nTest 2(random graph)"
echo "EO:"
print_test_res $($eo_dijkstra_cmd $dijkstra_graph2 2> /dev/null)
echo "Java:"
print_test_res $($java_dijkstra_cmd $dijkstra_graph2 2> /dev/null)
echo "C++:"
print_test_res $($cpp_dijkstra_cmd $dijkstra_graph2 2> /dev/null)

echo "====================================== Kruskal's algorithm ======================================"

eo_kruskal_cmd="scripts/eo_run.sh kruskal.appKruskal"
java_kruskal_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.kruskal.Kruskal"
cpp_kruskal_cmd="target/cpp/kruskal"

echo "Test 1(star.graph)"
echo "EO:"
print_test_res $($eo_kruskal_cmd $graph1 2> /dev/null)
echo "Java:"
print_test_res $($java_kruskal_cmd $graph1 2> /dev/null)
echo "C++:"
print_test_res $($cpp_kruskal_cmd $graph1 2> /dev/null)

echo -e "\nTest 2(star2.graph)"
echo "EO:"
print_test_res $($eo_kruskal_cmd $graph2 2> /dev/null)
echo "Java:"
print_test_res $($java_kruskal_cmd $graph2 2> /dev/null)
echo "C++:"
print_test_res $($cpp_kruskal_cmd $graph2 2> /dev/null)


echo -e "\nTest 3(random graph)"
echo "EO:"
print_test_res $($eo_kruskal_cmd $graph3 2> /dev/null)
echo "Java:"
print_test_res $($java_kruskal_cmd $graph3 2> /dev/null)
echo "C++:"
print_test_res $($cpp_kruskal_cmd $graph3 2> /dev/null)

echo "====================================== Ford–Fulkerson algorithm ======================================"

eo_ff_cmd="scripts/eo_run.sh fordfulkerson.mainFulkerson"
java_ff_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.fordfalkersonalg.FordFalkerson"
cpp_ff_cmd="target/cpp/fordfalkersonalg"

dijkstra_graph1=$(cat src/test/resources/dijkstra.graph)
dijkstra_graph2=$(java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 1 10)

echo "Test 1(dijkstra.graph)"
echo "EO:"
print_test_res $($eo_ff_cmd $dijkstra_graph1 2> /dev/null)
echo "Java:"
print_test_res $($java_ff_cmd $dijkstra_graph1 2> /dev/null)
echo "C++:"
print_test_res $($cpp_ff_cmd $dijkstra_graph1 2> /dev/null)

echo -e "\nTest 2(random graph)"
echo "EO:"
print_test_res $($eo_ff_cmd $dijkstra_graph2 2> /dev/null)
echo "Java:"
print_test_res $($java_ff_cmd $dijkstra_graph2 2> /dev/null)
echo "C++:"
print_test_res $($cpp_ff_cmd $dijkstra_graph2 2> /dev/null)