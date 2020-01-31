//
//  ViewController.swift
//  PodCast
//
//  Created by Vitor Mendes on 27/12/18.
//  Copyright © 2018 Vitor Mendes. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Nuke
import GoogleMobileAds

class PlayerViewController: CustomViewController,GADBannerViewDelegate  {
    
    var id = ""
    var podCastData: Podcast!
    
    var audioPlayerView = AudioPlayerView()
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primary
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
        loadData()
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
    func loadData() {
        startLoad()
        PodCastListService.getBestPodById(id: id) { resultPodCast in
            if SavedPodDAO.get().contains(where: { ($0.id == self.id && $0.download == true) } ) {
                let podCastDataSaved = SavedPodDAO.get().filter({ ($0.id == self.id && $0.download == true) }).first
                self.podCastData = Podcast(audio_length: Int(truncating: NSNumber(value: podCastDataSaved!.audio_length)),
                                           image: podCastDataSaved?.icon,
                                           title: podCastDataSaved?.title,
                                           listennotes_edit_url: nil,
                                           explicit_content: nil,
                                           audio: podCastDataSaved?.url,
                                           pub_date_ms: nil,
                                           podcast: nil,
                                           description: podCastDataSaved?.descriptionPod,
                                           id: podCastDataSaved?.id,
                                           thumbnail: podCastDataSaved?.icon,
                                           listennotes_url: nil,
                                           maybe_audio_invalid: nil,
                                           isDownload: true)
                self.setupAd()
                self.setupViews()
            }
            else if resultPodCast != nil {
                self.podCastData = resultPodCast
                self.setupAd()
                self.setupViews()
            }
            self.stopLoad()
        }
    }
    
    func setupViews() {
        PlayerController.inicialize(podCastData: podCastData)
        audioPlayerView = PlayerController.audioPlayerView
        view.addSubview(audioPlayerView)
        audioPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        if Ad.isPremium {
            audioPlayerView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            audioPlayerView.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        }
        audioPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        audioPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupAd() {
        
        if Ad.isPremium {
            return
        }
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = Ad.adBannerPlayer
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
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
    
}
