graph1=$(cat src/test/resources/star.graph)
graph2=$(cat src/test/resources/star2.graph)

eo_prim_cmd="scripts/eo_run.sh prim.appPrim"
cpp_prim_cmd="target/cpp/prim"

print_test_res() {
  if [ $? -eq 0 ]
  then
    echo "$@"
  else
    echo "Execution error"
  fi
}

echo "Comparison of the results of different implementations of Prim's algorithm"

echo "Test 1(star.graph)"
echo "EO:"
print_test_res $($eo_prim_cmd $graph1 2> /dev/null)

echo "C++:"
print_test_res $($cpp_prim_cmd $graph1 2> /dev/null)

echo -e "\nTest 2(star2.graph)"
echo "EO:"
print_test_res $($eo_prim_cmd $graph2 2> /dev/null)
echo "C++:"
print_test_res $($cpp_prim_cmd $graph2 2> /dev/null)
echo -e "\n"