## What this repository is for?

This repository proposes comparison between algorithmic graph realizations in C++,Java and EO.

## How to use

### Tools to be installed

#### Java
First, you need to install Java Development Kit (JDK) on your machine in order to build and work with eo_graphs. Version 11 of JDK would be a good option (you can find 
installation packages [here](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)). 

#### C++
Second, you need to install GCC on your machine in order to build and work with eo_graphs. Version 11.1 is optimal(you can find 
installation packages [here](https://gcc.gnu.org/gcc-11/)).

#### Maven
Third, you need to install Maven on your machine in order to build and work with eo_graphs. Version 3.8.2 is needed(you can find 
installation packages [here](https://maven.apache.org/download.cgi)).

### Downloading sources
Then, fork this repository with git:
```bash
git clone git@github.com:HSE-Eolang/eo_graphs.git
```

### Run scripts 
All scripts are running from the root folder of repository.

#### Сompilation of Java, EO and C ++ source codes

```bash
compile.sh
```

#### Comparing the results of executing programs in different languages, to make sure that the result is identical.

```bash
compare.sh
```

#### Testing of the execution time and memory consumption of programs on graphs of different sizes. Graphs are generated
randomly by an [utility](https://github.com/HSE-Eolang/eo_graphs/blob/master/src/main/java/ru/hse/eo_graphs/GraphGenerator.java) written in Java.

```bash
test.sh
```


