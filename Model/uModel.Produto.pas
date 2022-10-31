unit uModel.Produto;

interface

uses uController.Conexao, FireDAC.Comp.Client, System.SysUtils;

type
  TProduto = class
  private
    FCodigo: Integer;
    FPreco: double;
    FDescricao: String;
  public
    constructor Create;
    destructor Destroy; override;
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property Preco: double read FPreco write FPreco;
    function FindOne(const CodigoProduto: Integer): boolean;
  end;

implementation

{TProduto}

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin
  inherited;
end;

function TProduto.FindOne(const CodigoProduto: Integer): boolean;
var
  Query: TFDQuery;
begin
  Query := TControllerConexao.getInstance().Conexao.criarQuery();
  try
    Query.Open('SELECT * FROM PRODUTOS WHERE CODIGO = :codigo',
      [CodigoProduto]);
    if Query.RecordCount = 1 then
    begin
      Codigo := Query.FieldByName('codigo').AsInteger;
      Descricao := Query.FieldByName('descricao').AsString;
      Preco := Query.FieldByName('preco_venda').AsFloat;
      result := true;
      exit;
    end;
  finally
    Query.Free;
  end;
  result := false;
end;

end.
