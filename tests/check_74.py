# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Check vertex diagnostics and dense graph input for both Java commands."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    sources = [str(source) for source in (root / 'src/java').rglob('*.java')]
    subprocess.run(['javac', '-d', str(target), *sources], check=True)
    for name in ['Dijkstra', 'FordFalkerson']:
        command = ['java', '-cp', str(target), name]
        for args in [['0:5:2', '5'], ['5:1:10', '0:1:10'],
                     ['0:-1:2', '1'], ['-1:1:2', '1'], ['0:2:2', '1']]:
            result = subprocess.run(command + args, capture_output=True, text=True, timeout=5)
            assert result.returncode != 0, result
            assert 'outside the declared range 0..1' in result.stderr, result.stderr
            assert 'ArrayIndexOutOfBoundsException' not in result.stderr, result.stderr
        result = subprocess.run(command + ['0:1:2', '1:2:2', '2'],
                                capture_output=True, text=True, check=True, timeout=5)
        expected = 'Paths: 0 0 1' if name == 'Dijkstra' else '2'
        assert result.stdout.strip() == expected, result.stdout
