These were my choices during this challenge:

Architecture:

- As required, I used MVVM but included the Coordinator Design Pattern, which allows to navigate to other scenes by having access to the navigationController.

User Interface:

- I opted to use UIKit with ViewCode, since interface builders bring much more complexity when having to make changes.
- In order to avoid crashings, I put all the ViewCode pipeline(hierarchy, constraint setup and additional configurations) into a protocol that is called once the view is initialized.

Design Patterns:

- Coordinator: described above.
- Facade with Dependency Injection: In order to provide the necessary dependencies via a single place in a module, I defined a class that holds all dependencies(Dependency Container) and each one is added as required by a protocol `HasTheDependency`. When a class demands some specific dependencies, I define the requirements via a typealias for a type that implements some dependencies requirement protocol. This way, I only bring the specific tools for the class instead of the entire box.
- Delegation: The layers inside a MVVM scene communicate with each other via delegate, not having access to concrete types. ViewModel sends events to the ViewController and Coordinator via a delegation protocol
- Factory: Created an enum with a method to instantiate each layer of a scene and bind them together.

Scenes:

- RepoList: Displays a list of repos
- RepoDetails: Displays details for a specific repo

Pagination logic:

- Firstly, a network call is made to fetch the first page of 15 elements. When the user achieves the bottom, it's checked if there is still a cursor and then fetches the next page, in order to perform a query only if necessary.

External libraries:

- SnapKit: Helped me to define constraints in just a few lines of code
- SDWebImage: Saves already fetched images from URLs in a cache

What would I have done if had more time?

- Separated UITableViewDataSource protocol implementation in a another class different from ViewController
- Implement more reusable components and refine UI
- Implement a search bar for searching specific repos
- Test error cases

