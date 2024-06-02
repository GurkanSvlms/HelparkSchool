//
//  SplashView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 30.08.2023.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var coreDataManager = CoreDataManager()
    
    @State private var isLocation = true
    @State private var showPopup = false
    
    private var willEnterForegroundPublisher = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("helpark_title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.trailing, .leading], 20)
                Spacer()
                Text("Developed By Gürkan Sevilmiş")
                    .foregroundColor(Color("#3c7484"))
                    .padding(10)
            }
            if !isLocation {
                PopupOneButton(
                    showPopup: .constant(!isLocation),
                    title: "Konum",
                    subtitle: "Konum olmadan uygulamamıza giriş yapılamamaktadır.",
                    buttonText: "Ayarları Aç"
                ) {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
            }
        }
        .onAppear() {
            checkLocationAndNavigate()
        }
        .onReceive(willEnterForegroundPublisher) { _ in
            checkLocationAndNavigate()
        }
        .statusBarHidden(true)
        .navigationBarHidden(true)
    }
    
    private func checkLocationAndNavigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLocation = locationManager.isLocationEnabled
            if isLocation {
                if coreDataManager.getOnboardingStatus() {
                    navigationManager.navigate(.home(.onboarding))
                } else {
                    navigationManager.navigate(.home(.login))
                }
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
