<?php

return [
    "default" => [                                              // this is the config for the default view
        "iconCls" => "pimcore_icon_perspective",
        "elementTree" => [
            [
                "type" => "documents",                          // document tree
                "position" => "left",
                "expanded" => false,                            //  there can be only one expanded view on each side
                "hidden" => false,
                "sort" => -3                                    // trees with lower values are shown first
            ],
            [
                "type" => "assets",
                "position" => "left",
                "expanded" => false,
                "hidden" => false,
                "sort" => -2
            ],
            [
                "type" => "objects",
                "position" => "left",
                "expanded" => false,
                "hidden" => false,
                "sort" => -1
            ]

        ],
        "dashboards" => [                                  // this is the standard setting for the welcome screen
            "predefined" => [
                "welcome" => [                             // internal key of the dashboard
                    "positions" => [
                        [                                  // left column
                            [
                                "id" => 1,
                                "type" => "pimcore.layout.portlets.modificationStatistic",
                                "config" => null                // additional config
                            ],
                            [
                                "id" => 2,
                                "type" => "pimcore.layout.portlets.modifiedAssets",
                                "config" => null
                            ]
                        ],
                        [
                            [
                                "id" => 3,
                                "type" => "pimcore.layout.portlets.modifiedObjects",
                                "config" => null
                            ],
                            [
                                "id" => 4,
                                "type" => "pimcore.layout.portlets.modifiedDocuments",
                                "config" => null
                            ]
                        ]
                    ]
                ]
            ]
        ]

    ],
    "Client view" => [
        "icon" => "/pimcore/static6/img/flat-color-icons/biohazard.svg",
        "toolbar" => [
            "file" => 1
            ,
            "extras" => [
                "hidden" => false,
                "items" => [
                    "systemtools" => [
                        "items" => [
                            "fileexplorer" => false
                        ]
                    ],
                    "update" => false,
                    "maintenance" => false
                ]

            ],
            "marketing" => [                                                // hide the marketing menu
                "hidden" => 1
            ],
            "settings" => [
                "items" => [
                    "cache" => [
                        "items" => [
                            "clearAll" => 0                                 // hide "Clear All" but show the other Cache menu entries
                        ]
                    ]
                ]
            ],
            "search" => [
                "items" => [
                    "objects" => false
                ]
            ]
        ],
        "elementTree" => [
            [
                "type" => "customview",
                "position" => "right",                                      // show the asset tree on the right side
                "expanded" => false,                                         // expand it
                "hidden" => false,
                "id" => 3
            ],
            [
                "type" => "customview",
                "position" => "right",
                "expanded" => false,
                "hidden" => false,
				"id" => 1
            ],
            [
                "type" => "customview",
				"position" => "left",
				"expanded" => false,
				"hidden" => false,
				"id" => 2
            ],
        ],
        "dashboards" => [                                  // this is the standard setting for the welcome screen
            "disabledPortlets" => [                        // disallows access to the given portlets
                "pimcore.layout.portlets.modificationStatistic" => 1,
                "pimcore.layout.portlets.feed" => 1
            ],
            "predefined" => [
                "welcome" => [                             // internal key of the dashboard
                    "positions" => [
                        [                                  // left column
							[
                                "id" => 2,
                                "type" => "pimcore.layout.portlets.modifiedAssets",
                                "config" => null
                            ]
                        ],
                        [                                  // only show modified objects in the right column
                            [
                                "id" => 3,
                                "type" => "pimcore.layout.portlets.modifiedObjects",
                                "config" => null
                            ],
							[
                                "id" => 4,
                                "type" => "pimcore.layout.portlets.modifiedDocuments",
                                "config" => null
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ],
    "Assets only" => [
        "icon" => "/pimcore/static6/img/flat-color-icons/webcam.svg",
        "elementTree" => [
            [
                "type" => "assets",
                "position" => "left",                                      // show the asset tree on the right side
                "expanded" => false,                                       // expand it
                "hidden" => false,
                "sort" => -2
            ]
        ]
    ]
];
