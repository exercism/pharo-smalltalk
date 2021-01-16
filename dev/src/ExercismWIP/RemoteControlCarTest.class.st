Class {
	#name : #RemoteControlCarTest,
	#superclass : #ExercismTest,
	#category : #'ExercismWIP-ElonsToys'
}

{ #category : #tests }
RemoteControlCarTest >> testBatteryDisplayAfterDrivingMultipleTimes [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	23 timesRepeat: [ car drive ].
	
	self assert: 'Battery at 77%' equals: car batteryDisplay 
]

{ #category : #tests }
RemoteControlCarTest >> testBatteryDisplayAfterDrivingOnce [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	car drive.
	
	self assert: 'Battery at 99%' equals: car batteryDisplay 
]

{ #category : #tests }
RemoteControlCarTest >> testBatteryDisplayBatteryWhenEmpty [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	100 timesRepeat: [ car drive ]. "Drain the battery."

	car drive. "Attempt to drive one more time. Should not work."
	
	self assert: 'Battery empty' equals: car batteryDisplay 
]

{ #category : #'as yet unclassified' }
RemoteControlCarTest >> testBuyNewCarReturnsInstance [
	
	| car |
	car := RemoteControlCar buy.
	
	self assert: car isNotNil
]

{ #category : #'as yet unclassified' }
RemoteControlCarTest >> testBuyNewCarReturnsNewCarEachTime [

	| car1 car2 |
	self skip. "Remove this line to run the test."
	
	car1 := RemoteControlCar buy.
	car2 := RemoteControlCar buy.
	
	self assert: car1 ~~ car2
]

{ #category : #tests }
RemoteControlCarTest >> testDistanceDisplayAfterDrivingMultipleTimes [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	
	17 timesRepeat: [ car drive ].
	
	self assert: 'Driven 340 meters' equals: car distanceDisplay 
]

{ #category : #tests }
RemoteControlCarTest >> testDistanceDisplayAfterDrivingOnce [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	car drive.
	
	self assert: 'Driven 20 meteres' equals: car distanceDisplay
]

{ #category : #tests }
RemoteControlCarTest >> testDistanceDisplayWhenBatteryEmpty [
	
	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	
	100 timesRepeat: [ car drive ].
	
	car drive. "Attempt to drive one more time. Should not work."
	
	self assert: 'Driven 2000 meteres' equals: car distanceDisplay
]

{ #category : #tests }
RemoteControlCarTest >> testNewCarBatteryDisplay [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	
	self assert: 'Battery at 100%' equals: car batteryDisplay
]

{ #category : #tests }
RemoteControlCarTest >> testNewCarDistanceDisplay [

	| car |
	self skip. "Remove this line to run the test."
	
	car := RemoteControlCar new.
	
	self assert: 'Driven 0 meters' equals: car distanceDisplay
]
