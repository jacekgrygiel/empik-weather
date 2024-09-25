//
//  Debouncer.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation

class Debouncer {
    private let delay: TimeInterval
    private var task: Task<Void, Error>?

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func debounce(action: @escaping () async throws -> Void) {
        task?.cancel()

        task = Task {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            try await action()
        }
    }
}
