unit fMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  fConsultaFuncionario, fConsultaCidade;

type
  TfrmMenuPrincipal = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Sair1: TMenuItem;
    Cidades1: TMenuItem;
    procedure Cidades1Click(Sender: TObject);
    procedure Funcionarios1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation

{$R *.dfm}

procedure TfrmMenuPrincipal.Cidades1Click(Sender: TObject);
var
  lConsultaCidade: TfrmConsultaCidade;
begin
  lConsultaCidade := TfrmConsultaCidade.Create(nil);
  try
    lConsultaCidade.ShowModal;
  finally
    lConsultaCidade.Free;
  end;
end;

procedure TfrmMenuPrincipal.Funcionarios1Click(Sender: TObject);
var
  lConsultaFuncionario: TfrmConsultaFuncionario;
begin
  lConsultaFuncionario := TfrmConsultaFuncionario.Create(nil);
  try
    lConsultaFuncionario.ShowModal;
  finally
    lConsultaFuncionario.Free;
  end;
end;

procedure TfrmMenuPrincipal.Sair1Click(Sender: TObject);
begin
   Close;
end;

end.
