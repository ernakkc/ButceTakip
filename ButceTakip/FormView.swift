//
//  FormView.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 31.07.2026.
//

import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var showValidationAlert: Bool = false
    
    @State var title: String = ""
    @State var amount: Double = 0.0
    
    @State var currency: CurrencyType = .TL
    @State var note: String = ""
    @State var date: Date = .now
    @State var time: Date = .now
    @State var category: CategoryType = .OTHER
    @State var transactionType: TransactionType = .EXPENSE
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Form Başlığı ve Kapatma Butonu
                HStack {
                    Text("İşlem Ekle")
                        .font(.title2)
                    Spacer()
                    Button("Kapat") {
                        isPresented = false
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.gray)
                }
                .padding()
                
                Divider()
                
                // HARCAMA / GELİR seçme butonları
                Picker("", selection: $transactionType) {
                    Button("HARCAMA", action: { transactionType = .EXPENSE }).tag(TransactionType.EXPENSE)
                    Button("GELİR", action: { transactionType = .INCOME }).tag(TransactionType.INCOME)
                }
                .frame(alignment: .centerLastTextBaseline)
                .padding(20)
                .pickerStyle(.segmented)
                .animation(.spring(), value: transactionType)
                
                // Form içerikleri
                ScrollView {
                    VStack(spacing: 15) {
                        TextField("Miktar", value: $amount, formatter: amountFormatter)
                            
                            
                        Picker(selection: $currency, label: Text("Birim")) {
                            ForEach(CurrencyType.allCases, id: \.self) {Text($0.rawValue)}
                        }
                        
                        TextField("Başlık", text: $title)
                        TextField("Notlar", text: $note)
                        
                        Picker(selection: $category, label: Text("Kategori")) {
                            ForEach(CategoryType.allCases, id: \.self) {Text($0.rawValue)}
                        }
                        
                        DatePicker("Tarih", selection: $date, displayedComponents: .date).datePickerStyle(.automatic)
                        DatePicker("Saat", selection: $time, displayedComponents: .hourAndMinute).datePickerStyle(.automatic)
                        
                        
                    }
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 16)
                }
                
                // Kaydet Butonu
                .padding()
                Divider()
                Button("Kaydet", action: {
                    if amount.isZero || title.isEmpty || note.isEmpty {
                        showValidationAlert = true
                        return
                    }
                    self.isPresented = false
                    
                    let new = Transaction(title: title, amount: amount, currency: currency, note: note, date: date, time: time, category: category, transactionType: transactionType)
                    modelContext.insert(new)
                    
                })
                .alert("Tüm Boşlukları Doldurunuz !", isPresented: $showValidationAlert) {
                    Button("Tamam", role: .cancel) {}
                }
            }
        }
        .padding()
    }
}



#Preview("FormView Preview") {
    // Using a constant binding for preview purposes
    FormView(isPresented: .constant(true))
}

