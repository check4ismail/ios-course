import UIKit


func fibSequence(stopAt until : Int){
	
	var prevFib : Int = 0
	var currentFib : Int = 1
	var temp : Int = 0
	
	print(prevFib)
	print(currentFib)
	
	for _ in 0...until {
		temp = currentFib
		currentFib = currentFib + prevFib
		prevFib = temp
		print(currentFib)
	}
}

fibSequence(stopAt : 5)
