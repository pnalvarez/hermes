import Apollo

protocol RepoListViewModelContract {
  var totalRepos: Int { get }
  var reposInterface: [RepositoryDetails] { get }
  func viewDidLoad()
  func willDisplayCell(index: Int)
  func didSelectCell(index: Int)
}

//MARK: ViewModel class declaration
final class RepoListViewModel {
  //MARK: Facade for simplifying dependency injection
  typealias Dependencies = HasGraphQLClient
  //MARK: Shorter name to define the page info type in this context
  typealias CurrentPage = SearchRepositoriesQuery.Data.Search.PageInfo
  
  //MARK: Properties
  private let dependencies: Dependencies
  
  private var repos: [RepositoryDetails] = []
  
  private var currentPage: CurrentPage?
  
  private var currentIndex: Int = -1
  
  var totalRepos: Int {
    currentIndex + 1
  }
  
  var reposInterface: [RepositoryDetails] {
    repos
  }
  
  weak var viewController: RepoListDisplaying?
  private let coordinator: RepoListCoordinatorContract
  
  init(dependencies: Dependencies = DependencyContainer(),
       coordinator: RepoListCoordinatorContract) {
    self.dependencies = dependencies
    self.coordinator = coordinator
  }
}

//MARK: Auxiliar private methods
private extension RepoListViewModel {
  func initialSearch(phrase: String) {
    /*
     example search of a given phrase, using default searching parameters
     */
    viewController?.displayLoading(true)
    dependencies.client.searchRepositories(mentioning: phrase,
                                           cachePolicy: .fetchIgnoringCacheData) { [weak self] response in
      guard let self = self else { return }
      self.viewController?.displayLoading(false)
      switch response {
      case let .failure(error):
        self.viewController?.displayError(error.localizedDescription)
        
      case let .success(results):
        self.currentPage = results.pageInfo
        self.repos.append(contentsOf: results.repos)
        self.currentIndex += results.repos.count
        self.viewController?.updateUI()
      }
    }
  }
  
  func searchNext() {
    guard let cursor = currentPage?.endCursor else {
      return
    }
    dependencies.client.searchRepositories(mentioning: Constants.searchKey,
                                           filter: .after(Cursor(rawValue: cursor)),
                                           cachePolicy: .fetchIgnoringCacheData) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case let .failure(error):
        self.viewController?.displayError(error.localizedDescription)
      case let .success(results):
        self.currentPage = results.pageInfo
        self.repos.append(contentsOf: results.repos)
        self.viewController?.updateUI()
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
      viewController?.updateUI()
      searchNext()
    }
  }
  
  func didSelectCell(index: Int) {
    coordinator.routeToDetails(repositoryDetails: repos[index])
  }
}
