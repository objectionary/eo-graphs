# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Run the regression through compiled native entry points."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    sources = [str(source) for source in (root / 'src/java').rglob('*.java')]
    subprocess.run(['javac', '-d', str(target), *sources], check=True)
    for edges in [
        ['0', '1', '-2147483648', '1', '2', '1', '0', '2', '2147483647'],
        ['0', '2', '2147483647', '1', '2', '1', '0', '1', '-2147483648'],
    ]:
        result = subprocess.run(
            ['java', '-cp', str(target), 'Kruskal', *edges],
            check=True, capture_output=True, text=True, timeout=5,
        )
        assert result.stdout.strip() == 'MST: (0 1 - -2147483648) (1 2 - 1)', result.stdout
