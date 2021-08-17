package ru.hse.eo_graphs;

import java.util.concurrent.ThreadLocalRandom;

public class GraphGenerator {
    public static final int OUTPUT_TYPE_EDGES = 0;

    public static String generateEdges(int vNum){
        StringBuilder res = new StringBuilder();
        if(vNum > 1)
            for(int i = 0; i < vNum-1; i++)
                for(int j = i+1; j < vNum; j++){
                    System.out.print(
                            String.format(
                                    "%d %d %d ",
                                    i, j, ThreadLocalRandom.current().nextInt(1, 100)
                            )
                    );
                }
        return res.toString();
    }

    public static void main(String[] args) {
        if(args.length == 2)
            try{
                int outType = Integer.parseInt(args[0]);
                int vNum = Integer.parseInt(args[1]);
                switch (outType){
                    case OUTPUT_TYPE_EDGES:
                    default:
                        generateEdges(vNum);
                }

            }catch (Exception e){
                System.exit(1);
            }
    }
}
