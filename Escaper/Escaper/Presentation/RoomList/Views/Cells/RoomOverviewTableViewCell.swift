//
//  RoomOverviewCollectionViewCell.swift
//  Escaper
//
//  Created by 최완식 on 2021/11/04.
//

import UIKit

final class RoomOverviewTableViewCell: UITableViewCell {
    static let identifier = String(describing: RoomOverviewTableViewCell.self)

    enum Constant {
        static let cornerRadius = CGFloat(20)
        static let verticalSpace = CGFloat(5)
        static let horizontalSpace = CGFloat(20)
    }

    private let genreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorPalette.skullLightWhite.name)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.lineBreakMode = .byCharWrapping
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    private let ratingContainerView = RatingContainerView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }

    func update(_ room: Room) {
        self.genreImageView.image = UIImage(named: room.genres.first!.previewImageAssetName)
        self.titleLabel.text = room.name
        self.ratingContainerView.update(level: room.level, satisfaction: room.satisfaction)
    }

    override func prepareForReuse() {
        self.genreImageView.image = nil
        self.titleLabel.text = ""
        self.ratingContainerView.prepareForReuse()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.genreImageView.layer.cornerRadius = self.genreImageView.bounds.width/2
        self.contentView.layer.cornerRadius = Constant.cornerRadius
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: Constant.verticalSpace, left: Constant.horizontalSpace, bottom: Constant.verticalSpace, right: Constant.horizontalSpace))
    }
}

private extension RoomOverviewTableViewCell {
    func configure() {
        self.configureCell()
        self.configureGenreImageViewLayout()
        self.configureTitleLabelLayout()
        self.configureRatingContainerViewLayout()
    }

    func configureCell() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        self.selectedBackgroundView = bgColorView
        self.backgroundColor = .clear
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor(named: ColorPalette.gloomyBrown.name)
    }

    func configureGenreImageViewLayout() {
        self.genreImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.genreImageView)
        NSLayoutConstraint.activate([
            self.genreImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.genreImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.genreImageView.heightAnchor.constraint(equalToConstant: 40),
            self.genreImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureTitleLabelLayout() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.genreImageView.trailingAnchor, constant: 10),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configureRatingContainerViewLayout() {
        self.ratingContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.ratingContainerView)
        NSLayoutConstraint.activate([
            self.ratingContainerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.ratingContainerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.ratingContainerView.heightAnchor.constraint(equalToConstant: 30),
            self.ratingContainerView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}