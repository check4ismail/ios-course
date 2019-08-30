import UIKit

let date = Date()
let format = DateFormatter()
format.dateFormat = "yyyy-MM-dd HH:mm:ss"
let formattedDate = format.string(from: date)
print(formattedDate)
