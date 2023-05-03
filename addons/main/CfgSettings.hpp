class CfgSettings {
    class CBA {
        class Versioning {
            class MTI_Logistics {
                class Dependencies {
                    CBA[] = {"cba_main", REQUIRED_CBA_VERSION, "true"};
                    ACE[] = {"ace_main", REQUIRED_ACE_VERSION, "true"};
                    TFAR[] = {"tfar_core", REQUIRED_TFAR_VERSION, "true"};
                };
            };
        };
    };
};
