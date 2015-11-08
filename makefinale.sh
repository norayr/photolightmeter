ARCH="arm-linux"
LAZARUS="/media/mmc1/noch/lazarus"
#export PATH=/opt/fpc-svn/lib/fpc/2.5.1:/opt/fpc-svn/bin:/opt/binutils-arm-eabi/arm-none-eabi/bin:/opt/binutils-arm-eabi/bin:$PATH
export PATH=/opt/fpc-svn/lib/fpc/2.5.1:/opt/fpc-svn/bin:$PATH
#fpc -MObjFPC -Scgi -O1 -gl -WG -vewnhi -l -Fu../../usr/share/lazarus/lcl/units/x86_64-linux/ -Fu../../usr/share/lazarus/lcl/units/x86_64-linux/gtk2/ -Fu../../usr/share/lazarus/packager/units/x86_64-linux/ -Fu. -oproject1 -dLCL -dLCLgtk2
fpc project1.lpr -Xs -Xg -XX -MObjFPC -Scgi -O1 -gl -WG -vewnhi -l -Fu$LAZARUS/lcl/units/$ARCH/ -Fu$LAZARUS/lcl/units/$ARCH/gtk2/ -Fu$LAZARUS/packager/units/$ARCH/ -Fu. -oproject1 -dLCL -dLCLgtk2
#fpc project1.lpr -MObjFPC -Scgi -O1 -gl -WG -vewnhi -l -Fu$LAZARUS/lcl/units/$ARCH/ -Fu$LAZARUS/lcl/units/$ARCH/gtk2/ -Fu$LAZARUS/packager/units/$ARCH/ -Fu. -oproject1 -dLCL -dLCLgtk2

 


