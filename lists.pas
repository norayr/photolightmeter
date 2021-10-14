unit Lists;

//lazarus
//{$mode objfpc}{$H+}

interface

uses
  Classes, System.SysUtils;

const
  iso_bin : array[0..5] of integer = (50, 100, 200, 400, 800, 1600);
  aperture_bin : array[0..7] of real = (1.4, 2, 2.8, 4, 5.6, 8, 11, 16);
  shutter_bin : array[0..10] of real = (1, 1/2, 1/4, 1/8, 1/15, 1/30, 1/60, 1/125, 1/250, 1/500, 1/1000);

procedure iso(Str: TStrings);
procedure aperture(Str: TStrings);
procedure shutter(Str: TStrings);

implementation

procedure iso(Str: TStrings);
begin
  Str.Add('50');
  Str.Add('100');
  Str.Add('200');
  Str.Add('400');
  Str.Add('800');
  Str.Add('1600');
end;

procedure aperture(Str: TStrings);
begin
  Str.Add('f/1.4');
  Str.Add('f/2');
  Str.Add('f/2.8');
  Str.Add('f/4');
  Str.Add('f/5.6');
  Str.Add('f/8');
  Str.Add('f/11');
  Str.Add('f/16');
end;

procedure shutter(Str: TStrings);
begin
  Str.Add('1/1');
  Str.Add('1/2');
  Str.Add('1/4');
  Str.Add('1/8');
  Str.Add('1/15');
  Str.Add('1/30');
  Str.Add('1/60');
  Str.Add('1/125');
  Str.Add('1/250');
  Str.Add('1/500');
  Str.Add('1/1000');
end;

begin
end.

