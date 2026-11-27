# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Check that Java Prim builds an empty spanning forest for an empty graph."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    harness = target / 'CheckPrimEmpty.java'
    harness.write_text("""import prim.PrimMST;
import prim.WeightGraph;
public final class CheckPrimEmpty {
    public static void main(String[] args) {
        PrimMST tree = new PrimMST(new WeightGraph(0));
        if (!tree.getMst().isEmpty()) {
            throw new AssertionError("Empty graph produced a non-empty tree");
        }
        if (tree.getWeight() != 0) {
            throw new AssertionError("Empty graph produced a non-zero weight");
        }
    }
}
""")
    sources = [str(path) for path in (root / 'src/java/prim').glob('*.java')]
    subprocess.run(['javac', '-d', str(target), *sources, str(harness)], check=True)
    subprocess.run(['java', '-cp', str(target), 'CheckPrimEmpty'], check=True, timeout=5)
