//: Playground - noun: a place where people can play

import UIKit

fileprivate enum ListNode<Element> {
    case end
    indirect case node(Element, next:ListNode<Element>)
    
    func cons(_ x:Element) -> ListNode<Element> {
        return .node(x, next:self)
    }
}

public struct ListIndex<Element>: CustomStringConvertible {
    fileprivate let node: ListNode<Element>
    fileprivate let tag: Int
    
    public var description: String {
        return "ListIndex(\(tag))"
    }
}

extension ListIndex: Comparable {
    public static func == <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
    public static func < <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        // startIndex has the highest tag, endIndex the lowest
        return lhs.tag > rhs.tag
    }
}

public struct List<Element>: Collection {
    public typealias Index = ListIndex<Element>
    public var startIndex: Index
    public var endIndex: Index
    
    public subscript(idx: Index) -> Element {
        switch idx.node {
        case .end: fatalError("subscript out of range")
        case let .node(x, _) : return x
        }
    }
    
    public func index(after idx: Index) -> Index {
        switch idx.node {
        case .end: fatalError("Subscript out of range")
        case let .node(_, next): return Index(node: next, tag: idx.tag - 1)
        }
        
    }
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        startIndex = ListIndex(node: elements.reversed().reduce(.end) {
            $0.cons($1)
            }, tag: elements.count)
        endIndex = ListIndex(node: .end, tag: 0)
    }
}

extension List: CustomStringConvertible {
    public var description: String {
        let elements = self.map { String(describing: $0) }
            .joined(separator:";")
        return "List(\(elements))"
    }
}

extension List {
    public var count: Int {
        return startIndex.tag - endIndex.tag
    }
}

public func == <T:Equatable>(lhs:List<T>, rhs:List<T>) -> Bool {
    return lhs.elementsEqual(rhs)
}
