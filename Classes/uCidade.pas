unit uCidade;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils;

type
  TCidade = class
  private
    FCODIGO: integer;
    FCIDADE: string;
    FUF: string;
    FPAIS: string;

    class var FObjetoBusca: TCidade;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);
    class function Existe(pCidade: String): boolean;
    function MostraProximoID: integer;

    constructor Create;
    property CODIGO: integer read FCODIGO write FCODIGO;
    property CIDADE: string read FCIDADE write FCIDADE;
    property UF: string read FUF write FUF;
    property PAIS: string read FPAIS write FPAIS;

    class property ObjetoBusca: TCidade read FObjetoBusca write FObjetoBusca;
  end;

implementation

{ TCliente }

procedure TCidade.Alterar(pEfetuarCommit: boolean);
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' UPDATE CIDADE SET               ');
    lQuery.sql.Add(' CIDADE = :CIDADE                ');
    lQuery.sql.Add(' ,UF = :UF                       ');
    lQuery.sql.Add(' ,PAIS = :PAIS                   ');
    lQuery.sql.Add(' WHERE CODIGO = :CODIGO          ');

    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.ParamByName('CIDADE').AsString := FCIDADE;
    lQuery.ParamByName('UF').AsString := FUF;
    lQuery.ParamByName('PAIS').AsString := FPAIS;
    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmconexao.FDConnection.Commit;
    end;

  finally
    lQuery.Free;
  end;
end;

procedure TCidade.Carrega;
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' SELECT * FROM CIDADE          ');
    lQuery.sql.Add(' WHERE CODIGO = :CODIGO        ');
    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FCIDADE := lQuery.FieldByName('CIDADE').AsString;
      FUF := lQuery.FieldByName('UF').AsString;
      FPAIS := lQuery.FieldByName('PAIS').AsString;
    end;

  finally
    lQuery.Free;
  end;
end;

constructor TCidade.Create;
begin
  Inicializar;
end;

destructor TCidade.Destroy;
begin

  inherited;
end;

procedure TCidade.Excluir(pEfetuarCommit: boolean);
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add('DELETE FROM CIDADE WHERE CODIGO = :CODIGO ');
    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmconexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TCidade.Existe(pCidade: String): boolean;
var
  lQuery: Tfdquery;
begin
  Result := false;
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add('SELECT * FROM CIDADE WHERE CIDADE = :CIDADE');
    lQuery.ParamByName('CIDADE').AsString := pCidade;
    lQuery.Open;
    if (lQuery.RecordCount > 0) then
    begin
      Result := true;
      if not Assigned(FObjetoBusca) then
      begin
        FObjetoBusca := TCidade.Create;
      end;
      FObjetoBusca.CIDADE := pCidade;
      FObjetoBusca.Carrega;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TCidade.Incluir(pEfetuarCommit: boolean);
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' INSERT INTO CIDADE(           ');
    lQuery.sql.Add(' CODIGO                        ');
    lQuery.sql.Add(' ,CIDADE                       ');
    lQuery.sql.Add(' ,UF                           ');
    lQuery.sql.Add(' ,PAIS                         ');
    lQuery.sql.Add(' )VALUES(                      ');
    lQuery.sql.Add(' :CODIGO                       ');
    lQuery.sql.Add(' ,:CIDADE                      ');
    lQuery.sql.Add(' ,:UF                          ');
    lQuery.sql.Add(' ,:PAIS                       )');

    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.ParamByName('CIDADE').AsString := FCIDADE;
    lQuery.ParamByName('UF').AsString := FUF;
    lQuery.ParamByName('PAIS').AsString := FPAIS;

    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmconexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;

end;

procedure TCidade.Inicializar;
begin
  FCODIGO := 0;
  FCIDADE := '';
  FUF := '';
  FPAIS := '';
end;

function TCidade.MostraProximoID: integer;
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' SELECT gen_id(GEN_CIDADE_ID, 0)+1 codigo from CIDADE');
    lQuery.Open;
    Result := lQuery.FieldByName('codigo').AsInteger;
  finally
    lQuery.Free;
  end;
end;

end.
