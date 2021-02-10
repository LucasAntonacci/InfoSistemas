unit Endereco;

interface

Type
  TEndereco = class;

  TEventEndereco = procedure(pEndereco: TEndereco) of object;

  TEndereco = class
  private
    FLogradouro: string;
    FBairro: string;
    FUF: string;
    FCep: String;
    FNumero: integer;
    FLocalidade: string;
    FComplemento: string;
    FPais: string;
    procedure SetBairro(const Value: string);
    procedure SetCep(const Value: String);
    procedure SetComplemento(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: integer);
    procedure SetUF(const Value: string);
    procedure SetPais(const Value: string);
  public
    property Cep: String read FCep write SetCep;
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Numero: integer read FNumero write SetNumero;
    property Complemento: string read FComplemento write SetComplemento;
    property Bairro: string read FBairro write SetBairro;
    property Localidade: string read FLocalidade write SetLocalidade;
    property UF: string read FUF write SetUF;
    property Pais: string read FPais write SetPais;
  end;

implementation

{ TEndereco }

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TEndereco.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: integer);
begin
  FNumero := Value;
end;

procedure TEndereco.SetPais(const Value: string);
begin
  FPais := Value;
end;

procedure TEndereco.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
