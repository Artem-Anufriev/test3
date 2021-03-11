import Foundation

print("Enter the user name to get the list of repositories and then press enter:")
var userName: String = readLine()!
var repositories = Repositories(forUser: userName)
var semaphore = DispatchSemaphore(value: 0)
repositories.request(forPage: 1, semaphore: semaphore)
semaphore.wait()
repositories.print()
