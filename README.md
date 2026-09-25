# Figures Mobile App

A modern fintech mobile application built with Flutter, featuring a secure and seamless user experience for managing finances and making local transfers.

## 📱 Features

### 1. Onboarding & Authentication
-   **Splash Screen**: Animated entry with logo.
-   **Onboarding Flow**: 3-step carousel introducing key features.
-   **Login/Registration**: Secure entry points.
-   **PIN Creation**:
    -   **Login PIN**: 4-digit secure pin with optional biometric toggle.
    -   **Transaction PIN**: 6-digit pin for authorizing payments (must be different from Login PIN).
    -   **Custom Keypad**: Secure, in-app numeric keypad.

### 2. Home Dashboard
-   **Profile Header**: User greeting and quick profile access.
-   **Wallet Card**:
    -   Toggleable Balance Visibility (Eye icon).
    -   Displays Account Number and ID.
    -   "Add Money" action.
-   **Quick Actions**: Grid of common tasks (Transfer, Data, Airtime, etc.).
-   **Promotional Banners**: Auto-scrolling carousel of offers.
-   **Bottom Navigation**: Custom navigation bar (Home, Card, Payment, Terminal, Settings).

### 3. Payment & Transfers
-   **Payment Hub**: Grid of payment options (Local Transfer, International, Bills, etc.).
-   **Local Transfer (NGN)**:
    -   **Beneficiaries**: Quick access to saved contacts.
    -   **Recent Transfers**: History of past transactions with status indicators (Success/Failed).
    -   **New Transfer**:
        -   **Dynamic Form**: Input Amount, Select Bank, Enter Account Number.
        -   **Currency Support**: Multi-currency display (NGN, USD, GBP, EUR) with live balances.
        -   **Bank Search**: Searchable list of all Nigerian banks (fetched via API).
        -   **Account Verification**: Real-time validation of account numbers (Mocked).
            -   *Immediate Feedback*: Red error for invalid length.
            -   *Success State*: Green account name upon valid 10-digit entry.
        -   **Validation**: Prevents submission if fields are empty.
    -   **Review Screen**: Confirm transaction details before processing.
        -   Summary of Amount, Fees, and Total.
        -   Wallet and Beneficiary details.
        -   Secure masking of sensitive data.

## 🛠 Tech Stack
-   **Framework**: Flutter (Dart)
-   **Typography**: Google Fonts (**Inter**) for clean, modern readability.
-   **Networking**: `http` package for bank list fetching.
-   **Formatting**: `intl` for currency formatting.
-   **Icons**: Custom assets + Material Icons.

## 🚀 Getting Started

### Prerequisites
-   Flutter SDK installed.
-   Android/iOS Emulator or Physical Device.

### Installation
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/figures-app.git
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```

## 📂 Project Structure
-   `lib/main.dart`: Entry point and Theme config (Inter font).
-   `lib/screens/`: All UI screens (Onboarding, Home, Payment, etc.).
-   `lib/widgets/`: Reusable components (CustomKeypad, ProgressBar, etc.).
-   `assets/images/`: Static image resources.

## 🐛 Troubleshooting
-   **Naira Symbol Missing**: Ensure you are using the `Inter` font (configured in `main.dart`).
-   **Validation Stuck**: Ensure you are typing exactly 10 digits for the mock validation to trigger.

---
*Documentation updated on Jan 11, 2026*
