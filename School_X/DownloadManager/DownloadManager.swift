//
//  DownloadManager.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

actor DownloadManager {
    private var urlSession: URLSession!
    private let fileManager: FileManager
    private let cacheDirectory: URL
    
    init() {
        // Configure URLCache
        let memoryCapacity = 20 * 1024 * 1024 // 20 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "urlCache")
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        self.urlSession = URLSession(configuration: configuration)
        self.fileManager = FileManager.default
        self.cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("DownloadCache")
        
        // Create cache directory if it doesn't exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func download(from url: URL, to destinationURL: URL) async throws -> URL {
        let cacheFileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        
        // Check if file already exists in disk cache
        if fileManager.fileExists(atPath: cacheFileURL.path) {
            try await self.copyItemAsync(at: cacheFileURL, to: destinationURL)
            return destinationURL
        }
        
        // Download the file
        let downloadedFileURL: URL = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<URL, Error>) in
            let task = urlSession.downloadTask(with: url) { location, response, error in
                Task {
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let location = location else {
                        continuation.resume(throwing: URLError(.badServerResponse))
                        return
                    }
                    
                    do {
                        try await self.moveItemAsync(at: location, to: cacheFileURL)
                        try await self.copyItemAsync(at: cacheFileURL, to: destinationURL)
                        continuation.resume(returning: destinationURL)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            task.resume()
        }
        
        return downloadedFileURL
    }
    
    private func moveItemAsync(at srcURL: URL, to dstURL: URL) async throws {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try self.fileManager.moveItem(at: srcURL, to: dstURL)
                continuation.resume(returning: ())
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func copyItemAsync(at srcURL: URL, to dstURL: URL) async throws {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try self.fileManager.copyItem(at: srcURL, to: dstURL)
                continuation.resume(returning: ())
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
