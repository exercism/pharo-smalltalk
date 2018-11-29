# Sum Of Multiples

Given a number, find the sum of all the unique multiples of particular numbers up to
but not including that number.

If we list all the natural numbers below 20 that are multiples of 3 or 5,
we get 3, 5, 6, 9, 10, 12, 15, and 18.

The sum of these multiples is 78.

## Hint
The trick to this exercise is to understand how to iterate accross an Interval as well as check a Collection for any multiples that are divisible by a number. Try using the Spotter to look up potential classes and browse the categories of methods in those classes. 

Also remember that the Pharo environment is extensively cross referenced. You can right click on any class or method and browse "references" to a class (to see how it might be created), as well as "senders" of a method (to see how it might be used). 

## Collections are Used Pervasively in Smalltalk

The two most heavily used types of collections in Smalltalk are ordered collection and dictionaries.
Arrays are conceptually ordered collections that can’t change size.

```smalltalk
| a b |
a := OrderedCollection new
add: #red;
add: #green;
yourself.

b := Dictionary new
at: #red put: #rouge;
at: #green put: #vert;
yourself.
```

In each of the above assignments, the variable is bound to the result of the last message executed; i.e.
the result of `yourself` which is, hopefully, the newly created collection. Message `yourself` is
designed to return the receiver (almost like a no-op) but `add:` and `at:put:` do not (they return their
last parameter). So without `yourself`, we would bind `a` to `#green` and `b` to `#vert`.
I deliberately used cascading above in order to explain why `yourself` is used at all since it appears in
isolated methods in the built-in classes.

The big advantage to Smalltalk collections is that you can put any objects whatsoever in the collections.
Even the keys in dictionaries can be any type of object. Also, the objects in a specific collection don’t
have to be the same type; they can all be different types. We don’t need to invent new kinds of
collections just because we want to accumulate instances of a brand new class.

Ordered collections can be accessed like arrays; e.g. `a at: 1` indexed starting at 1. Dictionaries are
accessed the same way too; e.g. `b at: #red`. But there are many applications where we don’t need to
deal with the keys. For these, there are very simply looping facilities that iterate through the items; e.g.

```smalltalk
a do: [:item |
USE item FOR SOMETHING].

b do: [:item |
USE item FOR SOMETHING].
```

Loop variable `item` gets the elements of the collection one-by-one even if they are all different types.
If necessary, we can easily find out what something is at execution time; e.g. `item isKindOf: Boat`
returns true or false. There are also many special-case query messages like `item isCollection` or `item
isNumber`. There are also many looping constructs that create and return new collections such as

```smalltalk
c := clients select: [:client | client netWorth > 500000].

d := clients collect: [:client | client name].
```

In the first case, we get a subcollection of those clients that are pretty rich. In the second, we get a
collection of names (the original collection was a collection of clients).

## Downloading

To download this exercise in Pharo, type: `sum-of-multiples` into the `Exercism | Fetch Exercise` package menu prompt (right click on the Exercism package in the Pharo System Browser). You can also submit your solution from the same menu for any selected package. You don't normally need to use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `SumOfMultiplesTest`, will test the functionality of `SumOfMultiples`.

If you are still stuck, the track documentation has more detailed help on [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

A variation on Problem 1 at Project Euler [http://projecteuler.net/problem=1](http://projecteuler.net/problem=1)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
