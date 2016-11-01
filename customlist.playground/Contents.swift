//: Playground - noun: a place where people can play

import UIKit

enum List<Element> {
    case End
    indirect case Node(Element, next:List<Element>)
}

extension List {
    func cons(x:Element) -> List {
        return .Node(x, next:self)
    }
}

protocol StackType {
    associatedtype Element
    mutating func push(x:Element)
    mutating func pop() -> Element?
}

extension Array: StackType {
    mutating func push(x: Element) {
        append(x)
    }
    
    mutating func pop() -> Element? {
        return popLast()
    }
}

extension List: StackType {
    mutating func push(x: Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .End: return nil
        case let .Node(x, next:xs):
            self = xs
            return x
        }
    }
}

extension List: SequenceType {
    func generate() -> AnyGenerator<Element> {
        var current = self
        return AnyGenerator {
            current.pop()
        }
    }
}

extension List: ArrayLiteralConvertible {
    init(arrayLiteral elements: Element...) {
        self = elements.reverse().reduce(.End){ l, x in l.cons(x) }
    }
}
let l = List<Int>.End.cons(1).cons(2).cons(3)
let newList :List = [1, 2, 3]

for x in newList {
    print("\(x)")
}

let f = l.filter{ $0 > 2 }


