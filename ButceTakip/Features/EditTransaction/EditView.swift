//
//  EditView.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 1.08.2026.
//

import SwiftUI
import SwiftData

struct EditView: View {

    @Environment(\.modelContext) private var modelContext

    // Düzenlenecek mevcut işlem
    let transaction: Transaction

    @Binding var isPresented: Bool

    @State private var showValidationAlert = false
    @State private var showSaveError = false
    @State private var saveErrorMessage = ""

    @State private var title: String
    @State private var amount: Double
    @State private var currency: CurrencyType
    @State private var note: String
    @State private var date: Date
    @State private var time: Date
    @State private var category: CategoryType
    @State private var transactionType: TransactionType

    init(
        transaction: Transaction,
        isPresented: Binding<Bool>
    ) {
        self.transaction = transaction
        self._isPresented = isPresented

        // Form açıldığında mevcut işlem bilgilerini State'e aktar
        _title = State(initialValue: transaction.title)
        _amount = State(initialValue: transaction.amount)
        _currency = State(initialValue: transaction.currency)
        _note = State(initialValue: transaction.note)
        _date = State(initialValue: transaction.date)
        _time = State(initialValue: transaction.time)
        _category = State(initialValue: transaction.category)
        _transactionType = State(
            initialValue: transaction.transactionType
        )
    }

    var body: some View {
        VStack(spacing: 0) {

            header

            Divider()

            transactionTypePicker

            Divider()

            formContent

            Divider()

            saveButton
        }
        .padding()
        .alert(
            "Eksik Bilgi",
            isPresented: $showValidationAlert
        ) {
            Button("Tamam", role: .cancel) {}
        } message: {
            Text("Lütfen miktar ve başlık alanlarını doldurun.")
        }
        .alert(
            "Kayıt Hatası",
            isPresented: $showSaveError
        ) {
            Button("Tamam", role: .cancel) {}
        } message: {
            Text(saveErrorMessage)
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Text("İşlem Düzenle")
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()

            Button("Kapat") {
                isPresented = false
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
        .padding(.bottom)
    }

    // MARK: - İşlem Türü
    
    private var transactionTypePicker: some View {
        Picker("İşlem Türü", selection: $transactionType) {
            Text("HARCAMA")
                .tag(TransactionType.EXPENSE)

            Text("GELİR")
                .tag(TransactionType.INCOME)
        }
        .pickerStyle(.segmented)
        .padding(.vertical, 20)
        .animation(.spring(), value: transactionType)
    }

    // MARK: - Form

    private var formContent: some View {
        ScrollView {
            VStack(spacing: 16) {

                TextField(
                    "Miktar",
                    value: $amount,
                    formatter: amountFormatter
                )
                .textFieldStyle(.roundedBorder)

                Picker("Birim", selection: $currency) {
                    ForEach(CurrencyType.allCases, id: \.self) { item in
                        Text(item.rawValue)
                            .tag(item)
                    }
                }

                TextField("Başlık", text: $title)
                    .textFieldStyle(.roundedBorder)

                TextField("Notlar", text: $note, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)

                Picker("Kategori", selection: $category) {
                    ForEach(CategoryType.allCases, id: \.self) { item in
                        Text(item.rawValue)
                            .tag(item)
                    }
                }

                DatePicker(
                    "Tarih",
                    selection: $date,
                    displayedComponents: .date
                )

                DatePicker(
                    "Saat",
                    selection: $time,
                    displayedComponents: .hourAndMinute
                )
            }
            .padding(.vertical)
            .padding(.horizontal, 4)
        }
    }

    // MARK: - Kaydet

    private var saveButton: some View {
        Button {
            updateTransaction()
        } label: {
            Text("Değişiklikleri Kaydet")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .buttonStyle(.borderedProminent)
        .padding(.top)
    }

    // MARK: - Güncelleme

    private func updateTransaction() {
        let trimmedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard amount > 0, !trimmedTitle.isEmpty else {
            showValidationAlert = true
            return
        }

        // Yeni Transaction oluşturmuyoruz.
        // Mevcut Transaction nesnesini güncelliyoruz.
        transaction.title = trimmedTitle
        transaction.amount = amount
        transaction.currency = currency
        transaction.note = note.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        transaction.date = date
        transaction.time = time
        transaction.category = category
        transaction.transactionType = transactionType

        do {
            try modelContext.save()
            isPresented = false
        } catch {
            saveErrorMessage = error.localizedDescription
            showSaveError = true
        }
    }
}
