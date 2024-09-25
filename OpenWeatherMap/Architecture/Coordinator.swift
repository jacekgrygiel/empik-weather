//
//  Coordinator.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import UIKit

protocol CoordinatorController {}
extension UIViewController: CoordinatorController {}

protocol Transferable {}
extension String: Transferable {}

protocol CoordinatorType: AnyObject {

    var children: [CoordinatorType] { get set }
    var parent: CoordinatorType? { get set }
    var viewController: UIViewController { get }

    func attachChild(_ child: CoordinatorType)
    func detachChild(_ child: CoordinatorType)

    func detachFromParent()
    func detachAllChildren()

    func navigate(to: Navigation.Name, transferable: Transferable?)

    func start()
}

class Coordinator: CoordinatorType {

    weak var parent: CoordinatorType?
    var children = [CoordinatorType]()

    let controller: CoordinatorController
    var viewController: UIViewController {
        controller as? UIViewController ?? UIViewController()
    }

    init(controller: CoordinatorController, parent: CoordinatorType? = nil) {
        self.controller = controller
        self.parent = parent
    }

    func attachChild(_ child: CoordinatorType) {
        guard !(children.contains { $0 === child }) else {
            return
        }
        children.append(child)
        child.parent = self
    }

    func start() {
        fatalError("Should never run from Coordinator itself")
    }

    func detachFromParent() {
        parent?.detachChild(self)
    }

    func detachChild(_ child: CoordinatorType) {
        child.parent = nil
        children.removeElementByReference(child)
    }

    func detachAllChildren() {
        children.forEach {
            $0.detachAllChildren()
            detachChild($0)
        }
    }

    deinit {
        if !children.isEmpty { detachAllChildren() }
    }

    @MainActor
    func navigate(to: Navigation.Name, transferable: Transferable?) {
        fatalError("Should never run from Coordinator itself")
    }
}

extension CoordinatorType {
    func navigate(to: Navigation.Name) {
        navigate(to: to, transferable: nil)
    }
}

extension CoordinatorType {
    func handlerError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

public extension Array {
    mutating func removeElementByReference(_ element: Element) {
        guard let objIndex = firstIndex(where: { $0 as AnyObject === element as AnyObject }) else {
            return
        }
        remove(at: objIndex)
    }
}
