program InfoSistemasLucasAntonacci;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Visao\Principal.pas' {Principal},
  Cliente in 'Dominio\Cliente.pas',
  Endereco in 'Dominio\Endereco.pas',
  ViaCep in 'Dominio\ViaCep.pas',
  Controller.Cadastro in 'controller\Controller.Cadastro.pas',
  Datamodule.Cadastro in 'Dao\Datamodule.Cadastro.pas' {DmCadastro: TDataModule},
  ClienteXML in 'Dominio\ClienteXML.pas',
  Email in 'Dominio\Email.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPrincipal, uPrincipal);
  Application.CreateForm(TDmCadastro, DmCadastro);
  Application.Run;
end.
