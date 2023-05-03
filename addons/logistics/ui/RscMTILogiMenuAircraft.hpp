////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by CC-3255/01 "Mokka", v1.063, #Naribu)
////////////////////////////////////////////////////////
class RscMTILogiMenuAircraft {
    idd = IDD_RSCMTILOGIMENU_AIRCRAFT;
    INIT_DISPLAY(RscMTILogiMenuAircraft,ADDON)

    class controlsBackground {
        class Background: RscPicture {
            idc = IDC_RSCMTILOGIMENU_BACKGROUND;
            text = "#(argb,8,8,3)color(0,0,0,0.6)";
            x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 33 * GUI_GRID_CENTER_W;
            h = 23 * GUI_GRID_CENTER_H;
            colorBackground[] = {0,0,0,0.2};
        };
    };
    class controls {
        class Title: RscText {
            idc = IDC_RSCMTILOGIMENU_TITLE;
            text = "[SOB] Logistics Menu - Aircraft";
            x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 33 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
            colorBackground[] = {0.28,0.62,0.22,1};
        };
        class ButtonOK: RscButtonMenuOK {
            idc = IDC_RSCMTILOGIMENU_BUTTONOK;
            x = 31.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 24.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
            onButtonClick = "closeDialog 1";
        };
        class ButtonCancel: RscButtonMenuCancel {
            idc = IDC_RSCMTILOGIMENU_BUTTONCANCEL;
            x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 24.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
            colorBackground[] = {0.558,0,0,0.8};
            onButtonClick = "closeDialog 2";
        };
        class TextSelectVehicle: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTSELECTVEHICLE;
            text = "Select Aircraft:";
            x = 4 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.5 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class ListboxVehicle: RscListbox {
            idc = IDC_RSCMTILOGIMENU_LISTBOXVEHICLE;
            x = 4 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.5 * GUI_GRID_CENTER_W;
            h = 11 * GUI_GRID_CENTER_H;
        };
        class TextSelecSkin: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTSELECTSKIN;
            text = "Select Skin:";
            x = 4 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 15 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.5 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class ListboxSkin: RscListbox {
            idc = IDC_RSCMTILOGIMENU_LISTBOXSKIN;
            x = 4 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 16 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.5 * GUI_GRID_CENTER_W;
            h = 7 * GUI_GRID_CENTER_H;
        };
        class PictureVehiclePreview: RscPicture {
            idc = IDC_RSCMTILOGIMENU_PICTUREVEHICLEPREVIEW;
            text = "#(argb,8,8,3)color(1,1,1,1)";
            x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 15.5 * GUI_GRID_CENTER_W;
            h = 9 * GUI_GRID_CENTER_H;
        };
        class TextOperationProgress: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTOPERATIONPROGRESS;
            text = "Operation In Progress...";
            x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 10.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 33 * GUI_GRID_CENTER_W;
            h = 2 * GUI_GRID_CENTER_H;
            sizeEx = 2 * GUI_GRID_CENTER_H;
            style = ST_CENTER;
        };
        class TextOperationBlocked: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTOPERATIONBLOCKED;
            text = "- Output Area Blocked -";
            x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 16.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 33 * GUI_GRID_CENTER_W;
            h = 2 * GUI_GRID_CENTER_H;
            sizeEx = 2 * GUI_GRID_CENTER_H;
            style = ST_CENTER;
            textColor[] = {COLOUR_LOGIBOX_RED_RGBA};
        };
        class TextLogiboxStatus: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTLOGIBOXSTATUS;
            text = "LogiBox Status:";
            x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 18.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class TextOutputArea: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTOUTPUTAREA;
            text = "Output Area:";
            x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 19.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class TextAssetLimit: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTASSETLIMIT;
            text = "Asset Limit:";
            x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 16 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class TextConfigureLoadout: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTCONFIGURELOADOUT;
            text = "Configure Loadout:";
            x = 20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 5.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class ProgressOperationProgress: RscProgress {
            idc = IDC_RSCMTILOGIMENU_PROGRESSOPERATIONPROGRESS;
            x = 3.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 13 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 33 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class TextAssetLimitEdit: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTASSETLIMITEDIT;
            text = "N/A";
            x = 26.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 16 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 9.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class TextLogiboxStatusEdit: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTLOGIBOXSTATUSEDIT;
            text = "N/A";
            x = 26.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 18.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 9.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class TextOutputAreaEdit: RscText {
            idc = IDC_RSCMTILOGIMENU_TEXTOUTPUTAREAEDIT;
            text = "N/A";
            x = 26.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 19.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 9.75 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class CheckboxConfigureLoadoutEdit: RscCheckbox {
            idc = IDC_RSCMTILOGIMENU_CHECKBOXCONFIGURELOADOUTEDIT;
            x = 26.75 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 1 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
    };
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
