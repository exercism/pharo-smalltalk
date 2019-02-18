## Installation

The simplest way to install [Pharo](http://pharo.org) is is to use [zero conf](http://pharo.org/download#//*[@id="main"]/div/h2[3]) from a terminal command line.

Windows users who do not have a UNIX style shell installed should use the **Windows Installation** instructions below.

In your `/Exercism/pharo` directory, type:

```bash
curl https://get.pharo.org | bash
```

Then launch Pharo and load the exercism tools by typing:

```smalltalk
./pharo-ui Pharo.image eval "
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo-smalltalk:master/dev/src';
 load.
ExercismManager welcome.
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

### Windows Installation

The default download for installing Pharo is the Pharo Launcher. A handy tool for managing multiple Pharo images. It can be
found on the [Pharo.org](http://pharo.org/) website can be downloaded directly [here](https://files.pharo.org/pharo-launcher/windows). Run the downloaded installer to install the Pharo Launcher.

Run the Pharo launcher. On the left of the window will be various templates of Pharo images that can be downloaded. For Exercism
exercises Pharo 7.0 32-bit (development version) is recommended. It can be found under the Official Distributions heading in the Templates 
tree. Click to highlight an image template, then click the create image icon at the top middle (an orange cog shape), and give
it a name. Once the template is downloaded it will appear on the right in the Existing Images table. Click to highlight your
image in the table, then click the launch button at the top right (a green _play_ arrow).

Once the Pharo image has started open a Playground by left clicking anywhere and select _Playground_ from the World menu, or use
`ctrl + o + w`. Copy and paste the following code snippet into the playground:

```smalltalk
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo-smalltalk:master/dev/src';
 load.
 
(Smalltalk at: #ExercismManager) welcome
```

Evaluate the code by highlighting all of it, then right click and select _Do it_ from the menu, or use `ctrl + d`. After the
Exercism tools have downloaded, you can proceed below.

## Getting Started

When you launch Pharo, you will see a Welcome project, in a [System Browser](https://medium.com/@richardeng/pharo-quick-start-5bab70944ce2#3099).
The top, left most panel shows packages in your environment, and you will notice the install script has already configured
a package called `Exercism`, which contains a sub-project tag called `Welcome`. The second panel shows classes - and again
there is a class called `Welcome`. Underneath the classes panel there are 3 buttons, "Hier." (show a class hierachy), "Class" 
(toggle between class and instance methods), "Com." (toggle the class comments pane).

If you click on the comments button, you can see the latest instructions for using Pharo Exercism.

For other file based languages you would normally jump to a terminal at this point, and use the exercism cli to fetch the
next exercise. While Pharo can work with files in a similar manner, the environment is actually tuned to work with live objects, and classes,methods and source code are all considered objects like everything else. You will learn more about this over the course of this track.

For Exercism, we have included a plugin to Pharo that will let you retrieve and submit Pharo exercises from within the IDE.
All you need to do is right click on a package (in this case, the Welcome package in the top left panel), and select the Exercism|Fetch Exercise
menu item. This will prompt you for an exercise name (e.g. hello-world), and will then retrieve it automatically for you.

Exercise names can be found on each exercise description off your [Pharo track](https://exercism.io/my/tracks/pharo) page.
There is a *Downloading* heading with specific details and the exercise key to to type into the Fetch prompt. You don't need 
to use the suggested CLI command shown in the side bar.

When you have entered a valid exercise, the plugin will retrieve the code and dispaly it in the System Browser, ready for
you to begin coding.

<br/>
  
**Did you know:** *When you launch Pharo, you are actually restoring an execution image snapshot - similar to a VMWare Operating System image. This
is a powerful concept that allows you to suspend work mid operation, possibly even when debugging
something. When you next relaunch Pharo, you can then continue stepping through code in the restored debugger, or possibly continue a refactoring step.*
