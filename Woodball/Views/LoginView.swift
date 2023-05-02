//
//  LoginView.swift
//  test
//
//  Created by 醫 on 16/3/2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State var currentUser: UserModel = UserModel(email: "", name: "", rank: 0, membership: false)
    
    let horizontalPadding: CGFloat = 20.0
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var onBoardingState: Int = 0
    
    @State var validEmail: Bool = false
    @State var validPassword: Bool = false
    
    @State var verified: Bool = false
    @State var login: Bool = false
    
    @State var onAlert: Bool = false
    @State var onAlert2: Bool = false
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .bottom),
        removal: .move(edge: .top))
    
    var body: some View {
        
        switch onBoardingState {
        case 0:
            WelcomeView
                .transition(transition)
        case 1:
            EmailView
                .transition(transition)
        case 2:
            ContentView(user: currentUser)
                .navigationBarBackButtonHidden()
                .transition(transition)
        default:
            BlankView
                .transition(transition)
        }
        
    }
}


// MARK: components
extension LoginView {
    
    private var WelcomeView: some View {
        
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack (spacing: 20) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
                        .frame(width: 100)
                        .foregroundColor(.accentColor)

                    
                    VStack (spacing: 10) {
                        Button {
                            withAnimation(.spring()) {
                                nextPage()
                            }
                            
                        } label: {
                                Text("Log in")
                                    .font(.title)
                                    .padding(.horizontal, 50)
                                    .padding(.vertical, 5)
                                    .background {
                                        Rectangle()
                                            .foregroundColor(.accentColor)
                                            .cornerRadius(10)
                                    }
                                    .foregroundColor(.white)
                            }
                        Text("New member?")
                            .font(.subheadline)
                    }
            }
        }
    }
    
    private var EmailView: some View {
        VStack (spacing: 20) {
            Spacer()
            
            if !verified {
                
                Text("What's your registered email?")
                    .font(.title3)
                
                TextField("Type your email here", text: $email)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2.5)
                            .foregroundColor(.mint)
                    }
                    .padding(.horizontal, horizontalPadding)
                    .foregroundColor(.black)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                Button {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        if userVM.checkValidEmail(email: email) {
                            verified = true
                        } else {
                            onAlert.toggle()
                        }
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(checkValidEmail() ? .accentColor : .gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .padding(.horizontal, horizontalPadding)
                        .overlay {
                            Text("VERIFY")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                }
                .disabled(!checkValidEmail())
                .alert("Invalid email", isPresented: $onAlert) {
                    
                }
            }

            
            if verified {
                
                HStack {
                    Text(email)
                        .font(.title3)
                        .bold()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        
                    Spacer()
                    Image(systemName: "checkmark.seal.fill")
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, horizontalPadding + 10.0)
                .foregroundColor(.accentColor)
                .font(.headline)
                
                SecureField("Enter your password", text: $password)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2.5)
                            .foregroundColor(.mint)
                    }
                    .padding(.horizontal, horizontalPadding)
                    .foregroundColor(.black)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                

                Button {
                    guard let user = userVM.loggedIn(email: email, password: password) else { return }
                    currentUser = user
                    
                    if userVM.checkPassword(email: email, password: password) {
                        
                        withAnimation {
                            onBoardingState = 2
                        }
                    } else {
                        onAlert2.toggle()
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(checkValidPassword() ? .accentColor : .gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .padding(.horizontal, horizontalPadding)
                        .overlay {
                            Text("LOGIN")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                }
                .disabled(!checkValidPassword())
                .alert("Wrong password", isPresented: $onAlert2) {
                    
                }

            }
            Spacer()
            Spacer()
        }
        .background(Color(.white))
    
    } // end of EmailView
    
    private var BlankView: some View {
        ZStack {
            Color(.white)
            Text("test")
        }
        
    }
}

// MARK: functions
extension LoginView {
    
    func checkValidEmail() -> Bool {
        
        if email.count > 5 && email.contains("@") {
            validEmail = true
            return true
        }
        return false
    }
    
    func checkValidPassword() -> Bool {
        
        if password.count > 6 {
            validPassword = true
            return true
        }
        return false
    }
    
//    func checkValidPassword(completionHandler: (_ password: String) -> ()) {
//
//        let regex = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9]).{6,}$")
//
//        if regex.evaluate(with: password) {
//            validPassword = true
//        }
//        return regex.evaluate(with: password)
//    }
    
    func nextPage() {
        
        if onBoardingState < 3 {
            withAnimation(.spring()) {
                onBoardingState += 1
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
        .environmentObject(UserViewModel())
        
    }
}
