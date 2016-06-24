# standalone-it
Create a standalone tarball of a given program containing it's dynamic libraries

> WARNING: This project will copy program binaries and dybamic libraries to a tarball. Only use it if you know what are you doing. Watch out for copyrighted/patented stuff. Use it with wisdom. Respect the laws.

How to use:

1. Clone this repo
```
git@github.com:josmardias/standalone-it.git
cd standalone-it
```
2. Run create.sh passing a binary as argument
```
./create.sh /path/to/some/binary
```
3. A `standalone.tar.gz` file will be created

4. It contains the program binary and all it's dynamic libraries dependencies.

How to use the standalone tarball:

1. Extract the tarball contents
```
tar -xvf standalone.tar.gz
```

2. A `standalone` folder was created. Run the run.sh script inside it (can be from any path)
```
./standalone/run.sh <arguments to program>
```
