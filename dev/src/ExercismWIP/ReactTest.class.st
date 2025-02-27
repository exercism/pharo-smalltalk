"
# React

Implement a basic reactive system.

Reactive programming is a programming paradigm that focuses on how values
are computed in terms of each other to allow a change to one value to
automatically propagate to other values, like in a spreadsheet.

Implement a basic reactive system with cells with settable values (""input""
cells) and cells with values computed in terms of other cells (""compute""
cells). Implement updates so that when an input value is changed, values
propagate to reach a new stable system state.

In addition, compute cells should allow for registering change notification
callbacks.  Call a cell’s callbacks when the cell’s value in a new stable
state has changed from the previous stable state.

## Hint

TBD

"
Class {
	#name : 'ReactTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'reactCalculator'
	],
	#category : 'ExercismWIP-React',
	#package : 'ExercismWIP',
	#tag : 'React'
}

{ #category : 'config' }
ReactTest class >> uuid [
	"Answer a unique id for this exercise"
	^'afe1ff16-9d41-0d00-900c-16f608866539'
]

{ #category : 'config' }
ReactTest class >> version [
	"Generated from specification: 29 March 2019"
	^'2.0.0'
]

{ #category : 'running' }
ReactTest >> setUp [
	super setUp.
	reactCalculator := React new
]

{ #category : 'tests' }
ReactTest >> test01_InputCellsHaveAValue [
	| result |

	result := reactCalculator reactCells: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->10); add: ('type'->'input'); yourself); yourself) operations: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('cell'->'input'); add: ('value'->10); add: ('type'->'expect_cell_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test02_AnInputCellsValueCanBeSet [
	| result |

	result := reactCalculator reactCells: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->4); add: ('type'->'input'); yourself); yourself) operations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('cell'->'input'); add: ('value'->20); add: ('type'->'set_value'); yourself); at: 2 put: ((Dictionary new) add: ('cell'->'input'); add: ('value'->20); add: ('type'->'expect_cell_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test03_ComputeCellsCalculateInitialValue [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('cell'->'output'); add: ('value'->2); add: ('type'->'expect_cell_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test04_ComputeCellsTakeInputsInTheRightOrder [
	| result |

	result := reactCalculator reactCells: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('name'->'one'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('name'->'two'); add: ('initial_value'->2); add: ('type'->'input'); yourself); at: 3 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + inputs[1] * 10'); add: ('name'->'output'); add: ('inputs'->#('one' 'two' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('cell'->'output'); add: ('value'->21); add: ('type'->'expect_cell_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test05_ComputeCellsUpdateValueWhenDependenciesAreChanged [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('cell'->'input'); add: ('value'->3); add: ('type'->'set_value'); yourself); at: 2 put: ((Dictionary new) add: ('cell'->'output'); add: ('value'->4); add: ('type'->'expect_cell_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test06_ComputeCellsCanDependOnOtherComputeCells [
	| result |

	result := reactCalculator reactCells: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] * 2'); add: ('name'->'times_two'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 3 put: ((Dictionary new) add: ('compute_function'->'inputs[0] * 30'); add: ('name'->'times_thirty'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 4 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + inputs[1]'); add: ('name'->'output'); add: ('inputs'->#('times_two' 'times_thirty' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('cell'->'output'); add: ('value'->32); add: ('type'->'expect_cell_value'); yourself); at: 2 put: ((Dictionary new) add: ('cell'->'input'); add: ('value'->3); add: ('type'->'set_value'); yourself); at: 3 put: ((Dictionary new) add: ('cell'->'output'); add: ('value'->96); add: ('type'->'expect_cell_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test07_ComputeCellsFireCallbacks [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->4); yourself)); add: ('cell'->'input'); add: ('value'->3); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test08_CallbackCellsOnlyFireOnChange [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'if inputs[0] < 3 then 111 else 222'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('cell'->'input'); add: ('value'->2); add: ('type'->'set_value'); yourself); at: 3 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->222); yourself)); add: ('cell'->'input'); add: ('value'->4); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test09_CallbacksDoNotReportAlreadyReportedValues [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->3); yourself)); add: ('cell'->'input'); add: ('value'->2); add: ('type'->'set_value'); yourself); at: 3 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->4); yourself)); add: ('cell'->'input'); add: ('value'->3); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test10_CallbacksCanFireFromMultipleCells [
	| result |

	result := reactCalculator reactCells: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'plus_one'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 3 put: ((Dictionary new) add: ('compute_function'->'inputs[0] - 1'); add: ('name'->'minus_one'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'plus_one'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('name'->'callback2'); add: ('cell'->'minus_one'); add: ('type'->'add_callback'); yourself); at: 3 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->11); add: ('callback2'->9); yourself)); add: ('cell'->'input'); add: ('value'->10); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test11_CallbacksCanBeAddedAndRemoved [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->11); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 6) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('name'->'callback2'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 3 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->32); add: ('callback2'->32); yourself)); add: ('cell'->'input'); add: ('value'->31); add: ('type'->'set_value'); yourself); at: 4 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'remove_callback'); yourself); at: 5 put: ((Dictionary new) add: ('name'->'callback3'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 6 put: ((Dictionary new) add: ('value'->41); add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('expect_callbacks'->((Dictionary new) add: ('callback2'->42); add: ('callback3'->42); yourself)); add: ('cell'->'input'); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test12_RemovingACallbackMultipleTimesDoesntInterfereWithOtherCallbacks [
	| result |

	result := reactCalculator reactCells: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'output'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 6) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('name'->'callback2'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 3 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'remove_callback'); yourself); at: 4 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'remove_callback'); yourself); at: 5 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'remove_callback'); yourself); at: 6 put: ((Dictionary new) add: ('value'->2); add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('expect_callbacks'->((Dictionary new) add: ('callback2'->3); yourself)); add: ('cell'->'input'); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test13_CallbacksShouldOnlyBeCalledOnceEvenIfMultipleDependenciesChange [
	| result |

	result := reactCalculator reactCells: ((Array new: 5) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'plus_one'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 3 put: ((Dictionary new) add: ('compute_function'->'inputs[0] - 1'); add: ('name'->'minus_one1'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 4 put: ((Dictionary new) add: ('compute_function'->'inputs[0] - 1'); add: ('name'->'minus_one2'); add: ('inputs'->#('minus_one1' )); add: ('type'->'compute'); yourself); at: 5 put: ((Dictionary new) add: ('compute_function'->'inputs[0] * inputs[1]'); add: ('name'->'output'); add: ('inputs'->#('plus_one' 'minus_one2' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'output'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('expect_callbacks'->((Dictionary new) add: ('callback1'->10); yourself)); add: ('cell'->'input'); add: ('value'->4); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]

{ #category : 'tests' }
ReactTest >> test14_CallbacksShouldNotBeCalledIfDependenciesChangeButOutputValueDoesntChange [
	| result |

	result := reactCalculator reactCells: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('name'->'input'); add: ('initial_value'->1); add: ('type'->'input'); yourself); at: 2 put: ((Dictionary new) add: ('compute_function'->'inputs[0] + 1'); add: ('name'->'plus_one'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 3 put: ((Dictionary new) add: ('compute_function'->'inputs[0] - 1'); add: ('name'->'minus_one'); add: ('inputs'->#('input' )); add: ('type'->'compute'); yourself); at: 4 put: ((Dictionary new) add: ('compute_function'->'inputs[0] - inputs[1]'); add: ('name'->'always_two'); add: ('inputs'->#('plus_one' 'minus_one' )); add: ('type'->'compute'); yourself); yourself) operations: ((Array new: 5) at: 1 put: ((Dictionary new) add: ('name'->'callback1'); add: ('cell'->'always_two'); add: ('type'->'add_callback'); yourself); at: 2 put: ((Dictionary new) add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('cell'->'input'); add: ('value'->2); add: ('type'->'set_value'); yourself); at: 3 put: ((Dictionary new) add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('cell'->'input'); add: ('value'->3); add: ('type'->'set_value'); yourself); at: 4 put: ((Dictionary new) add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('cell'->'input'); add: ('value'->4); add: ('type'->'set_value'); yourself); at: 5 put: ((Dictionary new) add: ('expect_callbacks_not_to_be_called'->#('callback1' )); add: ('cell'->'input'); add: ('value'->5); add: ('type'->'set_value'); yourself); yourself) .
	self assert: result equals: ((Dictionary new))
]
