# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Check run-target output and failure handling with a controlled EO command."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    folder = Path(temporary)
    shutil.copy(root / 'Makefile', folder)
    shutil.copytree(root / 'tests/edges', folder / 'tests/edges')
    shutil.copytree(root / 'tests/list', folder / 'tests/list')
    command = folder / 'eoc'
    command.write_text(
        '#!/usr/bin/env python3\nimport os, sys\n'
        'print("RESULT " + sys.argv[-1])\n'
        'sys.exit(7 if os.environ.get("FAIL_EOC") else 0)\n',
        encoding='utf-8',
    )
    command.chmod(0o755)
    environment = {**os.environ, 'PATH': str(folder) + os.pathsep + os.environ['PATH']}
    for algorithm, source in [('prim', 'edges'), ('kruskal', 'edges'),
                              ('dijkstra', 'list'), ('fordfulkerson', 'list')]:
        target = f'target/run/{algorithm}.txt'
        subprocess.run(['make', '-o', 'compile', target], cwd=folder, env=environment, check=True)
        result = (folder / target).read_text().splitlines()
        assert len(result) == len(list((folder / 'tests' / source).iterdir())), result
        assert all(line.startswith('RESULT ') for line in result), result
    target = folder / 'target/run/prim.txt'
    target.unlink()
    result = subprocess.run(
        ['make', '-o', 'compile', 'target/run/prim.txt'], cwd=folder,
        env={**environment, 'FAIL_EOC': '1'}, capture_output=True, text=True,
    )
    assert result.returncode != 0 and not target.exists(), result
