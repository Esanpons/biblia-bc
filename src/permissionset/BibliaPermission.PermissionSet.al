permissionset 50000 "BibliaPermission"
{
    Assignable = true;
    Caption = 'BibliaPermission ', MaxLength = 30;
    Permissions =
        table "Biblie" = X,
        tabledata "Biblie" = RMID;
}
