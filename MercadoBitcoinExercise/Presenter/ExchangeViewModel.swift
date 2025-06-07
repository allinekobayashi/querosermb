struct ExchangeViewModel: Identifiable, Equatable {
    let id: String
    let name: String
    let website: String?
    let status: String
    let volumes: [String]
}

struct ExchangeListViewModel: Equatable {
    let lastUpdated: String
    let exchanges: [ExchangeViewModel]
}
