import Foundation

var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int {
	get {
		let area = width * height
		let areaCoveredPerBucket: Float = 1.5
		let bucketCount = ceil(area / areaCoveredPerBucket)
		return Int(bucketCount)
	}
	set {
		let areaCanCover = Double(newValue) * 1.5
		print("This amount of paint can cover an area of \(areaCanCover)")
	}
}

print(bucketsOfPaint)
bucketsOfPaint = 3
