# Exercism Pharo Track

[![Build & Unit tests](https://github.com/exercism/pharo-smalltalk/actions/workflows/ci.yml/badge.svg)](https://github.com/exercism/pharo-smalltalk/actions/workflows/ci.yml)
[![GitHub release](https://img.shields.io/github/release/exercism/pharo-smalltalk.svg)](https://github.com/exercism/pharo-smalltalk/releases/latest)
[![Pharo 12](https://img.shields.io/badge/Pharo-12-informational)](https://get.pharo.org/120+vm)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-informational)](https://get.pharo.org)



This repository is for the development of [Exercism](http://exercism.io) exercises running in the [Pharo Smalltalk](http://pharo.org) programming environment.


If you are new to Pharo or Exercism, consider using [Exercism to learn Pharo](https://exercism.io/tracks/pharo-smalltalk), so you can help contribute in the future.

If you already know Pharo, but would just like to help out with testing, please sign up for the track as above, review the [setup documentation](https://exercism.io/tracks/pharo-smalltalk/installation), and also visit the Discord channel (as described in [resources](./docs/RESOURCES.md)).

## Mentor Setup

If you are familiar with Pharo, but not quite sure about developing exercises, we are always happy to get extra help [mentoring](https://exercism.io/become-a-mentor) exercises.

If you sign up as a [Pharo Mentor](https://exercism.io/mentor/registrations/new) by choosing Pharo in the mentor list, you then need to [update your bio](https://github.com/exercism/website-copy/blob/master/mentors/README.md#mentors) and load up a special (dev-light) image.

Simply evalaluate the following in a fresh Pharo image (e.g. created from [Pharo Launcher](https://pharo.org/download) - choose latest stable release from Official distributions):

```smalltalk
Metacello new
 baseline: 'Exercism';
 repository: 'github://exercism/pharo-smalltalk:main/releases/latest';
 load: 'mentor'
```

You will then find a "View Mentee Solution..." entry in the Exercism menu, which allows you to safely download a mentee code submission into your image so you can browse code and references.

To use this browser, you need to paste the download link at the bottom of a submission into the menu prompt, and it will download and show the solution.

When looking at a solution, there is also a context menu to leave comments on methods and classes, as well as an option to view a summary report that can be pasted into the mentor panel.

## For maintainers
If you want to contribute by PR and produce an exercise or bugfix, follow __[Contributing guidelines](docs/CONTRIBUTING.md)__.
