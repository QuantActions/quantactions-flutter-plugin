//
//  Errors.swift
//  qa_flutter_plugin
//
//  Created by User on 20/10/2023.
//

import Foundation


enum QASDKError: Error {
    case faildInitialize
    case faildSerialize
}

protocol faildInitialize {
    func faildInitializeError() throws
}

protocol faildSerialize {
    func faildSerializeError() throws
}

private func faildInitializeError() throws {
    throw QASDKError.faildInitialize
}

private func faildSerializeError() throws {
    throw QASDKError.faildSerialize
}

//extension QAError {
//    public init(description: String, reason: String) {
//        self.init(description: description, reason: reason)
//    }
//}
