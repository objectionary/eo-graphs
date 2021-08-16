#!/bin/bash
object_to_run=$1
shift
java -cp target/classes:target/eo-runtime.jar -Xss40m  org.eolang.core.Main ru.hse.eo_graphs.eo.${object_to_run:-app} "$@"