//
//  URL+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit
import MobileCoreServices

extension URL: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base == URL {

    /// Get home directory.
    static var homeDirectory: URL {
        return URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
    }

    /// Get document directory.
    static var documnetDirectory: URL {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = documentPaths[0]
        return URL(fileURLWithPath: documentPath, isDirectory: true)
    }

    /// Get library directory.
    static var libraryDirectory: URL {
        let libraryPaths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        let libraryPath = libraryPaths[0]
        return URL(fileURLWithPath: libraryPath, isDirectory: true)
    }

    /// Get caches directory.
    static var cachesDirectory: URL {
        let cachesPaths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let cachesPath = cachesPaths[0]
        return cachesPath
    }

    /// Get temp directory.
    static var tempDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }

}

// MARK: - Methods

public extension ZZ where Base == URL {

    /// Get bytes size of file.
    /// - Returns: The bytes size of file.
    func fileBytes() -> Int? {
        do {
            let val = try base.resourceValues(forKeys: [.totalFileAllocatedSizeKey, .fileAllocatedSizeKey])
            return val.totalFileAllocatedSize ?? val.fileAllocatedSize
        } catch {
            return nil
        }
    }

    /// Get bytes size of directory.
    /// - Returns: The bytes size of directory.
    func directoryBytes() -> Int? {
        if let enumerator = FileManager.default.enumerator(at: base, includingPropertiesForKeys: [.totalFileAllocatedSizeKey, .fileAllocatedSizeKey], options: [], errorHandler: { (_, error) -> Bool in
            print(error)
            return false
        }) {
            var bytes = 0
            for case let url as URL in enumerator {
                bytes += url.zz.fileBytes() ?? 0
            }
            return bytes
        } else {
            return nil
        }
    }
    
    
    /// Get mimeType.
    /// - Returns: The string of mime type.
    func mimeType() -> String {
        let pathExtension = base.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }

}
