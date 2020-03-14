unit Lux;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils; 
         function GetLight() : integer;
implementation
uses Dialogs;

function GetLight() : integer;
var f : textfile;
 // s : string;
  z, i : integer;
luxpaths : array [0..3] of string;
luxfile : string;
found : boolean;
begin
// n810 diablo maemo4
luxpaths[0] := '/sys/class/i2c-adapter/i2c-0/device/0-0029/lux';
// n900 fremantle maemo5
luxpaths[1] := '/sys/class/i2c-adapter/i2c-2/2-0029/lux';
// n900 MeeGo 1.1
luxpaths[2] := '/sys/class/i2c-adapter/i2c-2/2-0029/device0/illuminance0_input';
// n900 maemo-leste
luxpaths[3] := '/sys/class/i2c-adapter/i2c-2/2-0029/iio:device1/in_illuminance0_input';
//   GetLight := 555;
found := false;
  for i := low(luxpaths) to high(luxpaths) do begin
     luxfile := luxpaths[i];
     if SysUtils.FileExists(luxfile) then begin
        found := true;
        assign (f, luxfile);
        reset(f);
        read (f, z);
        //GetLight := SysUtils.StrToInt(s);
        GetLight := z;
        close(f);
        exit;
     end;
  end;//for

if found = false then Dialogs.ShowMessage ('Hardware light-meter not found!');
end; //GetLight
end.

