# Exercism Pharo Track

![build status](https://travis-ci.org/exercism/pharo.svg?branch=master)

Exercism exercises for Pharo.

## Development Setup

This repository is for the development of [Exercism](http://exercism.io) exercises for the [Pharo](http://pharo.org) programming language. It is expected that you are [familiar](./docs/RESOURCES.md) with development in Pharo and its use of git. If however, you are new to Pharo or Exercism, consider using [Exercism to learn Pharo](./docs/INSTALLATION.md), so you can help contribute in the future.

 
To setup for contributing to the Pharo Exercism exercises, you need to load a development baseline either by:

1. Using an existing Pharo image (or PharoLauncher) and cloning `github://exercism/pharo:master` with a specified src directory of `dev/src`. You should then load the Metacello baseline `dev` from Iceberg project window.
***OR***
1. From a terminal command line, entering:

  ```bash
  curl https://get.pharo.org | bash
  ```

  and then launch Pharo with the development baseline by typing:

  ```smalltalk
./pharo-ui Pharo.image eval "
Metacello new 
 baseline: 'Exercism'; 
 repository: 'github://exercism/pharo:master/dev/src';
 load: 'dev'.
"
```

If you have any TIMEOUT problems refer to the [user installation instructions](./docs/INSTALLATION.md).

You also need to install the [latest Iceberg for Pharo 6.1](https://github.com/pharo-vcs/iceberg#update-iceberg).

## Contributing

We are keen to improve this track and show developers a different way of thinking about coding! :tada:

Please read about how to [get involved in an Exercism track](https://github.com/exercism/docs/tree/master/contributing-to-language-tracks) and also be sure to read the [Exercism Code of Conduct](https://exercism.io/code-of-conduct).

We welcome pull requests of all kinds. No contribution is too small, particularly those that provide fixes and improvements to existing exercises. Note that this track's exercises must conform to the [Exercism-wide standards](https://github.com/exercism/docs/tree/master/language-tracks/exercises), but if you're unsure about how to make a change, then open a GitHub issue, and we'll discuss it.


A list of missing exercise can be found at: http://exercism.io/languages/pharo/todo


### Conventions

- We use [SUunit](https://en.wikipedia.org/wiki/SUnit) (the original xUnit libary) and no additional 3rd-party-frameworks.
- For consistency, we use the test parameter order: `self assert: actual equals: expected` 


### Testing

At the most basic level, Exercism is all about the tests and testing with [test suites](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/test-suites.md).

Pharo exercises are organised into sub-packages, which each contain a TestCase that must be compatible with [SUunit](https://en.wikipedia.org/wiki/SUnit).

To test an exercise run it from the built-in test runner by clicking on the test orb. The orb will turn green if the tests are successful, or orange or red if their are any failures or errors respectively. Alternatively you can run test manually in the playground by evaluating:

```
MyExercismPackage suite run.
```

To test in a non-development image, you should follow the [user installation steps](./docs/INSTALLATION.md). If you 
are using that image to test subsequent development baselines - you may need to delete the following development directories to
ensure you get the latest code: 
`./pharo/pharo-local/iceberg, ./pharo/pharo-local/package-cache`

You will also need to delete any exercise directories that you have downloaded (e.g. `./hello-world, ./two-fer`).

### Coding Style

The code in this repository should follow [Smalltalk with style](http://sdmeta.gforge.inria.fr/FreeBooks/WithStyle/SmalltalkWithStyle.pdf) conventions wherever possible.

You should also make use of the built-in code formatter (meta-f in the editor) when creating exercises.

### Breaking Changes

If you plan to make significant or breaking changes, please open an issue so we can discuss it before merging. If this discussion is relevant to more than just the Pharo track, please also open an issue in [exercism/discussions](https://github.com/exercism/discussions/issues).

### Verifying Your Changes

Before submitting your pull request, you should your changes in two ways:

* Run all the tests for the Pharo exercises and ensure they all pass
* Run the Exercism-specific linter to verify the track

All the tests for Pharo exercises can be run from the top level of the repo with:

```smalltalk
AllExercismTests suite run.
```

For the Exercism specific linting, please see the [linter documentation](https://github.com/exercism/docs/blob/master/language-tracks/configuration/linting.md).

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
