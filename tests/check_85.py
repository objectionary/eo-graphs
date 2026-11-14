# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Run the regression through compiled native entry points."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    executable = target / 'dijkstra'
    subprocess.run(['g++', str(root / 'src/cpp/dijkstra.cpp'), '-o', str(executable)], check=True)
    for edges in [('1:1', '1:9'), ('1:9', '1:1'), ('1:1', '1:1')]:
        result = subprocess.run(
            [str(executable), '3', '3', '0', *edges, '2:1', '1', '2', '1:3'],
            check=True, capture_output=True, text=True, timeout=5,
        )
        assert result.stdout.strip() == 'Paths: 0 0 0', (edges, result.stdout)
    result = subprocess.run(
        [str(executable), '3', '2', '0', '1:9', '2:1', '1', '2', '1:3'],
        check=True, capture_output=True, text=True, timeout=5,
    )
    assert result.stdout.strip() == 'Paths: 0 2 0', result.stdout
