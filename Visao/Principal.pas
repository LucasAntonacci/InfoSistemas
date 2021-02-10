unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.threading, System.generics.collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Layouts,
  FMX.ListBox, Controller.Cadastro, IdSMTP, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Effects, FMX.Ani;

type
  TPrincipal = class(TForm)
    LayoutPrincipal: TLayout;
    LayoutBottom: TLayout;
    LayoutCenter: TLayout;
    gDados: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    gEndereco: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    LayoutContentAll: TLayout;
    LayoutRight: TLayout;
    lstPesquisa: TListView;
    bbInserirCadastro: TButton;

    eNome: TEdit;
    eIdentidade: TEdit;
    eCPF: TEdit;
    eTelefone: TEdit;
    eEmail: TEdit;
    eCep: TEdit;
    eLogradouro: TEdit;
    eNumero: TEdit;
    eComplemento: TEdit;
    eBairro: TEdit;
    eCidade: TEdit;
    eEstado: TEdit;
    ePais: TEdit;
    procedure eCepChangeTracking(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbInserirCadastroClick(Sender: TObject);
  private
    FListaClientes: TObjectList<TCliente>;
    procedure ValidarCadastro;
    procedure InserirCadastro;
    procedure LimparCampos;
    procedure BuscarCep;
    procedure EnviarEmail(pDestinatario: string);
    procedure RecebeEndereco(pEndereco: TEndereco);
    procedure updateListview;
  public
    { Public declarations }
  end;

var
  uPrincipal: TPrincipal;

implementation

{$R *.fmx}
{ TPrincipal }

procedure TPrincipal.bbInserirCadastroClick(Sender: TObject);
begin
  ValidarCadastro;
  InserirCadastro;
end;

procedure TPrincipal.BuscarCep;

begin
  TThread.CreateAnonymousThread(
    procedure
    var
      ControllerCadastro: iControllerCadastro;
    begin
      ControllerCadastro := TControllerCadastro.create;
      ControllerCadastro.ConsultarCep(strToInt(eCep.Text), RecebeEndereco);
    end).Start;

end;

procedure TPrincipal.InserirCadastro;
var
  LCliente: TCliente;
  LControllerCadastro: iControllerCadastro;
begin
  LCliente := TCliente.create;
  LControllerCadastro := TControllerCadastro.create;
  try
    LCliente.Nome                 := eNome.Text;
    LCliente.Identidade           := eIdentidade.Text.ToInteger;
    LCliente.CPF                  := eCPF.Text;
    LCliente.Telefone             := eTelefone.Text;
    LCliente.Email                := eEmail.Text;
    LCliente.Endereco.Cep         := eCep.Text;
    LCliente.Endereco.Logradouro  := eLogradouro.Text;
    LCliente.Endereco.Numero      := eNumero.Text.ToInteger;
    LCliente.Endereco.Complemento := eComplemento.Text;
    LCliente.Endereco.Bairro      := eBairro.Text;
    LCliente.Endereco.Localidade  := eCidade.Text;
    LCliente.Endereco.UF          := eEstado.Text;
    LCliente.Endereco.Pais        := ePais.Text;
    LControllerCadastro.CriarXML(LCliente);
    EnviarEmail(eEmail.Text);
    FListaClientes.Add(LCliente);
    updateListview;
  finally
    LimparCampos;
  end;
end;

procedure TPrincipal.eCepChangeTracking(Sender: TObject);
begin
  if Length((Sender as TEdit).Text) = 8 then
    BuscarCep;
end;

procedure TPrincipal.EnviarEmail(pDestinatario: string);
var
  LControllerCadastro: iControllerCadastro;
begin
  LControllerCadastro := TControllerCadastro.create;
  LControllerCadastro.Email.setHost(satDefault, 465, 'smtp.gmail.com', 'user@gmailcom', 'senh@Email2021').setMessage('programacaoinfosistemas@gmail.com',
  'Lucas Antonacci', pDestinatario, 'Dados do cliente cadastrado em Anexo').send('Segue em anexo os dados do cliente cadastrado.', 'Email.xml');
end;

procedure TPrincipal.FormCreate(Sender: TObject);
begin
  FListaClientes := TObjectList<TCliente>.create;
end;

procedure TPrincipal.FormDestroy(Sender: TObject);
begin
  FListaClientes.DisposeOf;
end;

procedure TPrincipal.FormShow(Sender: TObject);
begin
  eNome.SetFocus;
end;

procedure TPrincipal.LimparCampos;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TEdit then
      TEdit(Components[I]).Text := EmptyStr;
  end;
  eNome.SetFocus;
end;

procedure TPrincipal.RecebeEndereco(pEndereco: TEndereco);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      eLogradouro.Text := pEndereco.Logradouro;
      eNumero.Text := pEndereco.Numero.ToString;
      eComplemento.Text := pEndereco.Complemento;
      eBairro.Text := pEndereco.Bairro;
      eCidade.Text := pEndereco.Localidade;
      eEstado.Text := pEndereco.UF;
      ePais.Text := 'Brasil';
      eNumero.SetFocus;
      pEndereco.DisposeOf;
    end);

end;

procedure TPrincipal.updateListview;
var
  LCli: TCliente;
begin
  lstPesquisa.Items.Clear;
  for LCli in FListaClientes do
  begin
    with lstPesquisa.Items.Add do
    begin
      Data['Name'] := LCli.Nome;
      Data['Email'] := LCli.Email;
    end;
  end;
end;

procedure TPrincipal.ValidarCadastro;
begin
  if eIdentidade.Text = EmptyStr then
    eIdentidade.Text := '0';
  if eCPF.Text = EmptyStr then
    eCPF.Text := '0';
  if eNumero.Text = EmptyStr then
    eNumero.Text := '0';
end;

end.
