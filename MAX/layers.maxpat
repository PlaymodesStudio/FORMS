{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 1,
			"revision" : 10,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 34.0, 123.0, 1097.0, 813.0 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 326.0, 558.0, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 783.0, 21.5, 52.0, 20.0 ],
					"text" : "Update"
				}

			}
, 			{
				"box" : 				{
					"comment" : "presetbang",
					"id" : "obj-86",
					"index" : 1,
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 283.0, 94.0, 30.0, 30.0 ]
				}

			}
, 			{
				"box" : 				{
					"comment" : "oscAddress",
					"id" : "obj-85",
					"index" : 1,
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1043.0, 1201.0, 30.0, 30.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-84",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 977.0, 242.0, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-68",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 491.0, 808.0, 220.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 32.0, 18.0, 89.0, 27.0 ],
					"text" : "LAYER 3"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.996078431372549, 0.898039215686275, 0.603921568627451, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-67",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 268.0, 775.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 12.0, 135.0, 33.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-65",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 654.0, 773.0, 23.0, 33.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 721.0, 97.0, 30.0, 20.0 ],
					"text" : "FX"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-64",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 639.0, 758.0, 23.0, 33.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 437.5, 97.0, 30.0, 20.0 ],
					"text" : "FX"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-63",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 624.0, 743.0, 23.0, 33.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 154.5, 97.0, 30.0, 20.0 ],
					"text" : "FX"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-60",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 551.5, 689.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 21.0, 97.0, 23.0, 20.0 ],
					"text" : "T"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-61",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 899.5, 695.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 301.0, 97.0, 23.0, 20.0 ],
					"text" : "T"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-62",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1175.0, 695.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 584.0, 97.0, 23.0, 20.0 ],
					"text" : "T"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-59",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 551.5, 642.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 21.0, 50.0, 23.0, 20.0 ],
					"text" : "R"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-58",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 899.5, 647.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 301.0, 49.0, 23.0, 20.0 ],
					"text" : "R"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-57",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1175.0, 647.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 584.0, 49.0, 23.0, 20.0 ],
					"text" : "R"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-56",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 551.5, 665.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 21.0, 73.0, 23.0, 20.0 ],
					"text" : "H"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-55",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 899.5, 671.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 301.0, 73.0, 23.0, 20.0 ],
					"text" : "H"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-54",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1175.0, 671.0, 23.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 584.0, 73.0, 23.0, 20.0 ],
					"text" : "H"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-51",
					"items" : [ "none", ",", ",", "t1_metal", ",", ",", "t2_hnoise", ",", ",", "t3_clouds", ",", ",", "t4_fractal", ",", ",", "t5_spectralPage", ",", ",", "t6_vacquie", ",", ",", "t7_nebulae", ",", ",", "t8_hnoise2", ",", ",", "t9_aperiodicNoiseBlocks", ",", ",", "t10_r2d2", ",", ",", "t11_freeze", ",", ",", "t12_rhythmicDots", ",", ",", "t13_repeat", ",", ",", "t14_microtonalDrone", ",", ",", "t15_flowField", ",", ",", "t16_vacquieBlocks", ",", ",", "t17_noiseTears" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 576.5, 689.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 46.0, 97.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-52",
					"items" : [ "none", ",", ",", "r1_general", ",", ",", "r2_fencesUngrouped", ",", ",", "r3_fencesUngroupedWeights", ",", ",", "r4_fencesUngroupedWeights2", ",", ",", "r5_bells", ",", ",", "r6_euclideanFencesSpectral", ",", ",", "r7_fillsDots", ",", ",", "r8_marblesNew", ",", ",", "r9_marblesOld", ",", ",", "r10_dub", ",", ",", "r11_UKBreaks", ",", ",", "r12_fullEuclidean", ",", ",", "r13_techno", ",", ",", "r14_ikeda", ",", ",", "r15_spectralBreathe", ",", ",", "r16_qebrus", ",", ",", "r17_batucada", ",", ",", "r18_aperiodicBatucada", ",", ",", "r19_slow", ",", ",", "r20_dubstep", ",", ",", "r21_freezee", ",", ",", "r22_zimmer", ",", ",", "r23_jazz", ",", ",", "r24_repeat", ",", ",", "r25_genericDub", ",", ",", "r26_euclideanLines", ",", ",", "r27_ikeda2", ",", ",", "r28_batucadaSincopa", ",", ",", "r29_1kick", ",", ",", "r30_euclideanKick", ",", ",", "r31_blockingSnares", ",", ",", "r32_euclideanSnares", ",", ",", "r33_euclideanHats", ",", ",", "r34_euclideanDrumSet", ",", ",", "r35_techno2", ",", ",", "r36_euclideanKickShift", ",", ",", "r37_techSimple", ",", ",", "r38_shaker", ",", ",", "r39_anacrusa", ",", ",", "r40_anacrusaSpectral", ",", ",", "r41_anacrusaSpectralBlocking", ",", ",", "r42_ikedaLess", ",", ",", "r43_rumble", ",", ",", "r44_bigSnare", ",", ",", "r45_noiseBlocks", ",", ",", "r46_simpleSnare", ",", ",", "r47_anaIkeda" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 576.5, 641.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 46.0, 49.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-53",
					"items" : [ "none", ",", ",", "h1_theremin", ",", ",", "h2_iridescence", ",", ",", "h3_AM", ",", ",", "h4_partialDance", ",", ",", "h5_partialMelodies", ",", ",", "h6_clouds", ",", ",", "h7_arpeggios", ",", ",", "h8_xenakis", ",", ",", "h9_electro", ",", ",", "h10_bells", ",", ",", "h11_melodiesAndChords", ",", ",", "h12_UKClub", ",", ",", "h13_trance", ",", ",", "h14_dubstep", ",", ",", "h15_xenakisPoly", ",", ",", "h16_freeze", ",", ",", "h17_eno", ",", ",", "h18_bach", ",", ",", "h19_partialMelodies", ",", ",", "h20_repeat", ",", ",", "h21_dub", ",", ",", "h22_kangding", ",", ",", "h23_wendy", ",", ",", "h24_bells2", ",", ",", "h25_chords", ",", ",", "h26_clouds2", ",", ",", "h27_reagge", ",", ",", "h28_brossaBrown", ",", ",", "h29_brossaXenakis", ",", ",", "h30_brossaBranch", ",", ",", "h31_brossaXenakis2", ",", ",", "h32_brossaXenakis3", ",", ",", "h33_portamentoBass", ",", ",", "h34_filterBass", ",", ",", "h35_filterBass2", ",", ",", "h36_centralBass", ",", ",", "h37_randomNotes", ",", ",", "h38_sequentialNotes", ",", ",", "h39_arpNotes", ",", ",", "h40_bassNotes", ",", ",", "h41_noiseNotes", ",", ",", "h42_cloudNotes", ",", ",", "h43_counterBass", ",", ",", "h44_arpNotes2", ",", ",", "h45_counterSynth", ",", ",", "h46_padChords", ",", ",", "h47_bellNotes", ",", ",", "h48_padPage", ",", ",", "h49_bassBar", ",", ",", "h50_strumBar", ",", ",", "h51_bassRumble", ",", ",", "h52_harmPoints", ",", ",", "h53_chordBar", ",", ",", "h54_anaChord", ",", ",", "h55_anaBass", ",", ",", "h56_notePeriods", ",", ",", "h57_bassPeriods", ",", ",", "h58_pageBass" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 576.5, 665.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 46.0, 73.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-48",
					"items" : [ "none", ",", ",", "t1_metal", ",", ",", "t2_hnoise", ",", ",", "t3_clouds", ",", ",", "t4_fractal", ",", ",", "t5_spectralPage", ",", ",", "t6_vacquie", ",", ",", "t7_nebulae", ",", ",", "t8_hnoise2", ",", ",", "t9_aperiodicNoiseBlocks", ",", ",", "t10_r2d2", ",", ",", "t11_freeze", ",", ",", "t12_rhythmicDots", ",", ",", "t13_repeat", ",", ",", "t14_microtonalDrone", ",", ",", "t15_flowField", ",", ",", "t16_vacquieBlocks", ",", ",", "t17_noiseTears" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 924.5, 695.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 326.0, 97.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-49",
					"items" : [ "none", ",", ",", "r1_general", ",", ",", "r2_fencesUngrouped", ",", ",", "r3_fencesUngroupedWeights", ",", ",", "r4_fencesUngroupedWeights2", ",", ",", "r5_bells", ",", ",", "r6_euclideanFencesSpectral", ",", ",", "r7_fillsDots", ",", ",", "r8_marblesNew", ",", ",", "r9_marblesOld", ",", ",", "r10_dub", ",", ",", "r11_UKBreaks", ",", ",", "r12_fullEuclidean", ",", ",", "r13_techno", ",", ",", "r14_ikeda", ",", ",", "r15_spectralBreathe", ",", ",", "r16_qebrus", ",", ",", "r17_batucada", ",", ",", "r18_aperiodicBatucada", ",", ",", "r19_slow", ",", ",", "r20_dubstep", ",", ",", "r21_freezee", ",", ",", "r22_zimmer", ",", ",", "r23_jazz", ",", ",", "r24_repeat", ",", ",", "r25_genericDub", ",", ",", "r26_euclideanLines", ",", ",", "r27_ikeda2", ",", ",", "r28_batucadaSincopa", ",", ",", "r29_1kick", ",", ",", "r30_euclideanKick", ",", ",", "r31_blockingSnares", ",", ",", "r32_euclideanSnares", ",", ",", "r33_euclideanHats", ",", ",", "r34_euclideanDrumSet", ",", ",", "r35_techno2", ",", ",", "r36_euclideanKickShift", ",", ",", "r37_techSimple", ",", ",", "r38_shaker", ",", ",", "r39_anacrusa", ",", ",", "r40_anacrusaSpectral", ",", ",", "r41_anacrusaSpectralBlocking", ",", ",", "r42_ikedaLess", ",", ",", "r43_rumble", ",", ",", "r44_bigSnare", ",", ",", "r45_noiseBlocks", ",", ",", "r46_simpleSnare", ",", ",", "r47_anaIkeda" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 924.5, 647.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 326.0, 49.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-50",
					"items" : [ "none", ",", ",", "h1_theremin", ",", ",", "h2_iridescence", ",", ",", "h3_AM", ",", ",", "h4_partialDance", ",", ",", "h5_partialMelodies", ",", ",", "h6_clouds", ",", ",", "h7_arpeggios", ",", ",", "h8_xenakis", ",", ",", "h9_electro", ",", ",", "h10_bells", ",", ",", "h11_melodiesAndChords", ",", ",", "h12_UKClub", ",", ",", "h13_trance", ",", ",", "h14_dubstep", ",", ",", "h15_xenakisPoly", ",", ",", "h16_freeze", ",", ",", "h17_eno", ",", ",", "h18_bach", ",", ",", "h19_partialMelodies", ",", ",", "h20_repeat", ",", ",", "h21_dub", ",", ",", "h22_kangding", ",", ",", "h23_wendy", ",", ",", "h24_bells2", ",", ",", "h25_chords", ",", ",", "h26_clouds2", ",", ",", "h27_reagge", ",", ",", "h28_brossaBrown", ",", ",", "h29_brossaXenakis", ",", ",", "h30_brossaBranch", ",", ",", "h31_brossaXenakis2", ",", ",", "h32_brossaXenakis3", ",", ",", "h33_portamentoBass", ",", ",", "h34_filterBass", ",", ",", "h35_filterBass2", ",", ",", "h36_centralBass", ",", ",", "h37_randomNotes", ",", ",", "h38_sequentialNotes", ",", ",", "h39_arpNotes", ",", ",", "h40_bassNotes", ",", ",", "h41_noiseNotes", ",", ",", "h42_cloudNotes", ",", ",", "h43_counterBass", ",", ",", "h44_arpNotes2", ",", ",", "h45_counterSynth", ",", ",", "h46_padChords", ",", ",", "h47_bellNotes", ",", ",", "h48_padPage", ",", ",", "h49_bassBar", ",", ",", "h50_strumBar", ",", ",", "h51_bassRumble", ",", ",", "h52_harmPoints", ",", ",", "h53_chordBar", ",", ",", "h54_anaChord", ",", ",", "h55_anaBass", ",", ",", "h56_notePeriods", ",", ",", "h57_bassPeriods", ",", ",", "h58_pageBass" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 924.5, 671.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 326.0, 73.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-42",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1308.0, 732.0, 103.0, 22.0 ],
					"text" : "r #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-43",
					"linecount" : 3,
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1474.0, 704.0, 69.0, 49.0 ],
					"text" : "r #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-44",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "presetList.maxpat",
					"numinlets" : 2,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"patching_rect" : [ 1329.0, 771.0, 139.0, 310.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 715.5, 121.0, 139.0, 274.0 ],
					"varname" : "presetList[4]",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-45",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "presetList.maxpat",
					"numinlets" : 2,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"patching_rect" : [ 1184.0, 767.0, 143.0, 310.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 571.5, 121.0, 143.0, 274.0 ],
					"varname" : "presetList[5]",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-46",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1329.0, 1088.0, 75.0, 22.0 ],
					"text" : "prepend /fx1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-47",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1184.0, 1084.0, 92.0, 22.0 ],
					"text" : "prepend /layer1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-35",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1022.0, 728.0, 103.0, 22.0 ],
					"text" : "r #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-36",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1163.0, 732.0, 103.0, 22.0 ],
					"text" : "r #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-37",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "presetList.maxpat",
					"numinlets" : 2,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"patching_rect" : [ 1043.0, 767.0, 139.0, 310.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 431.5, 121.0, 139.0, 274.0 ],
					"varname" : "presetList[2]",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-38",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "presetList.maxpat",
					"numinlets" : 2,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"patching_rect" : [ 898.0, 763.0, 143.0, 310.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 289.5, 121.0, 143.0, 274.0 ],
					"varname" : "presetList[3]",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-40",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1043.0, 1084.0, 75.0, 22.0 ],
					"text" : "prepend /fx2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-41",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 898.0, 1080.0, 92.0, 22.0 ],
					"text" : "prepend /layer2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-34",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 736.0, 724.0, 103.0, 22.0 ],
					"text" : "r #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-33",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 877.0, 728.0, 103.0, 22.0 ],
					"text" : "r #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-32",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 284.0, 169.0, 105.0, 22.0 ],
					"text" : "s #0presetbang"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-31",
					"items" : [ "none", ",", ",", "fx1_transpose", ",", ",", "fx2_gate", ",", ",", "fx3_repeat", ",", ",", "fx4_freeze", ",", ",", "fx5_mask", ",", ",", "fx6_gateAbuse", ",", ",", "fx7_combo1", ",", ",", "fx8_rhythmFreeze", ",", ",", "fx9_rhythmGate", ",", ",", "fx10_combo2", ",", ",", "fx11_echo", ",", ",", "fx12_echoFull", ",", ",", "fx13_reverb", ",", ",", "fx14_filter", ",", ",", "fx15_BPfilter", ",", ",", "fx16_BPfilterHard", ",", ",", "fx17_reverb2", ",", "bang" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1368.0, 685.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 753.0, 97.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-30",
					"items" : [ "none", ",", ",", "fx1_transpose", ",", ",", "fx2_gate", ",", ",", "fx3_repeat", ",", ",", "fx4_freeze", ",", ",", "fx5_mask", ",", ",", "fx6_gateAbuse", ",", ",", "fx7_combo1", ",", ",", "fx8_rhythmFreeze", ",", ",", "fx9_rhythmGate", ",", ",", "fx10_combo2", ",", ",", "fx11_echo", ",", ",", "fx12_echoFull", ",", ",", "fx13_reverb", ",", ",", "fx14_filter", ",", ",", "fx15_BPfilter", ",", ",", "fx16_BPfilterHard", ",", ",", "fx17_reverb2", ",", "bang" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1059.5, 695.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 469.5, 97.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-26",
					"items" : [ "none", ",", ",", "fx1_transpose", ",", ",", "fx2_gate", ",", ",", "fx3_repeat", ",", ",", "fx4_freeze", ",", ",", "fx5_mask", ",", ",", "fx6_gateAbuse", ",", ",", "fx7_combo1", ",", ",", "fx8_rhythmFreeze", ",", ",", "fx9_rhythmGate", ",", ",", "fx10_combo2", ",", ",", "fx11_echo", ",", ",", "fx12_echoFull", ",", ",", "fx13_reverb", ",", ",", "fx14_filter", ",", ",", "fx15_BPfilter", ",", ",", "fx16_BPfilterHard", ",", ",", "fx17_reverb2", ",", "bang" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 766.5, 695.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 186.5, 97.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-27",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1141.0, 447.0, 98.0, 22.0 ],
					"text" : "prepend append"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-28",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 1141.0, 413.0, 57.0, 22.0 ],
					"text" : "route set"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-29",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "bang", "int" ],
					"patching_rect" : [ 1141.0, 381.0, 111.0, 23.0 ],
					"text" : "text method_fx.txt"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-22",
					"items" : [ "none", ",", ",", "t1_metal", ",", ",", "t2_hnoise", ",", ",", "t3_clouds", ",", ",", "t4_fractal", ",", ",", "t5_spectralPage", ",", ",", "t6_vacquie", ",", ",", "t7_nebulae", ",", ",", "t8_hnoise2", ",", ",", "t9_aperiodicNoiseBlocks", ",", ",", "t10_r2d2", ",", ",", "t11_freeze", ",", ",", "t12_rhythmicDots", ",", ",", "t13_repeat", ",", ",", "t14_microtonalDrone", ",", ",", "t15_flowField", ",", ",", "t16_vacquieBlocks", ",", ",", "t17_noiseTears" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1200.0, 695.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 609.0, 97.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-23",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1025.0, 447.0, 98.0, 22.0 ],
					"text" : "prepend append"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 1025.0, 413.0, 57.0, 22.0 ],
					"text" : "route set"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-25",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "bang", "int" ],
					"patching_rect" : [ 1025.0, 381.0, 105.0, 23.0 ],
					"text" : "text method_t.txt"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-21",
					"items" : [ "none", ",", ",", "r1_general", ",", ",", "r2_fencesUngrouped", ",", ",", "r3_fencesUngroupedWeights", ",", ",", "r4_fencesUngroupedWeights2", ",", ",", "r5_bells", ",", ",", "r6_euclideanFencesSpectral", ",", ",", "r7_fillsDots", ",", ",", "r8_marblesNew", ",", ",", "r9_marblesOld", ",", ",", "r10_dub", ",", ",", "r11_UKBreaks", ",", ",", "r12_fullEuclidean", ",", ",", "r13_techno", ",", ",", "r14_ikeda", ",", ",", "r15_spectralBreathe", ",", ",", "r16_qebrus", ",", ",", "r17_batucada", ",", ",", "r18_aperiodicBatucada", ",", ",", "r19_slow", ",", ",", "r20_dubstep", ",", ",", "r21_freezee", ",", ",", "r22_zimmer", ",", ",", "r23_jazz", ",", ",", "r24_repeat", ",", ",", "r25_genericDub", ",", ",", "r26_euclideanLines", ",", ",", "r27_ikeda2", ",", ",", "r28_batucadaSincopa", ",", ",", "r29_1kick", ",", ",", "r30_euclideanKick", ",", ",", "r31_blockingSnares", ",", ",", "r32_euclideanSnares", ",", ",", "r33_euclideanHats", ",", ",", "r34_euclideanDrumSet", ",", ",", "r35_techno2", ",", ",", "r36_euclideanKickShift", ",", ",", "r37_techSimple", ",", ",", "r38_shaker", ",", ",", "r39_anacrusa", ",", ",", "r40_anacrusaSpectral", ",", ",", "r41_anacrusaSpectralBlocking", ",", ",", "r42_ikedaLess", ",", ",", "r43_rumble", ",", ",", "r44_bigSnare", ",", ",", "r45_noiseBlocks", ",", ",", "r46_simpleSnare", ",", ",", "r47_anaIkeda" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1200.0, 647.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 609.0, 49.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-16",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 905.0, 447.0, 98.0, 22.0 ],
					"text" : "prepend append"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 905.0, 413.0, 57.0, 22.0 ],
					"text" : "route set"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "bang", "int" ],
					"patching_rect" : [ 905.0, 381.0, 105.0, 23.0 ],
					"text" : "text method_r.txt"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 944.0, 243.0, 20.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 830.0, 21.5, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-2",
					"items" : [ "none", ",", ",", "h1_theremin", ",", ",", "h2_iridescence", ",", ",", "h3_AM", ",", ",", "h4_partialDance", ",", ",", "h5_partialMelodies", ",", ",", "h6_clouds", ",", ",", "h7_arpeggios", ",", ",", "h8_xenakis", ",", ",", "h9_electro", ",", ",", "h10_bells", ",", ",", "h11_melodiesAndChords", ",", ",", "h12_UKClub", ",", ",", "h13_trance", ",", ",", "h14_dubstep", ",", ",", "h15_xenakisPoly", ",", ",", "h16_freeze", ",", ",", "h17_eno", ",", ",", "h18_bach", ",", ",", "h19_partialMelodies", ",", ",", "h20_repeat", ",", ",", "h21_dub", ",", ",", "h22_kangding", ",", ",", "h23_wendy", ",", ",", "h24_bells2", ",", ",", "h25_chords", ",", ",", "h26_clouds2", ",", ",", "h27_reagge", ",", ",", "h28_brossaBrown", ",", ",", "h29_brossaXenakis", ",", ",", "h30_brossaBranch", ",", ",", "h31_brossaXenakis2", ",", ",", "h32_brossaXenakis3", ",", ",", "h33_portamentoBass", ",", ",", "h34_filterBass", ",", ",", "h35_filterBass2", ",", ",", "h36_centralBass", ",", ",", "h37_randomNotes", ",", ",", "h38_sequentialNotes", ",", ",", "h39_arpNotes", ",", ",", "h40_bassNotes", ",", ",", "h41_noiseNotes", ",", ",", "h42_cloudNotes", ",", ",", "h43_counterBass", ",", ",", "h44_arpNotes2", ",", ",", "h45_counterSynth", ",", ",", "h46_padChords", ",", ",", "h47_bellNotes", ",", ",", "h48_padPage", ",", ",", "h49_bassBar", ",", ",", "h50_strumBar", ",", ",", "h51_bassRumble", ",", ",", "h52_harmPoints", ",", ",", "h53_chordBar", ",", ",", "h54_anaChord", ",", ",", "h55_anaBass", ",", ",", "h56_notePeriods", ",", ",", "h57_bassPeriods", ",", ",", "h58_pageBass" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1200.0, 671.0, 90.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 609.0, 73.0, 90.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 786.0, 447.0, 98.0, 22.0 ],
					"text" : "prepend append"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 786.0, 413.0, 57.0, 22.0 ],
					"text" : "route set"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "dump", "clear" ],
					"patching_rect" : [ 944.0, 284.0, 77.0, 22.0 ],
					"text" : "t dump clear"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-39",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "bang", "int" ],
					"patching_rect" : [ 786.0, 381.0, 108.0, 23.0 ],
					"text" : "text method_h.txt"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-9",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "presetList.maxpat",
					"numinlets" : 2,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"patching_rect" : [ 757.0, 763.0, 139.0, 310.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 150.0, 121.0, 139.0, 274.0 ],
					"varname" : "presetList[1]",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 284.0, 135.0, 22.0, 22.0 ],
					"text" : "t b"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-138",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "presetList.maxpat",
					"numinlets" : 2,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "" ],
					"patching_rect" : [ 612.0, 759.0, 143.0, 310.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 121.0, 143.0, 274.0 ],
					"varname" : "presetList",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 757.0, 1080.0, 75.0, 22.0 ],
					"text" : "prepend /fx3"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 612.0, 1076.0, 92.0, 22.0 ],
					"text" : "prepend /layer3"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.996078431372549, 0.749019607843137, 0.0, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-66",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 253.0, 760.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 41.0, 135.0, 354.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-69",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 506.0, 823.0, 220.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 312.5, 18.0, 89.0, 27.0 ],
					"text" : "LAYER 2"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.996078431372549, 0.898039215686275, 0.603921568627451, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-70",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 283.0, 790.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 289.5, 12.0, 135.0, 33.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.996078431372549, 0.749019607843137, 0.0, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-71",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 268.0, 775.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 289.5, 41.0, 135.0, 354.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-72",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 793.5, 823.0, 220.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 596.0, 18.0, 89.0, 27.0 ],
					"text" : "LAYER 1"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.996078431372549, 0.898039215686275, 0.603921568627451, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-73",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.5, 790.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 573.0, 12.0, 135.0, 33.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.996078431372549, 0.749019607843137, 0.0, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-74",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 555.5, 775.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 573.0, 41.0, 135.0, 354.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-75",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 808.5, 838.0, 220.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 172.0, 66.0, 89.0, 27.0 ],
					"text" : "FX 3"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.992156862745098, 0.6, 0.6, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-76",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 585.5, 805.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 149.0, 60.0, 135.0, 33.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.992156862745098, 0.0, 0.0, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-77",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.5, 790.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 149.0, 91.0, 135.0, 304.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-78",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 823.5, 853.0, 220.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 454.5, 66.0, 89.0, 27.0 ],
					"text" : "FX 2"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.992156862745098, 0.6, 0.6, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-79",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 600.5, 820.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 431.5, 60.0, 135.0, 33.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.992156862745098, 0.0, 0.0, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-80",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 585.5, 805.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 431.5, 91.0, 135.0, 304.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-81",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1112.0, 853.0, 220.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 738.0, 66.0, 89.0, 27.0 ],
					"text" : "FX 1"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.992156862745098, 0.6, 0.6, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-82",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 889.0, 820.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 715.0, 60.0, 135.0, 33.0 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.992156862745098, 0.0, 0.0, 1.0 ],
					"bordercolor" : [ 0.756862745098039, 0.623529411764706, 0.0, 1.0 ],
					"id" : "obj-83",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 874.0, 805.0, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 715.0, 91.0, 135.0, 304.0 ],
					"proportion" : 0.5
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"order" : 0,
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 0 ],
					"order" : 1,
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 0 ],
					"order" : 2,
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-138", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"order" : 2,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"order" : 2,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 0 ],
					"order" : 3,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 0 ],
					"order" : 1,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"order" : 1,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"order" : 8,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-29", 0 ],
					"order" : 0,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"order" : 4,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-31", 0 ],
					"order" : 0,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-39", 0 ],
					"order" : 3,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-48", 0 ],
					"order" : 5,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 0 ],
					"order" : 7,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 0 ],
					"order" : 6,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-51", 0 ],
					"order" : 9,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-52", 0 ],
					"order" : 11,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 0 ],
					"order" : 10,
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 0 ],
					"order" : 0,
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 0 ],
					"order" : 1,
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-52", 0 ],
					"order" : 2,
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-45", 0 ],
					"source" : [ "obj-2", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-45", 0 ],
					"source" : [ "obj-21", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-45", 0 ],
					"source" : [ "obj-22", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 0 ],
					"order" : 0,
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-48", 0 ],
					"order" : 1,
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-51", 0 ],
					"order" : 2,
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-23", 0 ],
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"source" : [ "obj-26", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"order" : 2,
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"order" : 1,
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-31", 0 ],
					"order" : 0,
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 0 ],
					"source" : [ "obj-28", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-28", 0 ],
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-37", 0 ],
					"source" : [ "obj-30", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-44", 0 ],
					"source" : [ "obj-31", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 1 ],
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-138", 1 ],
					"source" : [ "obj-34", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 1 ],
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-37", 1 ],
					"source" : [ "obj-36", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-40", 0 ],
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-41", 0 ],
					"source" : [ "obj-38", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"source" : [ "obj-40", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"source" : [ "obj-41", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-45", 1 ],
					"source" : [ "obj-42", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-44", 1 ],
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-46", 0 ],
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-47", 0 ],
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"source" : [ "obj-46", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-48", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-49", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-50", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-138", 0 ],
					"source" : [ "obj-51", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-138", 0 ],
					"source" : [ "obj-52", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-138", 0 ],
					"source" : [ "obj-53", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"source" : [ "obj-84", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"source" : [ "obj-86", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
 ]
	}

}
