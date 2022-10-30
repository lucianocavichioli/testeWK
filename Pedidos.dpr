program Pedidos;

uses
  Vcl.Forms,
  frmView.Pedido in 'View\frmView.Pedido.pas' {frmViewPedido},
  uController.Conexao in 'Controller\uController.Conexao.pas',
  uModel.Cliente in 'Model\uModel.Cliente.pas',
  uModel.Pedido in 'Model\uModel.Pedido.pas',
  uModel.ItemPedido in 'Model\uModel.ItemPedido.pas',
  uController.Cliente in 'Controller\uController.Cliente.pas',
  uController.Pedido in 'Controller\uController.Pedido.pas',
  uDAO.Conexao in 'DAO\uDAO.Conexao.pas',
  uController.Produto in 'Controller\uController.Produto.pas',
  uModel.Produto in 'Model\uModel.Produto.pas';

{$R *.res}

begin
 // ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewPedido, frmViewPedido);
  Application.Run;
end.
