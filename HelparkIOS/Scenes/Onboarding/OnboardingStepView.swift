//
//  OnboardingStepView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 8.09.2023.
//

import SwiftUI

struct OnboardingStepView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject var coreDataManager = CoreDataManager()
    var imageName: String
    var description: String
    var isButtonActive: Bool = false

    var body: some View {

        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)

            Text(description)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 390, height: 200)
                .foregroundColor(.white)
                .font(.title)

            if isButtonActive {
                Button(action: {
                    coreDataManager.setOnboardingStatus(isFirstTime: false)
                    navigationManager.navigate(.home(.home))
                }) {
                    Text("Başla")
                        .font(.title)
                        .padding()
                        .foregroundColor(Color("#449a3"))
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
            .padding()
            .background(Color("#449a3"))
            .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStepView(imageName: "heart.fill", description: "Otoparkını Kolayca Bul")
    }
}
