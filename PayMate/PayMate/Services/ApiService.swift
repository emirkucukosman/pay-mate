//
//  ApiService.swift
//  PayMate
//
//  Created by Emir Küçükosman on 11.11.2020.
//

import Foundation

final class ApiService {
    
    static let shared = ApiService()
    
    private init() {}
    
    func authTask(with credentials: Credentials, taskType: AuthTaskType, completion: @escaping (AuthResponse?, String?) -> ()) {
        
        var urlString = ""
        
        switch taskType {
            case .login:
                urlString = "http://localhost:5000/api/user/login"
            case .register:
                urlString = "http://localhost:5000/api/user/register"
        }
        
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            DispatchQueue.main.async {
                completion(nil, error.localizedDescription)
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                return DispatchQueue.main.async {
                    completion(nil, error!.localizedDescription)
                }
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                return DispatchQueue.main.async {
                    completion(nil, "Can not get response from the server")
                }
            }
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                return DispatchQueue.main.async {
                    completion(nil, "Can not read response from the server")
                }
            }
            
            if response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(authResponse, nil)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    completion(nil, authResponse.message)
                }
                
            }
            
        }
        .resume()
        
    }
    
    func accountTask(completion: @escaping (Account?, String?) -> ()) {
        
        guard let url = URL(string: "http://localhost:5000/api/account/balance") else {
            fatalError()
        }
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return completion(nil, "Authorization failed")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                return DispatchQueue.main.async {
                    completion(nil, error!.localizedDescription)
                }
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                return DispatchQueue.main.async {
                    completion(nil, "Can not get response from the server")
                }
            }
            
            if response.statusCode == 200 {
                guard let accountResponse = try? JSONDecoder().decode(AccountResponse.self, from: data) else {
                    return DispatchQueue.main.async {
                        completion(nil, "Fatal error")
                    }
                }
                DispatchQueue.main.async {
                    completion(accountResponse.account, nil)
                }
            } else {
                guard let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                    return DispatchQueue.main.async {
                        completion(nil, "Fatal error")
                    }
                }
                DispatchQueue.main.async {
                    completion(nil, errorResponse.message)
                }
            }
            
        }.resume()
        
    }
    
}
