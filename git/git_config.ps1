Write-Host "Git/Github User Setup" -ForegroundColor Green

$username = Read-Host "Git username"
$email = Read-Host "Git email address"
$userid = "$username <$email>"


###########################################
###         Generate SSH Key            ###
###########################################



###########################################
###         Generate GPG Key            ###
###########################################


# Generate GPG Key
Write-Host "Setting up GPG Key" -ForegroundColor Yellow

gpg --quick-generate-key --batch $userid rsa4096 sign,encrypt,auth 1y

# Get the Public Key
$publicKey = gpg --export --armor $userid

# Get the Public Key identifier
$keys = gpg -K --keyid-format=long $userid

$keys -match '(?<=rsa4096/)[A-F0-9]+'
$signingKey = $matches[0]

# Output Key To Terminal
Write-Host "Generated Key" -ForegroundColor Green
echo $publicKey

# Copy Public Key To Clipboard
Write-Host "Public Key Copied To Clipboard" -ForegroundColor Green
$publicKey | Set-Clipboard

# Open Webpage to Add to Github
Write-Host "Opening GitHub settings - Upload your GPG Key" -ForegroundColor Yellow
Start-Process https://github.com/settings/keys


###########################################
##             Config git                ##
###########################################
Write-Host "Configuring git with generated keys and credentials" -ForegroundColor Yellow

git config --global user.name $username
git config --global user.email $email

git config --global --unset gpg.format
git config --global user.signingkey $signingKey

Write-Host "Done!" -ForegroundColor Green