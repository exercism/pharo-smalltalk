## Installation

The simplest way to install Pharo is is to use [zero conf](http://pharo.org/download#//*[@id="main"]/div/h2[3]) from a terminal command line.

In your ```/Exercism/pharo directory```, type:
```$xslt
curl https://get.pharo.org | bash
```

Then launch Pharo and load some initial tools by typing:
```$xslt
./pharo-ui Pharo.image eval "
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo:master/dev/src';
 load.
(RPackageOrganizer default packageNamed: 'Exercism') browse
"
```

If you have any TIMEOUT problems when loading the initial tools (some corporate firewalls block git access), you can add an additional command to 
the beginning of the eval script like this:
 ```
./pharo-ui Pharo.image eval "
Iceberg remoteTypeSelector: #httpsUrl.
Metacello new 
...
```

**NOTE:** When you exit Pharo, save your changes (left click on the Pharo Desktop, and select "Save and Quit") then you DO NOT need
to repeat the tool loading step above, and should simply type:
```$xslt
./pharo-ui Pharo.image
```

***Did you know:** When you launch Pharo, you are actually restoring an execution image snapshot - similar to a VMWare Operating System image. This
is a powerful concept, as it allows you to suspend work mid operation, possibly even when you are in the middle of debugging
something. When you relaunch Pharo, you could then continue stepping through code in the restored debugger, or even continue a refactoring step.*
