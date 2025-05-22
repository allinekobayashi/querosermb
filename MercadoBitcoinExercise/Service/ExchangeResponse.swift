struct ExchangeResponse: Decodable, Equatable {
    let name: String?
    let id: String
    let website: String?

    // Date information
    let dataStart: String?
    let dataEnd: String?
    
    // Volume information
    let volume1hrsUsd: Double?
    let volume1dayUsd: Double?
    let volume1mthUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, website
        case id = "exchange_id"
        case dataStart = "data_start"
        case dataEnd = "data_end"
        case volume1hrsUsd = "volume_1hrs_usd"
        case volume1dayUsd = "volume_1day_usd"
        case volume1mthUsd = "volume_1mth_usd"
    }
}
