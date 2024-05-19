//
//  ExampleARViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import Observation

@Observable
final class ExampleARViewModel {
    var downloadedUrl: URL?
    var contents = [Content]()
    
    @ObservationIgnored private let downloadManager = DownloadManager()
    @ObservationIgnored private let apiManager = APIManager()
    
    func getContents() async throws {
        guard let contentsUrl = URL(string: APIRequestUrl.contents.urlString) else {return}
        let contentsResponse: GetResponseTemplate<Content> = try await apiManager.get(url: contentsUrl)
        await MainActor.run {
            contents = contentsResponse.results
        }
    }
    
    func download3D(url: URL) async throws {
        let fm = FileManager.default.temporaryDirectory.appendingPathComponent(url.lastPathComponent, conformingTo: .usdz)
        if FileManager().fileExists(atPath: fm.path()) {
            await MainActor.run(body:  {
                downloadedUrl = fm
            })
        } else {
            let response = try await downloadManager.download(from: url, to: fm)
            await MainActor.run {
                downloadedUrl = response
            }
        }
    }
    
}
