//
//  Repositories.swift
//  test3
//
//  Created by Artem on 25.01.2021.
//

import Foundation
import Alamofire

class Repositories {
    
    struct Repo: Decodable {
        let id: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
        }
    }
    
    typealias repositoriesArray = [Repo]
    
    private var repositories: repositoriesArray
    private var userName: String
    private var url: String
    
    init(forUser userName: String) {
        self.userName = userName
        self.repositories = []
        self.url = "https://api.github.com/users/\(userName)/repos?per_page=100&page="
    }
    
    public func print() {
        if !repositories.isEmpty {
            for index in repositories.indices {
                Swift.print("\(index + 1) - id: \(repositories[index].id), name: \(repositories[index].name)")
            }
            Swift.print("Total of \(repositories.count) repositories for the user \(userName).")
        } else {
            Swift.print("There are no repositories for the user \(userName)..")
        }
    }
    
    public func request(forPage page : Int, semaphore mySemaphore : DispatchSemaphore) {
        Swift.print("request \(page)")
        AF.request(url + String(page)).validate().responseDecodable(of: repositoriesArray.self, queue: .global()) { [self] (response) in
            guard let returnedRepos = response.value, !returnedRepos.isEmpty else {
                mySemaphore.signal()
                return
            }
            repositories.append(contentsOf: returnedRepos)
            request(forPage: page + 1,semaphore: mySemaphore)
        }
    }
}



