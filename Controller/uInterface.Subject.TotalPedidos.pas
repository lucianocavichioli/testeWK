unit uInterface.Subject.TotalPedidos;

interface

uses uInterface.Observer.TotalPedidos;

 type
  iSubjectTotalPedidos = interface
    procedure AdicionarObserver(const AObserver: iObserverTotalPedidos);
    procedure RemoverObserver(const AObserver: iObserverTotalPedidos);
    procedure Notificar;
  end;

implementation

end.
