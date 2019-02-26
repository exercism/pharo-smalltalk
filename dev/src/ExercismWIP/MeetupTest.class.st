"
# Meetup

Calculate the date of meetups.

Typically meetups happen on the same day of the week.  In this exercise, you
will take a description of a meetup date, and return the actual meetup date.

Examples of general descriptions are:

- The first Monday of January 2017
- The third Tuesday of January 2017
- The wednesteenth of January 2017
- The last Thursday of January 2017

The descriptors you are expected to parse are:
first, second, third, fourth, fifth, last, monteenth, tuesteenth, wednesteenth,
thursteenth, friteenth, saturteenth, sunteenth

Note that ""monteenth"", ""tuesteenth"", etc are all made up words. There was a
meetup whose members realized that there are exactly 7 numbered days in a month
that end in '-teenth'. Therefore, one is guaranteed that each day of the week
(Monday, Tuesday, ...) will have exactly one date that is named with '-teenth'
in every month.

Given examples of a meetup dates, each containing a month, day, year, and
descriptor calculate the date of the actual meetup.  For example, if given
""The first Monday of January 2017"", the correct meetup date is 2017/1/2.

## Hint

TBD

"
Class {
	#name : #MeetupTest,
	#superclass : #ExercismTest,
	#instVars : [
		'meetupCalculator'
	],
	#category : #'ExercismWIP-Meetup'
}

{ #category : #config }
MeetupTest class >> uuid [
	"Answer a unique id for this exercise"
	^'e08623da-2b3f-0d00-a2f8-616d09f0590c'
]

{ #category : #config }
MeetupTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
MeetupTest >> setUp [
	meetupCalculator := Meetup new
]

{ #category : #test }
MeetupTest >> testFirstFridayOfDecember2012 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2012 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2012-12-07'
]

{ #category : #test }
MeetupTest >> testFirstFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-06'
]

{ #category : #test }
MeetupTest >> testFirstFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-01'
]

{ #category : #test }
MeetupTest >> testFirstMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-01'
]

{ #category : #test }
MeetupTest >> testFirstMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-04'
]

{ #category : #test }
MeetupTest >> testFirstSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-02'
]

{ #category : #test }
MeetupTest >> testFirstSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-05'
]

{ #category : #test }
MeetupTest >> testFirstSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-07'
]

{ #category : #test }
MeetupTest >> testFirstSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-03'
]

{ #category : #test }
MeetupTest >> testFirstThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-03'
]

{ #category : #test }
MeetupTest >> testFirstThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-05'
]

{ #category : #test }
MeetupTest >> testFirstTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-04'
]

{ #category : #test }
MeetupTest >> testFirstTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-07'
]

{ #category : #test }
MeetupTest >> testFirstWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-07'
]

{ #category : #test }
MeetupTest >> testFirstWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-03'
]

{ #category : #test }
MeetupTest >> testFourthFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-27'
]

{ #category : #test }
MeetupTest >> testFourthFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-22'
]

{ #category : #test }
MeetupTest >> testFourthMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-22'
]

{ #category : #test }
MeetupTest >> testFourthMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-25'
]

{ #category : #test }
MeetupTest >> testFourthSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-23'
]

{ #category : #test }
MeetupTest >> testFourthSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-26'
]

{ #category : #test }
MeetupTest >> testFourthSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-28'
]

{ #category : #test }
MeetupTest >> testFourthSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-24'
]

{ #category : #test }
MeetupTest >> testFourthThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-24'
]

{ #category : #test }
MeetupTest >> testFourthThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-26'
]

{ #category : #test }
MeetupTest >> testFourthTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-25'
]

{ #category : #test }
MeetupTest >> testFourthTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-28'
]

{ #category : #test }
MeetupTest >> testFourthWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-28'
]

{ #category : #test }
MeetupTest >> testFourthWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-24'
]

{ #category : #test }
MeetupTest >> testFriteenthOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 4 dayofweek: 'Friday' .
	self assert: result equals: '2013-04-19'
]

{ #category : #test }
MeetupTest >> testFriteenthOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 8 dayofweek: 'Friday' .
	self assert: result equals: '2013-08-16'
]

{ #category : #test }
MeetupTest >> testFriteenthOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 9 dayofweek: 'Friday' .
	self assert: result equals: '2013-09-13'
]

{ #category : #test }
MeetupTest >> testLastFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-27'
]

{ #category : #test }
MeetupTest >> testLastFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-29'
]

{ #category : #test }
MeetupTest >> testLastMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-29'
]

{ #category : #test }
MeetupTest >> testLastMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-25'
]

{ #category : #test }
MeetupTest >> testLastSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-23'
]

{ #category : #test }
MeetupTest >> testLastSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-26'
]

{ #category : #test }
MeetupTest >> testLastSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-28'
]

{ #category : #test }
MeetupTest >> testLastSundayOfFebruary2015 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2015 month: 2 dayofweek: 'Sunday' .
	self assert: result equals: '2015-02-22'
]

{ #category : #test }
MeetupTest >> testLastSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-31'
]

{ #category : #test }
MeetupTest >> testLastThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-31'
]

{ #category : #test }
MeetupTest >> testLastThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-26'
]

{ #category : #test }
MeetupTest >> testLastTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-25'
]

{ #category : #test }
MeetupTest >> testLastTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-28'
]

{ #category : #test }
MeetupTest >> testLastWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-28'
]

{ #category : #test }
MeetupTest >> testLastWednesdayOfDecember2014 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2014 month: 12 dayofweek: 'Wednesday' .
	self assert: result equals: '2014-12-31'
]

{ #category : #test }
MeetupTest >> testLastWednesdayOfFebruary2012 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2012 month: 2 dayofweek: 'Wednesday' .
	self assert: result equals: '2012-02-29'
]

{ #category : #test }
MeetupTest >> testLastWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-31'
]

{ #category : #test }
MeetupTest >> testMonteenthOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 8 dayofweek: 'Monday' .
	self assert: result equals: '2013-08-19'
]

{ #category : #test }
MeetupTest >> testMonteenthOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 5 dayofweek: 'Monday' .
	self assert: result equals: '2013-05-13'
]

{ #category : #test }
MeetupTest >> testMonteenthOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 9 dayofweek: 'Monday' .
	self assert: result equals: '2013-09-16'
]

{ #category : #test }
MeetupTest >> testSaturteenthOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 4 dayofweek: 'Saturday' .
	self assert: result equals: '2013-04-13'
]

{ #category : #test }
MeetupTest >> testSaturteenthOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-16'
]

{ #category : #test }
MeetupTest >> testSaturteenthOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 10 dayofweek: 'Saturday' .
	self assert: result equals: '2013-10-19'
]

{ #category : #test }
MeetupTest >> testSecondFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-13'
]

{ #category : #test }
MeetupTest >> testSecondFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-08'
]

{ #category : #test }
MeetupTest >> testSecondMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-08'
]

{ #category : #test }
MeetupTest >> testSecondMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-11'
]

{ #category : #test }
MeetupTest >> testSecondSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-09'
]

{ #category : #test }
MeetupTest >> testSecondSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-12'
]

{ #category : #test }
MeetupTest >> testSecondSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-14'
]

{ #category : #test }
MeetupTest >> testSecondSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-10'
]

{ #category : #test }
MeetupTest >> testSecondThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-10'
]

{ #category : #test }
MeetupTest >> testSecondThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-12'
]

{ #category : #test }
MeetupTest >> testSecondTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-11'
]

{ #category : #test }
MeetupTest >> testSecondTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-14'
]

{ #category : #test }
MeetupTest >> testSecondWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-14'
]

{ #category : #test }
MeetupTest >> testSecondWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-10'
]

{ #category : #test }
MeetupTest >> testSunteenthOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 6 dayofweek: 'Sunday' .
	self assert: result equals: '2013-06-16'
]

{ #category : #test }
MeetupTest >> testSunteenthOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 5 dayofweek: 'Sunday' .
	self assert: result equals: '2013-05-19'
]

{ #category : #test }
MeetupTest >> testSunteenthOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 10 dayofweek: 'Sunday' .
	self assert: result equals: '2013-10-13'
]

{ #category : #test }
MeetupTest >> testThirdFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-20'
]

{ #category : #test }
MeetupTest >> testThirdFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-15'
]

{ #category : #test }
MeetupTest >> testThirdMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-15'
]

{ #category : #test }
MeetupTest >> testThirdMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-18'
]

{ #category : #test }
MeetupTest >> testThirdSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-16'
]

{ #category : #test }
MeetupTest >> testThirdSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-19'
]

{ #category : #test }
MeetupTest >> testThirdSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-21'
]

{ #category : #test }
MeetupTest >> testThirdSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-17'
]

{ #category : #test }
MeetupTest >> testThirdThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-17'
]

{ #category : #test }
MeetupTest >> testThirdThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-19'
]

{ #category : #test }
MeetupTest >> testThirdTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-18'
]

{ #category : #test }
MeetupTest >> testThirdTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-21'
]

{ #category : #test }
MeetupTest >> testThirdWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-21'
]

{ #category : #test }
MeetupTest >> testThirdWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-17'
]

{ #category : #test }
MeetupTest >> testThursteenthOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 6 dayofweek: 'Thursday' .
	self assert: result equals: '2013-06-13'
]

{ #category : #test }
MeetupTest >> testThursteenthOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 5 dayofweek: 'Thursday' .
	self assert: result equals: '2013-05-16'
]

{ #category : #test }
MeetupTest >> testThursteenthOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-19'
]

{ #category : #test }
MeetupTest >> testTuesteenthOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 4 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-04-16'
]

{ #category : #test }
MeetupTest >> testTuesteenthOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 8 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-08-13'
]

{ #category : #test }
MeetupTest >> testTuesteenthOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 3 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-03-19'
]

{ #category : #test }
MeetupTest >> testWednesteenthOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 2 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-02-13'
]

{ #category : #test }
MeetupTest >> testWednesteenthOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 1 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-01-16'
]

{ #category : #test }
MeetupTest >> testWednesteenthOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 6 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-06-19'
]
