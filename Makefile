ARCH = $(shell arch)
ifeq ($(ARCH),armv71)
	ARCH = arm
endif
LCL_PLATFORM = $(ARCH)-linux
#LAZARUS = "/media/mmc1/noch/src/freepascal/lazarus"
LAZBUILD = /usr/bin/lazbuild
WKSPACE = ${WORKSPACE}
HOME = ${WORKSPACE}
export HOME
PATH = "/usr/bin:/bin:/usr/sbin:/sbin"
#SETPATH = PATH=/local/fpc-svn/lib/fpc/2.5.1:/local/fpc-svn/bin:$(PATH)
SETPATH = PATH=/usr/bin:/bin:/usr/sbin:/sbin
PROJECT = project1.lpr
OUTFILE = lightmeter
FPC = /usr/bin/fpc
#PARAMS = -MObjFPC -Scgi -Cg -O1 -g -Xg -XX -l -vewnhibq -Filib/x86_64-linux -Fu/usr/lib/lazarus/2.0.0/lcl/units/x86_64-linux/gtk2 -Fu/usr/lib/lazarus/2.0.0/lcl/units/x86_64-linux -Fu/usr/lib/lazarus/2.0.0/components/lazutils/lib/x86_64-linux -Fu/usr/lib/lazarus/2.0.0/packager/units/x86_64-linux -Fu. -FUlib/x86_64-linux -FE. -oproject1 -dLCL -dLCLgtk2
#PARAMS = -MObjFPC -Scgi -Cg -O1 -g -Xg -XX -l -vewnhibq -Filib/$(LCL_PLATFORM) -Fu/usr/share/fpcsrc/3.0.4/packages/chm/src -Fu/usr/share/fpcsrc/3.0.4/rtl/$(ARCH)  -Fo/usr/lib/$(LCL_PLATFORM)-gnu/fpc/3.0.4/units/$(LCL_PLATFORM)/chm -Fu/usr/lib/$(LCL_PLATFORM)-gnu/fpc/3.0.4/units/$(LCL_PLATFORM)/chm -Fu/$(LCL_PLATFORM)/gtk2 -Fu/usr/lib/lazarus/2.0.0/lcl/units/$(LCL_PLATFORM)/gtk2 -Fu/usr/lib/lazarus/2.0.0/lcl/units/$(LCL_PLATFORM) -Fu/usr/lib/lazarus/2.0.0/components/lazutils/lib/$(LCL_PLATFORM) -Fu/usr/lib/lazarus/2.0.0/packager/units/$(LCL_PLATFORM) -Fu. -FUlib/$(LCL_PLATFORM) -FE. -oproject1 -dLCL -dLCLgtk2
#PARAMS = -MObjFPC -Scgi -Cg -O1 -g -Xg -XX -l -vewnhibq -Filib/$(LCL_PLATFORM)  -Fu/usr/share/fpcsrc/3.0.4/rtl/$(ARCH) -Fi/usr/lib/$(LCL_PLATFORM)-gnu/fpc/3.0.4/units/$(LCL_PLATFORM)/chm -Fo/usr/lib/$(LCL_PLATFORM)-gnu/fpc/3.0.4/units/$(LCL_PLATFORM)/chm -Fu/usr/lib/$(LCL_PLATFORM)-gnu/fpc/3.0.4/units/$(LCL_PLATFORM)/chm -Fu/$(LCL_PLATFORM)/gtk2 -Fu/usr/lib/lazarus/2.0.0/lcl/units/$(LCL_PLATFORM)/gtk2 -Fu/usr/lib/lazarus/2.0.0/lcl/units/$(LCL_PLATFORM) -Fu/usr/lib/lazarus/2.0.0/components/lazutils/lib/$(LCL_PLATFORM) -Fu/usr/lib/lazarus/2.0.0/packager/units/$(LCL_PLATFORM) -Fu. -FUlib/$(LCL_PLATFORM) -FE. -oproject1 -dLCL -dLCLgtk2

PARAMS = -MObjFPC -Scgi -Cg -O1 -g -Xg -XX -l -vewnhibq -FD/usr/bin -Fi/usr/share/fpcsrc/3.0.4/packages/chm -Fu/usr/share/fpcsrc/3.0.4/packages/chm -Fi/usr/share/fpcsrc/3.0.4/packages/chm/src -Fu/usr/share/fpcsrc/3.0.4/packages/chm/src -Fi/root/photolightmeter/lib/$(ARCH)-linux -Fu/usr/lib/lazarus/2.0.0/lcl/units/$(ARCH)-linux/gtk2 -Fu/usr/lib/lazarus/2.0.0/lcl/units/$(ARCH)-linux -Fu/usr/lib/lazarus/2.0.0/components/lazutils/lib/$(ARCH)-linux -Fu/usr/lib/lazarus/2.0.0/packager/units/$(ARCH)-linux -Fu. -Fulib/x86_64-linux/ -FE. -o./project1 -dLCL -dLCLgtk2

#PARAMS =  $(PROJECT) -Xs -Xg -XX -MObjFPC -Scgi -O1 -gl -WG -vewnhi -l -Fu$(LAZARUS)/lcl/units/$(ARCH)/ -Fu$(LAZARUS)/lcl/units/$(ARCH)/gtk2/ -Fu$(LAZARUS)/packager/units/$(ARCH)/ -Fu. -o$(OUTFILE) -dLCL -dLCLgtk2

all:
	    $(FPC) $(PARAMS) $(PROJECT)
	    #mkdir /tmp/.lazarus
	    #/usr/bin/lazbuild --verbose-pkgsearch --verbose -B -r --primary-config-path=/tmp/.lazarus project1.lpr
	    #rm -rf /tmp/.lazarus 

clean:
	    rm *.o
	    rm *.ppu
	    rm *.dbg
	    rm -rf /tmp/.lazarus
install:
	    cp lightmeter.png /usr/share/pixmaps/
	    cp lightmeter.desktop /usr/share/applications/
	    mkdir -p /opt/photolightmeter/bin
	    cp project1 /opt/photolightmeter/bin/photolightmeter

install_hildon:
	    mkdir -p $(CURDIR)/debian/photolightmeter/usr/share/pixmaps
	    cp lightmeter.png $(CURDIR)/debian/photolightmeter/usr/share/pixmaps/
	    mkdir -p $(CURDIR)/debian/photolightmeter/usr/share/applications/hildon
	    cp lightmeter.desktop $(CURDIR)/debian/photolightmeter/usr/share/applications/hildon/
	    mkdir -p $(CURDIR)/debian/photolightmeter/opt/photolightmeter/bin
	    cp project1 $(CURDIR)/debian/photolightmeter/opt/photolightmeter/bin/photolightmeter

uninstall:	
	    rm -rf /opt/photolightmeter
	    rm /usr/share/pixmaps/lightmeter.png
	    rm /usr/share/applications/lightmeter.desktop
	    
 


 


