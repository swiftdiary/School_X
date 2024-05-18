//
//  TodayView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct TodayView: View {
    @Environment(AppNavigation.self) private var navigation
    @AppStorage("authentication_token") private var authenticationToken: String = ""
    var body: some View {
        @Bindable var navigation = navigation
        VStack {
            ScrollView {
                NavigationLink(value: NavigationOption.tips) {
                    RoundedRectangle(cornerRadius: 12.0)
                        .fill(Color.orange.gradient)
                        .stroke(.white.opacity(0.5),lineWidth: 3)
                        .frame(height: 200)
                        .overlay(content: {
                            HStack {
                                Text("Tips")
                                Image(systemName: "lightbulb.min.fill")
                            }
                            .font(.largeTitle.bold())
                            .foregroundStyle(.background)
                        })
                        .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("Top")
                        .font(.title.bold())
                    Rectangle()
                        .frame(height: 2)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], content: {
                            ForEach(0..<50) { x in
                                HStack {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(Color.accentColor.gradient)
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading) {
                                        Text("Top Subject")
                                            .font(.title2.bold())
                                        Text("Subtitle to it")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(width: 250)
                            }
                        })
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle("Today")
        .onAppear(perform: {
            print("TOKEN: \(authenticationToken)")
        })
        .task {
            do {
                let manager = APIManager()
                guard let url = URL(string: APIRequestUrl.contents.urlString) else {
                    print("No url")
                    return
                }
                let data: [String: String] = try await manager.get(url: url)
                
                print(data)
            } catch {
                print("error, \(error)")
            }
        }
    }
}

#Preview {
    @State var navigation = AppNavigation()
    
    return TodayView()
        .environment(navigation)
}
