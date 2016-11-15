//: Playground - noun: a place where people can play

import UIKit

enum List<Element> {
    case end
    indirect case node(Element, next:List<Element>)
}

extension List {
    func cons(_ x:Element) -> List {
        return .node(x, next:self)
    }
}

let list = List<Int>.end.cons(3).cons(2).cons(1)

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}

protocol Stack {
    associatedtype Element
    mutating func push(_ :Element)
    mutating func pop() -> Element?
}

extension Array: Stack {
    mutating func push(_ x: Element) { append(x) }
    mutating func pop() -> Element? { return popLast() }
}

extension List: Stack {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next:xs):
            self = xs
            return x
        }
    }
}

extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}


