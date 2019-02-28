"
# Rest Api

Implement a RESTful API for tracking IOUs.

Four roommates have a habit of borrowing money from each other frequently, and have trouble remembering who owes whom, and how much.

Your task is to implement a simple [RESTful API](https://en.wikipedia.org/wiki/Representational_state_transfer) that receives [IOU](https://en.wikipedia.org/wiki/IOU)s as POST requests, and can deliver specified summary information via GET requests.

### API Specification

#### User object
```json
{
  ""name"": ""Adam"",
  ""owes"": {
    ""Bob"": 12.0,
    ""Chuck"": 4.0,
    ""Dan"": 9.5
  },
  ""owed_by"": {
    ""Bob"": 6.5,
    ""Dan"": 2.75,
  },
  ""balance"": ""<(total owed by other users) - (total owed to other users)>""
}
```

#### Methods

| Description | HTTP Method | URL | Payload Format | Response w/o Payload | Response w/ Payload |
| --- | --- | --- | --- | --- | --- |
| List of user information | GET | /users | `{""users"":[""Adam"",""Bob""]}` | `{""users"":<List of all User objects>}` | `{""users"":<List of User objects for <users> (sorted by name)}` |
| Create user | POST | /add | `{""user"":<name of new user (unique)>}` | N/A | `<User object for new user>` |
| Create IOU | POST | /iou | `{""lender"":<name of lender>,""borrower"":<name of borrower>,""amount"":5.25}` | N/A | `{""users"":<updated User objects for <lender> and <borrower> (sorted by name)>}` |

### Other Resources:
- https://restfulapi.net/
- Example RESTful APIs
  - [GitHub](https://developer.github.com/v3/)
  - [Reddit](https://www.reddit.com/dev/api/)
## Hint

TBD

"
Class {
	#name : #RestApiTest,
	#superclass : #ExercismTest,
	#instVars : [
		'restApiCalculator'
	],
	#category : #'ExercismWIP-RestApi'
}

{ #category : #config }
RestApiTest class >> uuid [
	"Answer a unique id for this exercise"
	^'ede39ebe-4a3f-0d00-bb6c-9c85071d6982'
]

{ #category : #config }
RestApiTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.1.1'
]

{ #category : #setup }
RestApiTest >> setUp [
	restApiCalculator := RestApi new
]

{ #category : #tests }
RestApiTest >> test01_IouBothUsersHave0Balance [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('amount'->3.0); add: ('lender'->'Adam'); add: ('borrower'->'Bob'); yourself) url: '/iou' database: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new) add: ('Adam'->3.0); yourself)); add: ('balance'-> -3.0); yourself); yourself)); yourself)
]

{ #category : #tests }
RestApiTest >> test01_UserManagementNoUsers [
	| result |

	result := restApiCalculator getUrl: '/users' database: ((Dictionary new) add: ('users'->#()); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->#()); yourself)
]

{ #category : #tests }
RestApiTest >> test02_IouBorrowerHasNegativeBalance [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('amount'->3.0); add: ('lender'->'Adam'); add: ('borrower'->'Bob'); yourself) url: '/iou' database: ((Dictionary new) add: ('users'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new) add: ('Chuck'->3.0); yourself)); add: ('balance'-> -3.0); yourself); at: 3 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('name'->'Chuck'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new) add: ('Adam'->3.0); add: ('Chuck'->3.0); yourself)); add: ('balance'-> -6.0); yourself); yourself)); yourself)
]

{ #category : #tests }
RestApiTest >> test02_UserManagementAddUser [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('user'->'Adam'); yourself) url: '/add' database: ((Dictionary new) add: ('users'->#()); yourself) .
	self assert: result equals: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself)
]

{ #category : #tests }
RestApiTest >> test03_IouLenderHasNegativeBalance [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('amount'->3.0); add: ('lender'->'Bob'); add: ('borrower'->'Adam'); yourself) url: '/iou' database: ((Dictionary new) add: ('users'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new) add: ('Chuck'->3.0); yourself)); add: ('balance'-> -3.0); yourself); at: 3 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('name'->'Chuck'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('balance'-> -3.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Adam'->3.0); yourself)); add: ('name'->'Bob'); add: ('owes'->((Dictionary new) add: ('Chuck'->3.0); yourself)); add: ('balance'->0.0); yourself); yourself)); yourself)
]

{ #category : #tests }
RestApiTest >> test03_UserManagementGetSingleUser [
	| result |

	result := restApiCalculator getPayload: ((Dictionary new) add: ('users'->#('Bob' )); yourself) url: '/users' database: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); yourself)); yourself)
]

{ #category : #tests }
RestApiTest >> test04_IouLenderOwesBorrower [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('amount'->2.0); add: ('lender'->'Adam'); add: ('borrower'->'Bob'); yourself) url: '/iou' database: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('balance'-> -3.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Adam'->3.0); yourself)); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new) add: ('Bob'->1.0); yourself)); add: ('balance'-> -1.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Adam'->1.0); yourself)); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->1.0); yourself); yourself)); yourself)
]

{ #category : #tests }
RestApiTest >> test05_IouLenderOwesBorrowerLessThanNewLoan [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('amount'->4.0); add: ('lender'->'Adam'); add: ('borrower'->'Bob'); yourself) url: '/iou' database: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('balance'-> -3.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Adam'->3.0); yourself)); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Bob'->1.0); yourself)); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->1.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new) add: ('Adam'->1.0); yourself)); add: ('balance'-> -1.0); yourself); yourself)); yourself)
]

{ #category : #tests }
RestApiTest >> test06_IouLenderOwesBorrowerSameAsNewLoan [
	| result |

	result := restApiCalculator postPayload: ((Dictionary new) add: ('amount'->3.0); add: ('lender'->'Adam'); add: ('borrower'->'Bob'); yourself) url: '/iou' database: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new) add: ('Bob'->3.0); yourself)); add: ('balance'-> -3.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new) add: ('Adam'->3.0); yourself)); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->3.0); yourself); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('users'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Adam'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); at: 2 put: ((Dictionary new) add: ('owed_by'->((Dictionary new))); add: ('name'->'Bob'); add: ('owes'->((Dictionary new))); add: ('balance'->0.0); yourself); yourself)); yourself)
]
