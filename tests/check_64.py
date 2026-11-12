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
    for weights, expected in [
        ((2000000000, 2100000000, 2000000000), [0, 0, 0]),
        ((2147483647, None, 2147483647), [0, 0, 1]),
        ((3, 8, 4), [0, 0, 1]),
        ((3, 8, None), [0, 0, 0]),
    ]:
        first, direct, second = weights
        edges = [(0, 1, first)]
        if direct is not None:
            edges.append((0, 2, direct))
        if second is not None:
            edges.append((1, 2, second))
        java = []
        cpp = ['3']
        for node in range(3):
            outgoing = [(v, w) for u, v, w in edges if u == node]
            java.append(':'.join([str(node)] + [str(x) for pair in outgoing for x in pair]))
            cpp += [str(len(outgoing)), str(node)] + [f'{v}:{w}' for v, w in outgoing]
        for command, args in zip(commands, [cpp, java]):
            result = subprocess.run(command + args, check=True, capture_output=True, text=True, timeout=5)
            assert list(map(int, result.stdout.split('Paths: ')[1].split())) == expected, result.stdout
