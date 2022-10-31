unit uController.TotalPedido;

interface

uses System.Classes, uInterface.Subject.TotalPedidos,
  uInterface.Observer.TotalPedidos,
  System.Generics.Collections;

type
  TControllerTotalPedido = class(TInterfacedObject, iSubjectTotalPedidos)
  private
    FValorTotalPedido: double;
    FObservadores: TList<iObserverTotalPedidos>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Zerar;
    procedure Adicionar(const Value: double);
    procedure Subtrair(const Value: double);
    procedure AdicionarObserver(const AObserver: iObserverTotalPedidos);
    procedure RemoverObserver(const AObserver: iObserverTotalPedidos);
    procedure Notificar;
  end;

implementation

{TControllerTotalPedido}

constructor TControllerTotalPedido.Create;
begin
  FObservadores := TList<iObserverTotalPedidos>.Create;
  Zerar;
end;

destructor TControllerTotalPedido.Destroy;
begin
  FObservadores.Free;
  inherited;
end;

procedure TControllerTotalPedido.AdicionarObserver(const AObserver
  : iObserverTotalPedidos);
begin
  FObservadores.Add(AObserver);
end;

procedure TControllerTotalPedido.RemoverObserver(const AObserver
  : iObserverTotalPedidos);
begin
  FObservadores.Delete(FObservadores.IndexOf(AObserver));
end;

procedure TControllerTotalPedido.Notificar;
var
   Observador: iObserverTotalPedidos;
begin
  for Observador in FObservadores do
    Observador.OnValorTotalChange(FValorTotalPedido);
end;

procedure TControllerTotalPedido.Subtrair(const Value: double);
begin
  FValorTotalPedido := FValorTotalPedido - Value;
  Notificar;
end;

procedure TControllerTotalPedido.Adicionar(const Value: double);
begin
  FValorTotalPedido := FValorTotalPedido + Value;
  Notificar;
end;

procedure TControllerTotalPedido.Zerar;
begin
  FValorTotalPedido := 0.00;
  Notificar;
end;

end.
