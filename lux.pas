unit Lux;

//lazarus
//{$mode objfpc}{$H+}

interface
//uses
  //Classes, SysUtils;
         function GetLight() : integer;
implementation
//lazarus
//uses Dialogs, SysUtils, strutils;
uses FMX.Dialogs, System.SysUtils, System.Sensors;


//lazarus linux
{
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

function readRealFromFile(var path: string): real;
var
  f: textfile;
  z: real;
begin
  z := 0.0;
  assign (f, path);
  reset(f);
  read (f, z);
  //lux := SysUtils.StrToInt(s);
  close(f);
  readRealFromFile := z;
end;

function checkOld(var lux: integer): boolean;
var
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
  drvdirnotfound = 'driver directory ' + drvdir + ' not found';
  lnk    = 'iio:device';
  inputfile = 'in_illuminance_input';
  inputfile_raw = 'in_illuminance_raw';
  inputfile_scale = 'in_illuminance_scale';
var
  info: TSearchRec;
  count : integer;
  tmp, tmu: string;
begin
  l := 0;
  checkNew := false;
  if SysUtils.DirectoryExists(drvdir) then begin
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
              begin  //it's a pity pascal has no elsif
                tmp := drvdir + '/' + name + '/' + inputfile_raw;
                tmu := drvdir + '/' + name + '/' + inputfile_scale;
                if SysUtils.FileExists(tmp) and SysUtils.FileExists(tmu) then
                begin
                  l := Round(readIntFromFile(tmp) * readRealFromFile(tmu));
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
  end
 else
  begin
   Dialogs.ShowMessage(drvdirnotfound);
  end; //if dir exists
  checkNew := false;

end;

function GetLight() : integer;
var
  lux: integer;
  b: boolean;
begin
  lux := 0;
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
}

//delphi fmx
 {
function GetLight3(var d: double): integer;
var
  m: TSensorManager;
  l: TCustomLightSensor;
  a: TSensorArray;
  i: integer;
begin
  m := TSensorManager.Current;
  m.Activate;

  t := m.GetSensorsByCategory(TSensorCategory.Light);
  if t <> nil then begin
    for i := 0 to Length(t) - 1 do
    begin
      l[i] := t[0] as TCustomLightSensor;
      l.Start;
    end;

  end;

end;
  }
function GetLight(): integer;
var

  MySensorArray : TSensorArray;

  MyAmbientLightSensor : TCustomLightSensor;

begin
  try

    TSensorManager.Current.Activate; // activate sensor manager

    // use GetSensorsByCategory to see if a Light sensor is found

    MySensorArray := TSensorManager.Current.GetSensorsByCategory(TSensorCategory.Light);

    if MySensorArray <> nil then begin  // check if Ambient Light Sensor is found

      //Fmx.Dialogs.ShowMessage('Ambient Light Sensor Found');

      MyAmbientLightSensor := MySensorArray[0] as TCustomLightSensor;
      if (not MyAmbientLightSensor.Started) then begin
        MyAmbientLightSensor.Start
      end;

      GetLight := Round(MyAmbientLightSensor.Lux);
    end

    else begin
      GetLight := 0;
      Fmx.Dialogs.ShowMessage('Ambient Light Sensor Not Found!')

    end;

  finally

    TSensorManager.Current.DeActivate // deactivate sensor manager

  end;

end;
end.

