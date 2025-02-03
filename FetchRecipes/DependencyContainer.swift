//
//  DependencyContainer.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

protocol DependencyManaging {
    static func register<T>(type: T.Type, _ service: @autoclosure @escaping () -> T, update: Bool)
    static func resolve<T>(_ type: T.Type) -> T?
}

actor DependencyContainer: DependencyManaging {
            
    private static var services: [ObjectIdentifier: () -> Any] = [:]
    private static var resolved: [ObjectIdentifier: Any] = [:]
    
    static func register<T>(type: T.Type, _ service: @autoclosure @escaping () -> T, update: Bool = false) {
        let identifier = ObjectIdentifier(T.self)
        services[identifier] = service
        if update {
            resolved[identifier] = service()
        }
    }
    
    static func resolve<T>(_ type: T.Type) -> T? {
        let identifier = ObjectIdentifier(type.self)
        if let service = resolved[identifier] as? T {
            return service
        } else {
            let service = services[identifier]?() as? T
            if let service {
                resolved[identifier] = service
            }
            return service
        }
    }
    
}

@propertyWrapper
struct Dependency<T> {
    
    var service: T?

    init() {
        guard let service = DependencyContainer.resolve(T.self) else {
            let serviceName = String(describing: T.self)
            fatalError("No service of type \(serviceName) registered!")
        }
        self.service = service
    }

    var wrappedValue: T? {
        get { self.service ?? nil }
        mutating set {
            service = newValue
        }
    }

}
