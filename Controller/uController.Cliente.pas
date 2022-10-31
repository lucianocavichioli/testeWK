unit uController.Cliente;

interface

uses uModel.Cliente;

type
  TControllerCliente = class
  private
    FCliente: TCliente;
  public
    property Cliente: TCliente read FCliente write FCliente;
    function FindOne(CodigoCliente: integer): boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{TControllerCliente}

constructor TControllerCliente.Create;
begin
  FCliente := TCliente.Create;
end;

destructor TControllerCliente.Destroy;
begin
  FCliente.Free;
  inherited;
end;

function TControllerCliente.FindOne(CodigoCliente: integer): boolean;
begin
  Result := Cliente.FindOne(CodigoCliente);
end;

end.
