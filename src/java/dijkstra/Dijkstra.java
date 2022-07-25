
import java.util.Arrays;

public class Dijkstra {
  public static void dijkstra(int vNum, int[] GR, int st) {
    int[] distance = new int[vNum];
    int count, index = 0, i, u;
    int[] path = new int[vNum];
    boolean[] visited = new boolean[vNum];
    for (i = 0; i < vNum; i++) {
      distance[i] = Integer.MAX_VALUE;
      visited[i] = false;
      path[i] = -1;
    }
    path[st] = st;
    distance[st] = 0;
    for (count = 0; count < vNum - 1; count++) {
      int min = Integer.MAX_VALUE;
      for (i = 0; i < vNum; i++)
        if (!visited[i] && distance[i] <= min) {
          min = distance[i];
          index = i;
        }
      u = index;
      visited[u] = true;
      for (i = 0; i < vNum; i++)
        if (!visited[i] && (GR[u * vNum + i] != 0) &&
            (distance[u] != Integer.MAX_VALUE) &&
            (distance[u] + GR[u * vNum + i] < distance[i])) {
          distance[i] = distance[u] + GR[u * vNum + i];
          path[i] = u;
        }
    }
    System.out.print("Paths: ");
    for (i = 0; i < vNum; i++)
      System.out.print(path[i] + " ");
  }

  public static void main(String[] args) {
    if (args.length > 0) {
      int i;
      int vNum = args.length;
      int[] GR = new int[vNum * vNum];
      Arrays.fill(GR, 0);

      for (i = 0; i < args.length; i++) {
        String[] vArray = args[i].split(":");
        int u, v = 0, w;
        u = Integer.parseInt(vArray[0]);
        if (vArray.length > 1) {
          for (int j = 1; j < vArray.length; j++) {
            if (j % 2 == 0) {
              w = Integer.parseInt(vArray[j]);
              GR[u * vNum + v] = w;
            } else {
              v = Integer.parseInt(vArray[j]);
            }
          }
        }
      }
      dijkstra(vNum, GR, 0);
    }
  }
}
