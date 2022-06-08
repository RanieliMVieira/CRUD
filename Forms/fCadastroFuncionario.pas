unit fCadastroFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, dConexao,
  uFuncionario, Vcl.DBCtrls, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits,
  Vcl.ComCtrls, fConsultaCidade, uCidade;

type
  TfrmCadastroFuncionario = class(TForm)
    pnlClienteBotao: TPanel;
    pnlClienteInfo: TPanel;
    lblNomeCliente: TLabel;
    edtNome: TEdit;
    lblEndereco: TLabel;
    edtEndereco: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    edtCidade: TEdit;
    lblCidade: TLabel;
    lblTelefone: TLabel;
    edtTelefone: TEdit;
    lblCPF: TLabel;
    edtEMAIL: TEdit;
    lblEMAIL: TLabel;
    edtCPF: TMaskEdit;
    edtCodigo: TEdit;
    lblCodigoCliente: TLabel;
    edtBairro: TEdit;
    lblBairro: TLabel;
    edtCEP: TMaskEdit;
    lblCEP: TLabel;
    btnCidade: TButton;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtRG: TEdit;
    edtData: TDateTimePicker;
    edtSalario: TJvCalcEdit;
    lblNumero: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCidadeClick(Sender: TObject);
    procedure edtCidadeExit(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    CodigoFuncionario: integer;
    Tipo: String;
    procedure IncluirFuncionario;
    procedure AlterarFuncionario;
    function ValidarCidade: Boolean;
  end;

var
  frmCadastroFuncionario: TfrmCadastroFuncionario;

implementation

{$R *.dfm}

procedure TfrmCadastroFuncionario.AlterarFuncionario;
var
  lFuncionario: TFuncionario;
begin
  lFuncionario := TFuncionario.Create;
  try
    lFuncionario.CODIGO := CodigoFuncionario;
    lFuncionario.NOME := edtNome.Text;
    lFuncionario.ENDERECO := edtEndereco.Text;
    lFuncionario.BAIRRO := edtBairro.Text;
    lFuncionario.NUMERO := edtNumero.Text;
    lFuncionario.COMPLEMENTO := edtComplemento.Text;
    lFuncionario.CIDADE := edtCidade.Text;
    lFuncionario.CEP := edtCEP.Text;
    lFuncionario.CPF := edtCPF.Text;
    lFuncionario.RG := edtRG.Text;
    lFuncionario.TELEFONE := edtTelefone.Text;
    lFuncionario.DATA_NASCIMENTO := edtData.Date;
    lFuncionario.EMAIL := edtEMAIL.Text;
    lFuncionario.SALARIO := edtSalario.Value;

    lFuncionario.Alterar(true);
  finally
    lFuncionario.Free;
  end;
end;

procedure TfrmCadastroFuncionario.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroFuncionario.btnCidadeClick(Sender: TObject);
var
  lConsultaCidade: TfrmConsultaCidade;
begin
  lConsultaCidade := TfrmConsultaCidade.Create(nil);
  try
    lConsultaCidade.showmodal;
    edtCidade.Text := dtmConexao.qryConsultaCidadeCIDADE.Value;
    edtCidade.SetFocus;
  finally
    lConsultaCidade.Free;
  end;

end;

procedure TfrmCadastroFuncionario.btnSalvarClick(Sender: TObject);
var
  I: integer;
begin
  if trim(edtNome.Text) = '' then
  begin
    ShowMessage
      ('Campo obrigat�rio n�o informado, favor preencher o Nome do funcion�rio.');
    edtNome.SetFocus;
    exit;
  end
  else if trim(edtEndereco.Text) = '' then
  begin
    ShowMessage
      ('Campo obrigat�rio n�o informado, favor preencher o endere�o do funcion�rio.');
    edtEndereco.SetFocus;
    exit;
  end
  else if trim(edtCidade.Text) = '' then
  begin
    ShowMessage
      ('Campo obrigat�rio n�o informado, favor preencher a cidade do fornecedor.');
    edtCidade.SetFocus;
    exit;
  end
  else if not TFuncionario.ValidaCEP(edtCEP.Text) then
  begin
    ShowMessage('CEP inv�lido.');
    edtCEP.SetFocus;
    exit;
  end
  else if trim(edtCPF.Text) = '' then
  begin
    ShowMessage('CPF n�o pode ser vazio.');
    edtCPF.SetFocus;
    exit;
  end
  else if not TFuncionario.ValidaCPF(edtCPF.Text) then
  begin
    ShowMessage('CPF inv�lido.');
    edtCPF.SetFocus;
    exit;
  end
  else if Tipo = 'Incluir' then
  begin
    IncluirFuncionario;
  end
  else if Tipo = 'Alterar' then
  begin
    AlterarFuncionario;
  end;
  close;
end;

procedure TfrmCadastroFuncionario.edtCidadeExit(Sender: TObject);
begin
  ValidarCidade;
end;

procedure TfrmCadastroFuncionario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TfrmCadastroFuncionario.FormShow(Sender: TObject);
begin
  edtNome.SetFocus;
end;

procedure TfrmCadastroFuncionario.IncluirFuncionario;
var
  lFuncionario: TFuncionario;
begin
  lFuncionario := TFuncionario.Create;
  try
    lFuncionario.CODIGO := strtoint(edtCodigo.Text);
    lFuncionario.NOME := edtNome.Text;
    lFuncionario.ENDERECO := edtEndereco.Text;
    lFuncionario.BAIRRO := edtBairro.Text;
    lFuncionario.NUMERO := edtNumero.Text;
    lFuncionario.COMPLEMENTO := edtComplemento.Text;
    lFuncionario.CIDADE := edtCidade.Text;
    lFuncionario.CEP := edtCEP.Text;
    lFuncionario.CPF := edtCPF.Text;
    lFuncionario.RG := edtRG.Text;
    lFuncionario.TELEFONE := edtTelefone.Text;
    lFuncionario.DATA_NASCIMENTO := edtData.Date;
    lFuncionario.EMAIL := edtEMAIL.Text;
    lFuncionario.SALARIO := edtSalario.Value;

    lFuncionario.Incluir(true);
  finally
    lFuncionario.Free;
  end;

end;

function TfrmCadastroFuncionario.ValidarCidade: Boolean;
begin
  if (trim(edtCidade.Text) <> EmptyStr) then
  begin
    if not TCidade.Existe(edtCidade.Text) then
    begin
      ShowMessage('Cidade n�o cadastrada, favor informar um que exista.');
      edtCidade.SetFocus;
      edtCidade.Clear;
    end;
  end;

end;

end.
