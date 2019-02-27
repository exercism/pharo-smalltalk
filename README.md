# Exercism Pharo Track

![build status](https://travis-ci.org/exercism/pharo-smalltalk.svg?branch=master)

The Pharo exercism track is in alpha development. 

If you'd like to help out with testing please [sign up here](https://exercism.io/my/tracks/pharo).
Until release we cannot sign up mentors, so for testing choose independent mode.  To restart testing, you can "leave" the track then rejoin. [Docs available here](https://exercism.io/my/tracks/pharo).  

If you'd like to help out with development, see below.

## Development Setup

This repository is for the development of [Exercism](http://exercism.io) exercises for the [Pharo Smalltalk](http://pharo.org) programming language. It is expected that you are [familiar](./docs/RESOURCES.md) with development in Pharo and its use of git. If however, you are new to Pharo or Exercism, consider using [Exercism to learn Pharo](./docs/INSTALLATION.md), so you can help contribute in the future.


NOTE: Pharo support for Exercism is currently in beta and so its not publicly visible, however you can still preview it through [this link](https://exercism.io/tracks/pharo).


You first need to ensure that you have a complete exercism development environment and have installed:
1. the [exercism command line interface](https://exercism.io/cli-walkthrough) and configured it to point to somewhere sensible for development (e.g. `exercism configure -w ~/development/exercism`)
1. the exercism/[problem specifications](https://github.com/exercism/problem-specifications) repo in a subdirectory of the exercism workspace configured above (this repo is used to generate exercise readme.md files, and as a reference to the suggested tests)
1. the [configlet](https://github.com/exercism/configlet#usage) linter/generator
1. the exercism/[pharo](https://github.com/exercism/pharo) repo, as a staging repository to which you will generate exercises and assets to check-in (separately from coding in pharo). I suggest calling it something like `~/development/exercism/pharo-staging` to avoid any confusion (note: it can reside anywhere)


Next setup a Pharo environment for creating the actual coding examples. You need to load a development exercism baseline:

1. Use [PharoLauncher](https://github.com/pharo-project/pharo-launcher) to create a fresh 7.0 (stable) development image, and then launch it (you can also use [zerconf](https://get.pharo.org/) if you are familiar with it)
1. Clone `https://exercism/pharo-smalltalk` as a GitHub problject and specify `exercism` as the owner name, `pharo-smalltalk` as the project name. This will automatically specify a src directory of `dev/src`).
1. Install the Metacello baseline `dev` (not the default) from the Iceberg by using the Metacello context menu. (e.g. right click on the "pharo-smalltalk" project you just cloned, and select the second option in the Metacello menu, and type ```dev```)


If you have any TIMEOUT problems refer to the [user installation instructions](./docs/INSTALLATION.md), as you may  need to use https as a download protocol.


## Contributing

We are keen to improve this track and show developers a different way of thinking about coding! :tada:

Please read about how to [get involved in an Exercism track](https://github.com/exercism/docs/tree/master/contributing-to-language-tracks) and also be sure to read the [Exercism Code of Conduct](https://exercism.io/code-of-conduct).

We welcome pull requests of all kinds. No contribution is too small, particularly those that provide fixes and improvements to existing exercises. Note that this track's exercises must conform to the [Exercism-wide standards](https://github.com/exercism/docs/tree/master/language-tracks/exercises), but if you're unsure about how to make a change, then open a GitHub issue, and we'll discuss it.

We are currently making changes os it's easier to contribute, and the following instructions are WIP:

  * Check out the development baseline (as outlined above)
  * find an exercise you like in the ExercismWIP package
  * TDD a solution and adjust the tests accordingly (our generator is pretty basic - this said, corrections might be appropriate as PR's back to the upstream [problem-specification](https://github.com/exercism/problem-specifications) text)
  * update the exercise meta data on the class side of the exercise (e.g. difficulty, unlockedBy, followedBy, Hint text etc).
  * get your solution reviewed by starting a PR
  * update the package of the chosen example to Exercism (i.e. move it out of the WIP package)
  * submit the final PR, and a maintainer will run the generator to create the Exercism assests (via configlet) and commit the final solution

### Conventions

- We use [SUnit](https://en.wikipedia.org/wiki/SUnit) (the original xUnit libary) and no additional 3rd-party-frameworks.
- For consistency, we use the test parameter order: `self assert: actual equals: expected` 


### Testing

At the most basic level, Exercism is all about the tests and testing with [test suites](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/test-suites.md).

Pharo exercism exercises are organised into sub-packages, which each contain a TestCase that must be compatible with [SUunit](https://en.wikipedia.org/wiki/SUnit).

To test an exercise run it from the built-in test runner by clicking on the test orb. The orb will turn green if the tests are successful, or orange or red if their are any failures or errors respectively. Alternatively you can run tests manually in the playground by evaluating:

```
<ExerciseName>Test suite run.
```

To test in a non-development image, you should follow the [user installation steps](./docs/INSTALLATION.md). If you 
are using that image to test subsequent development baselines - you may need to delete the following development directories to ensure you get the latest code: 
`./pharo/pharo-local/iceberg, ./pharo/pharo-local/package-cache`

You will also need to delete any exercise directories that you have downloaded (e.g. `./hello-world, ./two-fer`).

### Coding Style

The code in this repository should follow [Smalltalk with style](http://sdmeta.gforge.inria.fr/FreeBooks/WithStyle/SmalltalkWithStyle.pdf) conventions wherever possible.

You should also make use of the built-in code formatter (meta-f in the editor) when creating exercises.

### Breaking Changes

If you plan to make significant or breaking changes, please open an issue so we can discuss it before merging. If this discussion is relevant to more than just the Pharo track, please also open an issue in [exercism/discussions](https://github.com/exercism/discussions/issues).

### Verifying Your Changes

Before submitting your pull request, you should check your changes as follows:

1. Run all the tests for the Pharo exercises and ensure they all pass
1. Generate the exercises and templates into your seperate pharo exercism repo (the staging repo)
1. Run the Exercism-specific linter to verify the track
1. Check in your changes in a branch and generate a pull request

All the tests for Pharo exercises can be run from the top level of the repo with:

```smalltalk
AllExercismTests suite run.
```

To generate the templates, locate the ExercismGenerator class in your Pharo image (or pick Exercism | Generate Exercises... from the package context menu), and click on the generate triangle (class method). It prompts you for a location, which should be the `exercises` directory of the staging repo you checked out seperately.

For the Exercism specific linting, please see the [linter documentation](https://github.com/exercism/docs/blob/master/language-tracks/configuration/linting.md). You should run the linter from the command line in the exercises directory of the staging repo

Finally check-in your exercise and readme using a git cli or a tool like IntelliJ or VSCode. 

### Contributing a New Exercise

If you have an interesting idea, refer to the documentation about [adding new exercises](https://github.com/exercism/docs/blob/master/you-can-help/make-up-new-exercises.md).

Note that:

- Each exercise must stand on its own. Do not reference files outside the exercise directory. They will not be included when the user fetches the exercise.
- Exercises must conform to the [Exercism-wide standards](https://github.com/exercism/docs/tree/master/language-tracks/exercises).
- Exercises should only use the Pharo core libraries.
- Each exercise should be:
  - stored in a sub-project of Exercism named `Exercism-<ExerciseName>`
  - have a TestCase named `<ExerciseName>Tests` (in CamelCase) and an example solution named `<ExerciseName>`
  - the TestCase should have a class comment in markdown format that describes the exercise. This text is also used to generate a README.md file.
- Do not commit any configuration files or directories inside the exercise (this may be reviewed for future exercises, let us know if it becomes a problem)
- Be sure to generate a new UUID for the exercise using the [Exercism configlet](https://github.com/exercism/configlet), and add it to a new exercise entry in the `config.json` file.

### Submitting a Pull Request

Pull requests should be focused on a single exercise, issue, or conceptually cohesive change. Refer to Exercism's [pull request guidelines](https://github.com/exercism/docs/blob/master/contributing/pull-request-guidelines.md) for more detail.


## Acknowledgements

Thanks to the Pharo team for all their dedication in building a modern open source Smalltalk.

![Pharo](http://pharo.org/web/files/pharo.png)
