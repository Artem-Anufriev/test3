import Foundation
import Alamofire

var semaphore = DispatchSemaphore(value: 0)
var repositories = repositoriesArray()

private func request(forURL url : URL, completion: @escaping(repositoriesArray) -> Void) {
    AF.request(url).validate().responseDecodable(of: repositoriesArray.self, queue: .global()) { response in
        switch response.result {
        case .success:
            completion(response.value ?? [])
            if let links = response.response?.headers.dictionary["Link"],
               let nextLink = links.split(separator:Character(",")).first(where: { $0.contains("rel=\"next\"")}) {
                guard let beginIndex = nextLink.firstIndex(of: Character("<")),
                      let endIndex = nextLink.firstIndex(of: Character(">")),
                      let nextUrl = URL(string: String(nextLink[nextLink.index(after: beginIndex)..<endIndex])) else {
                    return
                }
                request(forURL: nextUrl, completion: completion)
            } else {
                semaphore.signal()
            }
        case let .failure(error):
            if let errorDescription = error.errorDescription {
                print(errorDescription)
                semaphore.signal()
            }
        }
    }
}

print("Enter the user name to get the list of repositories and then press enter:")
guard let userName = readLine(),
      !userName.isEmpty,
      let url = URL(string: "https://api.github.com/users/\(userName)/repos?per_page=100&page=1") else
{
    print("invalid username.")
    exit(0)
}

request(forURL: url) { repos in
    repositories.append(contentsOf: repos)
}

semaphore.wait()

if repositories.isEmpty {
    print("There are no repositories for the user \(userName)..")
} else {
    repositories.forEach { repo in
        print("id: \(repo.id), name: \(repo.name)")
    }
    print("Total of \(repositories.count) repositories for the user \(userName).")
}
