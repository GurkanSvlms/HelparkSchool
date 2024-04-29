//
//  OnboardingView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 31.08.2023.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    //@AppStorage("showOnbarding") var showOnboarding = true
    @State private var currentPage: Int = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                // İlk gösterim
                OnboardingStepView(imageName: "onboarding_first", description: "Otoparkını Kolayca Bul")
                    .tag(0)

                // İkinci gösterim
                OnboardingStepView(imageName: "onboarding_second", description: "Otoparkın Yoğunluğunu Öğren")
                    .tag(1)

                // Üçüncü gösterim
                OnboardingStepView(imageName: "onboarding_third", description: "Otopark Detaylarını  Öğren", isButtonActive: true)
                    .tag(2)
            }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .background(Color("#449a3"))
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onAppear(perform: viewAppear)
        }
    }

    private func viewAppear() {
        do {
            try HPUserDefaultsManager.shared.setModel(key: .favoriteCarParks, model: [CarParkModel]())
        } catch {
            print(HPUserDefaultsError.encodingFailed.localizedDescription)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
