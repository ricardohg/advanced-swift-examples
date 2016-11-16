//: Playground - noun: a place where people can play

import UIKit

let array = [3,4,2]
let squared = array.map{fib in fib * fib}
squared.sorted()

extension Array{
    func accumulate<U>(initial:U, combine:(U, Element) -> U) -> [U] {
        var running = initial
        return self.map {next in
            running = combine(initial, next)
            return running
        }
    }
    func map2<U>(transform:(Element) -> U) -> [U] {
        return reduce([]) {$0 + [transform($1)]}
    }
    func map3<C>(transform:(Element) -> C) -> [C] {
        return reduce([]) {f1, f2 in f1 + [transform(f2)]}
    }
    
    func newMap<T>(_ transform:(Element) -> T) -> [T] {
        var result:[T] = []
        result.reserveCapacity(count)
        
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

extension Sequence {
    func last(where predicate:(Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

array.accumulate(initial: 2, combine: +)
let modulo = array.filter{$0 % 2 == 0}
modulo
let cosos = (1..<10).map{num in num * num}.filter{$0 % 2 == 0}
cosos

let reducido = array.reduce(0){$0 + $1}
reducido
array
let squared2 = array.map2(transform: {$0 * $0})
squared2
let squared3 = array.map3(transform: {num in num * num})
squared3


let suits = ["♠", "♥", "♦", "♣"]
let ranks = ["J", "Q", "K", "A"]

let allCombinations = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

allCombinations
