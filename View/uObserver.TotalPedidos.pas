unit uObserver.TotalPedidos;

interface

uses System.Classes, uInterface.Observer.TotalPedidos,
  System.SysUtils, Vcl.ComCtrls;

type
  TObservadorTotalPedido = class(TInterfacedObject, iObserverTotalPedidos)
  private
    FPainel: TStatusPanel;
  public
    constructor Create(APainel: TStatusPanel); overload;
    destructor Destroy; override;
    procedure OnValorTotalChange(const AValorTotalPedido: double);
  end;

implementation

{TObservadorTotalPedido}

constructor TObservadorTotalPedido.Create(APainel: TStatusPanel);
begin
  FPainel := APainel;
  FPainel.Text := '';
end;

destructor TObservadorTotalPedido.Destroy;
begin
  FPainel := nil;
  inherited;
end;

procedure TObservadorTotalPedido.OnValorTotalChange
  (const AValorTotalPedido: double);
begin
  FPainel.Text := FormatFloat('Valor Total do Pedido: R$ #,##0.00',
    AValorTotalPedido);
end;

end.
