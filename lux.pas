unit Lux;

{$mode objfpc}{$H+}

interface
//uses
  //Classes, SysUtils; 
         function GetLight() : integer;
implementation
uses Dialogs, SysUtils, strutils;

function readIntFromFile(var path: string): integer;
var
  f: textfile;
  z: integer;
begin
  z := 0;
  assign (f, path);
  reset(f);
  read (f, z);
  //lux := SysUtils.StrToInt(s);
  close(f);
  readIntFromFile := z;
end;

function checkOld(var lux: integer): boolean;
var
  f : textfile;
  z, i : integer;
  luxpaths : array [0..3] of string;
  luxfile : string;
  found: boolean;
begin
// n810 diablo maemo4
luxpaths[0] := '/sys/class/i2c-adapter/i2c-0/device/0-0029/lux';
// n900 fremantle maemo5
luxpaths[1] := '/sys/class/i2c-adapter/i2c-2/2-0029/lux';
// n900 MeeGo 1.1
luxpaths[2] := '/sys/class/i2c-adapter/i2c-2/2-0029/device0/illuminance0_input';
// n900 maemo-leste
luxpaths[3] := '/sys/class/i2c-adapter/i2c-2/2-0029/iio:device1/in_illuminance0_input';
lux := 0;
found := false;
  for i := low(luxpaths) to high(luxpaths) do begin
     luxfile := luxpaths[i];
     if SysUtils.FileExists(luxfile) then begin
        found := true;
        z := readIntFromFile(luxfile);
        lux := z;
        exit;
     end;
  end;//for
  checkOld := found;
end;

function checkNew(var l: integer): boolean;
const
  drvdir = '/sys/bus/iio/devices';
  lnk    = 'iio:device';
  inputfile = 'in_illuminance_input';
  inputfile_raw = 'in_illuminance_raw';
  inputfile_scale = 'in_illuminance_scale';
var
  info: TSearchRec;
  count : integer;
  name, tmp, tmu: string;
begin
  l := 0;
  checkNew := false;
  ChDir (drvdir);
  if IOresult<>0 then
  begin
      Writeln ('Cannot change to directory : ',drvdir);
  end
 else
  begin
     //searching for device file
     count:=0;
    if SysUtils.FindFirst ('*',faAnyFile and faDirectory,Info)=0 then
    begin
    repeat
      inc(count);
      With info do
        begin
        if (Attr and faDirectory) = faDirectory then
        begin
          Write('Dir : ');
          Writeln (name:40,Size:15);
          if strutils.LeftStr(name, 10) = lnk then
          begin
            tmp := drvdir + '/' + name + '/' + inputfile;
            if SysUtils.FileExists(tmp) then
            begin
              l := readIntFromFile(tmp);
              checkNew := true;
              exit;
            end
            else
             begin
              tmp := drvdir + '/' + name + '/' + inputfile_raw;
              tmu := drvdir + '/' + name + '/' + inputfile_scale;
              if SysUtils.FileExists(tmp) and SysUtils.FileExists(tmu) then
              begin
                l := readIntFromFile(tmp) * readIntFromFile(tmu);
                checkNew := true;
                exit;
              end;
             end;
          end;
        end;
      end;
    until SysUtils.FindNext(info)<>0;
    end;
  FindClose(Info);
  end;
  checkNew := false;
end;

function GetLight() : integer;
var
  found: boolean;
  lux: integer;
  b: boolean;
begin
  GetLight := 0;
  b := checkOld(lux);
  GetLight := lux;
  if b = false then
  begin
    b := checkNew(lux);
    GetLight := lux;
  end; //if


  if b = false then Dialogs.ShowMessage ('Hardware light-meter not found!');
end; //GetLight
end.

