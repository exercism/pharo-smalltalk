# Exercism API

## Description

Most Exercism language tracks use the `exercism` command line tool for fetching and submitting exercises which interacts with `exercism.io` via a REST API. The Pharo Smalltalk language track instead uses the same REST API to bring exercises in and out of the Pharo image without the use of any intermediary tooling. This document details the Exercism API with a focus on how it is used by the Pharo Smalltalk language track. It is intended for maintainers of the Pharo Smalltalk tooling.

## Headers

All Endpoints require headers on the request to be set to the following values:

```
Authorization: Bearer <token>
Content-Type: application/json
```

The value `<token>` is the users CLI authentication token available at `https://exercism.io/my/settings`.

## Fetching Exercises

`GET api.exercism.io/v1/solutions/latest?exercise_id=<name>&track_id<language> HTTP/1.1`

In the URL above `<name>` is the name of the exercise e.g. `hello-world` and `<language>` is the language track e.g. `pharo-smalltalk`.

### Response

#### 200

A sucessful request will respond with the exercise.

`TODO` show response contents

#### 400

The language track name is ambiguous.

#### 403

The solution not unlocked for the user or the language track is not joined.

#### 404

The language track or exercise could not be found.

## References

- [exercism/pharo-smalltalk issue-32](https://github.com/exercism/pharo-smalltalk/issues/32)
- [exercism/exercism issue-4087](https://github.com/exercism/exercism/issues/4087)
- Refer to download and submit tests

