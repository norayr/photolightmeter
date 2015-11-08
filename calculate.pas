unit Calculate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 
const C = 330;

function Shutter( S {film speed} : integer; E {luminance} : integer ; N {aperture} : real) : real;
function Aperture( S {film speed} : integer; E {luminance} : integer ; t {shutter} : real) : real;
function FixShutter (t : real; var inx : shortint) : real;
function FixAperture(n : real) : real;

implementation
  uses Lists;

function FixAperture(n : real) : real;
begin       // no elsif in pascal... pity
   if n <= 1.7 then begin FixAperture := 1.4 ; exit end;
   if (n > 1.7) and (n <= 2.4) then begin FixAperture := 2.0; exit end;
   if (n > 2.4) and (n <= 3.4) then begin FixAperture := 2.8; exit end;
   if (n > 3.4) and (n <= 4.8) then begin FixAperture := 4.0; exit end;
   if (n > 4.8) and (n <= 7.0) then begin FIxAperture := 5.6; exit end;
   if (n > 7.0) and (n <= 9.0) then begin FixAperture := 8.0; exit end;
   if (n > 9.0) then begin FixAperture := 16.0; exit end;
end;

function FixShutter (t : real; var inx : shortint) : real;          //the same as in previous function just in a for cycle and
var k : byte;                                      // also returns index of the corresponding combobox shutter
  i, j, f : real;
begin
   if t >= 0.75 then begin FixShutter := Round(t); inx := 0; exit end; //shutter may be 3, 5, 10, 15 seconds
   if t < 1/1000 then begin FixShutter := 1/1000; inx := 10; exit end;  //shutter cannot be less than 1/1000

    for k := 1 to length(shutter_bin) - 2 do begin
      i := shutter_bin[k] + (shutter_bin[k-1] - shutter_bin[k])/2;
      j := shutter_bin[k+1] + (shutter_bin[k] - shutter_bin[k+1])/2;
      if (t < i) and ( t >= j) then begin
           f :=  shutter_bin[k];
           FixShutter := f; inx := k; exit;
      end;
    end;

end;

function Shutter( S {film speed} : integer; E {luminance} : integer ; N {aperture} : real) : real;
begin
if E = 0 then E := 1;
if S = 0 then S := 1;
Shutter := (N*N * C) / (E * S)

end;

function Aperture( S {film speed} : integer; E {luminance} : integer ; t {shutter} : real) : real;
begin

Aperture := sqrt( t * E * S / C )

end;

end.

