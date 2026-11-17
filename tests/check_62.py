# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Check clean, incremental, and partial Java builds with GNU Make."""

from pathlib import Path
import shutil
import subprocess
import tempfile
import time

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    source = Path(temporary) / 'java'
    shutil.copytree(root / 'src/java', source)
    subprocess.run(['make', 'clean'], cwd=source, check=True)
    subprocess.run(['make', '-j4'], cwd=source, check=True)
    target = source / 'targets'
    expected = ['Dijkstra.class', 'FordFalkerson.class', 'Kruskal.class',
                'GraphGenerator.class', 'prim/WeightGraph.class', 'prim/PrimMST.class']
    assert all((target / name).is_file() for name in expected)
    subprocess.run(['make', '-q'], cwd=source, check=True)
    before = {name: (target / name).stat().st_mtime_ns for name in expected}
    time.sleep(1.1)
    (source / 'dijkstra/Dijkstra.java').touch()
    subprocess.run(['make', '-j4'], cwd=source, check=True)
    assert (target / 'Dijkstra.class').stat().st_mtime_ns > before['Dijkstra.class']
    assert all((target / name).stat().st_mtime_ns == before[name]
               for name in expected if name != 'Dijkstra.class')
    (target / 'Kruskal.class').unlink()
    subprocess.run(['make', '-j4'], cwd=source, check=True)
    assert (target / 'Kruskal.class').is_file()
    subprocess.run(['make', '-q'], cwd=source, check=True)
