# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Check that C++ Prim selects real edges throughout the int weight range."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as tmp:
    exe = Path(tmp) / "prim"
    subprocess.run(["g++", str(root / "src/cpp/prim.cpp"), "-o", str(exe)], check=True)
    for weight in ("9999999", "10000000", "2147483647"):
        tree = subprocess.check_output([str(exe), "0", "1", weight], text=True)
        assert tree.strip() == f"MST: (0 1 - {weight})", tree
    tree = subprocess.check_output(
        [str(exe), "0", "1", "2147483647", "0", "2", "10000000", "2", "1", "9999999"],
        text=True,
    )
    assert tree.strip() == "MST: (0 2 - 10000000) (2 1 - 9999999)", tree
    split = subprocess.run(
        [str(exe), "0", "1", "1", "2", "3", "1"], capture_output=True, text=True,
    )
    assert split.returncode != 0 and "disconnected" in split.stderr, split
