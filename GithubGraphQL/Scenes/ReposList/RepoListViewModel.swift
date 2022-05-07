import Apollo

protocol RepoListViewModelContract {
  func viewDidLoad()
  func willDisplayCell(index: Int)
}

//MARK: ViewModel class declaration
final class RepoListViewModel {
  //MARK: Facade for simplifying dependency injection
  typealias Dependencies = HasMainQueue & HasGraphQLClient
  //MARK: Shorter name to define the page info type in this context
  typealias CurrentPage = SearchRepositoriesQuery.Data.Search.PageInfo
  
  //MARK: Properties
  private let dependencies: Dependencies
  
  private var repos: [RepositoryDetails] = [] {
    didSet {
      viewController?.updateUI()
    }
  }
  
  private var currentPage: CurrentPage?
  private var currentIndex: Int = 14
  
  private var totalRepos: Int {
    currentIndex + 1
  }
  
  weak var viewController: RepoListDisplaying?

  init(dependencies: Dependencies = DependencyContainer()) {
    self.dependencies = dependencies
  }
}

//MARK: Auxiliar private methods
private extension RepoListViewModel {
  func initialSearch(phrase: String) {
    /*
     example search of a given phrase, using default searching parameters
     */

    self.dependencies.client.searchRepositories(mentioning: phrase) { response in
      switch response {
      case let .failure(error):
        print(error)

      case let .success(results):
        let pageInfo = results.pageInfo
        print("pageInfo: \n")
        print("hasNextPage: \(pageInfo.hasNextPage)")
        print("hasPreviousPage: \(pageInfo.hasPreviousPage)")
        print("startCursor: \(String(describing: pageInfo.startCursor))")
        print("endCursor: \(String(describing: pageInfo.endCursor))")
        print("\n")

        results.repos.forEach { repository in
          print("Name: \(repository.name)")
          print("Path: \(repository.url)")
          print("Owner: \(repository.owner.login)")
          print("avatar: \(repository.owner.avatarUrl)")
          print("Stars: \(repository.stargazers.totalCount)")
          print("\n")
        }
        self.currentPage = results.pageInfo
        self.repos.append(contentsOf: results.repos)
      }
    }
  }
  
  func searchNext() {
    guard let cursor = currentPage?.endCursor else {
      return
    }
    dependencies.client.searchRepositories(mentioning: Constants.searchKey,
                              filter: .after(Cursor(rawValue: cursor))) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case let .failure(error):
        print(error)
      case let .success(results):
        self.currentPage = results.pageInfo
        self.repos.append(contentsOf: results.repos)
      }
    }
  }
}

//MARK: ViewModelContract implementation
extension RepoListViewModel: RepoListViewModelContract {
  func viewDidLoad() {
    initialSearch(phrase: Constants.searchKey)
  }
  
  func willDisplayCell(index: Int) {
    if index >= currentIndex {
      currentIndex += Constants.defaultPageLimit
      searchNext()
    }
  }
}
