private ["_dialog"];
_dialog = createdialog "AtmDialog";
call AtmDialogUpdateAmounts;
waitUntil { !dialog };