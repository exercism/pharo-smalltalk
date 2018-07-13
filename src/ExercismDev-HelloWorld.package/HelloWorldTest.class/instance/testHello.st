tests
testHello
	| greeter |
	greeter := HelloWorld new.
	self assert: greeter sayHello equals: 'Hello, World!'.