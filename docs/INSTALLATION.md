## Installation

The simplest way to install [Pharo](http://pharo.org) is is to use [zero conf](http://pharo.org/download#//*[@id="main"]/div/h2[3]) from a terminal command line.

In your `/Exercism/pharo` directory, type:

```bash
curl https://get.pharo.org | bash
```

Then launch Pharo and load some initial tools by typing:

```smalltalk
./pharo-ui Pharo.image eval "
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo:master/dev/src';
 load.
(RPackageOrganizer default packageNamed: 'Exercism') browse
"
```

If you have any TIMEOUT problems when loading the initial tools (some corporate firewalls block git access), you can add an additional command to the beginning of the eval script like this:

 ```smalltalk
./pharo-ui Pharo.image eval "
Iceberg remoteTypeSelector: #httpsUrl.
Metacello new 
...
```

**NOTE:** When you exit Pharo, save your changes (left click on the Pharo Desktop, and choose "Save and Quit").
You can then always start Pharo by typing:

```bash
./pharo-ui Pharo.image
```

***Did you know:** When you launch Pharo, you are actually restoring an execution image snapshot - similar to a VMWare Operating System image. This
is a powerful concept that allows you to suspend work mid operation, possibly even when debugging
something. When you next relaunch Pharo, you can then continue stepping through code in the restored debugger, or possibly continue a refactoring step.*
