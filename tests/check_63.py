# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Run the regression through compiled native entry points."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    subprocess.run(['javac', '-d', str(target), str(root / 'src/java/generator/GraphGenerator.java')], check=True)
    for arguments in [[], ['0'], ['0', '3', 'extra'], ['7', '3'], ['-1', '3'], ['abc', '3'], ['0', 'abc']]:
        result = subprocess.run(
            ['java', '-cp', str(target), 'GraphGenerator', *arguments],
            capture_output=True, text=True, timeout=5,
        )
        assert result.returncode != 0 and result.stderr.strip() and not result.stdout, (arguments, result)
    for form in ['0', '1']:
        result = subprocess.run(
            ['java', '-cp', str(target), 'GraphGenerator', form, '3'],
            check=True, capture_output=True, text=True, timeout=5,
        )
        assert result.stdout.strip() and not result.stderr, (form, result)
