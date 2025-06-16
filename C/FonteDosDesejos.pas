unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, LCLIntf, LCLType, LCLProc, PopupNotifier, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Limiar: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure LimiarClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure HSLtoRGB(H, S, L: Integer; var R, G, B: Integer);
    procedure RGBtoHSL(R, G, B : Integer; var H, S, L: Integer);

  private

  public

  end;

var
  Form1: TForm1;
  r, g, b, c, i, j, tamanho, quantidadeRuido, x, y, soma, media, u, d, e, mediana, temp: integer;
  ime, ims, mag, dir: array[0..511, 0..511] of integer;
  cor: TColor;
  mascara : array[0..2, 0..2] of integer;
  vetorTonsMediana : array[0..8] of integer;
  matrizC, matrizF: array [0..127, 0..127] of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

(*Evento para adicionar Ruído em Espectro DCT*)
procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Canvas.Pixels[X, Y] := RGBToColor(255, 255, 255);
  if X and Y <= 127 then
  begin
    MatrizC[X,Y] := 255;
  end;
end;

{*Evento ao mover o mouse por cima da imagem 2*}
procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Edit1.Text:= IntToStr(Mag[x,y]);
  Edit2.Text:= IntToStr(dir[x,y]);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

procedure TForm1.LimiarClick(Sender: TObject);
begin

end;

(*Filtro Convolucional Média Vizinhança 8*)
procedure TForm1.MenuItem10Click(Sender: TObject);
begin
     for i:= 0 to 2 do
         for j := 0 to 2 do
             begin
                  mascara[i, j] := 1;
             end;

     for i := 1 to Image1.Width - 2 do
         for j := 1 to Image1.Height - 2 do
         begin
             soma := 0;

             for x := -1 to 1 do
                 for y := -1 to 1 do
                 begin
                     soma := soma + (ime[i + x, j + y] * mascara[x + 1, y + 1]);
                 end;

             media := Round(soma/9);

             ims[i,j] := media;
             Image2.Canvas.Pixels[i, j] := RGB(media, media, media);
         end;
end;



(*Filtro Convolucional Mediana Vizinhança 8*)
procedure TForm1.MenuItem11Click(Sender: TObject);
begin
     for i:= 0 to 2 do
         for j := 0 to 2 do
             begin
                  mascara[i, j] := 1;
             end;

     for i := 1 to Image1.Width - 2 do
         for j := 1 to Image1.Height - 2 do
         begin

             for u := 0 to 8 do
             begin
                 vetorTonsMediana[u] := 0;
             end;

             u := 0;

             for x := -1 to 1 do
                 for y := -1 to 1 do
                 begin
                     vetorTonsMediana[u] := ime[i + x, j + y] * mascara[x + 1, y + 1];
                     Inc(u);
                 end;

             for d := 0 to 7 do
                for e := 0 to 7 - d do
                begin
                  if vetorTonsMediana[e] > vetorTonsMediana[e + 1] then
                  begin
                    temp := vetorTonsMediana[e];
                    vetorTonsMediana[e] := vetorTonsMediana[e + 1];
                    vetorTonsMediana[e + 1] := temp;
                  end;
                end;
             mediana := vetorTonsMediana[4];

             ims[i,j] := mediana;
             Image2.Canvas.Pixels[i, j] := RGB(mediana, mediana, mediana);
         end;


end;

(*Aplicar Ruído Sal e Pimenta*)
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
     tamanho := Image1.Width * Image1.Height;
     quantidadeRuido := Round(tamanho/10);
     Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);

     for i:= 0 to quantidadeRuido do
         begin
              x := Random(Image1.Width+1);
              y := Random(Image1.Height+1);
              c := Random(2);
              if c = 1 then c := 255;
              Image2.Canvas.Pixels[x, y] := RGB(c, c, c);
         end;
end;

(*Filtragem Baseada na Média de 10 Imagens*)
procedure TForm1.MenuItem13Click(Sender: TObject);
var im: array[1..10] of Graphics.TBitmap;
var i, j, x, y, r, g, b, largura, altura, tamanho, quantidadeRuido, somaR, somaG, somaB, mediaR, mediaG, mediaB : Integer;
var cor: TColor;
begin
     largura := Image1.Width;
     altura := Image1.Height;
     tamanho := largura * altura;
     quantidadeRuido := Round(tamanho/10);

     for i := 1 to 10 do
        begin
            im[i] := Graphics.TBitmap.Create;
            im[i].SetSize(largura, altura);
            im[i].Canvas.Draw(0, 0, Image1.Picture.Bitmap);

            for j := 0 to quantidadeRuido do
               begin
                   x := Random(largura+1);
                   y := Random(altura+1);
                   r := Random(256);
                   g := Random(256);
                   b := Random(256);

                   im[i].Canvas.Pixels[x,y] := RGB(r, g, b);
               end;
        end;

     for x := 0 to largura - 1 do
        for y := 0 to altura - 1 do
           begin
               somaR := 0;
               somaG := 0;
               somaB := 0;

               for i := 1 to 10 do
                  begin
                      cor := im[i].Canvas.Pixels[x, y];
                      r := Integer(cor and $FF);
                      g := Integer((cor shr 8) and $FF);
                      b := Integer((cor shr 16) and $FF);

                      somaR := somaR + r;
                      somaB := somaB + b;
                      somaG := somaG + g;
                  end;

               mediaR := Round(somaR / 10);
               mediaG := Round(somaG / 10);
               mediaB := Round(somaB / 10);

               Image2.Canvas.Pixels[x,y] := RGB(mediaR, mediaG, mediaB);
           end;

     for i := 1 to 10 do
        im[i].Free;
end;
{*Magnitude de sobel*}
procedure TForm1.MenuItem14Click(Sender: TObject);
var
  gx, gy, min, max,theta: Integer;
  i, j: Integer;
begin

  for j := 1 to Image1.Height - 2 do
    for i := 1 to Image1.Width - 2 do
    begin
      gx := (-1 * Ime[i-1, j-1]) + (1 * Ime[i+1, j-1]) +
            (-2 * Ime[i-1, j])   + (2 * Ime[i+1, j]) +
            (-1 * Ime[i-1, j+1]) + (1 * Ime[i+1, j+1]);

      gy := (-1 * Ime[i-1, j-1]) + (-2 * Ime[i, j-1]) + (-1 * Ime[i+1, j-1]) +
            (1 * Ime[i-1, j+1]) + (2 * Ime[i, j+1]) + (1 * Ime[i+1, j+1]);

      mag[i, j] := round(sqrt(gx * gx + gy * gy));
      if gx = 0 then
      begin
        if gy > 0 then
          theta := 90
        else if gy < 0 then
          theta := -90
        else
          theta := 0; // gx = 0 e gy = 0 → sem borda, direção indefinida
      end
      else
      begin
        theta := round(arctan(gy / gx) * 180 / pi);
      end;
      dir[i,j] := theta;


    end;


  min := mag[1, 1];
  max := mag[1, 1];


  for j := 1 to Image1.Height - 2 do
    for i := 1 to Image1.Width - 2 do
    begin
      if min > mag[i, j] then min := mag[i, j];
      if max < mag[i, j] then max := mag[i, j];
    end;


  if max = min then max := min + 1;


  for j := 1 to Image1.Height - 2 do
    for i := 1 to Image1.Width - 2 do

    begin
      Ims[i, j] := round((mag[i, j] - min) / (max - min) * 255);
      Image2.Canvas.Pixels[i, j] := RGB(Ims[i, j], Ims[i, j], Ims[i, j]);
    end;
end;
{*Binarização da imagem*}
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  lim : LongInt;
  cor:Integer;
begin
   lim := StrToInt(Edit5.Text);
   for i:=0 to (Image1.Height-2)do
     for j:=0 to (Image1.Width-2)do
     begin
       cor:= GetRValue(Image1.canvas.Pixels[i,j]);
       if cor>=lim then
         Image2.Canvas.Pixels[i,j]:=RGB(255, 255, 255)
       else
           Image2.Canvas.Pixels[i,j] := RGB(0,0,0);
     end;
end;
{*Equalização da Imagem*}
procedure TForm1.MenuItem16Click(Sender: TObject);
var
  nColunas, nLinhas:Integer;
  hist, histAcu: array[0 .. 255] of Integer;
  novoValor: array[0..255] of Byte;
  cor : TColor;
  cinza: Byte;
begin
  nColunas := Image1.Width;
  nLinhas := Image1.Height;


  for i:=0 to 255 do
  begin
    hist[i] := 0;
    histAcu[i] := 0;
    novoValor[i]:= 0;
  end;

  for i:= 0 to nColunas-1 do
   for j:= 0 to nLinhas-1 do
   begin
     cor := Image1.Canvas.Pixels[i,j];
     cinza:= GetRValue(cor);
     Inc(hist[cinza]);
   end;

  for i:=1 to 255 do
  begin
    histAcu[i]:= histAcu[i-1] + hist[i];
  end;

  for i:= 0 to 255 do
  begin
    novoValor[i] := max(0, round((255*histAcu[i])/(nColunas*nLinhas))-1);
  end;

  for i:=0 to nColunas-1 do
    for j:=0 to nLinhas-1 do
    begin
      cinza := GetRValue(Image1.Canvas.pixels[i,j]);

      Image2.Canvas.Pixels[i,j] := RGB(novoValor[cinza],novoValor[cinza],novoValor[cinza]);
    end;


end;

(*Compressão*)
procedure TForm1.MenuItem17Click(Sender: TObject);
var C, Y, RNormalizado, Intermediario: Double;
var i, j, R, S: Integer;
begin
  C := StrToFloat(Edit3.Text);
  Y := StrToFloat(Edit4.Text);

  for i := 0 to Image1.Width - 1 do
      for j := 0 to Image1.Height - 1 do
      begin
           R := GetRValue(Image1.Canvas.pixels[i,j]);
           RNormalizado := R / 255;
           Intermediario := C * power(RNormalizado, Y);
           S := Round(Intermediario * 255);
           if S > 255 then S := 255;
           if S < 0 then S := 0;
           Image2.Canvas.pixels[i,j] := RGB(S, S, S);
      end;
end;
{*Laplaciano Vizinhança 4*}
procedure TForm1.MenuItem18Click(Sender: TObject);
var
  i, j, corEq, min, max: integer;
  cor: array[0..511, 0..511] of integer;
begin

  for i := 0 to 511 do
    for j := 0 to 511 do
      cor[i, j] := 0;

  min := 2147483647;
  max := -2147483648;


  for i := 1 to Image1.Height - 2 do
    for j := 1 to Image1.Width - 2 do
    begin
      cor[i, j] :=
        -1 * (Image1.Canvas.Pixels[j - 1, i] +
              Image1.Canvas.Pixels[j + 1, i] +
              Image1.Canvas.Pixels[j, i - 1] +
              Image1.Canvas.Pixels[j, i + 1]) +
         4 * Image1.Canvas.Pixels[j, i];


      if cor[i, j] < min then min := cor[i, j];
      if cor[i, j] > max then max := cor[i, j];
    end;


  if max = min then max := min + 1;


  for i := 1 to Image1.Height - 2 do
    for j := 1 to Image1.Width - 2 do
    begin
      corEq := Round(((cor[i, j] - min) / (max - min)) * 255);


      if corEq < 0 then corEq := 0;
      if corEq > 255 then corEq := 255;

      Image2.Canvas.Pixels[j, i] := RGB(corEq, corEq, corEq);
    end;
end;

{*limiarização*}
procedure TForm1.MenuItem19Click(Sender: TObject);
var
  lim, cor: Integer ;
  i, j: Integer;
begin
  lim := StrToInt(Edit5.Text);

  for i := 0 to (Image1.Height - 2) do
    for j := 0 to (Image1.Width - 2) do
    begin
      cor := GetRValue(Image1.Canvas.Pixels[j, i]);
      if cor >= lim then
        Image2.Canvas.Pixels[j, i] := Image1.Canvas.Pixels[j, i]
      else
        Image2.Canvas.Pixels[j, i] := RGB(0, 0, 0);
    end;
end;
 {*Somar duas imagens*}
procedure TForm1.MenuItem20Click(Sender: TObject);
var
  soma, cor1, normal, cor2: Integer;

begin
  for i:= 0 to Image1.Height-1 do
   for j:= 0  to Image1.Width-1 do
   begin

     cor1 := GetRValue(Image1.Canvas.Pixels[i,j]);
     cor2 := GetRValue(Image2.Canvas.Pixels[i,j]);

     soma := cor1 + cor2;
     normal := round((soma-255)/255*255);
     Image3.Canvas.Pixels[i,j]:=RGB(normal,normal,normal);
   end;

end;


(*Passar Imagem da Direita para a Esquerda*)
procedure TForm1.Button1Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          ime[i, j] := ims[i , j];

  Image1.Picture := Image2.Picture;

end;
{*Magnitude*}
procedure TForm1.Edit1Change(Sender: TObject);
begin

end;
{*Direção*}
procedure TForm1.Edit2Change(Sender: TObject);
begin

end;
{*C para Compressão*}
procedure TForm1.Edit3Change(Sender: TObject);
begin

end;
{*Y para Compressão*}
procedure TForm1.Edit4Change(Sender: TObject);
begin

end;

{*Limiar*}
procedure TForm1.Edit5Change(Sender: TObject);
begin

end;

procedure TForm1.Edit6Change(Sender: TObject);
begin

end;


(*Sub-Menu 1*)
procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin

end;

(*Discrete Cosine Transformation*)
procedure TForm1.MenuItem22Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, Somatorios, CUV: double;
begin
  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        if i = 0 then
        begin
          alphaU := sqrt(1/128);
        end
        else
        begin
          alphaU := sqrt(2/128);
        end;

        if j = 0 then
        begin
          alphaV := sqrt(1/128);
        end
        else
        begin
          alphaV := sqrt(2/128);
        end;

        Somatorios := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              cor := getRValue(Image1.Canvas.Pixels[u,v]);
              Somatorios := Somatorios + cor * Cos(((2 * u + 1) * i * Pi) / (2 * 128)) * Cos(((2 * v + 1) * j * Pi) / (2 * 128));
            end;

        CUV := alphaU * alphaV * Somatorios;
        matrizC[i,j] := Round(CUV);
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        if matrizC[i,j] > 255 then
        begin
           Image2.Canvas.Pixels[i,j] := RGB(255, 255, 255);
        end
        else
        begin
          if matrizC[i,j] < 0 then
          begin
            Image2.Canvas.Pixels[i,j] := RGB(0, 0, 0);
          end
          else
          begin
            Image2.Canvas.Pixels[i,j] := RGB(matrizC[i,j], matrizC[i,j], matrizC[i,j]);
          end;
        end;
      end;
end;

(*Inverse Discrete Cosine Transform*)
procedure TForm1.MenuItem23Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, CUV: double;
begin
  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        CUV := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              if u = 0 then
              begin
                alphaU := sqrt(1/128);
              end
              else
              begin
                alphaU := sqrt(2/128);
              end;

              if v = 0 then
              begin
                alphaV := sqrt(1/128);
              end
              else
              begin
                alphaV := sqrt(2/128);
              end;

              cor := matrizC[u, v];
              CUV := CUV + alphaU * alphaV * cor * Cos(((2 * i + 1) * u * Pi) / (2 * 128)) * Cos(((2 * j + 1) * v * Pi) / (2 * 128));
            end;

        matrizF[i,j] := Round(CUV);
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        Image2.Canvas.Pixels[i,j] := RGB(matrizF[i,j], matrizF[i,j], matrizF[i,j]);
      end;
end;

(*Inverse DCT Filtro Passa Baixa*)
procedure TForm1.MenuItem24Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, CUV: double;
var matrizCopia, matrizResultado: array [0..127, 0..127] of integer;
begin
  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        if Sqrt(i*i + j*j) >= StrToFloat(Edit6.Text) then
        begin
          matrizCopia[i,j] := 0;
        end
        else
        begin
          matrizCopia[i,j] := matrizC[i,j];
        end;
      end;


  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        CUV := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              if u = 0 then
              begin
                alphaU := sqrt(1/128);
              end
              else
              begin
                alphaU := sqrt(2/128);
              end;

              if v = 0 then
              begin
                alphaV := sqrt(1/128);
              end
              else
              begin
                alphaV := sqrt(2/128);
              end;

              cor := matrizCopia[u, v];
              CUV := CUV + alphaU * alphaV * cor * Cos(((2 * i + 1) * u * Pi) / (2 * 128)) * Cos(((2 * j + 1) * v * Pi) / (2 * 128));
            end;

        matrizResultado[i,j] := Round(CUV);
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
      Image2.Canvas.Pixels[i, j] := RGB(matrizResultado[i, j], matrizResultado[i, j], matrizResultado[i, j]);
      end;
end;

(*Inverse DCT Filtro Passa Alta*)
procedure TForm1.MenuItem25Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, CUV: double;
var matrizCopia, matrizResultado: array [0..127, 0..127] of integer;
begin
  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        if Sqrt(i*i + j*j) <= StrToFloat(Edit6.Text) then
        begin
          matrizCopia[i,j] := 0;
        end
        else
        begin
          matrizCopia[i,j] := matrizC[i,j];
        end;
      end;


  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        CUV := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              if u = 0 then
              begin
                alphaU := sqrt(1/128);
              end
              else
              begin
                alphaU := sqrt(2/128);
              end;

              if v = 0 then
              begin
                alphaV := sqrt(1/128);
              end
              else
              begin
                alphaV := sqrt(2/128);
              end;

              cor := matrizCopia[u, v];
              CUV := CUV + alphaU * alphaV * cor * Cos(((2 * i + 1) * u * Pi) / (2 * 128)) * Cos(((2 * j + 1) * v * Pi) / (2 * 128));
            end;

        matrizResultado[i,j] := Max(0, Min(255, Round(CUV)));
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
      Image2.Canvas.Pixels[i, j] := RGB(matrizResultado[i, j], matrizResultado[i, j], matrizResultado[i, j]);
      end;
end;

(*Pseudo Cores*)
procedure TForm1.MenuItem26Click(Sender: TObject);
var i, j, tomDeCinza: integer;
var matriz: array [0..913, 0..457] of integer;
var tabelaCores: array[0..255, 0..2] of integer;
var matrizColorida: array [0..913, 0..457] of TColor;
begin
  if (OpenDialog1.Execute)
     then Image3.Picture.LoadFromFile(OpenDialog1.FileName);

  for i := 0 to 913 do
      for j := 0 to 457 do
      begin
           matriz[i,j] := GetRValue(Image3.Canvas.Pixels[i,j]);
      end;

  (*Montando Tabela de Cores*)
  for i := 0 to 255 do
  begin
    if i < 64 then
    begin
      tabelaCores[i,0] := 0;
      tabelaCores[i,1] := 0;
      tabelaCores[i,2] := i * 4;
    end;

    if (i >= 64) and (i < 128) then
    begin
      tabelaCores[i,0] := 0;
      tabelaCores[i,1] := (i - 64) * 4;
      tabelaCores[i,2] := 255;
    end;

    if (i >= 128) and (i < 192) then
    begin
      tabelaCores[i,0] := 0;
      tabelaCores[i,1] := 255;
      tabelaCores[i,2] := 255 - (i - 128) * 4;
    end;

    if i >= 192 then
    begin
      tabelaCores[i,0] := (i - 192) * 4;
      tabelaCores[i,1] := 255;
      tabelaCores[i,2] := 0;
    end;
  end;

  (*Carregando numa matriz RGB*)
  for i := 0 to 913 do
      for j := 0 to 457 do
      begin
        tomDeCinza := matriz[i,j];
        matrizColorida[i,j] := RGB(tabelaCores[tomDeCinza, 0], tabelaCores[tomDeCinza, 1], tabelaCores[tomDeCinza, 2]);
      end;

  for i := 0 to 913 do
      for j := 0 to 457 do
      begin
        Image3.Canvas.Pixels[i,j] := matrizColorida[i,j];
      end;
end;
{*Filtro do máximo*}
procedure TForm1.MenuItem27Click(Sender: TObject);
var
 max, pixel: integer;
begin
  for i := 1 to Image1.Width - 2 do
    for j := 1 to Image1.Height - 2 do
    begin
      max := 0;

      for x := -1 to 1 do
        for y := -1 to 1 do
        begin
          pixel := GetRValue(ColorToRGB(Image1.Canvas.Pixels[i + x, j + y]));
          if pixel > max then
            max := pixel;
        end;

      Image2.Canvas.Pixels[i, j] := RGB(max, max, max);
    end;
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
var
   min, pixel: integer;
begin
  for i := 1 to Image1.Width - 2 do
    for j := 1 to Image1.Height - 2 do
    begin
      min := 256;

      for x := -1 to 1 do
        for y := -1 to 1 do
        begin
          pixel := GetRValue(ColorToRGB(Image1.Canvas.Pixels[i + x, j + y]));
          if pixel < min then
            min := pixel;
        end;

      Image2.Canvas.Pixels[i, j] := RGB(min, min, min);
    end;
end;
{*Ponto Médio*}
procedure TForm1.MenuItem29Click(Sender: TObject);
var
   max, min, pixel: integer;
begin
  for i := 1 to Image1.Width - 2 do
    for j := 1 to Image1.Height - 2 do
    begin
      min := 256;
      max := -1;

      for x := -1 to 1 do
        for y := -1 to 1 do
        begin
          pixel := GetRValue(ColorToRGB(Image1.Canvas.Pixels[i + x, j + y]));
          if pixel < min then
            min := pixel;
          if pixel > max then
            max := pixel
        end;
      pixel:= round(1/2*(max+min));
      Image2.Canvas.Pixels[i, j] := RGB(pixel, pixel, pixel);
    end;
end;


(*Abrir Imagem*)
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)
     then Image1.Picture.LoadFromFile(OpenDialog1.FileName);
     for i:= 0 to Image1.Height do
       for j:= 0 to Image1.Width do
         begin
              ime[i,j] := GetRValue(Image1.Canvas.Pixels[i,j]);
         end;
end;

procedure TForm1.HSLtoRGB(H, S, L: Integer; var R, G, B: Integer);
var
  C, X, HLinha, M, R1, G1, B1, H1, S1, L1 : Double;
begin
  H1 := H / 255.0 * 360.0;
  S1 := S / 255.0;
  L1 := L / 255.0;

  C := (1 - Abs(2 * L1 - 1)) * S1;
  HLinha := H1 / 60.0;
  X := C * (1 - Abs(Frac(HLinha) * 2 - 1));

  if (HLinha >= 0) and (HLinha < 1) then
  begin
    R1 := C; G1 := X; B1 := 0;
  end
  else if (HLinha >= 1) and (HLinha < 2) then
  begin
    R1 := X; G1 := C; B1 := 0;
  end
  else if (HLinha >= 2) and (HLinha < 3) then
  begin
    R1 := 0; G1 := C; B1 := X;
  end
  else if (HLinha >= 3) and (HLinha < 4) then
  begin
    R1 := 0; G1 := X; B1 := C;
  end
  else if (HLinha >= 4) and (HLinha < 5) then
  begin
    R1 := X; G1 := 0; B1 := C;
  end
  else
  begin
    R1 := C; G1 := 0; B1 := X;
  end;

  M := L1 - C / 2;

  R := Round((R1 + M) * 255);
  G := Round((G1 + M) * 255);
  B := Round((B1 + M) * 255);
end;

procedure TForm1.RGBtoHSL(R, G, B : Integer; var H, S, L: Integer);
var
  R1, G1, B1, XMax, XMin, C, H1, S1, L1 : Double;
begin
  R1 := R / 255.0;
  G1 := G / 255.0;
  B1 := B / 255.0;

  XMax := Max(R1, Max(G1, B1));
  XMin := Min(R1, Min(G1, B1));
  C := XMax - XMin;
  L1 := (XMax + XMin) / 2;

  if C = 0 then
    H1 := 0
  else if XMax = R1 then
    H1 := 60.0 * ((G1 - B1) / C)
  else if XMax = G1 then
    H1 := 60.0 * ((B1 - R1) / C + 2)
  else
    H1 := 60.0 * ((R1 - G1) / C + 4);

  if H1 < 0 then
    H1 := H1 + 360.0;

  if (L1 = 0) or (L1 = 1) then
    S1 := 0
  else
    S1 := C / (1 - Abs(2 * L1 - 1));

  H := Round(H1 / 360.0 * 255);
  S := Round(S1 * 255);
  L := Round(L1 * 255);
end;

(*Equalização Histograma HSL*)
procedure TForm1.MenuItem30Click(Sender: TObject);
var
  i, j: integer;
  matrizH, matrizS, matrizL, matrizLModificada: array[0..511, 0..511] of integer;
  H, S, L, R, G, B: integer;
  hist, histAcu: array [0..255] of integer;
  novoValor: array [0..255] of Byte;
begin
  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      RGBtoHSL(GetRValue(Image1.Canvas.Pixels[i,j]), GetGValue(Image1.Canvas.Pixels[i,j]), GetBValue(Image1.Canvas.Pixels[i,j]), H, S, L);
      matrizH[i,j] := H;
      matrizS[i,j] := S;
      matrizL[i,j] := L;
    end;

  for i := 0 to 255 do
  begin
    hist[i] := 0;
    histAcu[i] := 0;
    novoValor[i] := 0;
  end;

  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      Inc(hist[matrizL[i,j]]);
    end;

  histAcu[0] := hist[0];
  for i := 1 to 255 do
  begin
    histAcu[i] := histAcu[i-1] + hist[i];
  end;

  for i := 0 to 255 do
  begin
    novoValor[i] := Min(255, Round(255 * histAcu[i] / (512 * 512)));
  end;

  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      matrizLModificada[i,j] := novoValor[matrizL[i,j]];
    end;

  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      HSLtoRGB(matrizH[i,j], matrizS[i,j], matrizLModificada[i,j], R, G, B);
      Image2.Canvas.Pixels[i,j] := RGB(R, G, B);
    end;
end;

(*Laplaciano e Laplaciano Gaussiana Side by Side*)
procedure TForm1.MenuItem31Click(Sender: TObject);
var
   cor: array[0..4, 0..4] of integer;
   soma: integer;
   i, j, corEq, min, max: integer;
   cor1: array[0..511, 0..511] of integer;
begin
  (*Laplaciano N4*)
  for i := 0 to 511 do
    for j := 0 to 511 do
      cor1[i, j] := 0;

  min := 2147483647;
  max := -2147483648;


  for i := 1 to Image1.Height - 2 do
    for j := 1 to Image1.Width - 2 do
    begin
      cor1[i, j] :=
        -1 * (Image1.Canvas.Pixels[j - 1, i] +
              Image1.Canvas.Pixels[j + 1, i] +
              Image1.Canvas.Pixels[j, i - 1] +
              Image1.Canvas.Pixels[j, i + 1]) +
         4 * Image1.Canvas.Pixels[j, i];


      if cor1[i, j] < min then min := cor1[i, j];
      if cor1[i, j] > max then max := cor1[i, j];
    end;


  if max = min then max := min + 1;


  for i := 1 to Image1.Height - 2 do
    for j := 1 to Image1.Width - 2 do
    begin
      corEq := Round(((cor1[i, j] - min) / (max - min)) * 255);


      if corEq < 0 then corEq := 0;
      if corEq > 255 then corEq := 255;

      Image1.Canvas.Pixels[j, i] := RGB(corEq, corEq, corEq);
    end;

  (*Laplaciano da Gaussiana*)
  for i :=0 to 4 do
    for j:=0 to 4 do
      begin
        cor[i,j] := 0;
      end;
  cor[0,2]:=-1;
  cor[1,1]:=-1;
  cor[2,0]:=-1;
  cor[3,1]:=-1;
  cor[4,2]:=-1;
  cor[3,3]:=-1;
  cor[2,4]:=-1;
  cor[1,3]:=-1;
  cor[1,2]:=-2;
  cor[2,1]:=-2;
  cor[3,2]:=-2;
  cor[2,3]:=-2;
  cor[2,2]:=16;

  for i:=2 to Image1.Height -3 do
    for j:= 2 to Image1.Width - 3 do
      begin
        soma:=0;
        for x:= -2 to 2 do
          for y:= -2 to 2 do
            soma:= soma+ GetRValue(Ime[i+x,j+y])* cor[x+2,y+2];

        if soma < 0 then soma := 0;
        if soma > 255 then soma := 255;

        Image2.Canvas.Pixels[i,j] := RGB(soma, soma, soma);
      end;
end;

(*Otsu com Limiarização*)
procedure TForm1.MenuItem32Click(Sender: TObject);
var totalTons: array[0..255] of integer;
var probabilidadeTons: array[0..255] of float;
var i, j: integer;
var miTesao, varianciaTotal, w0, w1, miTesinho, u0, u1, varianciaLocal, minNi, limiarOtimo, ni, maxVarEntre : float;
begin
  for i := 0 to 255 do
  begin
    totalTons[i] := 0;
  end;

  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      totalTons[GetRValue(Image1.Canvas.Pixels[i,j])] := totalTons[GetRValue(Image1.Canvas.Pixels[i,j])] + 1;
    end;

  for i := 0 to 255 do
  begin
    probabilidadeTons[i] :=  totalTons[i] / (512 * 512);
  end;

  miTesao := 0.0;
  for i := 0 to 255 do
  begin
    miTesao := miTesao + i * probabilidadeTons[i];
  end;

  varianciaTotal := 0.0;
  for i := 0 to 255 do
  begin
    varianciaTotal := varianciaTotal + ((i - miTesao) * (i - miTesao)) * probabilidadeTons[i];
  end;

  maxVarEntre := -1.0;
  limiarOtimo := 0;

  for j := 0 to 255 do
  begin
    w0 := 0.0;
    miTesinho := 0.0;

    for i := 0 to j do
    begin
      w0 := w0 + probabilidadeTons[i];
    end;

    w1 := 1.0 - w0;

    for i := 0 to j do
    begin
      miTesinho := miTesinho + i * probabilidadeTons[i];
    end;

    if w0 > 0 then
    begin
       u0 := miTesinho / w0;
    end
    else
    begin
      u0 := 0.0;
    end;

    if w1 > 0 then
    begin
      u1 := (miTesao - miTesinho) / w1;
    end
    else
    begin
      u1 := 0.0;
    end;

    varianciaLocal := w0 * w1 * ((u1 - u0) * (u1 - u0));

    if varianciaTotal > 0 then
    begin
       ni := varianciaLocal / varianciaTotal;
    end
    else
    begin
      ni := MaxFloat;
    end;

    if varianciaLocal > maxVarEntre then
    begin
      maxVarEntre := varianciaLocal;
      limiarOtimo := j;
    end;
  end;

  for i := 0 to 511 do
      for j := 0 to 511 do
      begin
        if GetRValue(Image1.Canvas.Pixels[i,j]) >= Round(limiarOtimo) then
        begin
          Image2.Canvas.Pixels[i,j] := Image1.Canvas.Pixels[i,j];
        end
        else
        begin
          Image2.Canvas.Pixels[i,j] := RGB(0,0,0);
        end;
      end;
end;

(*Método Otsu com Binarização*)
procedure TForm1.MenuItem33Click(Sender: TObject);
var totalTons: array[0..255] of integer;
var probabilidadeTons: array[0..255] of float;
var i, j: integer;
var miTesao, varianciaTotal, w0, w1, miTesinho, u0, u1, varianciaLocal, minNi, limiarOtimo, ni, maxVarEntre : float;
begin
  for i := 0 to 255 do
  begin
    totalTons[i] := 0;
  end;

  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      totalTons[GetRValue(Image1.Canvas.Pixels[i,j])] := totalTons[GetRValue(Image1.Canvas.Pixels[i,j])] + 1;
    end;

  for i := 0 to 255 do
  begin
    probabilidadeTons[i] :=  totalTons[i] / (512 * 512);
  end;

  miTesao := 0.0;
  for i := 0 to 255 do
  begin
    miTesao := miTesao + i * probabilidadeTons[i];
  end;

  varianciaTotal := 0.0;
  for i := 0 to 255 do
  begin
    varianciaTotal := varianciaTotal + ((i - miTesao) * (i - miTesao)) * probabilidadeTons[i];
  end;

  maxVarEntre := -1.0;
  limiarOtimo := 0;

  for j := 0 to 255 do
  begin
    w0 := 0.0;
    miTesinho := 0.0;

    for i := 0 to j do
    begin
      w0 := w0 + probabilidadeTons[i];
    end;

    w1 := 1.0 - w0;

    for i := 0 to j do
    begin
      miTesinho := miTesinho + i * probabilidadeTons[i];
    end;

    if w0 > 0 then
    begin
       u0 := miTesinho / w0;
    end
    else
    begin
      u0 := 0.0;
    end;

    if w1 > 0 then
    begin
      u1 := (miTesao - miTesinho) / w1;
    end
    else
    begin
      u1 := 0.0;
    end;

    varianciaLocal := w0 * w1 * ((u1 - u0) * (u1 - u0));

    if varianciaTotal > 0 then
    begin
       ni := varianciaLocal / varianciaTotal;
    end
    else
    begin
      ni := MaxFloat;
    end;

    if varianciaLocal > maxVarEntre then
    begin
      maxVarEntre := varianciaLocal;
      limiarOtimo := j;
    end;
  end;

  for i := 0 to 511 do
      for j := 0 to 511 do
      begin
        if GetRValue(Image1.Canvas.Pixels[i,j]) >= Round(limiarOtimo) then
        begin
          Image2.Canvas.Pixels[i,j] := RGB(255,255,255);
        end
        else
        begin
          Image2.Canvas.Pixels[i,j] := RGB(0,0,0);
        end;
      end;
end;

(*Esqueleto com Zhang e Suen*)
procedure TForm1.MenuItem34Click(Sender: TObject);
var i, j, p1, p2, p3, p4, p5, p6, p7, p8, p9, N, S, Produto1, Produto2 : integer;
var ImagemAtual, MarcadosParaExcluir: array[0..319, 0..239] of integer;
var Alterado : Boolean;
begin
  for i := 0 to 319 do
      for j := 0 to 239 do
      begin
        ImagemAtual[i, j] := GetRValue(Image1.Canvas.Pixels[i,j]);
      end;

  Alterado := True;
  while Alterado do
  begin
    Alterado := False;
    (*Passo1*)
    for i := 0 to 319 do
        for j := 0 to 239 do
        begin
          MarcadosParaExcluir[i,j] := 0;
        end;

    for i := 1 to 318 do
        for j := 1 to 238 do
        begin
          p1 := ImagemAtual[i, j];
          if p1 <> 255 then Continue;

          p2 := ImagemAtual[i - 1, j];
          p3 := ImagemAtual[i - 1, j + 1];
          p4 := ImagemAtual[i, j + 1];
          p5 := ImagemAtual[i + 1, j + 1];
          p6 := ImagemAtual[i + 1, j];
          p7 := ImagemAtual[i + 1, j - 1];
          p8 := ImagemAtual[i, j - 1];
          p9 := ImagemAtual[i - 1, j - 1];

          N := 0;
          if p9 <> 0 then
          begin
             N := N + 1;
          end;
          if p2 <> 0 then
          begin
             N := N + 1;
          end;
          if p3 <> 0 then
          begin
             N := N + 1;
          end;
          if p8 <> 0 then
          begin
             N := N + 1;
          end;
          if p4 <> 0 then
          begin
             N := N + 1;
          end;
          if p7 <> 0 then
          begin
             N := N + 1;
          end;
          if p6 <> 0 then
          begin
             N := N + 1;
          end;
          if p5 <> 0 then
          begin
             N := N + 1;
          end;

          S := 0;
          if (p2 = 0) and (p3 = 255) then
          begin
            S := S + 1;
          end;
          if (p3 = 0) and (p4 = 255) then
          begin
            S := S + 1;
          end;
          if (p4 = 0) and (p5 = 255) then
          begin
            S := S + 1;
          end;
          if (p5 = 0) and (p6 = 255) then
          begin
            S := S + 1;
          end;
          if (p6 = 0) and (p7 = 255) then
          begin
            S := S + 1;
          end;
          if (p7 = 0) and (p8 = 255) then
          begin
            S := S + 1;
          end;
          if (p8 = 0) and (p9 = 255) then
          begin
            S := S + 1;
          end;
          if (p9 = 0) and (p2 = 255) then
          begin
            S := S + 1;
          end;

          Produto1 := p2 * p4 * p6;
          Produto2 := p4 * p6 * p8;

          if (N >= 2) and (N <= 6) and (S = 1) and (Produto1 = 0) and (Produto2 = 0) then
          begin
            MarcadosParaExcluir[i, j] := 1;
            Alterado := True;
          end;
        end;

    for i := 1 to 318 do
        for j := 1 to 238 do
        begin
          if MarcadosParaExcluir[i,j] = 1 then
          begin
            ImagemAtual[i, j] := 0;
          end;
        end;

    (*Passo2*)
    for i := 0 to 319 do
        for j := 0 to 239 do
        begin
          MarcadosParaExcluir[i,j] := 0;
        end;

    for i := 1 to 318 do
        for j := 1 to 238 do
        begin
          p1 := ImagemAtual[i, j];
          if p1 <> 255 then Continue;

          p2 := ImagemAtual[i - 1, j];
          p3 := ImagemAtual[i - 1, j + 1];
          p4 := ImagemAtual[i, j + 1];
          p5 := ImagemAtual[i + 1, j + 1];
          p6 := ImagemAtual[i + 1, j];
          p7 := ImagemAtual[i + 1, j - 1];
          p8 := ImagemAtual[i, j - 1];
          p9 := ImagemAtual[i - 1, j - 1];

          N := 0;
          if p9 <> 0 then
          begin;
             N := N + 1;
          end;
          if p2 <> 0 then
          begin
             N := N + 1;
          end;
          if p3 <> 0 then
          begin
             N := N + 1;
          end;
          if p8 <> 0 then
          begin
             N := N + 1;
          end;
          if p4 <> 0 then
          begin;
             N := N + 1;
          end;
          if p7 <> 0 then
          begin
             N := N + 1;
          end;
          if p6 <> 0 then
          begin
             N := N + 1;
          end;
          if p5 <> 0 then
          begin
             N := N + 1;
          end;

          S := 0;
          if (p2 = 0) and (p3 = 255) then
          begin
            S := S + 1;
          end;
          if (p3 = 0) and (p4 = 255) then
          begin
            S := S + 1;
          end;
          if (p4 = 0) and (p5 = 255) then
          begin
            S := S + 1;
          end;
          if (p5 = 0) and (p6 = 255) then
          begin
            S := S + 1;
          end;
          if (p6 = 0) and (p7 = 255) then
          begin
            S := S + 1;
          end;
          if (p7 = 0) and (p8 = 255) then
          begin
            S := S + 1;
          end;
          if (p8 = 0) and (p9 = 255) then
          begin
            S := S + 1;
          end;
          if (p9 = 0) and (p2 = 255) then
          begin
            S := S + 1;
          end;

          Produto1 := p2 * p4 * p8;
          Produto2 := p2 * p6 * p8;

          if (N >= 2) and (N <= 6) and (S = 1) and (Produto1 = 0) and (Produto2 = 0) then
          begin
            MarcadosParaExcluir[i, j] := 1;
            Alterado := True;
          end;
        end;

    for i := 1 to 318 do
        for j := 1 to 238 do
        begin
          if MarcadosParaExcluir[i,j] = 1 then
          begin
            ImagemAtual[i, j] := 0;
          end;
        end;

  end;

  for i := 0 to 319 do
      for j := 0 to 239 do
      begin
        Image2.Canvas.Pixels[i, j] := RGB(ImagemAtual[i, j], ImagemAtual[i, j], ImagemAtual[i, j]);
      end;
end;

{*Salvar Imagem 2*}
procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Image2.Picture.Bitmap.SaveToFile(SaveDialog1.FileName);
  end;
end;

(*Fechar Formulário*)
procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close();
end;

(*Sub-Menu 2*)
procedure TForm1.MenuItem5Click(Sender: TObject);
begin

end;

(*Converter para Cinza*)
procedure TForm1.MenuItem6Click(Sender: TObject);
var
  i, j: Integer;
  cor, r, g, b, c: Integer;
begin

  for i := 0 to 511 do
    for j := 0 to 511 do
      ime[i, j] := Image1.Canvas.Pixels[i, j];


  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      cor := ime[i, j];
      r := GetRValue(cor);
      g := GetGValue(cor);
      b := GetBValue(cor);
      c := Round(0.299 * r + 0.587 * g + 0.114 * b);
      ims[i, j] := c;
    end;


  for i := 0 to 511 do
    for j := 0 to 511 do
      Image2.Canvas.Pixels[i, j] := RGB(ims[i, j], ims[i, j], ims[i, j]);
end;


(*Negativa Cinza*)
procedure TForm1.MenuItem7Click(Sender: TObject);
begin

  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            ims[i, j] := 255 - Image1.Canvas.Pixels[i,j];
            Image2.Canvas.Pixels[i, j] := RGB(ims[i, j], ims[i, j], ims[i, j]);
          end;
end;

(*Negativa Colorida*)
procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            cor := Image1.Canvas.Pixels[i, j];
            r := GetRValue(cor);
            g := GetGValue(cor);
            b := GetBValue(cor);
            Image2.Canvas.Pixels[i, j] := RGB(255 - r,255 - g,255 - b);
          end;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin

end;

(*Comentado devido a necessidade de pseudo cores
(*Separar Canais RGB em Três Imagens*)
procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            cor := Image1.Canvas.Pixels[i, j];
            r := GetRValue(cor);
            g := GetGValue(cor);
            b := GetBValue(cor);
            Image3.Canvas.Pixels[i, j] := RGB(r,0,0);
            Image4.Canvas.Pixels[i, j] := RGB(0,g,0);
            Image5.Canvas.Pixels[i, j] := RGB(0,0,b);
          end;

end;
*)


end.

