import Foundation

protocol ExchangeViewModelMapperProtocol {
    func map(_ exchanges: [Exchange]) -> [ExchangeViewModel]
}

final class ExchangeViewModelMapper: ExchangeViewModelMapperProtocol {
    func map(_ exchanges: [Exchange]) -> [ExchangeViewModel] {
        exchanges.map { exchange in
            return ExchangeViewModel(
                id: exchange.id,
                name: exchange.name ?? exchange.id,
                website: exchange.website ?? "N/A",
                status: exchange.isActive ? "Active" : "Inactive",
                volumes: exchange.volumes.map(formatVolume)
            )
        }
    }
    
    private func formatVolume(_ volume: ExchangeVolume) -> String {
        let absValue = abs(volume.volume)
        let (shortValue, suffix): (Double, String) = {
            switch absValue {
            case 1_000_000_000...:
                return (volume.volume / 1_000_000_000, "B")
            case 1_000_000...:
                return (volume.volume / 1_000_000, "M")
            case 1_000...:
                return (volume.volume / 1_000, "K")
            default:
                return (volume.volume, "")
            }
        }()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        let formattedVolume = numberFormatter.string(from: NSNumber(value: shortValue)) ?? "\(shortValue)"
        let periodString: String
        switch volume.period {
        case .hour:
            periodString = "per hour"
        case .day:
            periodString = "per day"
        case .month:
            periodString = "per month"
        }
        return "\(formattedVolume)\(suffix) \(volume.currencyCode) (\(periodString))"
    }
}
