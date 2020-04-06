ARCH="arm-linux"
#LAZARUS = "/media/mmc1/noch/src/freepascal/lazarus"
LAZBUILD = /usr/bin/lazbuild
PATH = "/usr/bin:/bin:/usr/sbin:/sbin"
#SETPATH = PATH=/local/fpc-svn/lib/fpc/2.5.1:/local/fpc-svn/bin:$(PATH)
SETPATH = PATH=/usr/bin:/bin:/usr/sbin:/sbin
PROJECT = project1.lpr
OUTFILE = lightmeter
FPC = /usr/bin/fpc
PARAMS =  $(PROJECT) -Xs -Xg -XX -MObjFPC -Scgi -O1 -gl -WG -vewnhi -l -Fu$(LAZARUS)/lcl/units/$(ARCH)/ -Fu$(LAZARUS)/lcl/units/$(ARCH)/gtk2/ -Fu$(LAZARUS)/packager/units/$(ARCH)/ -Fu. -o$(OUTFILE) -dLCL -dLCLgtk2

all:
	    #$(FPC) $(PARAMS)
	    $(SETPATH) /usr/bin/lazbuild project1.lpr
	    

clean:
	    rm *.o
	    rm *.ppu
	    rm *.dbg
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
	    
 


 


