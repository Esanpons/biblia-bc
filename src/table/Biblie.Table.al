table 50000 "Biblie"
{
    Caption = 'Biblie', Comment = 'ESP="Biblia"';
    DataClassification = CustomerContent;
    LookupPageId = "List Biblie";
    DrillDownPageId = "List Biblie";

    fields
    {
        field(1; "Id Book"; Integer)
        {
            Caption = 'Id Book', Comment = 'ESP="Id libro"';
        }
        field(2; "Id Chapter"; Integer)
        {
            Caption = 'Id Chapter', Comment = 'ESP="Capitulo"';
        }
        field(3; "Id Verse"; Integer)
        {
            Caption = 'Id Verse', Comment = 'ESP="Versiculo"';
        }
        field(5; "Name Book"; Text[250])
        {
            Caption = 'Name Book', Comment = 'ESP="Nombre libro"';
        }
        field(6; "Text BEC"; Text[2048])
        {
            Caption = 'Text BEC', Comment = 'ESP="Texto BEC"';
        }
        field(7; "Text RV1960"; Text[2048])
        {
            Caption = 'Text RV1960', Comment = 'ESP="Texto RV1960"';
        }
        field(8; "Text LBLA"; Text[2048])
        {
            Caption = 'Text LBLA', Comment = 'ESP="Texto LBLA"';
        }
    }
    keys
    {
        key(PK; "Id Book", "Id Chapter", "Id Verse")
        {
            Clustered = true;
        }
    }

    procedure NewDataRec()
    var
        Text001Qst: Label 'Are you sure to continue?', Comment = 'ESP="¿Estas seguro de continuar?"';
    begin
        if not Confirm(Text001Qst) then
            exit;

        Rec.Reset();
        Rec.DeleteAll();

        LoadExcel();
    end;

    local procedure LoadExcel()
    var
        ExcelBuffer: Record "Excel Buffer";
        DocInStream: InStream;
        FileName: Text;
        ShettName: Text;
        ValueInt: Integer;
    begin
        Clear(ExcelBuffer);
        Clear(DocInStream);

        if not UploadIntoStream('', '', '', FileName, DocInStream) then
            exit;

        ShettName := 'biblia';
        ExcelBuffer.OpenBookStream(DocInStream, ShettName);
        ExcelBuffer.ReadSheetContinous(ShettName, false);


        ExcelBuffer.Reset();
        ExcelBuffer.SetFilter("Row No.", '<>1');
        if ExcelBuffer.FindSet() then
            repeat
                case ExcelBuffer."Column No." of
                    1://A
                        begin
                            Rec.Init();
                            Evaluate(ValueInt, ExcelBuffer."Cell Value as Text");
                            Rec."Id Book" := ValueInt;
                        end;
                    2://B
                        begin
                            Evaluate(ValueInt, ExcelBuffer."Cell Value as Text");
                            Rec."Id Chapter" := ValueInt;
                        end;
                    3://C
                        begin
                            Evaluate(ValueInt, ExcelBuffer."Cell Value as Text");
                            Rec."Id Book" := ValueInt;
                        end;
                    4://D
                        Rec."Name Book" := ExcelBuffer."Cell Value as Text";
                    5://E
                        Rec."Text BEC" := CopyStr(GetText(ExcelBuffer), 1, 2048);
                    6://F
                        Rec."Text RV1960" := CopyStr(GetText(ExcelBuffer), 1, 2048);
                    7://G
                        begin
                            Rec."Text LBLA" := CopyStr(GetText(ExcelBuffer), 1, 2048);
                            Rec.Insert();
                        end;
                end;
            until ExcelBuffer.Next() = 0;
    end;

    local procedure GetText(var ExcelBuffer: Record "Excel Buffer") ReturnValue: Text
    var
        RecInStream: Instream;
    begin
        ReturnValue := ExcelBuffer."Cell Value as Text";

        if not ExcelBuffer."Cell Value as Blob".HasValue() then
            exit;

        ExcelBuffer.CalcFields("Cell Value as Blob");
        ExcelBuffer."Cell Value as Blob".CreateInStream(RecInStream, TextEncoding::Windows);
        RecInStream.ReadText(ReturnValue);
    end;
}
