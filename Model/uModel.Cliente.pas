unit uModel.Cliente;

interface

uses uController.Conexao, FireDAC.Comp.Client, System.SysUtils;

type
  TCliente = class
  private
    FCodigo: Integer;
    FUF: String;
    FNome: String;
    FCidade: String;
  public
    constructor Create;
    destructor Destroy; override;
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
    function FindOne(const CodigoCliente: Integer): boolean;
  end;

implementation

{TCliente}

constructor TCliente.Create;
begin

end;

destructor TCliente.Destroy;
begin

  inherited;
end;

function TCliente.FindOne(const CodigoCliente: Integer): boolean;
var
  Query: TFDQuery;
begin
  Query := TControllerConexao.getInstance().Conexao.criarQuery();
  try
    Query.Open('SELECT * FROM CLIENTES WHERE CODIGO = :codigo',
      [CodigoCliente]);
    if Query.RecordCount = 1 then
    begin
      Codigo := Query.FieldByName('codigo').AsInteger;
      Nome := Query.FieldByName('nome').AsString;
      Cidade := Query.FieldByName('cidade').AsString;
      UF := Query.FieldByName('uf').AsString;
      result := true;
      exit;
    end;
  finally
    Query.Free;
  end;
  result := false;
end;

end.
