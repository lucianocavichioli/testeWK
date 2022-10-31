unit uModel.ItemPedido;

interface

type
  TItemPedido = class
  private
    FCodigoProduto: Integer;
    FCodigo: Integer;
    FValorUnitario: double;
    FValorTotal: double;
    FCodigoPedido: Integer;
    FQuantidade: double;
  public
    constructor Create;
    destructor Destroy; override;
    property Codigo: Integer read FCodigo write FCodigo;
    property CodigoPedido: Integer read FCodigoPedido write FCodigoPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: double read FQuantidade write FQuantidade;
    property ValorUnitario: double read FValorUnitario write FValorUnitario;
    property ValorTotal: double read FValorTotal write FValorTotal;
  end;

implementation

{TItemPedido}

constructor TItemPedido.Create;
begin

end;

destructor TItemPedido.Destroy;
begin

  inherited;
end;

end.
