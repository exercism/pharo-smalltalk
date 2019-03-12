## Installation

The simplest way to install [Pharo](http://pharo.org) is is to use [zero conf](http://pharo.org/download#//*[@id="main"]/div/h2[3]) from a terminal command line.

Windows users who do not have a UNIX style shell installed should skip to the **Windows Installation** instructions (below).

In your `/Exercism/pharo-smalltalk` directory, type:

```bash
curl https://get.pharo.org/64/ | bash
```

Then launch Pharo and load the exercism tools by typing:

```smalltalk
./pharo-ui Pharo.image eval "
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo-smalltalk:v0.2.1';
 load.
#ExercismManager asClass welcome.
"
```

If you have any TIMEOUT problems when loading the initial tools, you can should exit Pharo and clear the git cache by typing:

```rm -rf pharo-local/iceberg/```

And then repeat the ```./pharo-ui ...``` example above.

If you continue to have problems (some corporate firewalls block git access), clear the cache and add an additional command to the beginning of the eval script like this:

```smalltalk
./pharo-ui Pharo.image eval "
Iceberg remoteTypeSelector: #httpsUrl.
Metacello new 
...
```

If everything is working properly, you should see loading progress bars flicker accross the screen, and then a Browser window will appear.

**TIP:** When you come to exit Pharo, save your changes (choose the Pharo menu, and select "Save and Quit").
You can then start Pharo with Exercism already loaded, by typing:

```bash
./pharo-ui Pharo.image
```

### Windows Installation (skip for OSX/Linux)

We are still working out the best command line tool prerequisites for windows, however you can also install Pharo graphically using the [Windows Pharo Launcher](https://files.pharo.org/pharo-launcher/windows) (a handy tool for managing multiple Pharo images). This launcher is also [available](http://pharo.org/download) for OSX and Linux if you are GUI inclined.

1. Run the downloaded .msi file to install the Pharo Launcher.

2. Run Pharo launcher and on the left of the window is a list of various Pharo image templates that can be downloaded. For Exercism
exercises, Pharo 7.0 32-bit (stable) is recommended (64bit is currently in beta and has reported issues). It can be found under the Official Distributions heading in the Templates 
tree. Click to highlight an image template, then click the create image icon at the top middle (an orange cog shape), and give
it a name. 
3. Once the template is downloaded it will appear on the right in the Existing Images table. Click on it, and then click the launch button at the top right (a green _play_ arrow).

Once the Pharo image has started, open a Playground by choosing the _Tools_ menu, and selecting _Playground_, or use
`ctrl + o + w`. 

Finally, copy and paste the following snippet into the playground:

```smalltalk
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo-smalltalk:v0.2.1';
 load.
 
#ExercismManager asClass welcome.
```

Then evaluate the pasted code by highlighting all of it, right clicking then selecting _Do it_ from the menu (or use `ctrl + d`). 

Now you can you can proceed below.

## Getting Started

When you launch Pharo, you will see a Welcome project, in a [System Browser](https://medium.com/@richardeng/pharo-quick-start-5bab70944ce2#3099) (_tip:_ if you ever lose this window you can open a new one from the Tools|System Browser menu).

The top, left hand panel of the System browser shows packages in your environment, and you will notice the install script has already configured
a package called `Exercism`, which contains a sub-project tag called `Welcome`. The second panel shows classes, which also has a class called `Welcome`. Underneath the classes panel there are 4 radio buttons, "Flat" (shows the classes in the package), "Hier." (shows a class hierachy), "Inst. side" (shows instance methods), "Class side" (shows class methods/constructors).

If you click on the Comment tab, you can see the latest instructions for using Pharo Exercism. Read the comments and try running your first test.

For other file based languages you would normally jump to a terminal at this point, and use the exercism cli to fetch the
next exercise. While Pharo can work with files in a similar manner, the environment is actually tuned to work with live objects. Classes, methods and source code are interestingly all objects like everything else in Pharo. You will learn more about this over the course of this track.

## Loading Exercises

For Exercism, we have included a plugin that will let you retrieve and submit Pharo exercises from within the IDE.
All you need to do is right click on a package (in this case, the Welcome package in the top left panel), and select the Exercism|Fetch Exercise
menu item. This will prompt you for an exercise name (e.g. hello-world), and will then retrieve it automatically for you.

Exercise names can be found on each exercise description on your [Pharo track](https://exercism.io/my/tracks/pharo) page (far right).
There is a *Download* instruction with a cli string that contains each exercise key. You can use the copy button next to the cli instructions and paste the entire string into the fetch prompt (and we will extract the key automatically).

When you have entered a valid exercise, the plugin will retrieve the relevant code and display it in the System Browser, ready for
you to begin coding.

<br/>
  
**Did you know:** *When you launch Pharo, you are actually restoring an execution image snapshot - similar to a VMWare Operating System image. This
is a powerful concept that allows you to suspend work mid operation, possibly even when debugging
something. When you next relaunch Pharo, you can then continue stepping through code in the restored debugger, or possibly continue a refactoring step.*
