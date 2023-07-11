page 50000 "List Biblie"
{
    ApplicationArea = All;
    Caption = 'Biblie', Comment = 'ESP="Biblia"';
    PageType = List;
    SourceTable = Biblie;
    UsageCategory = Tasks;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Name Book"; Rec."Name Book")
                {
                    ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                    ApplicationArea = All;
                }
                field("Id Chapter"; Rec."Id Chapter")
                {
                    ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                    ApplicationArea = All;
                }
                field("Id Verse"; Rec."Id Verse")
                {
                    ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                    ApplicationArea = All;
                }
                field("Text BEC"; Rec."Text BEC")
                {
                    ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                    ApplicationArea = All;
                }
                field("Text RV1960"; Rec."Text RV1960")
                {
                    ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                    ApplicationArea = All;
                }
                field("Text LBLA"; Rec."Text LBLA")
                {
                    ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowDocument)
            {
                ApplicationArea = All;
                Caption = 'Load Excel', Comment = 'ESP="Cargar Excel"';
                Image = Excel;
                ToolTip = 'Specifies the value of the field', comment = 'ESP="Especifica el valor del campo"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.NewDataRec();
                end;
            }
        }
    }
}
