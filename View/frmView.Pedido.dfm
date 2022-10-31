object frmViewPedido: TfrmViewPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 410
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 744
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    BorderWidth = 5
    BorderStyle = bsSingle
    Caption = 'Manuten'#231#227'o de Pedidos'
    TabOrder = 0
  end
  object PainelPedido: TPanel
    Left = 0
    Top = 108
    Width = 744
    Height = 302
    Align = alClient
    BorderWidth = 5
    BorderStyle = bsSingle
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 15
      Width = 100
      Height = 16
      Caption = 'C'#243'digo do Cliente'
    end
    object Label2: TLabel
      Left = 243
      Top = 15
      Width = 77
      Height = 16
      Caption = 'Data Emiss'#227'o'
    end
    object Label4: TLabel
      Left = 518
      Top = 268
      Width = 128
      Height = 16
      Caption = 'Valor Total do Pedido:'
    end
    object lblTotalPedido: TLabel
      Left = 652
      Top = 268
      Width = 68
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object Label7: TLabel
      Left = 9
      Top = 108
      Width = 115
      Height = 16
      Caption = 'Produtos do Pedido:'
    end
    object edtCliente: TEdit
      Left = 115
      Top = 11
      Width = 77
      Height = 24
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 0
    end
    object edtData: TMaskEdit
      Left = 326
      Top = 11
      Width = 72
      Height = 24
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object btnGravarPedido: TButton
      Left = 9
      Top = 256
      Width = 128
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 4
      OnClick = btnGravarPedidoClick
    end
    object gridProdutos: TStringGrid
      Left = 9
      Top = 130
      Width = 712
      Height = 119
      DefaultColWidth = 90
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      TabOrder = 3
      OnDrawCell = gridProdutosDrawCell
      OnKeyDown = gridProdutosKeyDown
      ColWidths = (
        90
        236
        119
        118
        117)
      RowHeights = (
        24)
    end
    object gbProduto: TGroupBox
      Left = 9
      Top = 41
      Width = 712
      Height = 58
      Caption = 'Novo Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCaptionText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label3: TLabel
        Left = 17
        Top = 23
        Width = 105
        Height = 16
        Caption = 'C'#243'digo do Produto'
      end
      object Label6: TLabel
        Left = 234
        Top = 23
        Width = 65
        Height = 16
        Caption = 'Quantidade'
      end
      object Label5: TLabel
        Left = 416
        Top = 23
        Width = 78
        Height = 16
        Caption = 'Valor Unit'#225'rio'
      end
      object edtProduto: TEdit
        Left = 128
        Top = 20
        Width = 77
        Height = 24
        MaxLength = 5
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtProdutoExit
      end
      object edtQuantidade: TEdit
        Left = 305
        Top = 20
        Width = 77
        Height = 24
        MaxLength = 5
        TabOrder = 1
      end
      object btnInserirProduto: TButton
        Left = 614
        Top = 20
        Width = 95
        Height = 25
        Caption = 'Inserir Produto'
        TabOrder = 3
        OnClick = btnInserirProdutoClick
      end
      object edtValorUnitario: TEdit
        Left = 500
        Top = 20
        Width = 77
        Height = 24
        MaxLength = 5
        TabOrder = 2
      end
    end
    object btnCancelar: TButton
      Left = 153
      Top = 256
      Width = 128
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = btnCancelarClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 744
    Height = 67
    Align = alTop
    Alignment = taLeftJustify
    BorderWidth = 5
    BorderStyle = bsSingle
    TabOrder = 2
    object btnCancelarPedido: TButton
      Left = 222
      Top = 19
      Width = 144
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 1
      OnClick = btnCancelarPedidoClick
    end
    object btnRecuperarPedido: TButton
      Left = 422
      Top = 19
      Width = 144
      Height = 25
      Caption = 'Recuperar Pedido'
      TabOrder = 2
      OnClick = btnRecuperarPedidoClick
    end
    object btnInserirPedido: TButton
      Left = 17
      Top = 19
      Width = 144
      Height = 25
      Caption = 'Inserir Pedido'
      TabOrder = 0
      OnClick = btnInserirPedidoClick
    end
  end
end
