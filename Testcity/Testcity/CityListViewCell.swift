//
//  CityListViewCell.swift
//  Testcity
//
//  Created by Brunya on 02.04.2021.
//

import UIKit

final class CityListViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .body)
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .label
        return $0
    }(UILabel(frame: .zero))
    private let iconImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "sun.dust.fill")!.withRenderingMode(.alwaysOriginal)
        return $0
    }(UIImageView(frame: .zero))
    private let pressureLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .headline)
      //  $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel(frame: .zero))
    private let humidityLabel: UILabel  = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .headline)
      //  $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel(frame: .zero))
    private let windSpeedLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .headline)
       // $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel(frame: .zero))
    private let feelsLikeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .headline)
      //  $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel(frame: .zero))
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 8.0
        $0.alignment = .firstBaseline
        $0.distribution = .fill
        return $0
    }(UIStackView(frame: .zero))
    
    func configure(name: String, pressure: Int, humidity: Int, wind: Double, feelsLike: Int) {
        nameLabel.text = name
        pressureLabel.text = "\(pressure) мм/с"
        humidityLabel.text = "\(humidity) %"
        windSpeedLabel.text = "\(wind) м/с"
        feelsLikeLabel.text = "\(feelsLike) ℃"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupAppearance()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension CityListViewCell {
    private func setupConstraints() {
        [
            nameLabel,
            iconImageView,
            pressureLabel,
            humidityLabel,
            windSpeedLabel,
            feelsLikeLabel
        ].forEach {
            stackView.addArrangedSubview($0)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)
        
        contentView.addSubview(stackView)
        
        [pressureLabel,
         humidityLabel,
         windSpeedLabel,
         feelsLikeLabel].forEach {
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
         }
        
        
        NSLayoutConstraint.activate([
//            pressureLabel.widthAnchor.constraint(equalTo: humidityLabel.widthAnchor),
//            humidityLabel.widthAnchor.constraint(equalTo: windSpeedLabel.widthAnchor),
//            windSpeedLabel.widthAnchor.constraint(equalTo: feelsLikeLabel.widthAnchor),
            
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension CityListViewCell {
    private func setupAppearance() {
        contentView.backgroundColor = .systemBackground
    }
}


// | ******* <-> *** |
