//
//  ParseManager.swift
//  JTI
//
//  Created by Nursultan on 10/17/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation

class ParseManager {
    
    static let shared = ParseManager()
    
    let networkManager: NetworkManager = Router(parser: DefaultParserImpl())
    
    private init() {}
    let token = UserManager.getCurrentToken()
    
    func multipartFormData<T: Decodable>(url: String, parameters: Parameters? = nil,
                                         success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.multipartFormData(url: url, parameters: parameters, token: token)
        let dispatch = DispatchQueue.global(qos: .utility)
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<GeneralResult<T>>) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let errorMessage):
                        error(errorMessage)
                    case .success(let value):
                        success(value.result)
                    }
                }
            }
        }
    }
    
    func postRequest<T: Decodable>(url: String, parameters: Parameters? = nil,
                                   success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.post(url: url, parameters: parameters, token: token)
        self.networkManager.request(endpoint) { (result: Result<GeneralResult<T>>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let errorMessage):
                    error(errorMessage)
                case .success(let value):
                    success(value.result)
                }
            }
        }
    }
    
    func getRequest<T: Decodable>(url: String, parameters: Parameters? = nil,
                                  success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.get(url: url, parameters: parameters, token: token)
        
        self.networkManager.request(endpoint) { (result: Result<GeneralResult<T>>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let errorMessage):
                    error(errorMessage)
                case .success(let value):
                    success(value.result)
                }
            }
        }
    }
    
    func deleteRequest<T: Decodable>(url: String, parameters: Parameters? = nil, url_parameters: Parameters? = nil,
                                   success: @escaping (T) -> (), error: @escaping (String) -> ()) {
        let endpoint = Endpoints.delete(url: url, parameters: nil, url_parameters: url_parameters, token: token)
        self.networkManager.request(endpoint) { (result: Result<GeneralResult<T>>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let errorMessage):
                    error(errorMessage)
                case .success(let value):
                    success(value.result)
                }
            }
        }
    }
   
}
