unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Edit1Change(Sender: TObject);
begin

end;

procedure TForm2.Label2Click(Sender: TObject);
begin

end;

procedure TForm2.Label5Click(Sender: TObject);
begin

end;

procedure TForm2.Button2Click(Sender: TObject);
begin

end;

//Aquiiii
procedure TForm2.RadioButton1Change(Sender: TObject);
begin
     if RadioButton1.Checked then
          begin
              Label2.Caption := 'R';
              Label3.Caption := 'G';
              Label4.Caption := 'B';
              Label6.Caption := 'H';
              Label7.Caption := 'S';
              Label8.Caption := 'V'
          end
     else
          begin
              Label2.Caption := 'H';
              Label3.Caption := 'S';
              Label4.Caption := 'V';
              Label6.Caption := 'R';
              Label7.Caption := 'G';
              Label8.Caption := 'B';
          end;
end;

end.

