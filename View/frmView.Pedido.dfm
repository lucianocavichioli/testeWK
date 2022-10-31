object frmViewPedido: TfrmViewPedido
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o de Pedidos'
  ClientHeight = 421
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
  object PainelPedido: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 84
    Width = 734
    Height = 293
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BorderWidth = 5
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = 161
    ExplicitWidth = 744
    ExplicitHeight = 302
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
  object Rodape: TStatusBar
    AlignWithMargins = True
    Left = 5
    Top = 387
    Width = 734
    Height = 29
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Panels = <
      item
        Alignment = taRightJustify
        Text = 'Valor Total do Pedido: R$ 0,00'
        Width = 200
      end>
    ExplicitLeft = 0
    ExplicitTop = 381
    ExplicitWidth = 744
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 738
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = clCream
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 80
    object btnInserirPedido: TButton
      Left = 73
      Top = 15
      Width = 144
      Height = 44
      Caption = 'Inserir Pedido'
      TabOrder = 0
      OnClick = btnInserirPedidoClick
    end
    object btnCancelarPedido: TButton
      Left = 275
      Top = 15
      Width = 144
      Height = 44
      Caption = 'Cancelar Pedido'
      TabOrder = 1
      OnClick = btnCancelarPedidoClick
    end
    object btnRecuperarPedido: TButton
      Left = 478
      Top = 15
      Width = 144
      Height = 44
      Caption = 'Recuperar Pedido'
      TabOrder = 2
      OnClick = btnRecuperarPedidoClick
    end
  end
end
