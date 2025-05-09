## How to Sign a PowerShell Script (a Step-By-Step Guide)

### step-1

### PowerShell script signing requires the administrator’s permission.

* Select Windows PowerShell App.
* Click on Run as Administrator.

### To view only your code signing certificates use the following command:

```sh
Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert
```

### we will store the cert in _cert_ variable

```sh
$cert = (Get-ChildItem –Path Cert:\LocalMachine\My -CodeSigningCert)[4]
```

### Sign Your PowerShell Script

```sh
Set-AuthenticodeSignature -FilePath SCRIPT_PATH -Certificate $cert
```

* for example

```sh
Set-AuthenticodeSignature -FilePath C:\CodeSigningCertificate\example_powershell_script.ps1 -Certificate $cert
```


--------------


# 🔐 How to Sign a PowerShell Script (Step-by-Step Guide)

Digitally signing a PowerShell script ensures its authenticity and integrity. This guide walks you through signing a script using a code signing certificate on Windows.

---

##  Prerequisites

- Windows OS
- PowerShell (run as Administrator)
- A valid code signing certificate
  - Either self-signed (for development/testing)
  - Or issued by a Certificate Authority (for production)

---

## 🧾 Step-by-Step Instructions

### ✅ Step 1: Open PowerShell as Administrator

1. Press `Start` and search for **PowerShell**.
2. Right-click **Windows PowerShell** and select **Run as Administrator**.

---

### ✅ Step 2: View Your Code Signing Certificates

To list code signing certificates in your **Current User** store:

```powershell
Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert
```

### If your certificate is stored under Local Machine, use:

```sh
Get-ChildItem Cert:\LocalMachine\My -CodeSigningCert
```

### Step 3: Store the Certificate in a Variable

```sh
$cert = Get-ChildItem -Path Cert:\LocalMachine\My -CodeSigningCert
```

### Step 4: Sign Your PowerShell Script

```sh
Set-AuthenticodeSignature -FilePath "C:\Path\To\YourScript.ps1" -Certificate $cert
```

### Step 5: Verify the Signature

```sh
Get-AuthenticodeSignature -FilePath "C:\CodeSigningCertificate\example_powershell_script.ps1"

```
