#macos.sh MAC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN MAC_REALNAME

#disable spotlight indexing
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/Gurpreet
sudo dscl . -create /Users/Gurpreet UserShell /bin/bash
sudo dscl . -create /Users/Gurpreet RealName $4
sudo dscl . -create /Users/Gurpreet UniqueID 1001
sudo dscl . -create /Users/Gurpreet PrimaryGroupID 80
sudo dscl . -create /Users/Gurpreet NFSHomeDirectory /Users/tcv
sudo dscl . -passwd /Users/Gurpreet "$MAC_USER_PASSWORD"
sudo dscl . -passwd /Users/Gurpreet "$MAC_USER_PASSWORD"
sudo createhomedir -c -u Gurpreet > /dev/null
sudo dscl . -append /Groups/admin GroupMembership username

#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes

echo $2 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

















#install ngrok
brew install ngrok/ngrok/ngrok

#configure ngrok and start it
ngrok authtoken 2Si1OJxnPrp6RuXN4CjmV2CABov_5fG6YiSu9m9YV9k8rag1f
ngrok tcp 5900 --region=in &
