object frmCadastroCidade: TfrmCadastroCidade
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cidade'
  ClientHeight = 249
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 208
    Width = 438
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnCancelar: TButton
      Left = 76
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnSalvar: TButton
      Left = 1
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 438
    Height = 208
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 32
      Top = 52
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label2: TLabel
      Left = 32
      Top = 98
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label3: TLabel
      Left = 32
      Top = 149
      Width = 19
      Height = 13
      Caption = 'Pais'
    end
    object lblCodigoCliente: TLabel
      Left = 32
      Top = 6
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object edtCidade: TEdit
      Left = 32
      Top = 71
      Width = 313
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 0
    end
    object cbxUF: TComboBox
      Left = 32
      Top = 117
      Width = 44
      Height = 21
      ItemIndex = 22
      TabOrder = 1
      Text = 'RS'
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SE'
        'SP'
        'TO')
    end
    object edtPais: TEdit
      Left = 32
      Top = 168
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
    end
    object edtCodigo: TEdit
      Left = 32
      Top = 25
      Width = 65
      Height = 21
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 3
    end
  end
end
