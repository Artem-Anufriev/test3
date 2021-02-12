//
//  Repo.swift
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
    
    typealias reposArray = [Repo]
    
    private var repos: reposArray
    private var userName: String
    private var url: String
    
    init(forUser user: String) {
        userName = user
        repos = []
        url = "https://api.github.com/users/\(userName)/repos?per_page=50&page="
    }
    
    public func print() {
        if !repos.isEmpty {
            for index in repos.indices {
                Swift.print("\(index + 1) - id: \(repos[index].id), name: \(repos[index].name)")
            }
            Swift.print("Total of \(repos.count) repositories for the user \(userName).")
        } else {
            Swift.print("There are no repositories for the user \(userName)..")
        }
    }
    
    public func request(forPage page : Int) {
        AF.request(url + String(page)).validate().responseDecodable(of: reposArray.self) { [self] (response) in
            //Swift.print("Response: \(response.request!) - \(response)")
            guard let returnedRepos = response.value, !returnedRepos.isEmpty else {
                CFRunLoopStop(runLoop)
                return
            }
            repos.append(contentsOf: returnedRepos)
            request(forPage: page + 1)
        }
    }
}



