unit uDAO.Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.DApt, vcl.Forms;

type
  TDAOConexao = class
  private
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
  public
    function getConexao: TFDConnection;
    function criarQuery: TFDQuery;
    function criarQueryTransaction: TFDQuery;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

var
  instanciaConexao: TDAOConexao;

  {TDAOConexao}

constructor TDAOConexao.Create;
begin
  FDPhysMySQLDriverLink := TFDPhysMySQLDriverLink.Create(nil);
  FDPhysMySQLDriverLink.VendorLib := ExtractFilePath(Application.Exename) +
    'libmysql.dll';
  FDConnection := TFDConnection.Create(nil);
  FDConnection.LoginPrompt := False;
  FDConnection.Params.Add('Database=testeWK');
  FDConnection.Params.Add('User_Name=root');
  FDConnection.Params.Add('Password=my123');
  FDConnection.Params.Add('DriverID=MySQL');
  FDConnection.Connected := true;
end;

function TDAOConexao.criarQuery: TFDQuery;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FDConnection;
  Result := Query;
end;

function TDAOConexao.criarQueryTransaction: TFDQuery;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Transaction := TFDTransaction.Create(nil);
  Query.Connection := FDConnection;
  Query.Transaction.Connection := FDConnection;
  Result := Query;
end;


destructor TDAOConexao.Destroy;
begin
  FDPhysMySQLDriverLink.Free;
  FDConnection.Free;
  inherited;
end;

function TDAOConexao.getConexao: TFDConnection;
begin
  Result := FDConnection;
end;

end.
