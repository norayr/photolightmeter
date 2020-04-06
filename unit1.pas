unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation
uses Lists,
     Lux,
     Calculate{,
     strutils};
const notenoughlight = 'Not enough light';
const lightisok = 'Light is OK';
const toomanylight = 'Too many light';
{$R *.lfm}

{ TForm1 }

function GetSpeed(): integer;
//var s : string;
begin
 //s := strutils.ExtractWord(1, Form1.ComboBox1.Items[Form1.ComboBox1.ItemIndex], [' ', '/']);
 //GetSpeed := SysUtils.StrToInt(s);
GetSpeed := Lists.iso_bin[Form1.ComboBox1.ItemIndex];
end;

function GetShutter(): real;
//var s : string; i : integer;
begin
   //s := strutils.ExtractWord(2, Form1.ComboBox2.Items[Form1.ComboBox2.ItemIndex], [' ', '/'] );
   //i := SysUtils.StrToInt(s);
   //GetShutter := 1 / i;
   GetShutter := Lists.shutter_bin[Form1.ComboBox2.ItemIndex];
end;

function GetAperture(): real;
//var s : string;
begin
  // s := strutils.ExtractWord(2, Form1.ComboBox3.Items[Form1.ComboBox3.ItemIndex], [' ', '/'] );
  // GetAperture := SysUtils.StrToFloat(s);
   GetAperture := Lists.aperture_bin[Form1.ComboBox3.ItemIndex];
end;


procedure SetShutter;
var s, e : integer;
t, n : real;
inx : shortint;
begin
  Form1.Label1.Caption:= 'Shutter';
  Form1.Label5.Caption:= ' ';
  s := GetSpeed();
  n := GetAperture();
  e := Lux.GetLight();
      t := Calculate.Shutter(s, e, n);
      if t < 1/1500 then Form1.Label5.Caption := toomanylight else Form1.Label5.Caption := lightisok;
      t := Calculate.FixShutter(t, inx);
      if t > 1 then begin
         Form1.Edit1.Text:= SysUtils.FloatToStr(t);
      end
      else
      begin
         Form1.Edit1.Text:= Form1.ComboBox2.Items[inx];
      end;
end;

procedure SetAperture;
var s, e : integer;
t, n : real;
begin
  Form1.Label1.Caption:= 'Aperture';
  Form1.Label5.Caption := ' ';
  s := GetSpeed();
  t := GetShutter();
  e := Lux.GetLight();
  n := Calculate.Aperture(s, e, t);
  if n <= 1.1 then begin
     Form1.Label5.Caption:= notenoughlight;
  end
  else
  begin
     if n > 18 then begin
        Form1.Label5.Caption := toomanylight;
     end
     else
     begin
        Form1.Label5.Caption := lightisok; // it's a pity pascal has no "elsif"
     end;
  end;
  n := Calculate.FixAperture(n);
  Form1.Edit1.Text:= SysUtils.FloatToStr(n);
end;

procedure Recalc;
begin
if Form1.Label1.Caption = 'Aperture' then
   begin
      SetAperture;
   end
  else
   begin
     SetShutter;
   end
end;


procedure LoadLists;
begin
  Lists.iso(Form1.ComboBox1.Items);
  Lists.shutter(Form1.ComboBox2.Items);
  Lists.aperture(Form1.ComboBox3.Items);
  Form1.ComboBox1.ItemIndex:= 1;
  Form1.ComboBox2.ItemIndex:= 7;
  Form1.ComboBox3.ItemIndex:= 4;

//Form1.ComboBox1.Caption:= Form1.ComboBox1.Items[0];
//Form1.ComboBox2.Caption:= Form1.ComboBox2.Items[0];
//Form1.ComboBox3.Caption:= Form1.ComboBox3.Items[0];

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//n900
//  Form1.Width:= 800;
//n810
  Form1.Width:= 720;
// n900
//Form1.Height:= 480;
  Form1.Height:= 425;
  Edit1.Font.Size:=100;
  Edit1.Text:='0';
  Edit1.Alignment:=taRightJustify;
  ComboBox1.Font.Size:=42;
//  ComboBox1.Text:='ISO';
//  ComboBox1.Width:=255; //n900
    ComboBox1.Width:=223; //n810
  ComboBox2.Font.Size:=42;
//  ComboBox2.Text:='Shutter';
//  ComboBox2.Width:=255; //n900
    ComboBox2.Width:=223; //n810
  ComboBox3.Font.Size:=42;
//  ComboBox3.Text:='Aperture';
//  ComboBox3.Width:=255; //n900
    ComboBox3.Width:=223; //n810
//  ComboBox3.ItemHeight:=42;

  Edit1.ReadOnly:= true;

  Form1.Caption:= 'Photographic light meter';
  Label2.Caption:= 'ISO';
  Label3.Caption:= 'Shutter';
  Label4.Caption:= 'Aperture';
  Label1.Caption:= 'Aperture';
  Label5.Caption := ' ';
  Button1.Caption:= 'Recalculate';
  LoadLists;
  Recalc;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
   Recalc;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Recalc;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
   SetAperture
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
   SetShutter
end;

end.

