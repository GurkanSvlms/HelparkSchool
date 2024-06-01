////
////  CarParkDetailView.swift
////  HelparkIOS
////
////  Created by Hasan Ali Şişeci on 4.02.2024.
////
//
//import SwiftUI
//
//struct CarParkDetailView: View {
//    let carPark: CarParkModel?
//    @StateObject var viewModel = CarParkDetailViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: UI.Spacing.p3) {
//                header
//                carParkName
//                densityAndLastUpdate
//                someInfo
//                priceTable
//                Spacer()
//            }
//        }
//            .scrollIndicators(.hidden)
//            .onAppear(perform: viewAppear)
//            .background { Color.blue.opacity(0.1).ignoresSafeArea() }
//    }
//
//    private var header: some View {
//        HStack(spacing: 0) {
//            Image.locationPinRed
//                .resizable()
//                .frame(width: 24, height: 24)
//                .aspectRatio(contentMode: .fit)
//            Text(viewModel.carParkDetail.district)
//                .font(.popBoldTitle3)
//            Spacer()
//            HStack {
//                Button {
//                    #warning("direction function will be added")
//                } label: {
//                    HPSquareButton(image: Image.detailDirectionImage, showStroke: false, color: .blue, lenght: 40)
//                }
//                Button {
//                    favoriteAction()
//                } label: {
//                    HPSquareButton(image: viewModel.isFavorite ? Image.detailFavImage : Image.detailAddFavImage, showStroke: false, color: .red, lenght: 40)
//                }
//            }
//        }.padding()
//    }
//
//    private var carParkName: some View {
//        Text(viewModel.carParkDetail.parkName)
//            .padding(.horizontal)
//            .multilineTextAlignment(.center)
//            .font(.popMediumHeadline)
//            .minimumScaleFactor(0.01)
//            .frame(width: UI.Size.Screen.width - 32, height: UI.Size.Button.defaultHeight)
//            .backgroundWithShadow()
//    }
//
//    private var densityAndLastUpdate: some View {
//        HStack {
//            intensity
//            Rectangle().frame(width: 2, height: 50)
//                .foregroundStyle(Color.black.opacity(0.2))
//            lastUpdate
//        }
//            .frame(width: UI.Size.Screen.width - 32, height: 80)
//            .backgroundWithShadow()
//    }
//
//    private var intensity: some View {
//        VStack(spacing: UI.Spacing.p1) {
//            HStack {
//                Text(Strings.live).foregroundStyle(viewModel.occupancyColor)
//                    .font(.popRegularSubheadline)
//                Circle().frame(width: 5)
//                    .foregroundStyle(viewModel.occupancyColor)
//                Text(Strings.intensity)
//                    .font(.popRegularSubheadline)
//            }
//            Text("\(viewModel.occupancyCapacity) / \(viewModel.carParkDetail.capacity)")
//                .padding(.horizontal, 15)
//                .padding(.vertical, 5)
//                .background {
//                Capsule().foregroundStyle(viewModel.occupancyColor)
//            }
//        }
//            .fixedSize(horizontal: false, vertical: true)
//            .frame(width: (UI.Size.Screen.width - 60) / 2)
//    }
//
//    private var lastUpdate: some View {
//        VStack {
//            Text(Strings.lastUpdate).font(.popSemiboldSubheadline)
//            Text("\(viewModel.carParkDetail.updateDate)").font(.popRegularSubheadline)
//        }.frame(width: (UI.Size.Screen.width - 60) / 2)
//    }
//
//    private var someInfo: some View {
//        VStack(spacing: UI.Spacing.p2) {
//            Group {
//                Text(Strings.workingHours)
//                    .font(.popRegularBody)
//                Text(carParkOpenText)
//                    .font(.popMediumSubheadline)
//                    .foregroundStyle(openOrClosedColor)
//                Text(viewModel.carParkDetail.workHours)
//                    .font(.popLightSubheadline)
//            }
//            Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
//                .foregroundStyle(Color.black.opacity(0.3))
//            Group {
//                Text(Strings.forDirections)
//                    .font(.popRegularBody)
//                Text(viewModel.carParkDetail.address)
//                    .multilineTextAlignment(.center)
//                    .font(.popLightSubheadline)
//            }
//            Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
//                .foregroundStyle(Color.black.opacity(0.3))
//            Group {
//                Text(Strings.parkType)
//                    .font(.popRegularBody)
//                Text(viewModel.carParkDetail.parkType)
//                    .font(.popLightSubheadline)
//            }
//        }
//            .padding()
//            .frame(width: UI.Size.Screen.width - 32)
//            .backgroundWithShadow()
//    }
//
//    private var priceTable: some View {
//        PriceTableView(priceData: viewModel.carParkDetail.tariff.convertToParkingRateArray())
//            .backgroundWithShadow()
//    }
//
//    private func viewAppear() {
//        guard let carPark = carPark else { return }
//        viewModel.carPark = carPark
//        let id = "\(viewModel.carPark.parkID)"
//        viewModel.fetchCarParkDetail(id: id)
//        viewModel.isFavoriteCheck()
//    }
//
//    private func favoriteAction() {
//        if viewModel.isFavorite {
//            viewModel.removeFromFavorite()
//        } else {
//            viewModel.saveToFavorite()
//        }
//    }
//
//    var openOrClosedColor: Color {
//        carPark?.isOpen == 0 ? .red : .green
//    }
//
//    var carParkOpenText: String {
//        "\(carPark?.isOpen == 0 ? Strings.closed.uppercased() : Strings.open.uppercased())"
//    }
//}
//
//#Preview {
//    CarParkDetailView(carPark: CarParkModel(id: UUID(), parkID: 2034, parkName: "Gülsuyu Metro Yer Altı Otoparkı", latitude: "", longitude: "", capacity: 130, emptyCapacity: 54, workHours: "12.00 - 24.00", parkType: "", freeTime: 1, district: "", isOpen: 0))
//}
