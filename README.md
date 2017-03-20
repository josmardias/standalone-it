# standalone-it
Create a standalone tarball of a given program containing it's dynamic libraries

> WARNING: This project will copy program binaries and dybamic libraries to a tarball. Only use it if you know what you are doing. Watch out for copyrighted/patented stuff. Use it with wisdom. Respect the laws.

Keep in mind that `standalone-it` will not copy configuration files, assets, and any other external resources. It will only copy the binary itself and it's dynamic library dependencies.

Tested on Fedora 24


## How it works:

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

## How to use the standalone tarball:

1. Extract the tarball contents. A `standalone` folder will be created.
```
tar -xvf standalone.tar.gz
```

(You can run those scripts below from any path)

3. Run the `configure.sh` to create lib folder with missing dynamic libraries
```
./standalone/run.sh <arguments to program>
```

4. Run the `run.sh` to start the program
```
./standalone/run.sh <arguments to program>
```
