unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, Unit2, Math,LCLType, LCLIntf;

type
  TDoubleMatrix = array of array of Double;
  TFiltroTipo = (ftMinimo, ftMaximo, ftPontoMedio);

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
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
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
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
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure CalcularDCT(imagem: TImage; var dct: TDoubleMatrix);
    procedure InversaDCT(const dct: TDoubleMatrix; destino: TImage);
    procedure HSLtoRGB(H, S, L: Integer; var R, G, B: Integer);




  private
       magnitudeArray: array of array of Double;
       MatMag: array of array of Integer;
       MatAng: array of array of Double;
  public

  end;

var
  Form1: TForm1;
  minDCT, maxDCT: Double;
  ModoInserirRuido: Boolean = False;



implementation

{$R *.lfm}

{ TForm1 }
// Converte valores HSL (Hue, Saturation, Lightness) para RGB
procedure TForm1.HSLtoRGB(H, S, L: Integer; var R, G, B: Integer);
var
  Hue, Saturation, Lightness: Double;
  Chroma, X, M: Double;
  Hr, Rtemp, Gtemp, Btemp: Double;
begin
  // Normalização dos valores de entrada
  Hue := H / 255.0 * 360.0;      // Converte H para o intervalo 0-360 graus
  Saturation := S / 255.0;       // Saturação normalizada de 0 a 1
  Lightness := L / 255.0;        // Luminosidade normalizada de 0 a 1

  // Cálculo da Chroma
  Chroma := (1 - Abs(2 * Lightness - 1)) * Saturation;
  Hr := Hue / 60.0;
  X := Chroma * (1 - Abs(Frac(Hr) * 2 - 1));

  // Inicialização das cores temporárias Rtemp, Gtemp e Btemp
  case Trunc(Hr) of
    0: begin Rtemp := Chroma; Gtemp := X;      Btemp := 0; end;
    1: begin Rtemp := X;      Gtemp := Chroma; Btemp := 0; end;
    2: begin Rtemp := 0;      Gtemp := Chroma; Btemp := X; end;
    3: begin Rtemp := 0;      Gtemp := X;      Btemp := Chroma; end;
    4: begin Rtemp := X;      Gtemp := 0;      Btemp := Chroma; end;
    else begin Rtemp := Chroma; Gtemp := 0;    Btemp := X; end;
  end;

  // Ajuste de luminosidade
  M := Lightness - (Chroma / 2);

  // Conversão final para escala de 0 a 255
  R := Round((Rtemp + M) * 255);
  G := Round((Gtemp + M) * 255);
  B := Round((Btemp + M) * 255);
end;


// Converte valores RGB para HSL (Hue, Saturation, Lightness)
procedure TForm1.RGBtoHSL(R, G, B: Integer; var H, S, L: Integer);
var
  Rnorm, Gnorm, Bnorm: Double;
  MaxVal, MinVal, Delta: Double;
  Hue, Saturation, Lightness: Double;
begin
  // Normalização dos valores RGB para 0-1
  Rnorm := R / 255.0;
  Gnorm := G / 255.0;
  Bnorm := B / 255.0;

  // Identificação dos valores máximo e mínimo entre os canais
  MaxVal := Max(Rnorm, Max(Gnorm, Bnorm));
  MinVal := Min(Rnorm, Min(Gnorm, Bnorm));
  Delta := MaxVal - MinVal;

  // Cálculo da luminosidade
  Lightness := (MaxVal + MinVal) / 2;

  // Cálculo da saturação
  if Delta = 0 then
    Saturation := 0
  else
    Saturation := Delta / (1 - Abs(2 * Lightness - 1));

  // Cálculo do matiz (Hue)
  if Delta = 0 then
    Hue := 0
  else if MaxVal = Rnorm then
    Hue := 60 * ((Gnorm - Bnorm) / Delta)
  else if MaxVal = Gnorm then
    Hue := 60 * (((Bnorm - Rnorm) / Delta) + 2)
  else
    Hue := 60 * (((Rnorm - Gnorm) / Delta) + 4);

  // Ajuste para manter Hue positivo
  if Hue < 0 then
    Hue := Hue + 360;

  // Conversão final para escala 0-255
  H := Round(Hue / 360.0 * 255);
  S := Round(Saturation * 255);
  L := Round(Lightness * 255);
end;


function GetGrayValue(Color: TColor): Byte;
begin
  Result := Round(0.299 * Red(Color) + 0.587 * Green(Color) + 0.114 * Blue(Color));
end;


//Filtro Minimo
procedure TForm1.MenuItem45Click(Sender: TObject);
  var
    bmp: Graphics.TBitmap;
    min, pixel, i, j, x, y: integer;
    cor: TColor;
  begin
    bmp := Graphics.TBitmap.Create;
    try
      bmp.Assign(Image1.Picture.Bitmap);  // Garante que o bitmap da imagem está carregado

      for i := 1 to bmp.Width - 2 do
        for j := 1 to bmp.Height - 2 do
        begin
          min := 256;

          for x := -1 to 1 do
            for y := -1 to 1 do
            begin
              cor := bmp.Canvas.Pixels[i + x, j + y];
              pixel := GetRValue(ColorToRGB(cor));  // Canal vermelho (tons de cinza)

              if pixel < min then
                min := pixel;
            end;

          Image2.Canvas.Pixels[i, j] := RGB(min, min, min);
        end;
    finally
      bmp.Free;
    end;
end;

 //Maximo
procedure TForm1.MenuItem46Click(Sender: TObject);
var
  bmp: Graphics.TBitmap;
  max, pixel, i, j, x, y: integer;
  cor: TColor;
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);  // Carregar a imagem de forma segura

    for i := 1 to bmp.Width - 2 do
      for j := 1 to bmp.Height - 2 do
      begin
        max := 0;

        for x := -1 to 1 do
          for y := -1 to 1 do
          begin
            cor := bmp.Canvas.Pixels[i + x, j + y];
            pixel := GetRValue(ColorToRGB(cor));  // Pegando o canal vermelho (R)

            if pixel > max then
              max := pixel;
          end;

        Image2.Canvas.Pixels[i, j] := RGB(max, max, max);
      end;
  finally
    bmp.Free;
  end;
end;

//PontoMedio
procedure TForm1.MenuItem47Click(Sender: TObject);
var
  bmp: Graphics.TBitmap;
  max, min, pixel, i, j, x, y: integer;
  cor: TColor;
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);  // Forçar o carregamento real da imagem

    for i := 1 to bmp.Width - 2 do
      for j := 1 to bmp.Height - 2 do
      begin
        min := 256;
        max := -1;

        for x := -1 to 1 do
          for y := -1 to 1 do
          begin
            cor := bmp.Canvas.Pixels[i + x, j + y];
            pixel := GetRValue(ColorToRGB(cor));  // Pega o canal R (como estamos tratando imagem em tons de cinza)

            if pixel < min then
              min := pixel;
            if pixel > max then
              max := pixel;
          end;

        pixel := round((max + min) / 2);  // Corrigido o cálculo da média

        Image2.Canvas.Pixels[i, j] := RGB(pixel, pixel, pixel);
      end;
  finally
    bmp.Free;
  end;
end;

procedure TForm1.MenuItem48Click(Sender: TObject);
var
  bmp: Graphics.TBitmap;
  i, j: Integer;
  H, S, L, R, G, B: Integer;
  hist, histAcu: array [0..255] of Integer;
  novoValor: array [0..255] of Byte;
  matrizH, matrizS, matrizL, matrizLModificada: array [0..511, 0..511] of Integer;
  largura, altura: Integer;
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);  // Garantia que a imagem está carregada corretamente
    largura := bmp.Width;
    altura := bmp.Height;

    // ======== ETAPA 1 - Conversão RGB para HSL e construção da matriz L ========
    for i := 0 to largura - 1 do
      for j := 0 to altura - 1 do
      begin
        RGBtoHSL(
          GetRValue(ColorToRGB(bmp.Canvas.Pixels[i, j])),
          GetGValue(ColorToRGB(bmp.Canvas.Pixels[i, j])),
          GetBValue(ColorToRGB(bmp.Canvas.Pixels[i, j])),
          H, S, L
        );

        matrizH[i, j] := H;
        matrizS[i, j] := S;
        matrizL[i, j] := L;
      end;

    // ======== ETAPA 2 - Cálculo do Histograma e Histograma Acumulado ========
    FillChar(hist, SizeOf(hist), 0);
    FillChar(histAcu, SizeOf(histAcu), 0);
    FillChar(novoValor, SizeOf(novoValor), 0);

    for i := 0 to largura - 1 do
      for j := 0 to altura - 1 do
        Inc(hist[matrizL[i, j]]);

    histAcu[0] := hist[0];
    for i := 1 to 255 do
      histAcu[i] := histAcu[i - 1] + hist[i];

    // ======== ETAPA 3 - Mapeamento dos novos valores de L ========
    for i := 0 to 255 do
      novoValor[i] := Min(255, Round(255 * histAcu[i] / (largura * altura)));

    for i := 0 to largura - 1 do
      for j := 0 to altura - 1 do
        matrizLModificada[i, j] := novoValor[matrizL[i, j]];

    // ======== ETAPA 4 - Conversão de volta para RGB ========
    for i := 0 to largura - 1 do
      for j := 0 to altura - 1 do
      begin
        HSLtoRGB(matrizH[i, j], matrizS[i, j], matrizLModificada[i, j], R, G, B);
        Image2.Canvas.Pixels[i, j] := RGB(R, G, B);
      end;
  finally
    bmp.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;
//Output Magnitude
procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

//Botão Definir
procedure TForm1.Button2Click(Sender: TObject);
begin

end;
//Botão de Seta
procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Picture := Image2.Picture;
end;

//Input T
procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

//Output Direção
procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

//Compressão Escala Dinâmica
procedure TForm1.MenuItem10Click(Sender: TObject);
  var
  x, y: Integer;
  r, g, b: Byte;
  rf, gf, bf: Double;
  c, gamma: Double;
  cStr, gStr: String;
begin
  // Obtém os valores c e gamma do usuário
  if not InputQuery('Compressão', 'Digite o valor de c (Maior que 0):', cStr) then Exit;
  if not InputQuery('Compressão', 'Digite o valor de y (gama) (Maior que 0):', gStr) then Exit;

  c := StrToFloat(cStr);
  gamma := StrToFloat(gStr);

  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Picture.Bitmap.Height - 1 do
  begin
    for x := 0 to Image1.Picture.Bitmap.Width - 1 do
    begin
      r := Red(Image1.Canvas.Pixels[x, y]);
      g := Green(Image1.Canvas.Pixels[x, y]);
      b := Blue(Image1.Canvas.Pixels[x, y]);

      rf := r / 255;
      gf := g / 255;
      bf := b / 255;

      rf := c * Power(rf, gamma);
      gf := c * Power(gf, gamma);
      bf := c * Power(bf, gamma);

      r := Round(EnsureRange(rf * 255, 0, 255));
      g := Round(EnsureRange(gf * 255, 0, 255));
      b := Round(EnsureRange(bf * 255, 0, 255));

      Image2.Canvas.Pixels[x, y] := RGBToColor(r, g, b);
    end;
  end;

end;
//Equalizar
procedure TForm1.MenuItem11Click(Sender: TObject);
var
  i, j,x,y,Cinza: Integer;
  Histograma, Freq_Acumulada, novoValor: array[0..255] of Integer;
  Cor: TColor;
  imagem_width, imagem_height, totalPixels: Integer;
begin
  imagem_width := Image1.Width;
  imagem_height := Image1.Height;
  totalPixels := imagem_width * imagem_height;
  Image2.Width:= imagem_width;
  Image2.Height:= imagem_height;

  for i := 0 to 255 do
  begin
    Histograma[i] := 0;               //começa o histrogama setado em 0
    Freq_Acumulada[i] := 0;
  end;

  //Histograma da Imagem1
  for y := 0 to imagem_height - 1 do
    for x := 0 to imagem_width - 1 do
    begin
      Cor := Image1.Canvas.Pixels[x,y];
      Cinza :=Round((GetRValue(Cor) + GetGValue(Cor) + GetBValue(Cor))/3);
      Histograma[Cinza] := Histograma[Cinza] + 1;
    end;

  // Calculadno a Frequencia acumulada dCt
  Freq_Acumulada[0] := Histograma[0];
  for i := 1 to 255 do
    Freq_Acumulada[i] := Freq_Acumulada[i - 1] + Histograma[i];

  //Fórmula da Equalização
  for i := 0 to 255 do
    novoValor[i] := Round((Freq_Acumulada[i] * 255) / totalPixels);

  // Imagem2 equalizada
  for y := 0 to imagem_height - 1 do
    for x := 0 to imagem_width - 1 do
    begin
      Cor := Image1.Canvas.Pixels[x, y];
      Cinza := (GetRValue(Cor) + GetGValue(Cor) + GetBValue(Cor)) div 3;
      Cinza := novoValor[Cinza];
      Image2.Canvas.Pixels[x, y] := RGB(Cinza, Cinza, Cinza);
    end;
end;


//Suavizar Média Np(4)
procedure TForm1.MenuItem13Click(Sender: TObject);
var
  x, y: Integer;
  sum_Red, sum_Green, sum_Blue: Integer;
  pixelColor: TColor;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
    begin
      // Se for borda, copia direto
      if (x = 0) or (y = 0) or (x = Image1.Width - 1) or (y = Image1.Height - 1) then
      begin
        Image2.Picture.Bitmap.Canvas.Pixels[x, y] := Image1.Picture.Bitmap.Canvas.Pixels[x, y];
      end
      else
      begin
        sum_Red := 0;
        sum_Green := 0;
        sum_Blue := 0;

        // Pixel central
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x, y];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);

        // Direita
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x + 1, y];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);

        // Esquerda
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x - 1, y];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);

        // Cima
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x, y - 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);

        // Baixo
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x, y + 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);

        // Aplicar média (5 pixels)
        Image2.Picture.Bitmap.Canvas.Pixels[x, y] :=
          RGBToColor(
            Round(sum_Red / 5),
            Round(sum_Green / 5),
            Round(sum_Blue / 5)
          );
      end;
    end;
end;
 //Média Np8
procedure TForm1.MenuItem14Click(Sender: TObject);
var
  x, y: Integer;
  sum_Red, sum_Green, sum_Blue: Integer;
  pixelColor: TColor;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
    begin
      // Mantem a borda igual a original pra não dar problema
      if (y = 0) or (x = 0) or (y = Image1.Height - 1) or (x = Image1.Width - 1) then
      begin
        Image2.Picture.Bitmap.Canvas.Pixels[x, y] := Image1.Picture.Bitmap.Canvas.Pixels[x, y];
      end
      else
      begin
        sum_Red := 0;
        sum_Green := 0;
        sum_Blue := 0;

        // Central
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x, y]; // centro
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Direita
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x + 1, y];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Esquerda
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x - 1, y];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Cima
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x, y - 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Baixo
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x, y + 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Inferior direita
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x + 1, y + 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Inferior esquerda
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x - 1, y + 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Superior direita
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x + 1, y - 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Superior Esquerda
        pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x - 1, y - 1];
        sum_Red := sum_Red + Red(pixelColor);
        sum_Green := sum_Green + Green(pixelColor);
        sum_Blue := sum_Blue + Blue(pixelColor);
        //Soma tudo e divide por 9
        Image2.Picture.Bitmap.Canvas.Pixels[x, y] :=
          RGBToColor(
            Round(sum_Red / 9),
            Round(sum_Green / 9),
            Round(sum_Blue / 9)
          );
      end;
    end;
end;
 //Ordenar vetor - Função Auxiliar NÂO CHAMADA NA INTERFACE
procedure OrdenaVetorByte(var A: array of Byte);
var
  i, j: Integer;
  temp: Byte;
begin
  for i := Low(A) to High(A) - 1 do
    for j := i + 1 to High(A) do
      if A[i] > A[j] then
      begin
        temp := A[i];
        A[i] := A[j];
        A[j] := temp;
      end;
end;


//Mediana 3x3
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  x, y, i, j, k: Integer;
  R, G, B: array[0..8] of Byte;
  pixelColor: TColor;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
    begin
      if (x = 0) or (y = 0) or (x = Image1.Width - 1) or (y = Image1.Height - 1) then  //Pra nao ter as bordas pretas
        Image2.Picture.Bitmap.Canvas.Pixels[x, y] := Image1.Picture.Bitmap.Canvas.Pixels[x, y]
      else
      begin
        k := 0;
        for j := -1 to 1 do
          for i := -1 to 1 do
          begin
            pixelColor := Image1.Picture.Bitmap.Canvas.Pixels[x + i, y + j];
            R[k] := Red(pixelColor);
            G[k] := Green(pixelColor);
            B[k] := Blue(pixelColor);
            Inc(k);
          end;

        OrdenaVetorByte(R);
        OrdenaVetorByte(G);
        OrdenaVetorByte(B);

        Image2.Picture.Bitmap.Canvas.Pixels[x, y] := RGBToColor(R[4], G[4], B[4]);
      end;
    end;
end;

  /// Gerar Ruído: Sal e Pimenta
procedure TForm1.MenuItem17Click(Sender: TObject);
var
  x, y, i: Integer;
  size, totalNoise: Integer;
  pixelColor: TColor;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  // Copiar imagem original para Image2
  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
      Image2.Picture.Bitmap.Canvas.Pixels[x, y] := Image1.Picture.Bitmap.Canvas.Pixels[x, y];

  // Gerar ruído
  size := Image2.Width * Image2.Height;
  totalNoise := size div 10;

  for i := 0 to totalNoise do
  begin
    x := Random(Image2.Width);
    y := Random(Image2.Height);

    if Random(2) = 0 then
      pixelColor := RGB(0, 0, 0)         // Pimenta (preto)
    else
      pixelColor := RGB(255, 255, 255);  // Sal (branco)

    Image2.Picture.Bitmap.Canvas.Pixels[x, y] := pixelColor;
  end;
end;


// Inverter Eixo Horizontal
procedure TForm1.MenuItem19Click(Sender: TObject);
var
  x, y: Integer;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
    begin
      Image2.Picture.Bitmap.Canvas.Pixels[Image1.Width - 1 - x, y] :=
        Image1.Picture.Bitmap.Canvas.Pixels[x, y];
    end;
end;

 //Inverter Eixo Vertical
procedure TForm1.MenuItem20Click(Sender: TObject);
var
  x, y: Integer;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
    begin
      Image2.Picture.Bitmap.Canvas.Pixels[x,Image1.Height - 1 -  y] :=
        Image1.Picture.Bitmap.Canvas.Pixels[x, y];
    end;
end;
  //Interpolar Vizinho Próximo
procedure TForm1.MenuItem22Click(Sender: TObject);
var
  oldWidth, oldHeight: Integer;
  newWidth, newHeight: Integer;
  x, y: Integer;
  srcX, srcY: Integer;
begin
  oldWidth := Image1.Picture.Bitmap.Width;
  oldHeight := Image1.Picture.Bitmap.Height;

  newWidth := Round(oldWidth * 1.1);
  newHeight := Round(oldHeight * 1.1);

  Image2.Picture.Bitmap.Width := newWidth;
  Image2.Picture.Bitmap.Height := newHeight;

  for y := 0 to newHeight - 1 do
    for x := 0 to newWidth - 1 do
    begin
      // Coordenadas da imagem original usando vizinho mais próximo
      srcX := Round(x / 1.1);
      srcY := Round(y / 1.1);

      // Garante que está dentro dos limites
      if srcX >= oldWidth then srcX := oldWidth - 1;
      if srcY >= oldHeight then srcY := oldHeight - 1;

      Image2.Canvas.Pixels[x, y] := Image1.Canvas.Pixels[srcX, srcY];
    end;
end;

//DCT (Discrete Cosine Transformation)
procedure TForm1.MenuItem23Click(Sender: TObject);
const
  N = 128;
var
  i, j, k, l: Integer;
  Ci, Cj, sum: Double;
  f: array[0..N - 1, 0..N - 1] of Double;
  dct: array[0..N - 1, 0..N - 1] of Double;
  pixelColor: TColor;
  gray: Byte;
begin
  // Verifica se a imagem tem tamanho 128x128
  if (Image1.Picture.Bitmap.Width <> N) or (Image1.Picture.Bitmap.Height <> N) then
  begin
    ShowMessage('A imagem deve ter tamanho 128x128!');
    Exit;
  end;

  // Converte para escala de cinza e armazena em f
  for j := 0 to N - 1 do
    for i := 0 to N - 1 do
    begin
      pixelColor := Image1.Canvas.Pixels[i, j];
      gray := Round(0.299 * Red(pixelColor) + 0.587 * Green(pixelColor) + 0.114 * Blue(pixelColor));
      f[i, j] := gray;
    end;

  // Aplica a DCT 2D
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      if i = 0 then Ci := 1 / Sqrt(N) else Ci := Sqrt(2) / Sqrt(N);
      if j = 0 then Cj := 1 / Sqrt(N) else Cj := Sqrt(2) / Sqrt(N);

      sum := 0;
      for k := 0 to N - 1 do
        for l := 0 to N - 1 do
          sum := sum + f[k, l] *
            cos((2 * k + 1) * i * Pi / (2 * N)) *
            cos((2 * l + 1) * j * Pi / (2 * N));

      dct[i, j] := Ci * Cj * sum;
    end;

  // Calcula min e max
  minDCT := dct[0, 0];
  maxDCT := dct[0, 0];
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      if dct[i, j] < minDCT then minDCT := dct[i, j];
      if dct[i, j] > maxDCT then maxDCT := dct[i, j];
    end;

  // Mostra imagem da DCT normalizada linearmente
  Image2.Picture.Bitmap.Width := N;
  Image2.Picture.Bitmap.Height := N;
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      gray := Round(255 * (dct[i, j] - minDCT) / (maxDCT - minDCT));
      Image2.Canvas.Pixels[i, j] := RGBToColor(gray, gray, gray);
    end;
end;



//Inversa DCT
procedure TForm1.MenuItem29Click(Sender: TObject);
const
  N = 128;
var
  i, j, u, v: Integer;
  Ci, Cj, sum: Double;
  dct: array[0..N - 1, 0..N - 1] of Double;
  f: array[0..N - 1, 0..N - 1] of Double;
  pixelColor: TColor;
  gray: Byte;
begin
  // Verifica se a imagem tem tamanho 128x128
  if (Image1.Picture.Bitmap.Width <> N) or (Image1.Picture.Bitmap.Height <> N) then
  begin
    ShowMessage('A imagem deve ter tamanho 128x128!');
    Exit;
  end;

  // Extrai imagem da DCT normalizada e desfaz a normalização
  for j := 0 to N - 1 do
    for i := 0 to N - 1 do
    begin
      pixelColor := Image1.Canvas.Pixels[i, j];
      gray := GetRValue(pixelColor);  // imagem em tons de cinza
      dct[i, j] := (gray / 255) * (maxDCT - minDCT) + minDCT;
    end;

  // Aplica a IDCT 2D
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      sum := 0;
      for u := 0 to N - 1 do
        for v := 0 to N - 1 do
        begin
          if u = 0 then Ci := 1 / Sqrt(N) else Ci := Sqrt(2) / Sqrt(N);
          if v = 0 then Cj := 1 / Sqrt(N) else Cj := Sqrt(2) / Sqrt(N);
          sum := sum + Ci * Cj * dct[u, v] *
            cos((2 * i + 1) * u * Pi / (2 * N)) *
            cos((2 * j + 1) * v * Pi / (2 * N));
        end;
      f[i, j] := sum;
    end;

  // Mostra imagem reconstruída
  Image2.Picture.Bitmap.Width := N;
  Image2.Picture.Bitmap.Height := N;
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      gray := Round(EnsureRange(f[i, j], 0, 255));
      Image2.Canvas.Pixels[i, j] := RGBToColor(gray, gray, gray);
    end;
end;


//Laplaciano
procedure TForm1.MenuItem24Click(Sender: TObject);
var
  x, y: Integer;
  grayCenter, grayRight, grayLeft, grayDown, grayUp, grayUpRight, grayUpLeft, grayDownRight, grayDownLeft: Byte;
  pixelColor: TColor;
  sum: Integer;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 1 to Image1.Height - 2 do
    for x := 1 to Image1.Width - 2 do
    begin
      pixelColor := Image1.Canvas.Pixels[x, y];
      grayCenter := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x + 1, y];
      grayRight := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x - 1, y];
      grayLeft := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x, y + 1];
      grayDown := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x, y - 1];
      grayUp := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x + 1, y - 1];
      grayUpRight := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x - 1, y - 1];
      grayUpLeft := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x + 1, y + 1];
      grayDownRight := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      pixelColor := Image1.Canvas.Pixels[x - 1, y + 1];
      grayDownLeft := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));

      // Aplica o kernel Laplaciano
      sum := -grayLeft - grayRight - grayUp - grayDown
             - grayUpLeft - grayUpRight - grayDownLeft - grayDownRight
             + 8 * grayCenter;

      //sum := sum + 128; // Centraliza os valores
      sum:= Abs(sum);
      if sum < 0 then sum := 0;
      if sum > 255 then sum := 255;

      Image2.Canvas.Pixels[x, y] := RGBToColor(sum, sum, sum);
    end;
end;

  //Limiarizar
procedure TForm1.MenuItem25Click(Sender: TObject);
var
  x, y: Integer;
  r, g, b, gray: Byte;
  cor: TColor;
  limiarStr: string;
  threshold: Integer;
begin
  limiarStr := InputBox('Limiarização', 'Digite o valor do limiar (0 a 255):', '128');  //inputs

  if not TryStrToInt(limiarStr, threshold) then  //verif o erro
  begin
    ShowMessage('Valor inválido!');
    Exit;
  end;

  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 0 to Image1.Height - 1 do
    for x := 0 to Image1.Width - 1 do
    begin
      cor := Image1.Picture.Bitmap.Canvas.Pixels[x, y];
      r := Red(cor);
      g := Green(cor);
      b := Blue(cor);
      gray := Round(0.3 * r + 0.59 * g + 0.11 * b);

      if gray >= threshold then
        Image2.Canvas.Pixels[x, y] := RGB(gray, gray, gray)
      else
        Image2.Canvas.Pixels[x, y] := RGB(0, 0, 0);
    end;
end;

  //Negativar Cinza
procedure TForm1.MenuItem27Click(Sender: TObject);
  var
    i, j: Integer;
    cor: TColor;
    r, g, b: Byte;
    gray, inverted: Byte;
  begin
    Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
    Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

    for j := 0 to Image1.Picture.Bitmap.Height - 1 do
      for i := 0 to Image1.Picture.Bitmap.Width - 1 do
      begin
        cor := Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        r := Red(cor);
        g := Green(cor);
        b := Blue(cor);
        gray := Round(0.299 * r + 0.587 * g + 0.114 * b);
        inverted := 255 - gray;
        Image2.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(inverted, inverted, inverted);
      end;
end;

  //Negativar Colorida
procedure TForm1.MenuItem28Click(Sender: TObject);
var
  i, j: Integer;
  cor: TColor;
  r, g, b: Byte;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for j := 0 to Image1.Picture.Bitmap.Height - 1 do
    for i := 0 to Image1.Picture.Bitmap.Width - 1 do
    begin
      cor := Image1.Picture.Bitmap.Canvas.Pixels[i, j];
      r := Red(cor);
      g := Green(cor);
      b := Blue(cor);
      Image2.Picture.Bitmap.Canvas.Pixels[i, j] :=
        RGBToColor(255 - r, 255 - g, 255 - b);
    end;

end;

  //Abrir Imagem
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
    if OpenDialog1.Execute then
       Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

//Separar Canal Azul
procedure TForm1.MenuItem31Click(Sender: TObject);
var
  azul, x, y: Integer;
  cor: TColor;
  bmp: Graphics.TBitmap;
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap); // força o carregamento da imagem
    for y := 0 to bmp.Height - 1 do
      for x := 0 to bmp.Width - 1 do
      begin
        cor := bmp.Canvas.Pixels[x, y];
        azul := Blue(cor);
        Image2.Canvas.Pixels[x, y] := RGB(0, 0, azul);
      end;
  finally
    bmp.Free;
  end;
end;

  //Separar Canal Verde
procedure TForm1.MenuItem32Click(Sender: TObject);
var
  verde, x, y: Integer;
  cor: TColor;
  bmp: Graphics.TBitmap;   //Forçar o carregamento da imagem antes de começar o looping
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);    //evita bug da tela não carregada
    for y := 0 to bmp.Height - 1 do
      for x := 0 to bmp.Width - 1 do
      begin
        cor := bmp.Canvas.Pixels[x, y];
        verde := Green(cor);
        Image2.Canvas.Pixels[x, y] := RGB(0,verde,0);
      end;
  finally
    bmp.Free;
  end;
end;
  //Separar Canal Vermelho
procedure TForm1.MenuItem33Click(Sender: TObject);
var
  vermelho, x, y: Integer;
  cor: TColor;
  bmp: Graphics.TBitmap;   //Forçar o carregamento da imagem antes de começar o looping
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);    //evita bug da tela não carregada
    for y := 0 to bmp.Height - 1 do
      for x := 0 to bmp.Width - 1 do
      begin
        cor := bmp.Canvas.Pixels[x, y];
        vermelho := Red(cor);
        Image2.Canvas.Pixels[x, y] := RGB(Vermelho,0,0);
      end;
  finally
    bmp.Free;
  end;
end;


  //Separar Canal Cinza/Azul
procedure TForm1.MenuItem34Click(Sender: TObject);
var
  azul, x, y: Integer;
  cor: TColor;
  bmp: Graphics.TBitmap;
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);
    for y := 0 to bmp.Height - 1 do
      for x := 0 to bmp.Width - 1 do
      begin
        cor := bmp.Canvas.Pixels[x, y];
        azul := Blue(cor);
        Image2.Canvas.Pixels[x, y] := RGB(azul, azul, azul);
      end;
  finally
    bmp.Free;
  end;
end;
  //Separar Canal Cinza/Verde
procedure TForm1.MenuItem35Click(Sender: TObject);
var
  verde, x, y: Integer;
  cor: TColor;
  bmp: Graphics.TBitmap;   //Forçar o carregamento da imagem antes de começar o looping
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);    //evita bug da tela não carregada
    for y := 0 to bmp.Height - 1 do
      for x := 0 to bmp.Width - 1 do
        begin
          cor := bmp.Canvas.Pixels[x, y];
          verde := Green(cor);
          Image2.Canvas.Pixels[x, y] := RGB(verde,verde,verde);
        end;
  finally
    bmp.Free;
  end;
end;
  //Separar Canal Cinza/Vermelho
procedure TForm1.MenuItem36Click(Sender: TObject);
var
  vermelho, x, y: Integer;
  cor: TColor;
  bmp: Graphics.TBitmap;   //Forçar o carregamento da imagem antes de começar o looping
begin
  bmp := Graphics.TBitmap.Create;
  try
    bmp.Assign(Image1.Picture.Bitmap);    //evita bug da tela não carregada
    for y := 0 to bmp.Height - 1 do
      for x := 0 to bmp.Width - 1 do
      begin
        cor := bmp.Canvas.Pixels[x, y];
        vermelho := Red(cor);
        Image2.Canvas.Pixels[x, y] := RGB(Vermelho,vermelho,vermelho);
      end;
  finally
    bmp.Free;
  end;
end;

procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
end;

  //Sobel Completo
procedure TForm1.MenuItem38Click(Sender: TObject);
var
  x, y, i, j: Integer;
  Gx, Gy, G: Integer;
  Gray: array[-1..1, -1..1] of Integer;
  pixelColor: TColor;
  Theta: Double;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  // Redimensionar as matrizes
  SetLength(MatMag, Image1.Width, Image1.Height);
  SetLength(MatAng, Image1.Width, Image1.Height);

  for y := 1 to Image1.Height - 2 do
    for x := 1 to Image1.Width - 2 do
    begin
      // Coleta os tons de cinza da vizinhança 3x3
      for j := -1 to 1 do
        for i := -1 to 1 do
        begin
          pixelColor := Image1.Canvas.Pixels[x+i, y+j];
          Gray[i, j] := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));
        end;

      //horizontal
      Gx := (-1 * Gray[-1,-1]) + (0 * Gray[0,-1]) + (1 * Gray[1,-1]) +
            (-2 * Gray[-1, 0]) + (0 * Gray[0, 0]) + (2 * Gray[1, 0]) +
            (-1 * Gray[-1, 1]) + (0 * Gray[0, 1]) + (1 * Gray[1, 1]);

      // vertical
      Gy := (-1 * Gray[-1,-1]) + (-2 * Gray[0,-1]) + (-1 * Gray[1,-1]) +
             (0 * Gray[-1, 0]) + ( 0 * Gray[0, 0]) + ( 0 * Gray[1, 0]) +
             (1 * Gray[-1, 1]) + ( 2 * Gray[0, 1]) + ( 1 * Gray[1, 1]);

      // Magnitude do gradiente
      G := Round(Sqrt(Gx * Gx + Gy * Gy));   //Se posteriormente quiser usar Magnitude e Direção
      if G > 255 then G := 255;

      // Direção do gradiente
      Theta := ArcTan2(Gy, Gx) * (180 / Pi);

      // Armazena os valores nas matrizes globais
      MatMag[x, y] := G;
      MatAng[x, y] := Theta;

      // Desenha pixel na imagem
      Image2.Canvas.Pixels[x, y] := RGB(G, G, G);
    end;
end;

  //Sobel Horizontal
procedure TForm1.MenuItem39Click(Sender: TObject);
var
  x, y, i,j: Integer;
  Gx, Gy, G: Integer;
  Gray: array[-1..1, -1..1] of Integer;
  pixelColor: TColor;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 1 to Image1.Height - 2 do
    for x := 1 to Image1.Width - 2 do
    begin
      //Coleta uma matriz de tons de cinza da vizinhança do pixel [3x3]
      for j := -1 to 1 do
        for i := -1 to 1 do
        begin
          pixelColor := Image1.Canvas.Pixels[x+i, y+j];
          Gray[i, j] := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));
        end;

        //Aplicando fitro da horizontal
        Gx := (-1 * Gray[-1,-1]) + (0 * Gray[0,-1]) + (1 * Gray[1,-1]) +
          (-2 * Gray[-1, 0]) + (0 * Gray[0, 0]) + (2 * Gray[1, 0]) +
          (-1 * Gray[-1, 1]) + (0 * Gray[0, 1]) + (1 * Gray[1, 1]);

        //sum := sum + 128; // Centraliza os valores
        Gx := Abs(Gx);
        if Gx > 255 then Gx := 255;

        Image2.Canvas.Pixels[x, y] := RGBToColor(Gx, Gx, Gx);
      end;
end;

  //Salvar Imagem
procedure TForm1.MenuItem3Click(Sender: TObject);
begin
   // Exibe a caixa de diálogo de salvar
  if SaveDialog1.Execute then
  begin
    // Salva a imagem no caminho escolhido pelo usuário
    Image1.Picture.SaveToFile(SaveDialog1.FileName);
  end;
end;

  //Sobel Vertical
procedure TForm1.MenuItem40Click(Sender: TObject);
var
  x, y, i,j: Integer;
  Gy, G: Integer;
  Gray: array[-1..1, -1..1] of Integer;
  pixelColor: TColor;
begin
  Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
  Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

  for y := 1 to Image1.Height - 2 do
    for x := 1 to Image1.Width - 2 do
    begin
      //Coletar uma matriz de tons de cinza da vizinhança do pixel [3x3]
      for j := -1 to 1 do
        for i := -1 to 1 do
        begin
          pixelColor := Image1.Canvas.Pixels[x+i, y+j];
          Gray[i, j] := Round(0.3 * Red(pixelColor) + 0.59 * Green(pixelColor) + 0.11 * Blue(pixelColor));
        end;
          //FIltro vertical
        Gy := (-1 * Gray[-1,-1]) + (-2 * Gray[0,-1]) + (-1 * Gray[1,-1]) +
               (0 * Gray[-1, 0]) + ( 0 * Gray[0, 0]) + ( 0 * Gray[1, 0]) +
               (1 * Gray[-1, 1]) + ( 2 * Gray[0, 1]) + ( 1 * Gray[1, 1]);

        Gy := Abs(Gy);
        if Gy > 255 then Gy := 255;

        Image2.Canvas.Pixels[x, y] := RGBToColor(Gy, Gy, Gy);
      end;
end;


// DCT funcao apenas                                                                                             // DCT funcao apenas
procedure TForm1.CalcularDCT(imagem: TImage; var dct: TDoubleMatrix);
const
  N = 128;
var
  i, j, k, l: Integer;
  Ci, Cj, sum: Double;
  f: array[0..N - 1, 0..N - 1] of Double;
  pixelColor: TColor;
  gray: Byte;
  DCTMat: TDoubleMatrix;
begin
  if (imagem.Picture.Bitmap.Width <> N) or (imagem.Picture.Bitmap.Height <> N) then
  begin
    ShowMessage('A imagem deve ter tamanho 128x128!');
    Exit;
  end;

  // Converte para escala de cinza
  for j := 0 to N - 1 do
    for i := 0 to N - 1 do
    begin
      pixelColor := imagem.Canvas.Pixels[i, j];
      gray := Round(0.299 * Red(pixelColor) + 0.587 * Green(pixelColor) + 0.114 * Blue(pixelColor));
      f[i, j] := gray;
    end;

  // Aplica a DCT
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      if i = 0 then Ci := 1 / Sqrt(N) else Ci := Sqrt(2) / Sqrt(N);
      if j = 0 then Cj := 1 / Sqrt(N) else Cj := Sqrt(2) / Sqrt(N);

      sum := 0;
      for k := 0 to N - 1 do
        for l := 0 to N - 1 do
          sum := sum + f[k, l] *
            cos((2 * k + 1) * i * Pi / (2 * N)) *
            cos((2 * l + 1) * j * Pi / (2 * N));

      dct[i, j] := Ci * Cj * sum;
    end;

  // Atualiza variáveis globais de min e max, se você quiser usar isso em outro lugar
  minDCT := dct[0, 0];
  maxDCT := dct[0, 0];
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      if dct[i, j] < minDCT then minDCT := dct[i, j];
      if dct[i, j] > maxDCT then maxDCT := dct[i, j];
    end;
end;

//Inversa DCT Funcao Apenas
procedure TForm1.InversaDCT(const dct: TDoubleMatrix; destino: TImage);
const
  N = 128;
var
  i, j, u, v: Integer;
  Ci, Cj, sum: Double;
  f: array[0..N - 1, 0..N - 1] of Double;
  gray: Byte;
begin
  // Aplica a IDCT 2D
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      sum := 0;
      for u := 0 to N - 1 do
        for v := 0 to N - 1 do
        begin
          if u = 0 then Ci := 1 / Sqrt(N) else Ci := Sqrt(2) / Sqrt(N);
          if v = 0 then Cj := 1 / Sqrt(N) else Cj := Sqrt(2) / Sqrt(N);
          sum := sum + Ci * Cj * dct[u, v] *
            cos((2 * i + 1) * u * Pi / (2 * N)) *
            cos((2 * j + 1) * v * Pi / (2 * N));
        end;
      f[i, j] := sum;
    end;

  // Prepara imagem de saída
  destino.Picture.Bitmap.Width := N;
  destino.Picture.Bitmap.Height := N;

  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
    begin
      gray := Round(EnsureRange(f[i, j], 0, 255));
      destino.Canvas.Pixels[i, j] := RGBToColor(gray, gray, gray);
    end;
end;

//PassaBaixa Cuttoff
procedure TForm1.MenuItem41Click(Sender: TObject);
var
  u,v,cutoff:Integer;
  DCTMat: TDoubleMatrix;
begin
   SetLength(DCTMat, 128, 128);
   if (Image1.Picture.Bitmap.Width <> 128) or (Image1.Picture.Bitmap.Height <> 128) then
      begin
        ShowMessage('A imagem deve ter tamanho 128x128!');
        Exit;
      end;
   Image2.Picture.Bitmap.SetSize(128, 128);


   //input
   cutoff:= StrToInt(InputBox('Filtro Passa-Baixa', 'Frequência de corte (ex: 50):','50'));

   CalcularDCT(Image1,DCTMat);

   //aplicando o filtro
   for u := 0 to 127 do
       for v := 0 to 127 do
           if(u > cutoff) or (v > cutoff) then
                DCTMat[u,v] := 0;

   InversaDCT(DCTMat, Image2);
   //Image2.Picture.Bitmap := Image2;
end;

//PassaAlta Cuttoff
procedure TForm1.MenuItem42Click(Sender: TObject);
var
  u, v, cutoff: Integer;
  DCTMat: TDoubleMatrix;
begin
    SetLength(DCTMat, 128, 128);

    if (Image1.Picture.Bitmap.Width <> 128) or (Image1.Picture.Bitmap.Height <> 128) then
    begin
      ShowMessage('A imagem deve ter tamanho 128x128!');
      Exit;
    end;

    Image2.Picture.Bitmap.SetSize(128, 128);

    // Entrada do usuário
    cutoff := StrToInt(InputBox('Filtro Passa-Alta', 'Frequência de corte (ex: 50):', '50'));

    // Calcula a DCT da imagem original
    CalcularDCT(Image1, DCTMat);

    // Aplica filtro passa-alta: zera tudo que está DENTRO do corte
    for u := 0 to 127 do
      for v := 0 to 127 do
        if (u <= cutoff) and (v <= cutoff) then
          DCTMat[u, v] := 0;

    // Reconstrói imagem
    InversaDCT(DCTMat, Image2);
end;


//PassaBaixa Radial
procedure TForm1.MenuItem43Click(Sender: TObject);
var
  u,v,cutoff:Integer;
  DCTMat: TDoubleMatrix;
begin
   SetLength(DCTMat, 128, 128);
   if (Image1.Picture.Bitmap.Width <> 128) or (Image1.Picture.Bitmap.Height <> 128) then
      begin
        ShowMessage('A imagem deve ter tamanho 128x128!');
        Exit;
      end;
   Image2.Picture.Bitmap.SetSize(128, 128);


   //input
   cutoff:= StrToInt(InputBox('Filtro Passa-Baixa', 'Frequência de corte (ex: 50):','50'));

   CalcularDCT(Image1,DCTMat);

   //aplicando o filtro
   for u := 0 to 127 do               //Filtro Radial
    for v := 0 to 127 do
      if sqrt(sqr(u) + sqr(v)) > cutoff then
        DCTMat[u,v] := 0;


   InversaDCT(DCTMat, Image2);
   //Image2.Picture.Bitmap := Image2;
end;

//Passa Alta Radial
procedure TForm1.MenuItem44Click(Sender: TObject);
var
  u, v, cutoff: Integer;
  DCTMat: TDoubleMatrix;
begin
    SetLength(DCTMat, 128, 128);

    if (Image1.Picture.Bitmap.Width <> 128) or (Image1.Picture.Bitmap.Height <> 128) then
    begin
      ShowMessage('A imagem deve ter tamanho 128x128!');
      Exit;
    end;

    Image2.Picture.Bitmap.SetSize(128, 128);

    // Entrada do usuário
    cutoff := StrToInt(InputBox('Filtro Passa-Alta', 'Frequência de corte (ex: 50):', '50'));

    // Calcula a DCT da imagem original
    CalcularDCT(Image1, DCTMat);

    // Aplica filtro passa-alta: zera tudo que está DENTRO do corte
    for u := 0 to 127 do
      for v := 0 to 127 do
        if sqrt(sqr(u) + sqr(v)) <= cutoff then
          DCTMat[u, v] := 0;

    // Reconstrói imagem
    InversaDCT(DCTMat, Image2);
end;

  //Sair
procedure TForm1.MenuItem4Click(Sender: TObject);
begin
   Close;
end;
//Novo formulário
procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  if not Assigned(Form2) then
    Form2 := TForm2.Create(Self);
  Form2.Show;
end;


//Binarização
procedure TForm1.MenuItem7Click(Sender: TObject);
var
  x, y: Integer;
  r, g, b, gray: Byte;
  cor: TColor;
  limiarStr: string;
  threshold: Integer;
  begin
    limiarStr := InputBox('Binarização', 'Digite o valor do limiar (0 a 255):', '128'); //Input

    if not TryStrToInt(limiarStr, threshold) then     //tratamento de erro
    begin
      ShowMessage('Valor inválido! Use um número entre 0 e 255.');
      Exit;
    end;

    // Validação do intervalo
    if (threshold < 0) or (threshold > 255) then
    begin
      ShowMessage('O limiar deve estar entre 0 e 255.');
      Exit;
    end;

    Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
    Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

    for y := 0 to Image1.Height - 1 do
      for x := 0 to Image1.Width - 1 do
      begin
        cor := Image1.Picture.Bitmap.Canvas.Pixels[x, y];
        r := Red(cor);
        g := Green(cor);
        b := Blue(cor);

        gray := Round(0.3 * r + 0.59 * g + 0.11 * b);

        if gray >= threshold then
          Image2.Picture.Bitmap.Canvas.Pixels[x, y] := RGB(255, 255, 255)
        else
          Image2.Picture.Bitmap.Canvas.Pixels[x, y] := RGB(0, 0, 0);
      end;
  end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin

end;
//Converter Para Cinza
procedure TForm1.MenuItem9Click(Sender: TObject);
  var
    i, j: Integer;
    cor: TColor;
    r, g, b: Byte;
    gray: Byte;
  begin
    Image2.Picture.Bitmap.Width := Image1.Picture.Bitmap.Width;
    Image2.Picture.Bitmap.Height := Image1.Picture.Bitmap.Height;

    for j := 0 to Image1.Picture.Bitmap.Height - 1 do
      for i := 0 to Image1.Picture.Bitmap.Width - 1 do
      begin
        cor := Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        r := Red(cor);
        g := Green(cor);
        b := Blue(cor);
        gray := Round(0.299 * r + 0.587 * g + 0.114 * b); // conversão para cinza
        Image2.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(gray, gray, gray);
      end;
  end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;


end.

