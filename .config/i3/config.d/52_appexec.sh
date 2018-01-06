#!/bin/sh

#echo exec --no-startup-id "i3-msg 'workspace \$workspace1; append_layout $HOME/.config/i3/workspace-1.json'"

if [ -e  /usr/bin/gnome-settings-daemon ]; then
  echo "exec /usr/bin/gnome-settings-daemon"
elif [ -e  /usr/libexec/gnome-settings-daemon ]; then
  echo "exec /usr/libexec/gnome-settings-daemon"
elif [ -e  /usr/bin/xfsettingsd ]; then
  echo "exec --no-startup-id /usr/bin/xfsettingsd --replace --no-daemon"
elif [ -e  /usr/bin/xfsettingsd ]; then
  echo "exec --no-startup-id /usr/bin/lxsettings-daemon --replace --no-daemon"
fi

echo "exec_always --no-startup-id feh --bg-scale /home/dirk/.local/share/bg_kosmonaut.jpg"

for c in firefox thunderbird owncloud nm-applet
do
  if [ -e "/usr/bin/${c}" ]; then
    echo "exec $c"
  fi
done

for c in xfce4-clipman clipit parcellite
do
  if [ -e "/usr/bin/${c}" ]; then
    echo "exec --no-startup-id $c"
    break
  fi
done

term1="i3-sensible-terminal -name term -title term"
term2="$term1"
term3="$term1"
mutt=$(which mutt)
if [ $? -eq 0 -a -e "$mutt" ] ; then
  term2="i3-sensible-terminal -name mail -title mail -e mutt"
fi
irssi=$(which irssi)
if [ $? -eq 0 -a -e "$irssi" ] ; then
  term3="i3-sensible-terminal -name chat -title chat -e irssi"
fi

echo "exec --no-startup-id i3-msg 'workspace 1; exec $term1; layout toggle split; layout splitv; split vertical; exec $term2; exec $term3'"
