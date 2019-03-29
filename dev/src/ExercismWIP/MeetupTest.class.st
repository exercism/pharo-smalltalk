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
	^'3cfbf216-9d41-0d00-9002-41e408866539'
]

{ #category : #config }
MeetupTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #setup }
MeetupTest >> setUp [
	meetupCalculator := Meetup new
]

{ #category : #tests }
MeetupTest >> test01_MonteenthOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 5 dayofweek: 'Monday' .
	self assert: result equals: '2013-05-13'
]

{ #category : #tests }
MeetupTest >> test02_MonteenthOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 8 dayofweek: 'Monday' .
	self assert: result equals: '2013-08-19'
]

{ #category : #tests }
MeetupTest >> test03_MonteenthOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 9 dayofweek: 'Monday' .
	self assert: result equals: '2013-09-16'
]

{ #category : #tests }
MeetupTest >> test04_TuesteenthOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 3 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-03-19'
]

{ #category : #tests }
MeetupTest >> test05_TuesteenthOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 4 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-04-16'
]

{ #category : #tests }
MeetupTest >> test06_TuesteenthOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 8 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-08-13'
]

{ #category : #tests }
MeetupTest >> test07_WednesteenthOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 1 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-01-16'
]

{ #category : #tests }
MeetupTest >> test08_WednesteenthOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 2 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-02-13'
]

{ #category : #tests }
MeetupTest >> test09_WednesteenthOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 6 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-06-19'
]

{ #category : #tests }
MeetupTest >> test10_ThursteenthOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 5 dayofweek: 'Thursday' .
	self assert: result equals: '2013-05-16'
]

{ #category : #tests }
MeetupTest >> test11_ThursteenthOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 6 dayofweek: 'Thursday' .
	self assert: result equals: '2013-06-13'
]

{ #category : #tests }
MeetupTest >> test12_ThursteenthOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-19'
]

{ #category : #tests }
MeetupTest >> test13_FriteenthOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 4 dayofweek: 'Friday' .
	self assert: result equals: '2013-04-19'
]

{ #category : #tests }
MeetupTest >> test14_FriteenthOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 8 dayofweek: 'Friday' .
	self assert: result equals: '2013-08-16'
]

{ #category : #tests }
MeetupTest >> test15_FriteenthOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 9 dayofweek: 'Friday' .
	self assert: result equals: '2013-09-13'
]

{ #category : #tests }
MeetupTest >> test16_SaturteenthOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-16'
]

{ #category : #tests }
MeetupTest >> test17_SaturteenthOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 4 dayofweek: 'Saturday' .
	self assert: result equals: '2013-04-13'
]

{ #category : #tests }
MeetupTest >> test18_SaturteenthOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 10 dayofweek: 'Saturday' .
	self assert: result equals: '2013-10-19'
]

{ #category : #tests }
MeetupTest >> test19_SunteenthOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 5 dayofweek: 'Sunday' .
	self assert: result equals: '2013-05-19'
]

{ #category : #tests }
MeetupTest >> test20_SunteenthOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 6 dayofweek: 'Sunday' .
	self assert: result equals: '2013-06-16'
]

{ #category : #tests }
MeetupTest >> test21_SunteenthOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'teenth' year: 2013 month: 10 dayofweek: 'Sunday' .
	self assert: result equals: '2013-10-13'
]

{ #category : #tests }
MeetupTest >> test22_FirstMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-04'
]

{ #category : #tests }
MeetupTest >> test23_FirstMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-01'
]

{ #category : #tests }
MeetupTest >> test24_FirstTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-07'
]

{ #category : #tests }
MeetupTest >> test25_FirstTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-04'
]

{ #category : #tests }
MeetupTest >> test26_FirstWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-03'
]

{ #category : #tests }
MeetupTest >> test27_FirstWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-07'
]

{ #category : #tests }
MeetupTest >> test28_FirstThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-05'
]

{ #category : #tests }
MeetupTest >> test29_FirstThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-03'
]

{ #category : #tests }
MeetupTest >> test30_FirstFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-01'
]

{ #category : #tests }
MeetupTest >> test31_FirstFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-06'
]

{ #category : #tests }
MeetupTest >> test32_FirstSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-05'
]

{ #category : #tests }
MeetupTest >> test33_FirstSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-02'
]

{ #category : #tests }
MeetupTest >> test34_FirstSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-03'
]

{ #category : #tests }
MeetupTest >> test35_FirstSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-07'
]

{ #category : #tests }
MeetupTest >> test36_SecondMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-11'
]

{ #category : #tests }
MeetupTest >> test37_SecondMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-08'
]

{ #category : #tests }
MeetupTest >> test38_SecondTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-14'
]

{ #category : #tests }
MeetupTest >> test39_SecondTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-11'
]

{ #category : #tests }
MeetupTest >> test40_SecondWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-10'
]

{ #category : #tests }
MeetupTest >> test41_SecondWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-14'
]

{ #category : #tests }
MeetupTest >> test42_SecondThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-12'
]

{ #category : #tests }
MeetupTest >> test43_SecondThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-10'
]

{ #category : #tests }
MeetupTest >> test44_SecondFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-08'
]

{ #category : #tests }
MeetupTest >> test45_SecondFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-13'
]

{ #category : #tests }
MeetupTest >> test46_SecondSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-12'
]

{ #category : #tests }
MeetupTest >> test47_SecondSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-09'
]

{ #category : #tests }
MeetupTest >> test48_SecondSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-10'
]

{ #category : #tests }
MeetupTest >> test49_SecondSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'second' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-14'
]

{ #category : #tests }
MeetupTest >> test50_ThirdMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-18'
]

{ #category : #tests }
MeetupTest >> test51_ThirdMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-15'
]

{ #category : #tests }
MeetupTest >> test52_ThirdTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-21'
]

{ #category : #tests }
MeetupTest >> test53_ThirdTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-18'
]

{ #category : #tests }
MeetupTest >> test54_ThirdWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-17'
]

{ #category : #tests }
MeetupTest >> test55_ThirdWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-21'
]

{ #category : #tests }
MeetupTest >> test56_ThirdThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-19'
]

{ #category : #tests }
MeetupTest >> test57_ThirdThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-17'
]

{ #category : #tests }
MeetupTest >> test58_ThirdFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-15'
]

{ #category : #tests }
MeetupTest >> test59_ThirdFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-20'
]

{ #category : #tests }
MeetupTest >> test60_ThirdSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-19'
]

{ #category : #tests }
MeetupTest >> test61_ThirdSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-16'
]

{ #category : #tests }
MeetupTest >> test62_ThirdSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-17'
]

{ #category : #tests }
MeetupTest >> test63_ThirdSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'third' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-21'
]

{ #category : #tests }
MeetupTest >> test64_FourthMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-25'
]

{ #category : #tests }
MeetupTest >> test65_FourthMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-22'
]

{ #category : #tests }
MeetupTest >> test66_FourthTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-28'
]

{ #category : #tests }
MeetupTest >> test67_FourthTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-25'
]

{ #category : #tests }
MeetupTest >> test68_FourthWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-24'
]

{ #category : #tests }
MeetupTest >> test69_FourthWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-28'
]

{ #category : #tests }
MeetupTest >> test70_FourthThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-26'
]

{ #category : #tests }
MeetupTest >> test71_FourthThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-24'
]

{ #category : #tests }
MeetupTest >> test72_FourthFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-22'
]

{ #category : #tests }
MeetupTest >> test73_FourthFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-27'
]

{ #category : #tests }
MeetupTest >> test74_FourthSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-26'
]

{ #category : #tests }
MeetupTest >> test75_FourthSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-23'
]

{ #category : #tests }
MeetupTest >> test76_FourthSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-24'
]

{ #category : #tests }
MeetupTest >> test77_FourthSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'fourth' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-28'
]

{ #category : #tests }
MeetupTest >> test78_LastMondayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 3 dayofweek: 'Monday' .
	self assert: result equals: '2013-03-25'
]

{ #category : #tests }
MeetupTest >> test79_LastMondayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 4 dayofweek: 'Monday' .
	self assert: result equals: '2013-04-29'
]

{ #category : #tests }
MeetupTest >> test80_LastTuesdayOfMay2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 5 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-05-28'
]

{ #category : #tests }
MeetupTest >> test81_LastTuesdayOfJune2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 6 dayofweek: 'Tuesday' .
	self assert: result equals: '2013-06-25'
]

{ #category : #tests }
MeetupTest >> test82_LastWednesdayOfJuly2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 7 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-07-31'
]

{ #category : #tests }
MeetupTest >> test83_LastWednesdayOfAugust2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 8 dayofweek: 'Wednesday' .
	self assert: result equals: '2013-08-28'
]

{ #category : #tests }
MeetupTest >> test84_LastThursdayOfSeptember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 9 dayofweek: 'Thursday' .
	self assert: result equals: '2013-09-26'
]

{ #category : #tests }
MeetupTest >> test85_LastThursdayOfOctober2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 10 dayofweek: 'Thursday' .
	self assert: result equals: '2013-10-31'
]

{ #category : #tests }
MeetupTest >> test86_LastFridayOfNovember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 11 dayofweek: 'Friday' .
	self assert: result equals: '2013-11-29'
]

{ #category : #tests }
MeetupTest >> test87_LastFridayOfDecember2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2013-12-27'
]

{ #category : #tests }
MeetupTest >> test88_LastSaturdayOfJanuary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 1 dayofweek: 'Saturday' .
	self assert: result equals: '2013-01-26'
]

{ #category : #tests }
MeetupTest >> test89_LastSaturdayOfFebruary2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 2 dayofweek: 'Saturday' .
	self assert: result equals: '2013-02-23'
]

{ #category : #tests }
MeetupTest >> test90_LastSundayOfMarch2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 3 dayofweek: 'Sunday' .
	self assert: result equals: '2013-03-31'
]

{ #category : #tests }
MeetupTest >> test91_LastSundayOfApril2013 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2013 month: 4 dayofweek: 'Sunday' .
	self assert: result equals: '2013-04-28'
]

{ #category : #tests }
MeetupTest >> test92_LastWednesdayOfFebruary2012 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2012 month: 2 dayofweek: 'Wednesday' .
	self assert: result equals: '2012-02-29'
]

{ #category : #tests }
MeetupTest >> test93_LastWednesdayOfDecember2014 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2014 month: 12 dayofweek: 'Wednesday' .
	self assert: result equals: '2014-12-31'
]

{ #category : #tests }
MeetupTest >> test94_LastSundayOfFebruary2015 [
	| result |

	result := meetupCalculator meetupWeek: 'last' year: 2015 month: 2 dayofweek: 'Sunday' .
	self assert: result equals: '2015-02-22'
]

{ #category : #tests }
MeetupTest >> test95_FirstFridayOfDecember2012 [
	| result |

	result := meetupCalculator meetupWeek: 'first' year: 2012 month: 12 dayofweek: 'Friday' .
	self assert: result equals: '2012-12-07'
]
