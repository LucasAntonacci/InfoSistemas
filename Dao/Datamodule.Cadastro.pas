unit Datamodule.Cadastro;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TDmCadastro = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmCadastro: TDmCadastro;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
