unit Controller.Cadastro;

interface

uses
  Endereco,
  Cliente,
  ClienteXML,
  Email,
  ViaCep;

Type
  TEndereco = Endereco.TEndereco;
  TEventEndereco = Endereco.TEventEndereco;
  IViaCep = ViaCep.IViaCep;
  TViaCep = ViaCep.TViaCep;
  TCliente = Cliente.TCliente;

  iControllerCadastro = interface
    ['{75E3F08E-B0AB-40C4-85B3-8BBCE2627CBF}']
    function ConsultarCep(pCep: integer; pOnReceiveEndereco: TEventEndereco) : iControllerCadastro;
    function CriarXML(pCliente: TCliente): iControllerCadastro;
    function Email: iEmail;
  end;

  TControllerCadastro = class(TInterfacedObject, iControllerCadastro)
  public
    function ConsultarCep(pCep: integer; pOnReceiveEndereco: TEventEndereco) : iControllerCadastro;
    function CriarXML(pCliente: TCliente): iControllerCadastro;
    function Email: iEmail;
  end;

implementation

{ TControllerCadastro }

function TControllerCadastro.ConsultarCep(pCep: integer; pOnReceiveEndereco: TEventEndereco): iControllerCadastro;
var
  LCep: IViaCep;
begin
  Result := Self;
  LCep := TViaCep.Create(pOnReceiveEndereco).getEndereco(pCep);
end;

function TControllerCadastro.CriarXML(pCliente: TCliente): iControllerCadastro;
var
  LXMLCliente: IXMLCliente;
begin
  Result := Self;
  LXMLCliente := TXMLCliente.Create(pCliente);
  LXMLCliente.generateXML;
end;

function TControllerCadastro.Email: iEmail;
begin
  Result:= TEmail.Create;
end;

end.
