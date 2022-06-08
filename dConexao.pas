unit dConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase;

type
  TdtmConexao = class(TDataModule)
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDConnection: TFDConnection;
    dtsFuncionario: TDataSource;
    qryFuncionario: TFDQuery;
    qryConsultaFuncionario: TFDQuery;
    qryConsultaFuncionarioCODIGO: TIntegerField;
    qryConsultaFuncionarioNOME: TStringField;
    qryConsultaFuncionarioENDERECO: TStringField;
    qryConsultaFuncionarioBAIRRO: TStringField;
    qryConsultaFuncionarioNUMERO: TStringField;
    qryConsultaFuncionarioCOMPLEMENTO: TStringField;
    qryConsultaFuncionarioCIDADE: TStringField;
    qryConsultaFuncionarioCEP: TStringField;
    qryConsultaFuncionarioCPF: TStringField;
    qryConsultaFuncionarioRG: TStringField;
    qryConsultaFuncionarioTELEFONE: TStringField;
    qryConsultaFuncionarioDATA_NASCIMENTO: TDateField;
    qryConsultaFuncionarioEMAIL: TStringField;
    qryConsultaFuncionarioSALARIO: TBCDField;
    qryFuncionarioCODIGO: TIntegerField;
    qryFuncionarioNOME: TStringField;
    qryFuncionarioENDERECO: TStringField;
    qryFuncionarioBAIRRO: TStringField;
    qryFuncionarioNUMERO: TStringField;
    qryFuncionarioCOMPLEMENTO: TStringField;
    qryFuncionarioCIDADE: TStringField;
    qryFuncionarioCEP: TStringField;
    qryFuncionarioCPF: TStringField;
    qryFuncionarioRG: TStringField;
    qryFuncionarioTELEFONE: TStringField;
    qryFuncionarioDATA_NASCIMENTO: TDateField;
    qryFuncionarioEMAIL: TStringField;
    qryFuncionarioSALARIO: TBCDField;
    qryCidade: TFDQuery;
    qryConsultaCidade: TFDQuery;
    dtsCidade: TDataSource;
    qryCidadeCODIGO: TIntegerField;
    qryCidadeCIDADE: TStringField;
    qryCidadeUF: TStringField;
    qryCidadePAIS: TStringField;
    qryConsultaCidadeCODIGO: TIntegerField;
    qryConsultaCidadeCIDADE: TStringField;
    qryConsultaCidadeUF: TStringField;
    qryConsultaCidadePAIS: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmConexao: TdtmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

end.
