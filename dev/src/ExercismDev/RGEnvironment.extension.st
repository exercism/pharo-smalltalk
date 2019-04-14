Extension { #name : #RGEnvironment }

{ #category : #'*ExercismDev' }
RGEnvironment >> createBrowserWithTitle: aString [
	"Copied from #browse, but doesn't open the browser so you can customise it before opening
	(and avoid a filter string race condition)"
	
	 | clyEnv clyNavEnv browser |

	clyEnv := ClyRing2Environment new.
	clyEnv environment: self.

	clyNavEnv := (ClyNavigationEnvironment over: clyEnv)
		addPlugin: ClyDefaultSystemEnvironmentPlugin new;
	   attachToSystem.

	browser := ClyFullBrowser new 
		navigationEnvironment: clyNavEnv.
	browser addPlugin: ClyStandardBrowserPlugin new.
	
	browser system name: aString.

	^ browser
]
