//
//  Config.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import StoreKit
import GoogleMobileAds

class Config: UIViewController,ListUpdateDelegate {
    
    var headerView = HeaderView()
    var userInfo: UserInfo!
    
    var bannerView: GADBannerView!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DescriptionConfigTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SingleButtonTableViewCell.self, forCellReuseIdentifier: "cellSingleButton")
        tableView.register(RemoveAdTableViewCell.self, forCellReuseIdentifier: "cellRemoveAdButton")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.primary
        tableView.backgroundColor = UIColor.primary
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        setupAd()
        setupViews()
        loadData()
    }
    
    func setupViews() {
        
        headerView.titleLabel.text = R.string.localizable.configuracoes()
        
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
    }
    
    func setupAd() {
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = Ad.adBannerConfig
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bannerView)
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bannerView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func loadData() {
        userInfo = UserInfoDAO.get().first
        tableView.reloadData()
    }
    
}

extension Config: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DescriptionConfigTableViewCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.titleLabel.text = R.string.localizable.localizacaoIndication() + " " + (userInfo.locationdescription ?? "")
            cell.setup()
            return cell
        }
//        else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DescriptionConfigTableViewCell
//            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
//            cell.titleLabel.text = R.string.localizable.idiomaIndication() + " " + (userInfo.language ?? "")
//            cell.setup()
//            return cell
//        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DescriptionConfigTableViewCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.titleLabel.text = R.string.localizable.sharePodCat()
            cell.setup()
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DescriptionConfigTableViewCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.titleLabel.text = R.string.localizable.avalieNos()
            cell.setup()
            return cell
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DescriptionConfigTableViewCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.titleLabel.text = R.string.localizable.sobre()
            cell.setup()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSingleButton") as! SingleButtonTableViewCell
            cell.clearDataDelegate = self
            cell.setup()
            return cell
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRemoveAdButton") as! RemoveAdTableViewCell
//        cell.removeAdDelegate = self
//        cell.setup()
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
           let country = CountryListViewController()
           country.delegate = self
           let countryViewController = UINavigationController(rootViewController: country)
           countryViewController.modalPresentationStyle = .overFullScreen
           present(countryViewController, animated: true)
        }
//        else if indexPath.row == 1 {
//            let language = LanguageListViewController()
//            language.delegate = self
//            let languageListViewController = UINavigationController(rootViewController: language)
//            present(languageListViewController, animated: true)
//        }
        else if indexPath.row == 1 {
            let shareText = R.string.localizable.downloadText() + " https://apps.apple.com/br/app/id/1474413697"
            let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            activityViewController.excludedActivityTypes = [.airDrop]
            
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                popoverController.sourceView = self.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }
            activityViewController.modalPresentationStyle = .overFullScreen
            self.present(activityViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 2 {
            SKStoreReviewController.requestReview()
        }
        else if indexPath.row == 3 {
            let about = AboutViewController()
            about.delegate = self
            let aboutViewController = UINavigationController(rootViewController: about)
            aboutViewController.modalPresentationStyle = .overFullScreen
            present(aboutViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}

extension Config: ClearDataDelegate {
    
    func performClearData() {
        let pods = SavedPodDAO.get()
        
        for element in pods {
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(element.url ?? "")
            debugPrint(destinationUrl)
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                do {
                    try FileManager.default.removeItem(at: destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        SavedPodDAO.deleteAll()
        QueueDAO.deleteAll()
        AplicationUtil.performAlert(title: R.string.localizable.sucess(), description: R.string.localizable.removeDataSucessMessage())
    }
}

extension Config: GADBannerViewDelegate{
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
}
