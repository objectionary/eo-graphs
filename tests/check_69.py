# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

"""Run the regression through compiled native entry points."""

from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as temporary:
    target = Path(temporary)
    regression = target / 'WeightCheck.java'
    regression.write_text("""package prim;
public class WeightCheck {
    public static void main(String[] args) {
        for (int weight : new int[] {2000000000, -2000000000, 0, 5, -5}) {
            WeightGraph graph = new WeightGraph(3);
            graph.addEdge(0, 1, weight);
            graph.addEdge(1, 2, weight);
            long expected = 2L * weight;
            try {
                int actual = new PrimMST(graph).getWeight();
                if (actual != expected) {
                    throw new AssertionError(actual + " != " + expected);
                }
            } catch (ArithmeticException error) {
                if (expected >= Integer.MIN_VALUE && expected <= Integer.MAX_VALUE) {
                    throw error;
                }
            }
        }
        WeightGraph mixed = new WeightGraph(4);
        mixed.addEdge(0, 1, -2000000000);
        mixed.addEdge(1, 2, -2000000000);
        mixed.addEdge(2, 3, 2000000000);
        if (new PrimMST(mixed).getWeight() != -2000000000) {
            throw new AssertionError("A representable final weight must be returned");
        }
    }
}
""", encoding='utf-8')
    sources = [str(source) for source in (root / 'src/java/prim').glob('*.java')]
    subprocess.run(['javac', '-d', str(target), *sources, str(regression)], check=True)
    subprocess.run(['java', '-cp', str(target), 'prim.WeightCheck'], check=True, timeout=5)
