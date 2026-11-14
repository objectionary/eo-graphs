# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Exercise the native algorithm through its public entry point."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    harness = target / 'CheckPrim.java'
    harness.write_text("""import prim.PrimMST;
import prim.WeightGraph;
public final class CheckPrim {
    public static void main(String[] args) {
        WeightGraph disconnected = new WeightGraph(4);
        disconnected.addEdge(0, 1, 1);
        disconnected.addEdge(2, 3, 1);
        reject(disconnected);
        reject(new WeightGraph(2));
        WeightGraph isolated = new WeightGraph(3);
        isolated.addEdge(0, 1, 2);
        reject(isolated);
        WeightGraph connected = new WeightGraph(3);
        connected.addEdge(0, 1, 2);
        connected.addEdge(1, 2, 3);
        PrimMST tree = new PrimMST(connected);
        if (tree.getMst().size() != 2 || tree.getWeight() != 5) {
            throw new AssertionError("Connected graph changed");
        }
        if (!new PrimMST(new WeightGraph(1)).getMst().isEmpty()) {
            throw new AssertionError("Singleton graph changed");
        }
    }
    private static void reject(WeightGraph graph) {
        try {
            new PrimMST(graph);
            throw new AssertionError("Disconnected graph was accepted");
        } catch (IllegalArgumentException expected) {
            if (!expected.getMessage().contains("connected graph")) {
                throw new AssertionError(expected);
            }
        }
    }
}
""")
    sources = [str(path) for path in (root / 'src/java/prim').glob('*.java')]
    subprocess.run(['javac', '-d', str(target), *sources, str(harness)], check=True)
    subprocess.run(['java', '-cp', str(target), 'CheckPrim'], check=True, timeout=5)
