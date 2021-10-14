unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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
const toomuchlight = 'Too much light';
{$R *.fmx}

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
  //lazarus
  //Form1.Label1.Caption:= 'Shutter';
  //Form1.Label5.Caption:= ' ';
  //delphi fmx
  Form1.Label1.Text:= 'Shutter';
  Form1.Label5.Text:= ' ';

  s := GetSpeed();
  n := GetAperture();
  e := Lux.GetLight();
      t := Calculate.Shutter(s, e, n);
      //lazarus
      //if t < 1/1500 then Form1.Label5.Caption := toomuchlight else Form1.Label5.Caption := lightisok;
      if t < 1/1500 then Form1.Label5.Text := toomuchlight else Form1.Label5.Text := lightisok;
      t := Calculate.FixShutter(t, inx);
      if t > 1 then begin
      //lazarus
      //   Form1.Edit1.Text:= SysUtils.FloatToStr(t);
      //delphi fmx
         Form1.Edit1.Text:= System.SysUtils.FloatToStr(t);
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
  Form1.Label1.Text := 'Aperture';
  Form1.Label5.Text := ' ';
  s := GetSpeed();
  t := GetShutter();
  e := Lux.GetLight();
  n := Calculate.Aperture(s, e, t);
  if n <= 1.1 then begin
     //lazarus
     //Form1.Label5.Caption:= notenoughlight;
     //delphi fmx
     Form1.Label5.Text:= notenoughlight;
  end
  else
  begin
     if n > 18 then begin
        //lazanus
        //Form1.Label5.Caption := toomuchlight;
        //delphi fmx
        Form1.Label5.Text := toomuchlight;
     end
     else
     begin
        //lazarus
        //Form1.Label5.Caption := lightisok;
        //delphi fmx
        Form1.Label5.Text := lightisok; // it's a pity pascal has no "elsif"
     end;
  end;
  n := Calculate.FixAperture(n);
  //lazarus
  //Form1.Edit1.Text:= SysUtils.FloatToStr(n);
  //delphi fmx
  Form1.Edit1.Text := System.SysUtils.FloatToStr(n);
end;

procedure Recalc;
begin
//lazarus
//if Form1.Label1.Caption = 'Aperture' then
//delphi fmx
if Form1.Label1.Text = 'Aperture' then
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  Recalc
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Recalc
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  SetAperture
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  SetShutter
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  comboFontSize = 42;
  labelFontSize = 12;

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
  //delphi fmx
  //Edit1.Align := TAlignLayout.FitRight;
  //lazarus
  //Edit1.Alignment:=taRightJustify;
  //lazarus
////ComboBox1.Font.Size:=42;
////  ComboBox1.Text:='ISO';
////  ComboBox1.Width:=255; //n900
//    ComboBox1.Width:=223; //n810
////  ComboBox2.Font.Size:= comboFontSize;
////  ComboBox2.Text:='Shutter';
////  ComboBox2.Width:=255; //n900
//    ComboBox2.Width:=223; //n810
////  ComboBox3.Font.Size:= comboFontSize;
////  ComboBox3.Text:='Aperture';
////  ComboBox3.Width:=255; //n900
//    ComboBox3.Width:=223; //n810
    ComboBox3.ItemHeight:= comboFontSize;

  Edit1.ReadOnly:= true;

  Form1.Caption:= 'Photographic light meter';
  //delphi fmx
  Label2.Text := 'ISO';
  Label3.Text := 'Shutter';
  Label4.Text := 'Aperture';
  Label1.Text := 'Aperture';
  Label5.Text := ' ';
  Button1.Text := 'Recalculate';
  //lazarus
  //Label2.Caption:= 'ISO';
  //Label3.Caption:= 'Shutter';
  //Label4.Caption:= 'Aperture';
  //Label1.Caption:= 'Aperture';
  //Label5.Caption := ' ';
  //Button1.Caption:= 'Recalculate';

  Label1.Font.Size := labelFontSize;
  Label2.Font.Size := labelFontSize;
  Label3.Font.Size := labelFontSize;
  Label4.Font.Size := labelFontSize;
  Label5.Font.Size := labelFontSize;
  Button1.Font.Size:= labelFontSize;

  LoadLists;
  Recalc;
end;



end.
