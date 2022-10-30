unit uController.Produto;

interface

uses uModel.Produto;

type
  TControllerProduto = class
  private
    FProduto: TProduto;
  public
    property Produto: TProduto read FProduto write FProduto;
    function FindOne(CodigoProduto: integer): boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{TControllerPedido}

constructor TControllerProduto.Create;
begin
  FProduto := TProduto.Create;
end;

destructor TControllerProduto.Destroy;
begin
  FProduto.Free;
  inherited;
end;

function TControllerProduto.FindOne(CodigoProduto: integer): boolean;
begin
  Result := FProduto.FindOne(CodigoProduto);
end;

end.
