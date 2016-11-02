//: Playground - noun: a place where people can play

import UIKit

private enum ListNode<Element> {
    case End
    indirect case Node(Element, next:ListNode<Element>)
    
    func cons(x:Element) -> ListNode<Element> {
        return .Node(x, next:self)
    }
}

public struct ListIndex<Element> {
    private let node: ListNode<Element>
    private let tag: Int
    
}

extension ListIndex: ForwardIndexType {
    public func successor() -> ListIndex<Element> {
        switch node {
        case let .Node(_, next: next):
            return ListIndex(node: next, tag: tag.predecessor())
        case .End:
            fatalError("cannot increment endIndex")
        }
    }
}

public func == <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
    return lhs.tag == rhs.tag
}

public struct List<Element>: Collection {
    public typealias Index = ListIndex<Element>
    public var startIndex: Index
    public var endIndex: Index
    
    public subscript(idx: Index) -> Element {
        switch idx.node {
        case .End:
            fatalError("subscript out of range")
        case let .Node(x, _) : return x
        }
    }
}

extension List: ArrayLiteralConvertible {
    public init(arrayLiteral elements: Element...) {
        startIndex = ListIndex(node: elements.reverse().reduce(.End) {
            $0.cons($1)
            }, tag: elements.count)
        endIndex = ListIndex(node: .End, tag: 0)
    }
}

extension List {
    public var count: Int {
        return startIndex.tag - endIndex.tag
    }
}

//public func == <T>(lhs:List<T>, rhs:List<T>) -> Bool {
//    return lhs.elementsEqual(rhs, isEquivalent: ==)
//}
