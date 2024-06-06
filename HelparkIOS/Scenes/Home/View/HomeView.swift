//
//  HomeView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 31.08.2023.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            mapView
            VStack {
                ProfileCardView()
                Spacer()
                homeButtons
            }
            .onAppear {
                if let userLocation = locationManager.userLocation {
                    viewModel.fetchParksByRadius(district: "a", lat: String(userLocation.latitude), lng: String(userLocation.longitude), radius: 7.0)
                } else {
                    viewModel.fetchParksByRadius(district: "a", lat: "40.9609", lng: "29.1904", radius: 7.0)
                }
            }
            loadingView
        }
        
        .sheet(isPresented: $viewModel.showDetailCard, content: {
            CarParkDetailView(homeViewModel: viewModel, carPark: viewModel.selectedCarPark ?? .defaultCarPark)
                .presentationDetents([.height(235), .large])
                .topAligned()
            
        })
        .sheet(isPresented: $viewModel.showSearchSheet, content: {
            SearchView(viewModel: viewModel)
                .topAligned()
            
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    private var mapView: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, userTrackingMode: .none, annotationItems: viewModel.carParkList) { carPark in
            MapAnnotation(coordinate: carPark.coordinate) {
                ParkAnnotationView(isTapped: carPark.id == viewModel.lastTappedParkID, title: carPark.parkName)
                    .onTapGesture {
                    tapPinAction(carPark)
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }

    private var homeButtons: some View {
        HStack {
            Spacer()
            VStack {
                
                Button {
                    viewModel.showSearchSheet = true
                } label: {
                    HPSquareButton(image: Image("search"))
                }
                
                Button {
                    tapMyLocationAction()
                } label: {
                    HPSquareButton(image: Image("myLocation"))
                }
            }.padding()
        }
    }

    private var loadingView: some View {
        ZStack {
            if viewModel.isLoading {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .ignoresSafeArea()
                    .opacity(0.8)
                LottieView()
            }
        }
    }

    private func tapPinAction(_ carPark: CarParkModel) {
        if viewModel.lastTappedParkID != 0 && viewModel.lastTappedParkID == carPark.id {
            viewModel.lastTappedParkID = 0
        } else {
            viewModel.selectedCarPark = carPark
            viewModel.showDetailCard = true
            viewModel.lastTappedParkID = carPark.id
        }
    }

    private func tapMyLocationAction() {
        DispatchQueue.main.async {
            if let userLocation = self.locationManager.userLocation {
                withAnimation {
                    self.locationManager.region = MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
