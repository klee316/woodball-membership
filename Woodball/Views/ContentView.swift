//
//  ContentView.swift
//  test
//
//  Created by 醫 on 13/3/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Int = 0
    @State var user: UserModel = UserModel(email: "master@gmail.com", name: "Master Yoda", rank: 1, membership: true)
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        ZStack (alignment: .top) {
            
            LinearGradient(colors: [.mint, .green.opacity(0.8), .white],
                           startPoint: .top,
                           endPoint: .bottom)
            .frame(height: 300)
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                MemberView(user: $user)
                
                NewsView()
                
                UsefulLinksView() //end of News
                
            }
        }
    }
}

    
struct MemberView: View {
    
    @Binding var user: UserModel
    
    var body: some View {
        
        HStack(alignment: .top) {
            Circle()
                .frame(width: 80, height: 120)
                .padding(10)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                Spacer()
                Text(user.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .bold()
                Spacer()
                HStack (alignment: .top) {
                    VStack (alignment: .leading) {
                        Text("RANK")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .italic()
                            .bold()
                        Spacer()
                        Image(systemName: "\(String(user.rank)).circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            .foregroundColor(.white)
//                        Text(String(user.rank))
//                            .font(.title)
//                            .bold()
//                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack (alignment: .leading) {
                        Text("MEMBERSHIP")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .italic()
                            .bold()
                        Spacer()
                        HStack {
                            Image(systemName: user.membership ? "checkmark.seal.fill" : "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                            Text("valid til 2023")
                                .font(.callout)
                                .bold()
                            
                            
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                    Spacer()
                }
                .frame(height: 45)
                Spacer()
                
            }
            .padding(.vertical, 25)
            .frame(height: 180)
            
        }
        .padding()
        .frame(height: 180)
    }
    
}


struct NewsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("News")
                .font(.title)
                .italic()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 0) {
                    ForEach(0 ..< 5) { index in
                        Rectangle()
                            .frame(width: 280, height: 200)
                            .cornerRadius(25)
                            .foregroundColor(.gray)
                            .opacity(0.25)
                            .padding(.leading, 15)
                    }
                    Rectangle()
                        .frame(width: 15)
                        .foregroundColor(.white)
                }

            } //end of News
        }
    }
}

struct UsefulLinksView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Useful Links")
                .font(.title)
                .italic()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 0) {
                    ForEach(0 ..< 5) { index in
                        Rectangle()
                            .frame(width: 280, height: 200)
                            .cornerRadius(25)
                            .foregroundColor(.gray)
                            .opacity(0.25)
                            .padding(.leading, 15)
                    }
                    Rectangle()
                        .frame(width: 15)
                        .foregroundColor(.white)
                }
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
    }
}
