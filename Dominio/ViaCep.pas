unit ViaCep;

interface

uses
  System.Classes, Endereco,Datamodule.Cadastro, System.SysUtils;

Type

  IViaCep = interface
    ['{186E2B9A-1A86-4D94-8A3C-E933219ED960}']
    function getEndereco(pCEP: integer): IViaCep;
  end;

  TViaCep = class(TInterfacedObject, IViaCep)
  private
    FOnReceiveEndereco: TEventEndereco;
  public
    constructor Create(ReceiveEndereco: TEventEndereco);
    function getEndereco(pCEP: integer): IViaCep;
  end;

implementation

{ TViaCep }

constructor TViaCep.Create(ReceiveEndereco: TEventEndereco);
begin
  FOnReceiveEndereco := ReceiveEndereco;
end;

function TViaCep.getEndereco(pCEP: integer): IViaCep;
var
  Endereco: TEndereco;
begin
  Result:=Self;
  DmCadastro.RESTClient1.BaseURL:=Format('https://viacep.com.br/ws/%s/json/',[pCep.ToString]);
  DmCadastro.RESTRequest1.Execute;
  Endereco := TEndereco.Create;
  with Endereco do
  begin
    Cep:= DmCadastro.FDMemTable1.FieldByName('cep').AsString;
    Logradouro:=DmCadastro.FDMemTable1.FieldByName('logradouro').AsString;
    Complemento:=DmCadastro.FDMemTable1.FieldByName('complemento').AsString;
    Bairro:=DmCadastro.FDMemTable1.FieldByName('bairro').AsString;
    Localidade:=DmCadastro.FDMemTable1.FieldByName('localidade').AsString;
    UF:=DmCadastro.FDMemTable1.FieldByName('uf').AsString;
  end;
  FOnReceiveEndereco(Endereco);
end;

end.
