# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Run both MST commands on dense and sparse vertex labels."""

from pathlib import Path
import re
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    sources = [str(source) for source in (root / 'src/java').rglob('*.java')]
    subprocess.run(['javac', '-d', str(target), *sources], check=True)
    commands = [['java', '-cp', str(target), name] for name in ['prim.PrimMST', 'Kruskal']]
    for labels in [(0, 1, 2), (7, 42, 1000000000), (100, 900, 500)]:
        first, second, third = labels
        edges = [(first, second, 3), (second, third, 4), (first, third, 12)]
        expected = {frozenset((first, second)), frozenset((second, third))}
        for order in [edges, list(reversed(edges))]:
            arguments = [str(value) for edge in order for value in edge]
            for command in commands:
                result = subprocess.run(command + arguments, check=True, capture_output=True, text=True, timeout=5)
                found = re.findall(r'\((-?\d+) (-?\d+) - (-?\d+)\)', result.stdout)
                assert len(found) == 2, (command, result.stdout)
                assert {frozenset((int(a), int(b))) for a, b, _ in found} == expected, result.stdout
                assert sum(int(weight) for _, _, weight in found) == 7, result.stdout
