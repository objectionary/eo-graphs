#!/bin/bash
cmd_input="java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 0"
cmd_input2="java -cp target/classes -Xss40m  ru.hse.eo_graphs.GraphGenerator 1"

eo_prim_cmd="scripts/eo_run.sh prim.appPrim"
java_prim_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.prim.PrimMST"
cpp_prim_cmd="target/cpp/prim"

eo_dijkstra_cmd="scripts/eo_run.sh dijkstra.main"
java_dijkstra_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.dijkstra.Dijkstra"
cpp_dijkstra_cmd="target/cpp/dijkstra"

eo_kruskal_cmd="scripts/eo_run.sh kruskal.appKruskal"
java_kruskal_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.kruskal.Kruskal"
cpp_kruskal_cmd="target/cpp/kruskal"

eo_ff_cmd="scripts/eo_run.sh fordfulkerson.mainFulkerson"
java_ff_cmd="java -cp target/classes -Xss40m  ru.hse.eo_graphs.java.fordfalkersonalg.FordFalkerson"
cpp_ff_cmd="target/cpp/fordfalkersonalg"

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
	do_test "$java_dijkstra_cmd" "$cmd_input2" $vNum
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

echo "========= Kruskal's algorithm ========="

printf  "| %-35s |\r\n" "C++:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$cpp_kruskal_cmd" "$cmd_input" $vNum
done
echo "---------------------------------------"


printf  "| %-35s |\r\n" "Java:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$java_kruskal_cmd" "$cmd_input" $vNum
done
echo "---------------------------------------"

printf  "| %-35s |\r\n" "EO:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$eo_kruskal_cmd" "$cmd_input" $vNum
done
echo -e "---------------------------------------\n"

echo "====== Ford–Fulkerson algorithm ======="
printf  "| %-35s |\r\n" "C++:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$cpp_ff_cmd" "$cmd_input2" $vNum
done
echo "---------------------------------------"

printf  "| %-35s |\r\n" "Java:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$java_ff_cmd" "$cmd_input2" $vNum
done
echo "---------------------------------------"

printf  "| %-35s |\r\n" "EO:"
print_header
for vNum in 10 30 50
do
  echo "---------------------------------------"
	do_test "$eo_ff_cmd" "$cmd_input2" $vNum
done
echo -e "---------------------------------------\n"
