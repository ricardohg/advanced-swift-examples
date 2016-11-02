//: Playground - noun: a place where people can play

import UIKit

protocol Setting {
    func settingsView() -> UIView
}

//var defaultSettings:[String:Setting] = [
//"Airplane Mode":true,
//"Name":"iPhone",
//]

extension Dictionary {
    
    init<S:Sequence> (_ sequence:S)
        where S.Iterator.Element == (Key, Value) {
        self = [:]
        self.merge(other: sequence)
    }
    
    mutating func merge <S:Sequence> (other: S)
        where S.Iterator.Element == (Key, Value) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
}


let arr = [1,2,1,4,5]
var dict = [1:"one", 2:"two"]
let dict2 = [1:"one"]

for num in arr where dict[num] != nil {
    print(num)
}

let defaultAlarms = (1..<5).map{("Alarm \($0)",false)}
let dictionaryAlarms = Dictionary(defaultAlarms)
