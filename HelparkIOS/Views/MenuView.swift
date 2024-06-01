//
//  MenuView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.01.2024.
//

import SwiftUI

enum NavigationDestination {
    case favorites
    case agreement
    case about
    case rate
}

struct MenuModel: Identifiable, Equatable, Hashable {
    static func == (lhs: MenuModel, rhs: MenuModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID().uuidString
    var title: String
    var iconName: String
    var isLastItem: Bool = false
    var action: NavigationDestination?
}


struct MenuView: View {
    let item: MenuModel
    let isLastItem: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                if !item.iconName.isEmpty {
                    Image(item.iconName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("#3c7484"))
                }
                   
                Text(item.title)
                    .foregroundColor(Color("#3c7484"))
                    .multilineTextAlignment(.leading)
                Spacer()
                Image("right_arrow")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color("#3c7484"))
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(item: MenuModel(title: "Sample Item", iconName: "myLocation", isLastItem: false, action: nil), isLastItem: false)
    }
}
