//
//  API+Manager.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import Foundation

class APIManager: APIManagerProtocol {

    static let SchoolXURL = "https://school-x.json-translator.uz/api/v1"
    
    func get<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = UserDefaults.standard.value(forKey: "authentication_token") as? String {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authentication")
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
        return try decode(data: data)
    }
    
    func get<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.value(forKey: "authentication_token") as? String {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authentication")
        }
        request.httpBody = try JSONEncoder().encode(body)
        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
        return try decode(data: data)
    }

    func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.value(forKey: "authentication_token") as? String {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authentication")
        }
        request.httpBody = try JSONEncoder().encode(body)
        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
        return try decode(data: data)
    }

    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "HTTPError", code: statusCode, userInfo: nil)
        }
    }

    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}

protocol APIManagerProtocol {
    func get<T: Decodable>(url: URL) async throws -> T
    func get<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T
    func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T
}

enum APIRequestUrl {
    case contents
    case contentsId(String)
    case questions
    case subjects
    case subjectsId(String)
    case topics
    case topicsId(String)
    
    case auth
    
    var urlString: String {
        switch self {
        case .contents: APIManager.SchoolXURL + "/main/contents/"
        case .contentsId(let id): APIManager.SchoolXURL + "/main/contents/\(id)/"
        case .questions: APIManager.SchoolXURL + "/main/questions/"
        case .subjects: APIManager.SchoolXURL + "/main/subjects/"
        case .subjectsId(let id): APIManager.SchoolXURL + "/main/subjects/\(id)/"
        case .topics: APIManager.SchoolXURL + "/main/topics/"
        case .topicsId(let id): APIManager.SchoolXURL + "/main/topics/\(id)/"
            
        case .auth: APIManager.SchoolXURL + "/users/auth/"
        }
    }
}
