#!/usr/bin/env bash

#java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -jar $HOME/Downloads/burpsuite_pro_v2022.2.5.jar
java -Xmx8G --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -jar $HOME/Downloads/burpsuite_pro_v2023.12.1.4.jar
