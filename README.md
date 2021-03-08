# test3

Задание 3
Напишите консольное приложение.
1. Оно должно запрашивать никнейм и получать по нему список репозиториев из Github.
2. Полученный список репозиториев выводится на экран терминала в виде списка имен
репозиториев.
3. Для запросов в сеть нужно использовать Alamofire с помощью ​swift package manager.​
4. Для доступа к Github использовать официальный API ​https://developer.github.com/v3/
5. Язык программирования: Swift последней версии

Недостатки:

- Проект не собирается. Пришлось заново генерировать проект.

Листинг с терминала, после клонирования проекта с GitHub:
Last login: Tue Mar  9 00:35:50 on console
artem@iMac-Artem ~ % cd Documents 
artem@iMac-Artem Documents % cd test3
artem@iMac-Artem test3 % swift build
Fetching https://github.com/Alamofire/Alamofire.git
Cloning https://github.com/Alamofire/Alamofire.git
Resolving https://github.com/Alamofire/Alamofire.git at 5.4.1
[40/40] Linking test3
artem@iMac-Artem test3 % swift run
Enter the user name to get the list of repositories and then press enter:
artem-anufriev
reading repositories, please wait..
1 - id: 338159959, name: test1
2 - id: 345817759, name: test2
3 - id: 338181009, name: test3
4 - id: 338157545, name: test4
Total of 4 repositories for the user artem-anufriev.
artem@iMac-Artem test3 % 

- Нет выраженной структуры проекта.
- Константы в коде.
- Странная организация параллельного потока для выполнения запроса. Она работает.
- class Repositories, struct Repo
- - Не соответствие между именем файла и именем класса внутри.
- - Проблема с именами (не понятно что они значат)
- - Проблема с пониманием области видимости переменных.
