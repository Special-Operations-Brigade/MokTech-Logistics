////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by CC-3255/01 "Mokka", v1.063, #Naribu)
////////////////////////////////////////////////////////
class RscMTILogiBoxScreen {
    idd = IDD_RSCMTILOGIBOX_SCREEN;
    INIT_DISPLAY(RscMTILogiBoxScreen,ADDON)

    class controlsBackground {
        class Background: RscPicture {
            idc = IDC_RSCMTILOGIBOX_SCREEN_BACKGROUND;
            text = "#(argb,8,8,3)color(0.6,0.6,0.6,0.6)";
            x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 6 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 30 * GUI_GRID_CENTER_W;
            h = 15 * GUI_GRID_CENTER_H;
            colorBackground[] = {0,0,0,0.2};
        };
    };
    class controls {
        class Title: RscText {
            idc = IDC_RSCMTILOGIBOX_SCREEN_TITLE;
            text = "[SOB] LogiBox v1.24.11b_rev1";
            x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 30 * GUI_GRID_CENTER_W;
            h = 2 * GUI_GRID_CENTER_H;
            colorBackground[] = {0.28,0.62,0.22,1};
        };
        class TextLogiboxStatus: RscText {
            idc = IDC_RSCMTILOGIBOX_SCREEN_TEXTLOGIBOXSTATUS;
            text = "Status:";
            x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 6 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 30 * GUI_GRID_CENTER_W;
            h = 4 * GUI_GRID_CENTER_H;
            sizeEx = 4 * GUI_GRID_CENTER_H;
            style = ST_CENTER;
        };
        class TextSpawning: RscText {
            idc = IDC_RSCMTILOGIBOX_SCREEN_TEXTSPAWNING;
            text = "Spawning:";
            x = 8 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 14 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 6 * GUI_GRID_CENTER_W;
            h = 2 * GUI_GRID_CENTER_H;
            sizeEx = 1 * GUI_GRID_CENTER_H;
        };
        class TextLogiboxStatusEdit: RscText {
            idc = IDC_RSCMTILOGIBOX_SCREEN_TEXTLOGIBOXSTATUSEDIT;
            text = "N/A";
            x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 10 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 30 * GUI_GRID_CENTER_W;
            h = 3 * GUI_GRID_CENTER_H;
            sizeEx = 3 * GUI_GRID_CENTER_H;
            style = ST_CENTER;
        };
        class TextSpawningEdit: RscText {
            idc = IDC_RSCMTILOGIBOX_SCREEN_TEXTSPAWNINGEDIT;
            text = "N/A";
            x = 14 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 14 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 18 * GUI_GRID_CENTER_W;
            h = 2 * GUI_GRID_CENTER_H;
            sizeEx = 1 * GUI_GRID_CENTER_H;
        };
        class ProgressOperationProgress: RscProgress {
            idc = IDC_RSCMTILOGIMENU_PROGRESSOPERATIONPROGRESS;
            x = 7 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
            y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
            w = 26 * GUI_GRID_CENTER_W;
            h = 2 * GUI_GRID_CENTER_H;
        };
    };
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
