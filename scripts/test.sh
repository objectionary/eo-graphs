cmd_input="java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 0"
cmd_input2="java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 1"

eo_prim_cmd="scripts/eo_run.sh prim.appPrim"
java_prim_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.prim.PrimMST"
cpp_prim_cmd="target/cpp/prim"

eo_dijkstra_cmd="scripts/eo_run.sh dijkstra.main"
java_dijkstra_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.dijkstra.Dijkstra"
cpp_dijkstra_cmd="target/cpp/dijkstra"

print_header(){
  echo "---------------------------------------"
  printf  "| %-4s | %-10s | %-15s |\r\n" "vNum" "Time" "Memory(Kbyte)"
}

do_test(){
  IFS=" "
  res=$( { /usr/bin/time -f "%E %M" $1 $($2 $3) > /dev/null; } 2>&1 )

  read -ra resarr <<< "$res"
  printf  "| %-4s | %-10s | %15s |\r\n" "$3" "${resarr[0]}" "${resarr[1]}"
}


echo "========== Prim's algorithm ==========="

printf  "| %-35s |\r\n" "C++:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$cpp_prim_cmd" "$cmd_input" $vNum
done
echo "---------------------------------------"


printf  "| %-35s |\r\n" "Java:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$java_prim_cmd" "$cmd_input" $vNum
done
echo "---------------------------------------"

printf  "| %-35s |\r\n" "EO:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$eo_prim_cmd" "$cmd_input" $vNum
done
echo -e "---------------------------------------\n"

echo "======== Dijkstra's algorithm ========="
printf  "| %-35s |\r\n" "C++:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$cpp_dijkstra_cmd" "$cmd_input2" $vNum
done
echo "---------------------------------------"

printf  "| %-35s |\r\n" "Java:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$java_dijkstra_cmd" "$cmd_input" $vNum
done
echo "---------------------------------------"

printf  "| %-35s |\r\n" "EO:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$eo_dijkstra_cmd" "$cmd_input2" $vNum
done
echo -e "---------------------------------------\n"






