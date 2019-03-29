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
	^'f8080717-9d41-0d00-9011-755a08866539'
]

{ #category : #config }
ClockTest class >> version [
	"Generated from specification: 29 March 2019"
	^'2.4.0'
]

{ #category : #setup }
ClockTest >> setUp [
	clockCalculator := Clock new
]

{ #category : #tests }
ClockTest >> test01_CreateANewClockWithAnInitialTimeOnTheHour [
	| result |

	result := clockCalculator createMinute: 0 hour: 8 .
	self assert: result equals: '08:00'
]

{ #category : #tests }
ClockTest >> test02_CreateANewClockWithAnInitialTimePastTheHour [
	| result |

	result := clockCalculator createMinute: 9 hour: 11 .
	self assert: result equals: '11:09'
]

{ #category : #tests }
ClockTest >> test03_CreateANewClockWithAnInitialTimeMidnightIsZeroHours [
	| result |

	result := clockCalculator createMinute: 0 hour: 24 .
	self assert: result equals: '00:00'
]

{ #category : #tests }
ClockTest >> test04_CreateANewClockWithAnInitialTimeHourRollsOver [
	| result |

	result := clockCalculator createMinute: 0 hour: 25 .
	self assert: result equals: '01:00'
]

{ #category : #tests }
ClockTest >> test05_CreateANewClockWithAnInitialTimeHourRollsOverContinuously [
	| result |

	result := clockCalculator createMinute: 0 hour: 100 .
	self assert: result equals: '04:00'
]

{ #category : #tests }
ClockTest >> test06_CreateANewClockWithAnInitialTimeSixtyMinutesIsNextHour [
	| result |

	result := clockCalculator createMinute: 60 hour: 1 .
	self assert: result equals: '02:00'
]

{ #category : #tests }
ClockTest >> test07_CreateANewClockWithAnInitialTimeMinutesRollOver [
	| result |

	result := clockCalculator createMinute: 160 hour: 0 .
	self assert: result equals: '02:40'
]

{ #category : #tests }
ClockTest >> test08_CreateANewClockWithAnInitialTimeMinutesRollOverContinuously [
	| result |

	result := clockCalculator createMinute: 1723 hour: 0 .
	self assert: result equals: '04:43'
]

{ #category : #tests }
ClockTest >> test09_CreateANewClockWithAnInitialTimeHourAndMinutesRollOver [
	| result |

	result := clockCalculator createMinute: 160 hour: 25 .
	self assert: result equals: '03:40'
]

{ #category : #tests }
ClockTest >> test10_CreateANewClockWithAnInitialTimeHourAndMinutesRollOverContinuously [
	| result |

	result := clockCalculator createMinute: 3001 hour: 201 .
	self assert: result equals: '11:01'
]

{ #category : #tests }
ClockTest >> test11_CreateANewClockWithAnInitialTimeHourAndMinutesRollOverToExactlyMidnight [
	| result |

	result := clockCalculator createMinute: 8640 hour: 72 .
	self assert: result equals: '00:00'
]

{ #category : #tests }
ClockTest >> test12_CreateANewClockWithAnInitialTimeNegativeHour [
	| result |

	result := clockCalculator createMinute: 15 hour:  -1 .
	self assert: result equals: '23:15'
]

{ #category : #tests }
ClockTest >> test13_CreateANewClockWithAnInitialTimeNegativeHourRollsOver [
	| result |

	result := clockCalculator createMinute: 0 hour:  -25 .
	self assert: result equals: '23:00'
]

{ #category : #tests }
ClockTest >> test14_CreateANewClockWithAnInitialTimeNegativeHourRollsOverContinuously [
	| result |

	result := clockCalculator createMinute: 0 hour:  -91 .
	self assert: result equals: '05:00'
]

{ #category : #tests }
ClockTest >> test15_CreateANewClockWithAnInitialTimeNegativeMinutes [
	| result |

	result := clockCalculator createMinute:  -40 hour: 1 .
	self assert: result equals: '00:20'
]

{ #category : #tests }
ClockTest >> test16_CreateANewClockWithAnInitialTimeNegativeMinutesRollOver [
	| result |

	result := clockCalculator createMinute:  -160 hour: 1 .
	self assert: result equals: '22:20'
]

{ #category : #tests }
ClockTest >> test17_CreateANewClockWithAnInitialTimeNegativeMinutesRollOverContinuously [
	| result |

	result := clockCalculator createMinute:  -4820 hour: 1 .
	self assert: result equals: '16:40'
]

{ #category : #tests }
ClockTest >> test18_CreateANewClockWithAnInitialTimeNegativeSixtyMinutesIsPreviousHour [
	| result |

	result := clockCalculator createMinute:  -60 hour: 2 .
	self assert: result equals: '01:00'
]

{ #category : #tests }
ClockTest >> test19_CreateANewClockWithAnInitialTimeNegativeHourAndMinutesBothRollOver [
	| result |

	result := clockCalculator createMinute:  -160 hour:  -25 .
	self assert: result equals: '20:20'
]

{ #category : #tests }
ClockTest >> test20_CreateANewClockWithAnInitialTimeNegativeHourAndMinutesBothRollOverContinuously [
	| result |

	result := clockCalculator createMinute:  -5810 hour:  -121 .
	self assert: result equals: '22:10'
]

{ #category : #tests }
ClockTest >> test21_AddMinutesAddMinutes [
	| result |

	result := clockCalculator addMinute: 0 hour: 10 value: 3 .
	self assert: result equals: '10:03'
]

{ #category : #tests }
ClockTest >> test22_AddMinutesAddNoMinutes [
	| result |

	result := clockCalculator addMinute: 41 hour: 6 value: 0 .
	self assert: result equals: '06:41'
]

{ #category : #tests }
ClockTest >> test23_AddMinutesAddToNextHour [
	| result |

	result := clockCalculator addMinute: 45 hour: 0 value: 40 .
	self assert: result equals: '01:25'
]

{ #category : #tests }
ClockTest >> test24_AddMinutesAddMoreThanOneHour [
	| result |

	result := clockCalculator addMinute: 0 hour: 10 value: 61 .
	self assert: result equals: '11:01'
]

{ #category : #tests }
ClockTest >> test25_AddMinutesAddMoreThanTwoHoursWithCarry [
	| result |

	result := clockCalculator addMinute: 45 hour: 0 value: 160 .
	self assert: result equals: '03:25'
]

{ #category : #tests }
ClockTest >> test26_AddMinutesAddAcrossMidnight [
	| result |

	result := clockCalculator addMinute: 59 hour: 23 value: 2 .
	self assert: result equals: '00:01'
]

{ #category : #tests }
ClockTest >> test27_AddMinutesAddMoreThanOneDay1500Min25Hrs [
	| result |

	result := clockCalculator addMinute: 32 hour: 5 value: 1500 .
	self assert: result equals: '06:32'
]

{ #category : #tests }
ClockTest >> test28_AddMinutesAddMoreThanTwoDays [
	| result |

	result := clockCalculator addMinute: 1 hour: 1 value: 3500 .
	self assert: result equals: '11:21'
]

{ #category : #tests }
ClockTest >> test29_SubtractMinutesSubtractMinutes [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 10 value: 3 .
	self assert: result equals: '10:00'
]

{ #category : #tests }
ClockTest >> test30_SubtractMinutesSubtractToPreviousHour [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 10 value: 30 .
	self assert: result equals: '09:33'
]

{ #category : #tests }
ClockTest >> test31_SubtractMinutesSubtractMoreThanAnHour [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 10 value: 70 .
	self assert: result equals: '08:53'
]

{ #category : #tests }
ClockTest >> test32_SubtractMinutesSubtractAcrossMidnight [
	| result |

	result := clockCalculator subtractMinute: 3 hour: 0 value: 4 .
	self assert: result equals: '23:59'
]

{ #category : #tests }
ClockTest >> test33_SubtractMinutesSubtractMoreThanTwoHours [
	| result |

	result := clockCalculator subtractMinute: 0 hour: 0 value: 160 .
	self assert: result equals: '21:20'
]

{ #category : #tests }
ClockTest >> test34_SubtractMinutesSubtractMoreThanTwoHoursWithBorrow [
	| result |

	result := clockCalculator subtractMinute: 15 hour: 6 value: 160 .
	self assert: result equals: '03:35'
]

{ #category : #tests }
ClockTest >> test35_SubtractMinutesSubtractMoreThanOneDay1500Min25Hrs [
	| result |

	result := clockCalculator subtractMinute: 32 hour: 5 value: 1500 .
	self assert: result equals: '04:32'
]

{ #category : #tests }
ClockTest >> test36_SubtractMinutesSubtractMoreThanTwoDays [
	| result |

	result := clockCalculator subtractMinute: 20 hour: 2 value: 3000 .
	self assert: result equals: '00:20'
]

{ #category : #tests }
ClockTest >> test37_CompareTwoClocksForEqualityClocksWithSameTime [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test38_CompareTwoClocksForEqualityClocksAMinuteApart [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->36); add: ('hour'->15); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) .
	self assert: result equals: false
]

{ #category : #tests }
ClockTest >> test39_CompareTwoClocksForEqualityClocksAnHourApart [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->37); add: ('hour'->14); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->15); yourself) .
	self assert: result equals: false
]

{ #category : #tests }
ClockTest >> test40_CompareTwoClocksForEqualityClocksWithHourOverflow [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->37); add: ('hour'->10); yourself) clock2: ((Dictionary new) add: ('minute'->37); add: ('hour'->34); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test41_CompareTwoClocksForEqualityClocksWithHourOverflowBySeveralDays [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->11); add: ('hour'->3); yourself) clock2: ((Dictionary new) add: ('minute'->11); add: ('hour'->99); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test42_CompareTwoClocksForEqualityClocksWithNegativeHour [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->40); add: ('hour'->22); yourself) clock2: ((Dictionary new) add: ('minute'->40); add: ('hour'-> -2); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test43_CompareTwoClocksForEqualityClocksWithNegativeHourThatWraps [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->3); add: ('hour'->17); yourself) clock2: ((Dictionary new) add: ('minute'->3); add: ('hour'-> -31); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test44_CompareTwoClocksForEqualityClocksWithNegativeHourThatWrapsMultipleTimes [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->49); add: ('hour'->13); yourself) clock2: ((Dictionary new) add: ('minute'->49); add: ('hour'-> -83); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test45_CompareTwoClocksForEqualityClocksWithMinuteOverflow [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->1); add: ('hour'->0); yourself) clock2: ((Dictionary new) add: ('minute'->1441); add: ('hour'->0); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test46_CompareTwoClocksForEqualityClocksWithMinuteOverflowBySeveralDays [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->2); add: ('hour'->2); yourself) clock2: ((Dictionary new) add: ('minute'->4322); add: ('hour'->2); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test47_CompareTwoClocksForEqualityClocksWithNegativeMinute [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->40); add: ('hour'->2); yourself) clock2: ((Dictionary new) add: ('minute'-> -20); add: ('hour'->3); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test48_CompareTwoClocksForEqualityClocksWithNegativeMinuteThatWraps [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->10); add: ('hour'->4); yourself) clock2: ((Dictionary new) add: ('minute'-> -1490); add: ('hour'->5); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test49_CompareTwoClocksForEqualityClocksWithNegativeMinuteThatWrapsMultipleTimes [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->15); add: ('hour'->6); yourself) clock2: ((Dictionary new) add: ('minute'-> -4305); add: ('hour'->6); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test50_CompareTwoClocksForEqualityClocksWithNegativeHoursAndMinutes [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->32); add: ('hour'->7); yourself) clock2: ((Dictionary new) add: ('minute'-> -268); add: ('hour'-> -12); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test51_CompareTwoClocksForEqualityClocksWithNegativeHoursAndMinutesThatWrap [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->7); add: ('hour'->18); yourself) clock2: ((Dictionary new) add: ('minute'-> -11513); add: ('hour'-> -54); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
ClockTest >> test52_CompareTwoClocksForEqualityFullClockAndZeroedClock [
	| result |

	result := clockCalculator equalClock1: ((Dictionary new) add: ('minute'->0); add: ('hour'->24); yourself) clock2: ((Dictionary new) add: ('minute'->0); add: ('hour'->0); yourself) .
	self assert: result equals: true
]
