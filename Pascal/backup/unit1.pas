unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  r,g,b,c,i,j : integer;
  ime, ims : array[0..392,0..389] of integer;
  cor: TColor;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
     for i:=0 to Image1.Width do
        Ime[i,j] := Ims[i,j];

  Image1.Picture := Image2.Picture ;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
    if(OpenDialog1.Execute)
     then Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  for j:=0 to Image1.Height do
    for i:=0 to Image1.Width do
     begin
       cor:= Image1.Canvas.Pixels[i,j];
       r := GetRValue(cor);
       g := GetGValue(cor);
       b := GetBValue(cor);
       c := round(0.299*r + 0.587*g + 0.114*b);

       Image2.Canvas.Pixels[i,j] := RGB(c,c,c);
     end;
end;
//Converter para Cinza
procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  for j := 0 to Image1.Height - 1 do
    for i := 0 to Image1.Width - 1 do
      begin
        ims[i, j] := 255 - ime[i, j]; // Inversão de cores
        Image2.Canvas.Pixels[i, j] := RGB(ims[i, j], ims[i, j], ims[i, j]);
      end;
end;

//Converter Cores
procedure TForm1.MenuItem8Click(Sender: TObject);
begin
     Form2 := TForm2.Create(Self);
     Form2.Show;
end;

end.
