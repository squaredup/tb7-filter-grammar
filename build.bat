SET CLASSPATH=.;Cantlr4-complete.jar;%CLASSPATH%

java -jar "antlr-4.7.1-complete.jar" -o java -Dlanguage=Java tb7f.g4
javac java/tb7*.java
cd java
java org.antlr.v4.gui.TestRig tb7f expression -gui