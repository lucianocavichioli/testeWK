unit uController.Pedido;

interface

uses uModel.Pedido, uModel.ItemPedido;

type
  TControllerPedido = class
  private
    FPedido: TPedido;
    FItemPedido: TItemPedido;
  public
    constructor Create;
    destructor Destroy; override;

    property Pedido: TPedido read FPedido write FPedido;
    property ItemPedido: TItemPedido read FItemPedido write FItemPedido;

    function Inserir: boolean;
    function Excluir: boolean;
    function getLastError: string;
    function FindOne(CodigoPedido: integer): boolean;
  end;

implementation

{TControllerPedido}

constructor TControllerPedido.Create;
begin
  FPedido := TPedido.Create;
  FItemPedido := TItemPedido.Create;
end;

destructor TControllerPedido.Destroy;
begin
  FPedido.Free;
  FItemPedido.Free;
  inherited;
end;

function TControllerPedido.Excluir: boolean;
begin
  result := FPedido.Excluir;
end;

function TControllerPedido.FindOne(CodigoPedido: integer): boolean;
begin
  result := FPedido.FindOne(CodigoPedido);
end;

function TControllerPedido.getLastError: string;
begin
  result := FPedido.getLastError;
end;

function TControllerPedido.Inserir: boolean;
begin
  result := FPedido.Inserir;
end;

end.
