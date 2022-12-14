unit uController.Produto;

interface

uses uModel.Produto;

type
  TControllerProduto = class
  private
    FProduto: TProduto;
  public
    property Produto: TProduto read FProduto write FProduto;
    function FindOne(const CodigoProduto: integer): boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{TControllerProduto}

constructor TControllerProduto.Create;
begin
  FProduto := TProduto.Create;
end;

destructor TControllerProduto.Destroy;
begin
  FProduto.Free;
  inherited;
end;

function TControllerProduto.FindOne(const CodigoProduto: integer): boolean;
begin
  Result := FProduto.FindOne(CodigoProduto);
end;

end.
