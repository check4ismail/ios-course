import UIKit

//// 1. Typical example of passing functions as inputs
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//func add(no1: Int, no2: Int) -> Int {
//	return no1 + no2
//}
//
//func multiply(no1: Int, no2: Int) -> Int {
//	return no1 * no2
//}
//
//calculator(n1: 2, n2: 3, operation: add)
//calculator(n1: 2, n2: 3, operation: multiply)


//// 2. Using closures instead of example 1. Simplifies code
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//calculator(n1: 2, n2: 3, operation: { (no1: Int, no2: Int) -> Int in
//	return no1 * no2
//})

//// 3. A more simplied version of number 2 by removing parameter type
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//calculator(n1: 2, n2: 3, operation: { (no1, no2) -> Int in
//	return no1 * no2
//})

//// 4. A more simplied version of closure by removing the return type
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//calculator(n1: 2, n2: 3, operation: { (no1, no2) in
//	return no1 * no2
//})

//// 5. A more simplied version of closure by getting rid of return!
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//calculator(n1: 2, n2: 3, operation: { (no1, no2) in no1 * no2 })

//// 6. A more simplied version of closure by using anonymous parameter names
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//// $0 = first parameter, $1 = second parameter
//print(calculator(n1: 2, n2: 3, operation: { $0 * $1 }))

//// 7. A more simplied version of closure by using trailing closures
//func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
//	return operation(n1, n2)
//}
//
//let result = calculator(n1: 2, n2: 3) { $0 * $1 }
//print(result)

//// 8. A better real-life example of closures
//var array = [2,4,6,7,8,10]
//
//func addOne(n1 : Int) -> Int {
//	return n1 + 1
//}
//array.map(addOne) // Calls addOne function to update each array value

// 9. A simplied version of number 8
var array = [2,4,6,7,8,10]

print(array.map({ (n1) in n1 + 1 }))
print(array.map{$0 + 1})

let newArray = array.map{"\($0)"}
print(newArray)
