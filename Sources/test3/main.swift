import Foundation
import Alamofire

print("Enter the user name to get the list of repositories and then press enter:")
var userName: String = readLine()!

var repositories = Repositories(forUser: userName)
// Store a reference to the current run loop
var runLoop = CFRunLoopGetCurrent()
repositories.request(forPage: 1)

// Start run loop after work has been started
print("reading repositories, please wait..")
CFRunLoopRun()
repositories.print()

exit(EXIT_SUCCESS)
