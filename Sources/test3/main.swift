import Foundation
import Alamofire

print("Enter the user name to get the list of repositories and then press enter:")
let userName: String = readLine()!

var repos = Repositories(forUser: userName)
// Store a reference to the current run loop
let runLoop = CFRunLoopGetCurrent()
repos.request(forPage: 1)

// Start run loop after work has been started
print("reading repositories, please wait..")
CFRunLoopRun()
repos.print()

exit(EXIT_SUCCESS)
