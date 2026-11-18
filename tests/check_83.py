# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Check parallel and zero-weight edges through the C++ Prim command."""

from pathlib import Path
import re
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    executable = Path(temporary) / 'prim'
    subprocess.run(['g++', str(root / 'src/cpp/prim.cpp'), '-o', str(executable)], check=True)
    for edges, weight in [
        ([(0, 1, 5), (0, 1, 3), (1, 0, 7), (0, 1, 6)], 3),
        ([(0, 1, 0), (1, 0, 4)], 0),
        ([(0, 1, 0), (1, 2, 1), (0, 2, 5)], 1),
        ([(0, 1, 0), (1, 2, 0), (0, 2, 0)], 0),
        ([(0, 1, 2), (1, 2, 1), (0, 2, 5)], 3),
        ([(0, 1, -3), (1, 2, 1), (0, 2, 5)], -2),
    ]:
        vertices = {node for first, second, _ in edges for node in [first, second]}
        for ordered in [edges, list(reversed(edges))]:
            args = [str(value) for edge in ordered for value in edge]
            result = subprocess.run([str(executable), *args], check=True,
                                    capture_output=True, text=True, timeout=5)
            found = re.findall(r'\((-?\d+) (-?\d+) - (-?\d+)\)', result.stdout)
            assert len(found) == len(vertices) - 1, result.stdout
            assert all(first != second for first, second, _ in found), result.stdout
            assert {int(node) for first, second, _ in found for node in [first, second]} == vertices, result.stdout
            assert sum(int(item[2]) for item in found) == weight, result.stdout
