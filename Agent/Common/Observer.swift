


import Foundation

final class Observer {
    
    private var observers: Array<NSObjectProtocol> = .init()
    private let center = NotificationCenter.default
    private let queue: OperationQueue
    
    required init(queue: OperationQueue = .main) {
        self.queue = queue
    }
    
    deinit {
        observers.forEach(center.removeObserver)
        observers.removeAll()        
    }
    
    func when(_ name: Notification.Name, object: Any? = .none, perform handler: @escaping(Notification) -> Void) {
        let observer = center.addObserver(forName: name, object: object, queue: queue, using: handler)
        observers.append(observer)
    }
    
    static func fire(observer name: Notification.Name, with object: Any? = nil) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
    func remove() {
        observers.forEach(center.removeObserver)
        observers.removeAll()
    }
    
}

extension Notification.Name {
    static var calling: Self { .init("make.phone.call") }
    static var logout: Self { .init("log.out") }
    static var selectEvaluationAnser: Self { .init("select.evaluation.anser") }
}


