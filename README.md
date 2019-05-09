# Exercism Pharo Track

![build status](https://travis-ci.org/exercism/pharo-smalltalk.svg?branch=master)

This repository is for the development of [Exercism](http://exercism.io) exercises running in the [Pharo Smalltalk](http://pharo.org) programming environment.


If you are new to Pharo or Exercism, consider using [Exercism to learn Pharo](https://exercism.io/tracks/pharo-smalltalk), so you can help contribute in the future. 

If you already know Pharo, but would just like to help out with testing, please sign up for the track as above, review the [setup documentation](https://exercism.io/tracks/pharo-smalltalk/installation), and also visit the Discord channel (as described in [resources](./docs/RESOURCES.md)). 


## Development Setup

It is expected that you are already [familiar](./docs/RESOURCES.md) with development in Pharo and its use of [Iceberg Git](https://github.com/pharo-vcs/iceberg). 

To begin, you need to ensure that you have a complete exercism development environment and have installed:
1. the [exercism command line interface](https://exercism.io/cli-walkthrough) and configured it to point to somewhere sensible for development (e.g. `exercism configure -w ~/development/exercism`)
1. the Exercism [configlet](https://github.com/exercism/configlet#usage) linter/generator
1. a clone of this repository (`git clone https://github.com/exercism/pharo-smalltalk`), as a staging repository to which you will generate exercises and assets to check-in (separately from coding in pharo). I suggest calling it something like `~/development/exercism/pharo-staging` to avoid any confusion (note: it can reside anywhere)
1. (Optionally) a clone of exercism/[problem specifications](https://github.com/exercism/problem-specifications), also in a subdirectory of the exercism workspace configured above (this repo is used to generate exercise readme.md files, and is a reference to the suggested tests)

Next setup a Pharo environment for creating the actual coding examples. You need to load a development exercism baseline:

1. Use [PharoLauncher](https://github.com/pharo-project/pharo-launcher) to create a fresh 7.0 (stable) development image, and launch it (you can also use [zerconf](https://get.pharo.org/) if you are familiar with it)
1. Fork `https://exercism/pharo-smalltalk` on github  
1. Clone `https://<your id>/pharo-smalltalk` as a GitHub project and specify `<your id>` as the owner name, `pharo-smalltalk` as the project name
1. Install the Metacello baseline `dev` (not the default) in Iceberg using the Metacello context menu. (e.g. right click on the "pharo-smalltalk" project you just cloned, and select the second option in the Metacello menu, and type `dev`)

If you have any TIMEOUT problems refer to the [user installation instructions](./docs/INSTALLATION.md), 

## Contributing

We are keen to improve this track and show developers a different way of thinking about coding! :tada:

Please read how to [get involved in an Exercism track](https://github.com/exercism/docs/tree/master/contributing-to-language-tracks) and also be sure to read the [Exercism Code of Conduct](https://exercism.io/code-of-conduct).

We welcome pull requests of all kinds. No contribution is too small, particularly those that provide fixes and improvements to existing exercises. Note that this track's exercises must conform to the [Exercism-wide standards](https://github.com/exercism/docs/tree/master/language-tracks/exercises), but if you're unsure about how to make a change, then open a GitHub issue, and we'll discuss it.

### Completing an Exercise

While there many ways to help, by far the easiest and most useful contribution is to complete a solution for any of the currently "open" exercise. 

  * Ensure your image is caught up to the exercism/pharo-smalltalk master (and push any changes back to your fork)
  
  * The exercises are all TestCases that been automatically generated from the aforementioned problem-specifications repository. You will find them as subclasses of ExercismTest in the ExercismWIP package.
  
  * Once you have selected an Exercise you want to work on, create an Issue in Github specifying "Convert Exercise <name>". This will let others know you are working on one, and will also form a basis for your later pull request

  * Each WIP exercise already has the problem description in its class comment, and you run its tests and TDD a solution (in the debugger if you run the first test by itself).

  * You may need to adjust the test if it's not idiomatic Smalltalk (our generator is pretty basic - however this said, some corrections might be appropriate as PR's back to the upstream [problem-specification](https://github.com/exercism/problem-specifications) text)
  
  * Update the exercise meta data on the class side of the exercise by overriding the #exercise method and filling in a difficulty, topics etc. You should also fill in some Hint text in the Test comment tab (at the bottom - by replacing the text TBD) 
  
  * Update the package of the chosen example to `Exercise@<ExerciseName>` (i.e. move it out of the WIP package)
  * Create a new branch in Iceberg with the name of the exercise you chose (you can use the Iceberg tool for this, and enter your issue number from above)
  * Before submitting your pull request, Run all the tests for the Pharo exercises and ensure they all pass
  * Now get your solution reviewed by pushing your branch to your fork and then creating a PR on exercism/pharo-Smalltalk. It is important to [enable maintainer edits](https://help.github.com/en/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork), so we can collaborate with you in your branch
  * follow your PR and answer any ensuing questions
  * finally submit any adjustments and a maintainer will run the generator to create the Exercism assets (via configlet) and commit the final solution so it appears on the site

### Conventions

- We use [SUnit](https://en.wikipedia.org/wiki/SUnit) (the original xUnit libary) and no additional 3rd-party-frameworks for exercises.
- For consistency, we use the test parameter order: `self assert: actual equals: expected` 


### Testing

At the most basic level, Exercism is all about the tests and testing with [test suites](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/test-suites.md).

Pharo exercism exercises are organised into sub-packages, which each contain a TestCase that must be compatible with [SUunit](https://en.wikipedia.org/wiki/SUnit).

To test an exercise run it from the built-in test runner by clicking on the test orb. The orb will turn green if the tests are successful, or orange or red if their are any failures or errors respectively. Alternatively you can run tests manually in the playground by evaluating:

```smalltalk
<ExerciseName>Test suite run. "single exercise"

AllExercismTests suite run. "all exercises"
```

To test in a non-development image, you should follow the [user installation steps](./docs/INSTALLATION.md). If you 
are using that image to test subsequent development baselines - you may need to delete the following development directories to ensure you get the latest code: 
`./pharo/pharo-local/iceberg, ./pharo/pharo-local/package-cache`

### Coding Style

The code in this repository should follow [Pharo with style](https://github.com/SquareBracketAssociates/Booklet-PharoWithStyle) conventions wherever possible. You can also refer to the more generic [Smalltalk with style](http://sdmeta.gforge.inria.fr/FreeBooks/WithStyle/SmalltalkWithStyle.pdf) as well.

You should also make use of the built-in code formatter (meta-t FO in the editor) when creating exercises, as well as the code critques.

### Breaking Changes

If you plan to make significant or breaking changes, please open an issue so we can discuss it before merging. If this discussion is relevant to more than just the Pharo track, please also open an issue in [exercism/discussions](https://github.com/exercism/discussions/issues).

### Publishing A Completed Exercise (Maintainers)

When an exercise has been reviewed and is ready to put on the site you need to follow some extra steps.

1. Clone a copy of the repository into a staging location (a directory without any special characters due to [issue 154](https://github.com/exercism/configlet/issues/154))
1. Right click on the exercism Package and choose "Generate exercise meta data", this will generate exercise meta data in your seperate staging location
1. Commit the generated changes into the exercise branch so they will appear with the new exercise


### Contributing a New Exercise

If you have an interesting idea, refer to the documentation about [adding new exercises](https://github.com/exercism/docs/blob/master/you-can-help/make-up-new-exercises.md).

There is an example of a user defined exercise in the project, see: `DieTest`. By overriding the method `customData`, the generator will create the relevant files for you.

Note that:

- Each exercise must stand on its own. Do not reference files outside the exercise directory. They will not be included when the user fetches the exercise.
- Exercises must conform to the [Exercism-wide standards](https://github.com/exercism/docs/tree/master/language-tracks/exercises).
- Exercises should only use the Pharo core libraries.
- Each exercise should be:
  - stored in a top level project named `Exercism@<ExerciseName>`
  - have a TestCase named `<ExerciseName>Test` (in CamelCase) and an example solution named `<ExerciseName>`
  - the TestCase should have a class comment in markdown format that describes the exercise. This text is also used to generate a README.md file.
- Do not commit any configuration files or directories inside the exercise (this may be reviewed for future exercises, let us know if it becomes a problem)
- Be sure to generate a new UUID for the exercise using `UUIDGenerator next`, and place that value in the `uuid` method for the test

### Submitting a Pull Request

Pull requests should be focused on a single exercise, issue, or conceptually cohesive change. Refer to Exercism's [pull request guidelines](https://github.com/exercism/docs/blob/master/contributing/pull-request-guidelines.md) for more detail.


## Acknowledgements

Thanks to the Pharo team for all their dedication in building a modern open source Smalltalk.

![Pharo](http://pharo.org/web/files/pharo.png)
