unit Cliente;

interface

uses
  Endereco;

Type
  TCliente = class
  private
    FEmail: string;
    FCPF: string;
    FIdentidade: integer;
    FNome: String;
    FEndereco: TEndereco;
    FTelefone: string;
    procedure SetCPF(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetIdentidade(const Value: integer);
    procedure SetNome(const Value: String);
    procedure SetTelefone(const Value:string);
  public
    Constructor create;
    destructor Destroy; override;
    property Nome: String read FNome write SetNome;
    property Identidade: integer read FIdentidade write SetIdentidade;
    property CPF: string read FCPF write SetCPF;
    property Telefone: string read FTelefone write SetTelefone;
    property Email: string read FEmail write SetEmail;
    property Endereco: TEndereco read FEndereco write SetEndereco;
  end;

implementation

{ TCliente }

constructor TCliente.create;
begin
  FEndereco := TEndereco.create;
end;

destructor TCliente.destroy;
begin
  FEndereco.DisposeOf;
  inherited;
end;

procedure TCliente.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

procedure TCliente.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TCliente.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TCliente.SetIdentidade(const Value: integer);
begin
  FIdentidade := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

end.
