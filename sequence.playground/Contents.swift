//: Playground - noun: a place where people can play

import UIKit

struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        
        return string[string.startIndex..<offset]
    
    }
}

struct PrefixSequence: Sequence {
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

for prefix in PrefixSequence(string: "What Fart") {
    print(prefix)
}

PrefixSequence(string: "gonor").map { $0.uppercased() }

func fibsIterator() -> AnyIterator<Int> {
    var state = (0, 1)
    
    return AnyIterator {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

let fibSequence = AnySequence(fibsIterator)
Array(fibSequence.prefix(7))

let randomNumbers = sequence(first: 100) { (previous: UInt32) in
    let newValue = arc4random_uniform(previous)
    guard newValue > 0 else { return nil }
    return newValue
}
Array(randomNumbers)

let fibsSequence2 = sequence(state: (0, 1)) {
    // The compiler needs a little type inference help here
    (state: inout (Int, Int)) -> Int? in
    let upcomingNumber = state.0
    state = (state.1, state.0 + state.1)
    return upcomingNumber
}

Array(fibsSequence2.prefix(7))