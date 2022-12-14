unit frmView.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uController.Produto, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, uController.Conexao, Vcl.Grids, uController.Pedido,
  uModel.ItemPedido, Vcl.ComCtrls, uController.TotalPedido,
  uObserver.TotalPedidos;

type
  TipoEStado = (teBrowser, teInsert, teEdit);

  TfrmViewPedido = class(TForm)
    PainelPedido: TPanel;
    edtCliente: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtData: TMaskEdit;
    btnGravarPedido: TButton;
    gridProdutos: TStringGrid;
    gbProduto: TGroupBox;
    edtProduto: TEdit;
    Label3: TLabel;
    Label6: TLabel;
    edtQuantidade: TEdit;
    btnInserirProduto: TButton;
    Label7: TLabel;
    Label5: TLabel;
    edtValorUnitario: TEdit;
    btnCancelar: TButton;
    Rodape: TStatusBar;
    Panel1: TPanel;
    btnInserirPedido: TButton;
    btnCancelarPedido: TButton;
    btnRecuperarPedido: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure gridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridProdutosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnRecuperarPedidoClick(Sender: TObject);
    procedure btnInserirPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    ControllerPedidos: TControllerPedido;
    ControllerProduto: TControllerProduto;
    ControllerTotalPedido: TControllerTotalPedido;
    ObservadorTotalPedido: TObservadorTotalPedido;
    EstadoAtual: TipoEStado;
    procedure limparDados;
    procedure inserirNoGrid(Codigo: Integer; Descricao: String;
      Quantidade, ValorUnitario: double);
    procedure editarProduto;
    procedure btnInserirProdutoAtualizar(Sender: TObject);
    procedure excluirProduto;
    procedure HabilitarPainel(Habilitar: boolean);
    procedure TrocarEstado(Estado: TipoEStado);
  public
    {Public declarations}
  end;

const
  cgCodigo = 0;
  cgDescricao = 1;
  cgQuantidade = 2;
  cgValorUnitario = 3;
  cgValorTotal = 4;

var
  frmViewPedido: TfrmViewPedido;

implementation

{$R *.dfm}

procedure TfrmViewPedido.FormCreate(Sender: TObject);
begin
  ControllerPedidos := TControllerPedido.Create;
  ControllerProduto := TControllerProduto.Create;
  ControllerTotalPedido := TControllerTotalPedido.Create;
  ObservadorTotalPedido := TObservadorTotalPedido.Create(Rodape.Panels[0]);
  ControllerTotalPedido.AdicionarObserver(ObservadorTotalPedido);
  TrocarEstado(teBrowser);
end;

procedure TfrmViewPedido.FormDestroy(Sender: TObject);
begin
  ControllerPedidos.Free;
  ControllerProduto.Free;
  ControllerTotalPedido.Free;
end;

procedure TfrmViewPedido.btnCancelarClick(Sender: TObject);
begin
  TrocarEstado(teBrowser);
end;

procedure TfrmViewPedido.btnCancelarPedidoClick(Sender: TObject);
var
  CodigoPedido: Integer;
begin
  CodigoPedido := StrToIntDef(InputBox('Cancelar Pedido',
    'Informe o n?mero do pedido que deseja cancelar', ''), - 1);
  if CodigoPedido < 1 then
    raise Exception.Create
      ('O n?mero do pedido deve ser um n?mero inteiro e maior que zero.');

  if not ControllerPedidos.FindOne(CodigoPedido) then
    raise Exception.Create('O pedido de n?mero ' + IntToStr(CodigoPedido) +
      ' n?o existe.');

  if not ControllerPedidos.Excluir() then
    raise Exception.Create(ControllerPedidos.getLastError());
  ShowMessage('Pedido ' + IntToStr(CodigoPedido) + ' exclu?do com sucesso.');
end;

procedure TfrmViewPedido.btnGravarPedidoClick(Sender: TObject);
var
  CodigoCliente: Integer;
  DataEmissao: TDate;
  DataInicial: TDate;
  Formato: TFormatSettings;
  i: Integer;
begin
  if edtCliente.Text = '' then
    raise Exception.Create('Informe um C?digo do Cliente.');
  CodigoCliente := StrToIntDef(edtCliente.Text, 0);
  if CodigoCliente < 1 then
    raise Exception.Create('Informe um C?digo do Cliente v?lido.');

  if edtData.Text = '' then
    raise Exception.Create('Informe uma Data de Emiss?o.');

  Formato := TFormatSettings.Create();
  Formato.ShortDateFormat := 'dd/mm/yyyy';
  Formato.DateSeparator := '/';
  DataInicial := StrToDate('31/12/1999', Formato);
  DataEmissao := StrToDateDef(edtData.Text, DataInicial);
  if DataEmissao <= DataInicial then
    raise Exception.Create
      ('Informe uma Data de Emiss?o posterior a 31/12/1999.');

  if not ControllerPedidos.Pedido.Cliente.FindOne(CodigoCliente) then
    raise Exception.Create('C?digo de Cliente n?o encontrado.');

  ControllerPedidos.Pedido.data := DataEmissao;
  ControllerPedidos.Pedido.Items.Clear;
  for i := 1 to pred(gridProdutos.RowCount) do
  begin
    ControllerPedidos.Pedido.Items.Add(TItemPedido.Create);
    ControllerPedidos.Pedido.Items[i - 1].CodigoProduto :=
      StrToInt(gridProdutos.Cells[cgCodigo, i]);
    ControllerPedidos.Pedido.Items[i - 1].Quantidade :=
      StrToFloat(gridProdutos.Cells[cgQuantidade, i]);
    ControllerPedidos.Pedido.Items[i - 1].ValorUnitario :=
      StrToFloat(gridProdutos.Cells[cgValorUnitario, i]);
    ControllerPedidos.Pedido.Items[i - 1].ValorTotal :=
      StrToFloat(gridProdutos.Cells[cgValorTotal, i]);
  end;

  if EstadoAtual = teInsert then
  begin
    if not ControllerPedidos.Inserir then
      raise Exception.Create(ControllerPedidos.getLastError());
  end
  else
  begin
    if not ControllerPedidos.Atualizar then
      raise Exception.Create(ControllerPedidos.getLastError());
  end;

  ShowMessage('Pedido ' + IntToStr(ControllerPedidos.Pedido.Numero) +
    ' gravado com sucesso.');
  TrocarEstado(teBrowser);
end;

procedure TfrmViewPedido.btnInserirProdutoClick(Sender: TObject);
var
  CodigoProduto: Integer;
  Quantidade: double;
  ValorUnitario: double;
begin
  if edtProduto.Text = '' then
    raise Exception.Create('Informe o C?digo do Produto.');
  CodigoProduto := StrToIntDef(edtProduto.Text, 0);
  if CodigoProduto < 1 then
    raise Exception.Create('Informe um C?digo de Produto v?lido.');

  if edtQuantidade.Text = '' then
    raise Exception.Create('Informe a Quantidade.');
  Quantidade := StrToFloatDef(edtQuantidade.Text, - 1.00);
  if Quantidade < 0.0099 then
    raise Exception.Create('Informe uma Quantidade v?lida maior que 0.00.');

  if edtValorUnitario.Text = '' then
    Exception.Create('Informe o Valor Unit?rio.');
  ValorUnitario := StrToFloatDef(edtValorUnitario.Text, - 1.00);
  if Quantidade < 0.0099 then
    raise Exception.Create('Informe um Valor Unit?rio maior que 0.00.');

  if not ControllerProduto.FindOne(CodigoProduto) then
    raise Exception.Create('C?digo do Produto n?o existe.');

  inserirNoGrid(CodigoProduto, ControllerProduto.Produto.Descricao, Quantidade,
    ValorUnitario);

  edtProduto.Text := '';
  edtProduto.SetFocus;
  edtQuantidade.Text := '';
  edtValorUnitario.Text := '';
  btnCancelarPedido.Enabled := false;
  btnRecuperarPedido.Enabled := false;
end;

procedure TfrmViewPedido.btnRecuperarPedidoClick(Sender: TObject);
var
  CodigoPedido: Integer;
  ItemPedido: TItemPedido;
begin
  CodigoPedido := StrToIntDef(InputBox('Recuperar Pedido',
    'Informe o n?mero do pedido que deseja recuperar', ''), - 1);
  if CodigoPedido < 1 then
    raise Exception.Create
      ('O n?mero do pedido deve ser um n?mero inteiro e maior que zero.');

  if not ControllerPedidos.FindOne(CodigoPedido) then
    raise Exception.Create('O pedido de n?mero ' + IntToStr(CodigoPedido) +
      ' n?o existe.');

  TrocarEstado(teEdit);

  edtCliente.Text := IntToStr(ControllerPedidos.Pedido.Cliente.Codigo);
  edtData.Text := DateToStr(ControllerPedidos.Pedido.data);

  for ItemPedido in ControllerPedidos.Pedido.Items do
  begin
    ControllerProduto.FindOne(ItemPedido.CodigoProduto);
    inserirNoGrid(ItemPedido.CodigoProduto, ControllerProduto.Produto.Descricao,
      ItemPedido.Quantidade, ItemPedido.ValorUnitario);
  end;

  ShowMessage('Pedido ' + IntToStr(CodigoPedido) + ' recuperado com sucesso.');

end;

procedure TfrmViewPedido.btnInserirPedidoClick(Sender: TObject);
begin
  TrocarEstado(teInsert);
end;

procedure TfrmViewPedido.btnInserirProdutoAtualizar(Sender: TObject);
var
  Quantidade: double;
  ValorUnitario: double;
begin
  if edtQuantidade.Text = '' then
    raise Exception.Create('Informe a Quantidade.');
  Quantidade := StrToFloatDef(edtQuantidade.Text, - 1.00);
  if Quantidade < 0.0099 then
    raise Exception.Create('Informe uma Quantidade v?lida maior que 0.00.');

  if edtValorUnitario.Text = '' then
    Exception.Create('Informe o Valor Unit?rio.');
  ValorUnitario := StrToFloatDef(edtValorUnitario.Text, - 1.00);
  if Quantidade < 0.0099 then
    raise Exception.Create('Informe um Valor Unit?rio maior que 0.00.');

  gridProdutos.Cells[cgQuantidade, gridProdutos.Row] := FloatToStr(Quantidade);
  gridProdutos.Cells[cgValorUnitario, gridProdutos.Row] :=
    FloatToStr(ValorUnitario);
  gridProdutos.Cells[cgValorTotal, gridProdutos.Row] :=
    FloatToStr(Quantidade * ValorUnitario);

  ControllerTotalPedido.Adicionar(Quantidade * ValorUnitario);

  btnInserirProduto.Caption := 'Inserir Produto';
  btnInserirProduto.OnClick := btnInserirProdutoClick;
  gbProduto.Caption := 'Novo Produto';
  gbProduto.Font.Color := clCaptionText;
  edtProduto.Enabled := true;
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtValorUnitario.Text := '';
  btnGravarPedido.Enabled := true;
  gridProdutos.Enabled := true;
  gridProdutos.SetFocus;
end;

procedure TfrmViewPedido.edtProdutoExit(Sender: TObject);
begin
  if (edtProduto.Text <> '') and (edtValorUnitario.Text = '') then
  begin
    if ControllerProduto.FindOne(StrToIntDef(edtProduto.Text, 0)) then
      edtValorUnitario.Text := FloatToStr(ControllerProduto.Produto.Preco);
  end;
end;

procedure TfrmViewPedido.inserirNoGrid(Codigo: Integer; Descricao: String;
  Quantidade: double; ValorUnitario: double);
var
  novaLinha: Integer;
begin
  if gridProdutos.RowCount = 1 then
  begin
    gridProdutos.RowCount := 2;
    gridProdutos.FixedRows := 1;
    gridProdutos.Cells[cgCodigo, 0] := 'Produto';
    gridProdutos.Cells[cgDescricao, 0] := 'Descri??o';
    gridProdutos.Cells[cgQuantidade, 0] := 'Quantidade';
    gridProdutos.Cells[cgValorUnitario, 0] := 'Valor Unit?rio';
    gridProdutos.Cells[cgValorTotal, 0] := 'Valor Total';
    novaLinha := 1;
  end
  else
  begin
    novaLinha := gridProdutos.RowCount;
    gridProdutos.RowCount := gridProdutos.RowCount + 1;
  end;

  gridProdutos.Cells[cgCodigo, novaLinha] := IntToStr(Codigo);
  gridProdutos.Cells[cgDescricao, novaLinha] := Descricao;
  gridProdutos.Cells[cgQuantidade, novaLinha] := FloatToStr(Quantidade);
  gridProdutos.Cells[cgValorUnitario, novaLinha] := FloatToStr(ValorUnitario);
  gridProdutos.Cells[cgValorTotal, novaLinha] :=
    FloatToStr(Quantidade * ValorUnitario);
  ControllerTotalPedido.Adicionar(Quantidade * ValorUnitario);
end;

procedure TfrmViewPedido.gridProdutosDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  ValorFormatado: String;
  LarguraColuna: Integer;
  LarguraTexto: Integer;
  PosicaoInicial: Integer;
begin
  if ACol < 2 then
    exit;
  if ARow < 1 then
    exit;
  ValorFormatado := FormatFloat('#,##0.00',
    StrToFloat(gridProdutos.Cells[ACol, ARow]));
  gridProdutos.Canvas.FillRect(Rect);
  LarguraColuna := Rect.Width;
  LarguraTexto := gridProdutos.Canvas.TextWidth(ValorFormatado);
  PosicaoInicial := Rect.Left + LarguraColuna - 10 - LarguraTexto;
  gridProdutos.Canvas.TextOut(PosicaoInicial, Rect.Top + 3, ValorFormatado);
end;

procedure TfrmViewPedido.gridProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    editarProduto;
  if Key = VK_DELETE then
    excluirProduto;
end;

procedure TfrmViewPedido.HabilitarPainel(Habilitar: boolean);
var
  i: Integer;
begin
  PainelPedido.Enabled := Habilitar;
  for i := 0 to pred(PainelPedido.ControlCount) do
    if PainelPedido.Controls[i] is TControl then
      (PainelPedido.Controls[i] as TControl).Enabled := Habilitar;
  for i := 0 to pred(gbProduto.ControlCount) do
    if gbProduto.Controls[i] is TControl then
      (gbProduto.Controls[i] as TControl).Enabled := Habilitar;
  if Habilitar then
    gbProduto.Caption := 'Novo Produto'
  else
    gbProduto.Caption := '';
end;

procedure TfrmViewPedido.limparDados;
begin
  gridProdutos.RowCount := 1;
  gridProdutos.Rows[0].Clear;
  edtCliente.Text := '';
  edtData.Text := '';
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtValorUnitario.Text := '';
  ControllerTotalPedido.Zerar;
end;

procedure TfrmViewPedido.TrocarEstado(Estado: TipoEStado);
begin
  limparDados();
  HabilitarPainel(true);
  btnInserirPedido.Enabled := false;
  btnCancelarPedido.Enabled := false;
  btnRecuperarPedido.Enabled := false;
  if Estado = teBrowser then
  begin
    HabilitarPainel(false);
    btnInserirPedido.Enabled := true;
    btnCancelarPedido.Enabled := true;
    btnRecuperarPedido.Enabled := true;
  end;
  EstadoAtual := Estado;
end;

procedure TfrmViewPedido.editarProduto;
begin
  if gridProdutos.RowCount = 1 then
    exit;
  gbProduto.Caption := ' ===== Editando Produto ===== ';
  gbProduto.Font.Color := clRed;
  edtProduto.Enabled := false;
  edtProduto.Text := gridProdutos.Cells[cgCodigo, gridProdutos.Row];
  edtQuantidade.Text := gridProdutos.Cells[cgQuantidade, gridProdutos.Row];
  edtValorUnitario.Text := gridProdutos.Cells[cgValorUnitario,
    gridProdutos.Row];
  ControllerTotalPedido.Subtrair(StrToFloat(gridProdutos.Cells[cgValorUnitario,
    gridProdutos.Row]));
  btnInserirProduto.Caption := 'Salvar Produto';
  btnInserirProduto.OnClick := btnInserirProdutoAtualizar;
  btnGravarPedido.Enabled := false;
  gridProdutos.Enabled := false;
  edtQuantidade.SetFocus;
end;

procedure TfrmViewPedido.excluirProduto;
var
  Mensagem: string;
  ValorTotalProduto: double;
  i: Integer;
begin
  if gridProdutos.RowCount = 1 then
    exit;
  Mensagem := 'Confirma a exclus?o do produto: ' + gridProdutos.Cells
    [cgCodigo, gridProdutos.Row] + ' - ' + gridProdutos.Cells[cgDescricao,
    gridProdutos.Row];
  if MessageDlg(Mensagem, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    exit;

  if gridProdutos.RowCount = 2 then
  begin
    gridProdutos.RowCount := 1;
    gridProdutos.Rows[0].Clear;
    ControllerTotalPedido.Zerar;
    exit;
  end;
  ValorTotalProduto := StrToFloat(gridProdutos.Cells[cgValorTotal,
    gridProdutos.Row]);
  ControllerTotalPedido.Subtrair(ValorTotalProduto);

  for i := gridProdutos.Row to gridProdutos.RowCount - 2 do
    gridProdutos.Rows[i] := gridProdutos.Rows[i + 1];
  gridProdutos.RowCount := gridProdutos.RowCount - 1;
end;

end.
