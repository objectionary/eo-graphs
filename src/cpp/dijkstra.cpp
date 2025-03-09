/*
SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
SPDX-License-Identifier: MIT
*/

#include <iostream>
#include <climits>
#include <cstring>
#include <stdlib.h>
using namespace std;

void dijkstra(int vNum, int* GR, int st)
{
    int distance[vNum], count, index, i, u, m=st, path[vNum];
    bool visited[vNum];
    for (i=0; i<vNum; i++){
        distance[i]=INT_MAX; visited[i]=false;
        path[i]=-1;
    }
    path[st]=st;
    distance[st]=0;
    for (count=0; count<vNum-1; count++){
        int min=INT_MAX;
        for (i=0; i<vNum; i++)
            if (!visited[i] && distance[i]<=min){
                min=distance[i]; index=i;
            }
        u=index;
        visited[u]=true;
        for (i=0; i<vNum; i++)
            if (!visited[i] && GR[u*vNum+i] && distance[u]!=INT_MAX &&
            distance[u]+GR[u*vNum+i]<distance[i]){
                distance[i]=distance[u]+GR[u*vNum+i];
                path[i]=u;
            }

    }
    cout << "Paths: ";
    for (i=0; i<vNum; i++)
      cout << path[i] << " ";
}

int main(int argc, char *argv[])
{
    if(argc> 1){
        int i;
        int vNum = argc-1;
        int* GR = new int [vNum*vNum];
        memset(GR, 0, sizeof(GR));

        for(i=1;i<argc;i++){
           char *token = strtok(argv[i], ":");
           if(token != NULL){
             int u,v,w;
             u = atoi(token);
             bool isW = false;
             token = strtok(NULL, ":");
             while (token != NULL){
               if(isW){
                 w = atoi(token);
                 GR[u*vNum+v]=w;
               }else{
                 v = atoi(token);
               }
               isW = !isW;
               token = strtok(NULL, ":");
             }
           }
        }
        dijkstra(vNum,GR,0);
    }

    return 0;
}
