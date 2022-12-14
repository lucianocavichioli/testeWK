unit uController.Conexao;

interface

uses
  System.SysUtils, System.Classes, vcl.Forms, uDAO.Conexao;

type
  TControllerConexao = class
  private
    FConexao: TDAOConexao;
  public
    property Conexao: TDAOConexao read FConexao write FConexao;
    class function getInstance: TControllerConexao;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{TControllerConexao}

var
  instanciaConexao: TControllerConexao;

constructor TControllerConexao.Create;
begin
  FConexao := TDAOConexao.Create;
end;

destructor TControllerConexao.Destroy;
begin
  FConexao.Free;
  inherited;
end;

class function TControllerConexao.getInstance: TControllerConexao;
begin
  // Singleton
  if instanciaConexao = nil then
    instanciaConexao := TControllerConexao.Create;
  result := instanciaConexao;
end;

initialization

instanciaConexao := nil;

finalization

if instanciaConexao <> nil then
  FreeAndNil(instanciaConexao);

end.
