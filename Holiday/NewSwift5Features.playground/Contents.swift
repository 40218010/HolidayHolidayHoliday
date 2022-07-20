import Foundation

var greeting = "Hello, playground"
 
print(greeting)

// new string capabilities

let coolNewString = #"the keyword "var" is used to declare a variable"#

let multilineString =
"""
some cool new features are now avaliable in swift 5
some things stay the same: \(coolNewString)
haha

"""

// integer multiples

let x = 2
let y = 6

if y.isMultiple(of: x) {print("\(y) is an even number")}
