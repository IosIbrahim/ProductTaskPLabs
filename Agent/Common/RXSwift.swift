//
//  RXSwift.swift
//  Agent
//
//  Created by ibrahim on 26/03/2023.
//

import RxSwift
import RxCocoa

typealias Disposer = DisposeBag

@propertyWrapper
final class PublishedSubject<Value> {
    var wrappedValue: PublishSubject<Value>
    init() {
        self.wrappedValue = PublishSubject<Value>()
    }
}

@propertyWrapper
final class Disposed {
    var wrappedValue: Disposer

    init() {
        self.wrappedValue = .init()
    }
}

@propertyWrapper
final class PublishedRelay<Value> {
    var wrappedValue: PublishRelay<Value>
    init() {
        self.wrappedValue = PublishRelay<Value>()
    }
}

@propertyWrapper
final class BehavioralRelay<Value> {
    var wrappedValue: BehaviorRelay<Value>
    init(value: Value) {
        self.wrappedValue = BehaviorRelay<Value>(value: value)
    }
}
