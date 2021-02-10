object DmCadastro: TDmCadastro
  OldCreateOrder = False
  Height = 259
  Width = 389
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://viacep.com.br/ws/31110720/json'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 48
    Top = 144
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 48
    Top = 24
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 48
    Top = 80
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse1
    Left = 216
    Top = 80
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 216
    Top = 24
  end
end
