unit fConsultaCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, fCadastroCidade, dConexao, uCidade;

type
  TfrmConsultaCidade = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dbgConsultaCidade: TDBGrid;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnVisualizar: TButton;
    btnExcluir: TButton;
    btnSair: TButton;
    edtPesquisarCidade: TEdit;
    cbxFiltroCidade: TComboBox;
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtPesquisarCidadeChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizarQueryCidade;
    procedure BuscarDadosCidade;
  end;

var
  frmConsultaCidade: TfrmConsultaCidade;

implementation

{$R *.dfm}

procedure TfrmConsultaCidade.btnAlterarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaCidade.RecordCount > 0 then
  begin
    BuscarDadosCidade;
  end
  else
  begin
    ShowMessage('N�o h� registro selecionado.');
  end;
end;

procedure TfrmConsultaCidade.btnExcluirClick(Sender: TObject);
var
  lCidade: TCidade;
begin
  if dtmConexao.qryConsultaCidade.RecordCount > 0 then
  begin
    if Application.MessageBox
      ('Tem certeza que deseja excluir o registro selecionado?', 'Confirma��o',
      mb_yesNO + mb_iconQuestion + MB_DEFBUTTON2) = idYes then
      begin
        lCidade := TCidade.Create;
        try
          lCidade.CODIGO := dtmConexao.qryConsultaCidadeCODIGO.AsInteger;
          lCidade.Excluir(true);
          AtualizarQueryCidade;
          frmConsultaCidade.Refresh;
        finally
          lCidade.Free;
        end;
      end;
  end
  else
  begin
    ShowMessage('N�o h� registro selecionado.');
  end;

end;

procedure TfrmConsultaCidade.btnIncluirClick(Sender: TObject);
var
  lFormulario: TfrmCadastroCidade;
  lCidade: TCidade;
begin
  lFormulario := TfrmCadastroCidade.Create(nil);

  try
    lFormulario.Tipo := 'Incluir';
    lFormulario.edtCodigo.Enabled := false;
    lFormulario.edtCodigo.Text := lCidade.MostraProximoID.ToString;
    lFormulario.ShowModal;
    AtualizarQueryCidade;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaCidade.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaCidade.btnVisualizarClick(Sender: TObject);
var
  lFormulario: TfrmCadastroCidade;
  lCidade: TCidade;
begin
  if dtmConexao.qryConsultaCidade.RecordCount > 0 then
  begin
    lCidade := TCidade.Create;
    lFormulario := TfrmCadastroCidade.Create(nil);
    try
      lCidade.CODIGO := dtmConexao.qryConsultaCidade.FieldByName('CODIGO')
        .asinteger;
      lCidade.Carrega;
      lFormulario.edtCodigo.Text := IntToStr(lCidade.CODIGO);
      lFormulario.edtCidade.Text := lCidade.CIDADE;
      lFormulario.cbxUF.Text := lCidade.UF;
      lFormulario.edtPais.Text := lCidade.PAIS;
      lFormulario.btnSalvar.Enabled := false;
      lFormulario.ShowModal;
      AtualizarQueryCidade;
    finally
      lFormulario.Free;
      lCidade.Free;
    end;
  end
  else
  begin
    ShowMessage('N�o h� registro selecionado.');
  end;
end;

procedure TfrmConsultaCidade.BuscarDadosCidade;
var
  lFormulario: TfrmCadastroCidade;
  lCidade: TCidade;
begin
  lCidade := TCidade.Create;
  lFormulario := TfrmCadastroCidade.Create(nil);
  try
    lFormulario.Tipo := 'Alterar';
    lFormulario.CodigoCidade := 0;
    lCidade.CODIGO := dtmConexao.qryConsultaCidade.FieldByName('CODIGO')
      .asinteger;
    lFormulario.CodigoCidade := lCidade.CODIGO;
    lCidade.Carrega;
    lFormulario.edtCodigo.Text := IntToStr(lCidade.CODIGO);
    lFormulario.edtCidade.Text := lCidade.CIDADE;
    lFormulario.cbxUF.Text := lCidade.UF;
    lFormulario.edtPais.Text := lCidade.PAIS;
    lFormulario.ShowModal;
    AtualizarQueryCidade;
  finally
    lFormulario.Free;
    lCidade.Free;
  end;

end;

procedure TfrmConsultaCidade.edtPesquisarCidadeChange(Sender: TObject);
begin
  AtualizarQueryCidade;
end;

procedure TfrmConsultaCidade.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TfrmConsultaCidade.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  edtPesquisarCidade.SetFocus;
  AtualizarQueryCidade;
end;

procedure TfrmConsultaCidade.AtualizarQueryCidade;
begin
  dtmConexao.qryConsultaCidade.close;
  dtmConexao.qryConsultaCidade.SQL.Clear;
  dtmConexao.qryConsultaCidade.SQL.add('SELECT * FROM CIDADE');
  if edtPesquisarCidade.Text <> emptyStr then
  begin
    case cbxFiltroCidade.ItemIndex of
      0:
        begin
          dtmConexao.qryConsultaCidade.SQL.add('WHERE CODIGO LIKE ' +
            QuotedStr('%' + edtPesquisarCidade.Text + '%'));
        end;
      1:
        begin
          dtmConexao.qryConsultaCidade.SQL.add('WHERE CIDADE LIKE ' +
            QuotedStr('%' + edtPesquisarCidade.Text + '%'));
        end;
    end;
  end;
  dtmConexao.qryConsultaCidade.Open;
end;

end.
