# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Exercise the native algorithm through its public entry point."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    executable = target / 'flow'
    subprocess.run(['g++', str(root / 'src/cpp/fordfalkersonalg.cpp'), '-o', str(executable)], check=True)
    for count in ['1001', '1', '0', '-1']:
        result = subprocess.run([str(executable), count], capture_output=True, text=True, timeout=5)
        assert result.returncode != 0, result
        assert 'between 2 and 1000' in result.stderr, result.stderr
    for count, last in [('1000', '999'), ('2', '1')]:
        result = subprocess.run([str(executable), count, '1', '0', f'{last}:7'],
                                capture_output=True, text=True, check=True, timeout=5)
        assert result.stdout.strip() == '7', result.stdout
