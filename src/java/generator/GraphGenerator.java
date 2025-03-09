/*
SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
SPDX-License-Identifier: MIT
*/

import java.util.concurrent.ThreadLocalRandom;

public class GraphGenerator {
    public static final int OUTPUT_TYPE_EDGES = 0;
    public static final int OUTPUT_TYPE_ADJACENCY_LISTS = 1;

    public static String generateEdges(int vNum){
        StringBuilder res = new StringBuilder();
        if(vNum > 1)
            for(int i = 0; i < vNum-1; i++)
                for(int j = i+1; j < vNum; j++){
                    res.append(
                            String.format(
                                    "%d %d %d ",
                                    i, j, ThreadLocalRandom.current().nextInt(1, 100)
                            )
                    );
                }
        return res.toString();
    }

    public static String generateAdjacencyLists(int vNum){
        StringBuilder res = new StringBuilder();
        if(vNum > 1)
            for(int i = 0; i < vNum; i++){
                res.append(i);
                for(int j = 0; j < vNum; j++){
                    if(i!=j)
                        res.append(
                                String.format(
                                        ":%d:%d",
                                        j, ThreadLocalRandom.current().nextInt(1, 100)
                                )
                        );
                }
                res.append(" ");
            }
        return res.toString();
    }

    public static void main(String[] args) {
        if(args.length == 2)
            try{
                int outType = Integer.parseInt(args[0]);
                int vNum = Integer.parseInt(args[1]);
                switch (outType){
                    case OUTPUT_TYPE_ADJACENCY_LISTS:
                        System.out.print(generateAdjacencyLists(vNum));
                        break;
                    case OUTPUT_TYPE_EDGES:
                    default:
                        System.out.print(generateEdges(vNum));
                }

            }catch (Exception e){
                System.exit(1);
            }
    }
}
