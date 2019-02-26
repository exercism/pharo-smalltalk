"
# Clock

Implement a clock that handles times without dates.

You should be able to add and subtract minutes to it.

Two clocks that represent the same time should be equal to each other.

## Hint

TBD

"
Class {
	#name : #ClockTest,
	#superclass : #ExercismTest,
	#instVars : [
		'clockCalculator'
	],
	#category : #'ExercismWIP-Clock'
}

{ #category : #config }
ClockTest class >> uuid [
	"Answer a unique id for this exercise"
	^'e0dd37da-2b3f-0d00-a30b-ee2009f0590c'
]

{ #category : #config }
ClockTest class >> version [
	"Generated from specification: 26 February 2019"
	^'2.4.0'
]

{ #category : #setup }
ClockTest >> setUp [
	clockCalculator := Clock new
]

{ #category : #test }
ClockTest >> testAddMinutesAddAcrossMidnight [
	| result |

	result := clockCalculator addMinute: 59 hour: 23 value: 2 .
	self assert: result equals: '00:01'
]

{ #category : #test }
ClockTest >> testAddMinutesAddMinutes [
	| result |

	result := clockCalculator addMinute: 0 hour: 10 value: 3 .
	self assert: result equals: '10:03'
]

{ #category : #test }
ClockTest >> testAddMinutesAddMoreThanOneDay1500Min25Hrs [
	| result |

	result := clockCalculator addMinute: 32 hour: 5 value: 1500 .
	self assert: result equals: '06:32'
]

{ #category : #test }
ClockTest >> testAddMinutesAddMoreThanOneHour [
	| result |

	result := clockCalculator addMinute: 0 hour: 10 value: 61 .
	self assert: result equals: '11:01'
]

{ #category : #test }
ClockTest >> testAddMinutesAddMoreThanTwoDays [
	| result |

	result := clockCalculator addMinute: 1 hour: 1 value: 3500 .
	self assert: result equals: '11:21'
]

{ #category : #test }
ClockTest >> testAddMinutesAddMoreThanTwoHoursWithCarry [
	| result |

	result := clockCalculator addMinute: 45 hour: 0 value: 160 .
	self assert: result equals: '03:25'
]

{ #category : #test }
ClockTest >> testAddMinutesAddNoMinutes [
	| result |

	result := clockCalculator addMinute: 41 hour: 6 value: 0 .
	self assert: result equals: '06:41'
]

{ #category : #test }
ClockTest >> testAddMinutesAddToNextHour [
	| result |

	result := clockCalculator addMinute: 45 hour: 0 value: 40 .
	self assert: result equals: '01:25'
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksAMinuteApart [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->36); add: ('hour'->15); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) .
	self assert: result equals: false
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksAnHourApart [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->37); add: ('hour'->14); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) .
	self assert: result equals: false
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithHourOverflow [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->37); add: ('hour'->10); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->34); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithHourOverflowBySeveralDays [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->11); add: ('hour'->3); yourself) clock2: ((Dictionary new) add: ('minute'->11); add: ('hour'->99); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithMinuteOverflow [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->1); add: ('hour'->0); yourself) clock2: ((Dictionary new) add: ('minute'->1441); add: ('hour'->0); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithMinuteOverflowBySeveralDays [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->2); add: ('hour'->2); yourself) clock2: ((Dictionary new) add: ('minute'->4322); add: ('hour'->2); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeHour [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->40); add: ('hour'->22); yourself) clock2: ((Dictionary new) add: ('minute'->40); add: ('hour'-> -2); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeHourThatWraps [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->3); add: ('hour'->17); yourself) clock2: ((Dictionary new) add: ('minute'->3); add: ('hour'-> -31); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeHourThatWrapsMultipleTimes [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->49); add: ('hour'->13); yourself) clock2: ((Dictionary new) add: ('minute'->49); add: ('hour'-> -83); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeHoursAndMinutes [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->32); add: ('hour'->7); yourself) clock2: ((Dictionary new) add: ('minute'-> -268); add: ('hour'-> -12); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeHoursAndMinutesThatWrap [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->7); add: ('hour'->18); yourself) clock2: ((Dictionary new) add: ('minute'-> -11513); add: ('hour'-> -54); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeMinute [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->40); add: ('hour'->2); yourself) clock2: ((Dictionary new) add: ('minute'-> -20); add: ('hour'->3); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeMinuteThatWraps [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->10); add: ('hour'->4); yourself) clock2: ((Dictionary new) add: ('minute'-> -1490); add: ('hour'->5); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithNegativeMinuteThatWrapsMultipleTimes [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->15); add: ('hour'->6); yourself) clock2: ((Dictionary new) add: ('minute'-> -4305); add: ('hour'->6); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityClocksWithSameTime [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCompareTwoClocksForEqualityFullClockAndZeroedClock [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->0); add: ('hour'->24); yourself) clock2: ((Dictionary new) add: ('minute'->0); add: ('hour'->0); yourself) .
	self assert: result equals: true
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeHourAndMinutesRollOver [
	| result |

	result := clockCalculator createMinute: 160 hour: 25 .
	self assert: result equals: '03:40'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeHourAndMinutesRollOverContinuously [
	| result |

	result := clockCalculator createMinute: 3001 hour: 201 .
	self assert: result equals: '11:01'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeHourAndMinutesRollOverToExactlyMidnight [
	| result |

	result := clockCalculator createMinute: 8640 hour: 72 .
	self assert: result equals: '00:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeHourRollsOver [
	| result |

	result := clockCalculator createMinute: 0 hour: 25 .
	self assert: result equals: '01:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeHourRollsOverContinuously [
	| result |

	result := clockCalculator createMinute: 0 hour: 100 .
	self assert: result equals: '04:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeMidnightIsZeroHours [
	| result |

	result := clockCalculator createMinute: 0 hour: 24 .
	self assert: result equals: '00:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeMinutesRollOver [
	| result |

	result := clockCalculator createMinute: 160 hour: 0 .
	self assert: result equals: '02:40'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeMinutesRollOverContinuously [
	| result |

	result := clockCalculator createMinute: 1723 hour: 0 .
	self assert: result equals: '04:43'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeHour [
	| result |

	result := clockCalculator createMinute: 15 hour:  -1 .
	self assert: result equals: '23:15'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeHourAndMinutesBothRollOver [
	| result |

	result := clockCalculator createMinute:  -160 hour:  -25 .
	self assert: result equals: '20:20'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeHourAndMinutesBothRollOverContinuously [
	| result |

	result := clockCalculator createMinute:  -5810 hour:  -121 .
	self assert: result equals: '22:10'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeHourRollsOver [
	| result |

	result := clockCalculator createMinute: 0 hour:  -25 .
	self assert: result equals: '23:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeHourRollsOverContinuously [
	| result |

	result := clockCalculator createMinute: 0 hour:  -91 .
	self assert: result equals: '05:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeMinutes [
	| result |

	result := clockCalculator createMinute:  -40 hour: 1 .
	self assert: result equals: '00:20'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeMinutesRollOver [
	| result |

	result := clockCalculator createMinute:  -160 hour: 1 .
	self assert: result equals: '22:20'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeMinutesRollOverContinuously [
	| result |

	result := clockCalculator createMinute:  -4820 hour: 1 .
	self assert: result equals: '16:40'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeNegativeSixtyMinutesIsPreviousHour [
	| result |

	result := clockCalculator createMinute:  -60 hour: 2 .
	self assert: result equals: '01:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeOnTheHour [
	| result |

	result := clockCalculator createMinute: 0 hour: 8 .
	self assert: result equals: '08:00'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimePastTheHour [
	| result |

	result := clockCalculator createMinute: 9 hour: 11 .
	self assert: result equals: '11:09'
]

{ #category : #test }
ClockTest >> testCreateANewClockWithAnInitialTimeSixtyMinutesIsNextHour [
	| result |

	result := clockCalculator createMinute: 60 hour: 1 .
	self assert: result equals: '02:00'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractAcrossMidnight [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 0 value: 4 .
	self assert: result equals: '23:59'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractMinutes [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 10 value: 3 .
	self assert: result equals: '10:00'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractMoreThanAnHour [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 10 value: 70 .
	self assert: result equals: '08:53'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractMoreThanOneDay1500Min25Hrs [
	| result |

	result := clockCalculator subtractMinute: 32 hour: 5 value: 1500 .
	self assert: result equals: '04:32'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractMoreThanTwoDays [
	| result |

	result := clockCalculator subtractMinute: 20 hour: 2 value: 3000 .
	self assert: result equals: '00:20'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractMoreThanTwoHours [
	| result |

	result := clockCalculator subtractMinute: 0 hour: 0 value: 160 .
	self assert: result equals: '21:20'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractMoreThanTwoHoursWithBorrow [
	| result |

	result := clockCalculator subtractMinute: 15 hour: 6 value: 160 .
	self assert: result equals: '03:35'
]

{ #category : #test }
ClockTest >> testSubtractMinutesSubtractToPreviousHour [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 10 value: 30 .
	self assert: result equals: '09:33'
]
