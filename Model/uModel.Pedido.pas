unit uModel.Pedido;

interface

uses uModel.Cliente, uModel.ItemPedido, System.Generics.Collections,
  uController.Conexao, FireDAC.Comp.Client, System.SysUtils,
  FireDAC.Phys.MySQLWrapper,
  uController.Cliente;

type
  TPedido = class
  private
    FCodigo: Integer;
    FCliente: TCliente;
    FData: TDate;
    FItems: TObjectList<TItemPedido>;
    FLastError: String;
    FTotalPedido: double;
    function getTotalPedido: double;
  public
    constructor Create;
    destructor Destroy; override;

    property Numero: Integer read FCodigo write FCodigo;
    property Data: TDate read FData write FData;
    property Cliente: TCliente read FCliente write FCliente;
    property TotalPedido: double read getTotalPedido;
    property Items: TObjectList<TItemPedido> read FItems write FItems;

    function Inserir: boolean;
    function Excluir: boolean;
    function getLastError: string;
    function FindOne(CodigoPedido: Integer): boolean;
  end;

implementation

{TPedido}

constructor TPedido.Create;
begin
  FLastError := '';
  FCliente := TCliente.Create;
  FItems := TObjectList<TItemPedido>.Create();
end;

destructor TPedido.Destroy;
begin
  FCliente.Free;
  FItems.Free;
  inherited;
end;

function TPedido.Excluir: boolean;
var
  Query: TFDQuery;
begin
  Result := false;
  Query := TControllerConexao.getInstance().Conexao.criarQueryTransaction();
  try
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL
        ('DELETE FROM PEDIDOS_PRODUTOS WHERE numero_pedido = :numero',
        [Self.Numero]);
      Query.ExecSQL('DELETE FROM PEDIDOS WHERE codigo = :codigo',
        [Self.Numero]);
    except
      on E: EMySQLNativeException do
      begin
        Query.Transaction.Rollback;
        FLastError := 'Erro excluindo pedido:' + E.Message;
        exit;
      end;
    end;
    Query.Transaction.Commit;
  finally
    Query.Transaction.Free;
    Query.Transaction := nil;
    Query.Free;
  end;
  Result := true;
end;

function TPedido.FindOne(CodigoPedido: Integer): boolean;
var
  Query: TFDQuery;
  indice: Integer;
begin
  Query := TControllerConexao.getInstance().Conexao.criarQuery();
  try
    Query.Open('SELECT * FROM PEDIDOS WHERE CODIGO = :codigo', [CodigoPedido]);
    if Query.RecordCount = 1 then
    begin
      Numero := Query.FieldByName('codigo').AsInteger;
      Data := Query.FieldByName('data_emissao').AsDateTime;
      Cliente.FindOne(Query.FieldByName('codigo_cliente').AsInteger);

      FTotalPedido := 0.00;
      Items.Clear;
      Query.Open('SELECT * FROM PEDIDOS_PRODUTOS WHERE NUMERO_PEDIDO = :codigo',
        [CodigoPedido]);
      Query.First;
      while not Query.Eof do
      begin
        Items.Add(TItemPedido.Create);
        indice := Items.Count - 1;
        Items[indice].Codigo := Query.FieldByName('codigo').AsInteger;
        Items[indice].CodigoProduto := Query.FieldByName('codigo_produto')
          .AsInteger;
        Items[indice].Quantidade := Query.FieldByName('quantidade').AsFloat;
        Items[indice].ValorUnitario :=
          Query.FieldByName('valor_unitario').AsFloat;
        Items[indice].ValorTotal := Query.FieldByName('valor_total').AsFloat;
        FTotalPedido := FTotalPedido + Items[indice].ValorTotal;
        Query.Next();
      end;
      Result := true;
      exit;
    end;
  finally
    Query.Free;
  end;
  Result := false;
end;

function TPedido.getLastError: string;
begin
  Result := FLastError;
end;

function TPedido.getTotalPedido: double;
begin
  Result := FTotalPedido;
end;

function TPedido.Inserir: boolean;
var
  Query: TFDQuery;
  NumeroPedido: Integer;
  i: Integer;
  TotalPedido: double;
begin
  Result := false;
  Query := TControllerConexao.getInstance().Conexao.criarQueryTransaction();
  try
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Clear;
      Query.SQL.Add
        ('INSERT INTO PEDIDOS( data_emissao, codigo_cliente, total)');
      Query.SQL.Add('VALUES(:data, :cliente, 0.00);');
      Query.SQL.Add('SELECT LAST_INSERT_ID() as numero_pedido;');
      Query.ParamByName('data').AsDate := Data;
      Query.ParamByName('cliente').AsInteger := Cliente.Codigo;
      Query.Open;

      NumeroPedido := Query.FieldByName('numero_pedido').AsInteger;
      TotalPedido := 0.00;

      Query.SQL.Clear;
      Query.SQL.Add
        ('INSERT INTO PEDIDOS_PRODUTOS(numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total)');
      Query.SQL.Add
        ('VALUES(:numero_pedido, :codigo_produto, :quantidade, :valor_unitario, :valor_total)');

      for i := 0 to pred(Items.Count) do
      begin
        TotalPedido := TotalPedido + Items[i].ValorTotal;
        Query.Unprepare;
        Query.ParamByName('numero_pedido').AsInteger := NumeroPedido;
        Query.ParamByName('codigo_produto').AsInteger := Items[i].CodigoProduto;
        Query.ParamByName('quantidade').AsFloat := Items[i].Quantidade;
        Query.ParamByName('valor_unitario').AsFloat := Items[i].ValorUnitario;
        Query.ParamByName('valor_total').AsFloat := Items[i].ValorTotal;
        Query.ExecSQL;
      end;

      Query.SQL.Clear;
      Query.SQL.Add('UPDATE PEDIDOS SET total = :total');
      Query.SQL.Add('WHERE CODIGO = :codigo');
      Query.ParamByName('total').AsFloat := TotalPedido;
      Query.ParamByName('codigo').AsInteger := NumeroPedido;
      Query.ExecSQL;
    except
      on E: EMySQLNativeException do
      begin
        Query.Transaction.Rollback;
        FLastError := 'Erro gravando pedido:' + E.Message;
        exit;
      end;
    end;
    Query.Transaction.Commit;
    Numero := NumeroPedido;
    FTotalPedido := TotalPedido;
  finally
    Query.Transaction.Free;
    Query.Transaction := nil;
    Query.Free;
  end;
  Result := true;
end;

end.
