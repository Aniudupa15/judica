# judica

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Judica is an innovative legal-tech project aimed at simplifying access to legal information for different types of users. It incorporates a conversational chatbot that provides legal insights tailored to the needs of common citizens, advocates, and police officers.

# NOTE: Contents under this note is still in progress DO NOT REFER ANYTHING BELOW THIS LINE

# Key Features:

  ## Legal Information Chatbot

    * Offers general legal information to common users.
    * Uses natural language processing (NLP) to simplify complex legal terms.
    * Covers various topics including civil rights, criminal law, property disputes, and more.

  ## Bail Reckoner (for Advocates)

    * Assesses bail eligibility for undertrial convicts.
    * Provides legal precedents and eligibility criteria based on relevant laws and judgments.
    * Designed to save time by automating preliminary bail analysis.

  ## FIR Filing Assistance (for Police Officers)

    * Streamlines the creation of First Information Reports (FIRs).
    * Generates FIRs in PDF format with crime-specific legal references.
    * Offers contextual legal information to ensure accurate documentation.

# Table of Contents

  - Getting Started
  - Features
  - Installation
  - Usage
    - For Common Users
    - For Advocates
    - For Police Officers
  - Contributing

# Getting Started

To begin using Judica, clone the repository and follow the setup instructions below.

## Prerequisites
  - Python 3.8+
  - pip
  - Firebase
  - Dependencies (listed in requirements.txt)

## Features

  ### 1. Legal Information Chatbot
  * **Target Users:** Common citizens
  * *Capabilities:*
    * Provide easy-to-understand legal guidance.
    * Offer summaries of laws, legal rights, and procedural information.
  
  ### 2. Bail Reckoner (Advocates)
  * *Functionality:*
    * Analyze bail eligibility based on inputs like charges, nature of crime, and prior convictions.
    * Reference case laws and precedents dynamically.
  
  ### 3. FIR Filing Assistance (Police Officers)
  * *Functionality:*
    * Formulates FIRs using user inputs such as crime details, suspect information, and evidence descriptions.
    * Generates legally compliant PDFs for record-keeping and judicial use.

## Installation

### Clone the Repository:
```
$ git clone https://github.com/yourusername/judica.git
$ cd judica
```

### Install Dependencies:
```
$ pip install -r requirements.txt
```

### Set Up Database:

Ensure `Firebase` is running on your system.
Update the `config.py` file with your `Firebase URI` and `database name`.

Run the Application:
```
$ python app.py
```

## Usage
### For Common Users
  * Interact with the chatbot by typing questions in natural language.
  * **Example:**
    * What are my rights as a tenant?
    * How can I file a consumer complaint?

### For Advocates
  * Access the Bail Reckoner feature by selecting the relevant mode in the chatbot interface.
  * **Input details such as:**
    * Nature of the offense
    * Background of the accused
    * Any special circumstances

### For Police Officers
  * Use the FIR Filing feature to draft FIRs.
  * **Input key details such as:**
    * Type of crime
    * Incident date and location
    * Suspect and witness details

## Contributing
  
We welcome contributions to improve Judica!

### Fork the repository.

* Create a feature branch:
```
$ git checkout -b feature-name
```

* Commit your changes and push them:
```
$ git commit -m "Description of changes"
$ git push origin feature-name
```
Create a pull request.

### Contact
For further queries, reach out to:

* Email: support@judica.com
* Website: Judica Official Site
