# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Run the regression through compiled native entry points."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    executable = target / 'flow'
    subprocess.run(['g++', str(root / 'src/cpp/fordfalkersonalg.cpp'), '-o', str(executable)], check=True)
    subprocess.run(['javac', '-d', str(target), str(root / 'src/java/fordfalkersonalg/FordFalkerson.java')], check=True)
    cases = [
        (['0:1:5:1:7', '1:'], ['2', '2', '0', '1:5', '1:7'], '12'),
        (['0:1:7:1:5', '1:'], ['2', '2', '0', '1:7', '1:5'], '12'),
        (['0:1:5', '1:'], ['2', '1', '0', '1:5'], '5'),
        (['0:1:2000000000:2:2000000000', '1:3:2000000000', '2:3:2000000000', '3:'],
         ['4', '2', '0', '1:2000000000', '2:2000000000', '1', '1', '3:2000000000', '1', '2', '3:2000000000'],
         '4000000000'),
        (['0:1:2000000000', '1:0:2000000000:2:2000000000', '2:'],
         ['3', '1', '0', '1:2000000000', '2', '1', '0:2000000000', '2:2000000000'],
         '2000000000'),
    ]
    for java_args, cpp_args, expected in cases:
        for command in [['java', '-cp', str(target), 'FordFalkerson', *java_args], [str(executable), *cpp_args]]:
            result = subprocess.run(command, check=True, capture_output=True, text=True, timeout=5)
            assert result.stdout.strip() == expected, (command, result.stdout, expected)
    overflow = subprocess.run(
        ['java', '-cp', str(target), 'FordFalkerson', '0:1:2147483647:1:1', '1:'],
        capture_output=True, text=True, timeout=5,
    )
    assert overflow.returncode != 0 and 'integer overflow' in overflow.stderr, overflow
