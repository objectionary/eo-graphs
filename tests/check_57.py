# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Exercise EO Ford-Fulkerson through its linked command-line entry point."""

from pathlib import Path
import subprocess

root = Path(__file__).resolve().parents[1]
for arguments, expected in [
    (['1'], '0'),
    (['1', '1', '0', '0:5'], '0'),
    (['2', '1', '0', '1:9'], '9'),
    (['2'], '0'),
]:
    result = subprocess.run(
        ['eoc', '--no-color', '--batch', '--blind', '--parser', '0.63.2',
         '--home-tag', '0.63.2', '--target', str(root / 'target/eo/fordfulkerson'),
         '--alone', 'dataize', '--heap=8G', 'fordfulkerson.fordfulkersonApp', *arguments],
        cwd=root / 'src/eo', capture_output=True, text=True, timeout=30,
    )
    assert result.returncode == 0, (arguments, result.stderr)
    assert result.stdout.strip() == expected, (arguments, result.stdout, result.stderr)
