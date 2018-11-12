java -jar "antlr-4.7.1-complete.jar" -o java tb7f.g4
javac java/tb7f*.java
cd java
java org.antlr.v4.gui.TestRig tb7f expression -gui