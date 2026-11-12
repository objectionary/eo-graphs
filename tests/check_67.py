# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Exercise the native algorithm through its public entry point."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    subprocess.run(['g++', str(root / 'src/cpp/dijkstra.cpp'), '-o', str(target / 'dijkstra')], check=True)
    subprocess.run(['javac', '-d', str(target), str(root / 'src/java/dijkstra/Dijkstra.java')], check=True)
    commands = [[str(target / 'dijkstra')], ['java', '-cp', str(target), 'Dijkstra']]
    cases = [
        (['3', '2', '0', '1:2', '2:5', '0', '1', '1', '2', '1:-10'],
         ['0:1:2:2:5', '1', '2:1:-10'], False),
        (['3', '0', '0', '1', '1', '2:-1', '0', '2'], ['0', '1:2:-1', '2'], False),
        (['2', '2', '0', '1:-1', '1:2', '0', '1'], ['0:1:-1:1:2', '1'], False),
        (['2', '1', '0', '1:2', '0', '1'], ['0:1:2', '1'], True),
        (['2', '1', '0', '1:0', '0', '1'], ['0:1:0', '1'], True),
    ]
    for cpp, java, valid in cases:
        for command, args in zip(commands, [cpp, java]):
            result = subprocess.run(command + args, capture_output=True, text=True, timeout=5)
            assert (result.returncode == 0) == valid, (args, result)
            if not valid:
                assert 'non-negative edge weights' in result.stderr, result.stderr
    java_api = target / 'CheckDijkstra.java'
    java_api.write_text('''public final class CheckDijkstra {
    public static void main(String[] args) {
        try {
            Dijkstra.dijkstra(2, new int[] {0, -1, 0, 0}, 0);
            throw new AssertionError("Negative matrix was accepted");
        } catch (IllegalArgumentException expected) {
            if (!expected.getMessage().contains("non-negative edge weights")) {
                throw new AssertionError(expected);
            }
        }
        Dijkstra.dijkstra(2, new int[] {0, 2, 0, 0, -1}, 0);
    }
}
''')
    subprocess.run(['javac', '-cp', str(target), '-d', str(target), str(java_api)], check=True)
    subprocess.run(['java', '-cp', str(target), 'CheckDijkstra'], check=True, timeout=5)
    cpp_api = target / 'check_api.cpp'
    source = (root / 'src/cpp/dijkstra.cpp').as_posix()
    cpp_api.write_text(f'#define main graph_main\n#include "{source}"\n#undef main\n' + '''
int main() {
    int invalid[] = {0, -1, 0, 0};
    bool rejected = false;
    try {
        dijkstra(2, invalid, 0);
    } catch (const std::invalid_argument& expected) {
        rejected = std::string(expected.what()).find("non-negative edge weights") != std::string::npos;
    }
    if (!rejected) return 1;
    int valid[] = {0, 2, 0, 0, -1};
    dijkstra(2, valid, 0);
    return 0;
}
''')
    executable = target / 'check_api'
    subprocess.run(['g++', str(cpp_api), '-o', str(executable)], check=True)
    subprocess.run([str(executable)], check=True, timeout=5)
