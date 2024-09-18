//
//  Logger.swift
//

import Foundation
import os.log

enum Logger {
    static var log: (OSLogType, String) -> Void = {
        let log = OSLog(subsystem: "com.networking", category: "network")
        return { os_log("[💈] %{public}@", log: log, type: $0, $1) }
    }()
}
