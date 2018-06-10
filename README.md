# Exercism Pharo Track

![build status](https://travis-ci.org/exercism/pharo.svg?branch=master)

Exercism exercises in Pharo.

## Setup

The simplest way to install Pharo is ...

## Contributing

Thank you so much for contributing! :tada:

Please read about how to [get involved in a track](https://github.com/exercism/docs/tree/master/contributing-to-language-tracks). Be sure to read the Exercism [Code of Conduct](https://github.com/exercism/exercism.io/blob/master/CODE_OF_CONDUCT.md).

We welcome pull requests of all kinds. No contribution is too small.

We encourage contributions that provide fixes and improvements to existing exercises. Please note that this track's exercises must conform to the Exercism-wide standards described in the [documentation](https://github.com/exercism/docs/tree/master/language-tracks/exercises). If you're unsure about how to make a change, then go ahead and open a GitHub issue, and we'll discuss it.

## Exercise Tests

At the most basic level, Exercism is all about the tests. You can read more about how we think about test suites in [the Exercism documentation](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/test-suites.md).

Test files should use the following format:

```
# include the body of an example test
```

## Opening an Issue

If you plan to make significant or breaking changes, please open an issue so we can discuss it first. If this is a discussion that is relevant to more than just the Pharo track, please open an issue in [exercism/discussions](https://github.com/exercism/discussions/issues).

## Submitting a Pull Request

Pull requests should be focused on a single exercise, issue, or conceptually cohesive change. Please refer to Exercism's [pull request guidelines](https://github.com/exercism/docs/blob/master/contributing/pull-request-guidelines.md).

Please follow the coding standards for Pharo. (If there is a formatter for the track's language, add instructions for using it here.)

### Verifying Your Change

Before submitting your pull request, you'll want to verify the changes in two ways:

* Run all the tests for the Pharo exercises
* Run an Exercism-specific linter to verify the track

All the tests for Pharo exercises can be run from the top level of the repo with

```
# add this command
```

For the Exercism-specific linting, please see [the documentation](https://github.com/exercism/docs/blob/master/language-tracks/configuration/linting.md).

## Contributing a New Exercise

Please see the documentation about [adding new exercises](https://github.com/exercism/docs/blob/master/you-can-help/make-up-new-exercises.md).

Note that:

- Each exercise must stand on its own. Do not reference files outside the exercise directory. They will not be included when the user fetches the exercise.
- Exercises should use only the Pharo core libraries.
- Exercises must conform to the Exercism-wide standards described in [the documentation](https://github.com/exercism/docs/tree/master/language-tracks/exercises).
- Each exercise should have a test suite, an example solution, a template file for the real implementation and ... (anything else that needs to go with each exercise for this track). The CI build expects files to be named using the following convention: (describe the Pharo convention for naming the various files that make up an exercise).
- Please do not commit any configuration files or directories inside the exercise other than ...
- Be sure to add it to the appropriate place in the `config.json` file.
