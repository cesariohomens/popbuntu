#!/bin/bash

# PopBuntu
# Cesário Garcia Mil-Homens
# cesario@cesariogarcia.com
# https://www.cesariogarcia.com

echo "Installing POP_OS Theme"
sudo add-apt-repository ppa:system76/pop
sudo apt update
sudo apt -y upgrade
sudo apt -y install pop-theme gnome-tweak-tool chrome-gnome-shell xdotool
clear

#Verifying Google Chrome installation
echo "Verifying Google Chrome installation"
if google-chrome --version >/dev/null 2>&1; then
 echo "Google Chrome found"
else
 echo "Installing Google Chrome"
 wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
 sudo dpkg -i google-chrome-stable_current_amd64.deb
 rm google-chrome-stable_current_amd64.deb
fi
clear

#Installing extensions
echo "Install the following Google Chrome and Gnome extensions"
google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/1251/blyr/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/779/clipboard-indicator/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/1230/gmail-message-tray/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/1319/gsconnect/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/805/hide-dash/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/750/openweather/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/7/removable-drive-menu/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/1112/screenshot-tool/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/906/sound-output-device-chooser/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/1099/transparent-gnome-panel/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/1301/ubuntu-appindicators/ >/dev/null 2>&1
google-chrome https://extensions.gnome.org/extension/19/user-themes/ >/dev/null 2>&1
clear

#Installing POP_OS Plymouth theme
echo "Installing POP_OS Plymouth theme"
sudo apt -y install plymouth-theme*
sudo update-alternatives --config default.plymouth
echo "Select POP_OS theme"
read -n1 -r -p "Press any key to continue..." key
clear
sudo update-initramfs -u
clear

#Tunning GDM and gnome-shell
sudo mv /usr/share/gnome-shell/theme/gdm3.css /usr/share/gnome-shell/theme/gdm3.css.bak
sudo mv /usr/share/gnome-shell/theme/gnome-shell.css /usr/share/gnome-shell/theme/gnome-shell.css.bak
sudo mv /usr/share/gnome-shell/theme/Yaru/gnome-shell.css /usr/share/gnome-shell/theme/Yaru/gnome-shell.css.bak
sudo mv /usr/share/gnome-shell/theme/ubuntu.css /usr/share/gnome-shell/theme/ubuntu.css.bak
sudo mv /usr/share/gnome-shell/theme/ubuntu-high-contrast.css /usr/share/gnome-shell/theme/ubuntu-high-contrast.css.bak
sudo mv /usr/share/gnome-shell/theme/Yaru/ubuntu-high-contrast.css /usr/share/gnome-shell/theme/Yaru/ubuntu-high-contrast.css.bak
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/pop.css
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/gnome-shell.css
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/Yaru/gnome-shell.css
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/Yaru/ubuntu-high-contrast.css 
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/gdm3.css
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/ubuntu.css
sudo ln -sf /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme/ubuntu-high-contrast.css
sudo mv /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu-logo.png.bak
sudo convert -size 217x58 xc:transparent /usr/share/plymouth/ubuntu-logo.png
clear

#Setting up applications to POP theme
gsettings set org.gnome.desktop.interface gtk-theme "Pop"

#Setting up cursor to POP theme
gsettings set org.gnome.desktop.interface cursor-theme "Pop"

#Setting up icons to POP theme
gsettings set org.gnome.desktop.interface icon-theme "Pop"

#Changing terminal theme
echo "Changing terminal theme"
profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
profile=${profile:1:-1}
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile}/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile}/ use-transparent-background true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile}/ use-theme-transparency false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile}/ background-transparency-percent "20"
clear

#Installing Plank
echo "Installing Plank"
read -n1 -r -p "Press any key to continue..." key
sudo apt -y purge gnome-shell-extension-ubuntu-dock
sudo apt -y install plank
sudo mkdir /usr/share/plank/themes/Pop
touch dock.theme
echo "[PlankTheme]
#The roundness of the top corners.
TopRoundness=3
#The roundness of the bottom corners.
BottomRoundness=0
#The thickness (in pixels) of lines drawn.
LineWidth=0
#The color (RGBA) of the outer stroke.
OuterStrokeColor=100;;100;;100;;200
#The starting color (RGBA) of the fill gradient.
FillStartColor=40;;40;;40;;150
#The ending color (RGBA) of the fill gradient.
FillEndColor=60;;60;;60;;190

#The color (RGBA) of the inner stroke.
InnerStrokeColor=20;;20;;20;;200

[PlankDockTheme]
#The padding on the left/right dock edges, in tenths of a percent of IconSize.
HorizPadding=2
#The padding on the top dock edge, in tenths of a percent of IconSize.
TopPadding=2.5
#The padding on the bottom dock edge, in tenths of a percent of IconSize.
BottomPadding=2.5
#The padding between items on the dock, in tenths of a percent of IconSize.
ItemPadding=3
#The size of item indicators, in tenths of a percent of IconSize.
IndicatorSize=5
#The size of the icon-shadow behind every item, in tenths of a percent of IconSize.
IconShadowSize=1
#The height (in percent of IconSize) to bounce an icon when the application sets urgent.
UrgentBounceHeight=1.6666666666666667
#The height (in percent of IconSize) to bounce an icon when launching an application.
LaunchBounceHeight=0.625
#The opacity value (0 to 1) to fade the dock to when hiding it.
FadeOpacity=1
#The amount of time (in ms) for click animations.
ClickTime=300
#The amount of time (in ms) to bounce an urgent icon.
UrgentBounceTime=600
#The amount of time (in ms) to bounce an icon when launching an application.
LaunchBounceTime=600
#The amount of time (in ms) for active window indicator animations.
ActiveTime=300
#The amount of time (in ms) to slide icons into/out of the dock.
SlideTime=300
#The time (in ms) to fade the dock in/out on a hide (if FadeOpacity is < 1).
FadeTime=250
#The time (in ms) to slide the dock in/out on a hide (if FadeOpacity is 1).
HideTime=250
#The size of the urgent glow (shown when dock is hidden), in tenths of a percent of IconSize.
GlowSize=30
#The total time (in ms) to show the hidden-dock urgent glow.
GlowTime=10000
#The time (in ms) of each pulse of the hidden-dock urgent glow.
GlowPulseTime=2000
#The hue-shift (-180 to 180) of the urgent indicator color.
UrgentHueShift=150
#The time (in ms) to move an item to its new position or its addition/removal to/from the dock.
ItemMoveTime=450
#Whether background and icons will unhide/hide with different speeds. The top-border of both will leave/hit the screen-edge at the same time.
CascadeHide=true" > dock.theme
sudo mv dock.theme /usr/share/plank/themes/Pop/
sudo chown root:root /usr/share/plank/themes/Pop/dock.theme
echo "Select Plank POP theme after reboot with -> plank --preferences"
read -n1 -r -p "Press any key to continue..." key

#Create Dashboard launcher
clear
touch launcher.desktop
echo "[Desktop Entry]
Comment=
Terminal=false
Name=Start
Exec=/bin/bash /usr/local/bin/plank_show_apps.sh
Type=Application
Icon=gnome-panel-launcher" > launcher.desktop
sudo mv launcher.desktop /usr/share/applications
sudo chown root:root /usr/share/applications/launcher.desktop

touch plank_show_apps.sh
echo "#!/bin/bash
xdotool keydown Super key a
xdotool keyup Super" > plank_show_apps.sh
sudo mv plank_show_apps.sh /usr/local/bin/
sudo chown root:root /usr/local/bin/plank_show_apps.sh

touch launcher.dockitem
echo "[PlankDockItemPreferences]
Launcher=file:///usr/share/applications/launcher.desktop" > launcher.dockitem
mv launcher.dockitem ~/.config/plank/dock1/launchers

#Execute plank at startup
touch plank.desktop
echo "[Desktop Entry]
Type=Application
Exec=plank
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Plank
Name=Plank
Comment[en_US]=
Comment=" > plank.desktop
sudo mv plank.desktop /etc/xdg/autostart
sudo chown root:root /etc/xdg/autostart/plank.desktop
clear

#Reboot to apply new changes
echo "Rebooting to apply new changes"
sudo reboot
read -n1 -r -p "Press any key to continue..." key
