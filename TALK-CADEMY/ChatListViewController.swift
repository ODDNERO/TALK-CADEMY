//
//  ChatListViewController.swift
//  TALK-CADEMY
//
//  Created by NERO on 7/19/24.
//

import UIKit
import SnapKit

struct ChatInfo: Hashable, Identifiable {
    let id = UUID()
    let user: String
    let profile: UIImage
    let message: String
    let date: String
}

final class ChatListViewController: UIViewController {
    enum Section: CaseIterable {
        case main
        case sub
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, ChatInfo>!
    
    private var chatList = [ChatInfo(user: "짱구", profile: UIImage(systemName: "person.circle.fill")!, message: "액션가면 보자", date: "24.01.12"),
                            ChatInfo(user: "맹구", profile: UIImage(systemName: "person.circle.fill")!, message: "새로 모은 돌이야", date: "24.01.12"),
                            ChatInfo(user: "훈이", profile: UIImage(systemName: "person.circle.fill")!, message: "알았어... ㅠㅠ", date: "24.01.11"),
                            ChatInfo(user: "철수", profile: UIImage(systemName: "person.circle.fill")!, message: "오늘은 학원 가야 해서 안 돼", date: "24.01.10"),
                            ChatInfo(user: "유리", profile: UIImage(systemName: "person.circle.fill")!, message: "토끼가 생각나는 하루네", date: "24.01.08")]
    
    private let userSearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "친구 이름을 검색해 보세요"
        searchBar.tintColor = .black
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureDataSource()
        applySnapshot()
    }
}

extension ChatListViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatInfo>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(chatList, toSection: .main)
        snapshot.appendItems([ChatInfo(user: "메모", profile: UIImage(systemName: "square.and.pencil")!, message: "숙제하기", date: "24.01.13")], toSection: .sub)
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatInfo> = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.image = itemIdentifier.profile
            content.imageProperties.tintColor = .systemCyan
            
            content.text = itemIdentifier.user
            content.textProperties.color = .black
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            
            content.secondaryText = itemIdentifier.message
            content.secondaryTextProperties.color = .gray
            content.secondaryTextProperties.font = .systemFont(ofSize: 13)
            
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 5
            cell.contentConfiguration = content
           
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .white
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .systemGray6
        configuration.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

extension ChatListViewController {
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "TALK"
        
        view.addSubview(collectionView)
        view.addSubview(userSearchBar)
        
        userSearchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(userSearchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
