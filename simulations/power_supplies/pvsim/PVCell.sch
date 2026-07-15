(kicad_sch
	(version 20260306)
	(generator "eeschema")
	(generator_version "10.0")
	(uuid "20ae6910-fa75-4a11-aa0e-ec2905e49983")
	(paper "A4")
	(lib_symbols
		(symbol "Device:R"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(in_pos_files yes)
			(duplicate_pin_numbers_are_jumpers no)
			(property "Reference" "R"
				(at 2.032 0 90)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "R"
				(at 0 0 90)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at -1.778 0 90)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Description" "Resistor"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_keywords" "R res resistor"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_fp_filters" "R_*"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(symbol "R_0_1"
				(rectangle
					(start -1.016 -2.54)
					(end 1.016 2.54)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "R_1_1"
				(pin passive line
					(at 0 3.81 270)
					(length 1.27)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 0 -3.81 90)
					(length 1.27)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Diode:1N914"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(in_pos_files yes)
			(duplicate_pin_numbers_are_jumpers no)
			(property "Reference" "D"
				(at 0 2.54 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "1N914"
				(at 0 -2.54 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal"
				(at 0 -4.445 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Datasheet" "http://www.vishay.com/docs/85622/1n914.pdf"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Description" "100V 0.3A Small Signal Fast Switching Diode, DO-35"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Device" "D"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Pins" "1=K 2=A"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_keywords" "diode"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_fp_filters" "D*DO?35*"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(symbol "1N914_0_1"
				(polyline
					(pts
						(xy -1.27 1.27) (xy -1.27 -1.27)
					)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 1.27) (xy 1.27 -1.27) (xy -1.27 0) (xy 1.27 1.27)
					)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 0) (xy -1.27 0)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "1N914_1_1"
				(pin passive line
					(at -3.81 0 0)
					(length 2.54)
					(name "K"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 3.81 0 180)
					(length 2.54)
					(name "A"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Simulation_SPICE:IDC"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0.0254)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(in_pos_files yes)
			(duplicate_pin_numbers_are_jumpers no)
			(property "Reference" "I"
				(at 2.54 2.54 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "1"
				(at 2.54 0 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Datasheet" "https://ngspice.sourceforge.io/docs/ngspice-html-manual/manual.xhtml#sec_Independent_Sources_for"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Description" "Current source, DC"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Pins" "1=+ 2=-"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Type" "DC"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Device" "I"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_keywords" "simulation"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(symbol "IDC_0_0"
				(polyline
					(pts
						(xy -1.27 0.254) (xy 1.27 0.254)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -0.762 -0.254) (xy -1.27 -0.254)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 0.254 -0.254) (xy -0.254 -0.254)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -0.254) (xy 0.762 -0.254)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "IDC_0_1"
				(polyline
					(pts
						(xy -0.254 1.778) (xy 0 1.27) (xy 0.254 1.778)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 0 1.27) (xy 0 2.286)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(circle
					(center 0 0)
					(radius 2.54)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(symbol "IDC_1_1"
				(pin passive line
					(at 0 5.08 270)
					(length 2.54)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 0 -5.08 90)
					(length 2.54)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Simulation_SPICE:VSIN"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0.0254)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(in_pos_files yes)
			(duplicate_pin_numbers_are_jumpers no)
			(property "Reference" "V"
				(at 2.54 2.54 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "VSIN"
				(at 2.54 0 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Datasheet" "https://ngspice.sourceforge.io/docs/ngspice-html-manual/manual.xhtml#sec_Independent_Sources_for"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Description" "Voltage source, sinusoidal"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Pins" "1=+ 2=-"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Params" "dc=0 ampl=1 f=1k ac=1"
				(at 2.54 -2.54 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Sim.Type" "SIN"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Sim.Device" "V"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "ki_keywords" "simulation ac vac"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(symbol "VSIN_0_0"
				(arc
					(start -1.27 0)
					(mid -0.635 0.6323)
					(end 0 0)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 1.27 0)
					(mid 0.635 -0.6323)
					(end 0 0)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(text "+"
					(at 0 1.905 0)
					(effects
						(font
							(size 1.27 1.27)
						)
					)
				)
			)
			(symbol "VSIN_0_1"
				(circle
					(center 0 0)
					(radius 2.54)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(symbol "VSIN_1_1"
				(pin passive line
					(at 0 5.08 270)
					(length 2.54)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 0 -5.08 90)
					(length 2.54)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "power:GND"
			(power global)
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(in_pos_files yes)
			(duplicate_pin_numbers_are_jumpers no)
			(property "Reference" "#PWR"
				(at 0 -6.35 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "GND"
				(at 0 -3.81 0)
				(show_name no)
				(do_not_autoplace no)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Description" "Power symbol creates a global label with name \"GND\" , ground"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_keywords" "global power"
				(at 0 0 0)
				(show_name no)
				(do_not_autoplace no)
				(hide yes)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(symbol "GND_0_1"
				(polyline
					(pts
						(xy 0 0) (xy 0 -1.27) (xy 1.27 -1.27) (xy 0 -2.54) (xy -1.27 -1.27) (xy 0 -1.27)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "GND_1_1"
				(pin power_in line
					(at 0 0 270)
					(length 0)
					(name ""
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
	)
	(junction
		(at 106.68 88.9)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "1c54bc96-e30c-430b-9d76-87a43aa03814")
	)
	(junction
		(at 86.36 71.12)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "34ddaf41-a8ed-49a4-8368-8e86375bff9e")
	)
	(junction
		(at 86.36 88.9)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "36988bd3-3cba-4e6c-ab27-befe0dca0c67")
	)
	(junction
		(at 72.39 88.9)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "76fcb124-1a13-43a3-82ae-8024fea899f0")
	)
	(junction
		(at 106.68 71.12)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "a2ebc737-83ed-4694-ad6f-bfb18b6d9b7a")
	)
	(wire
		(pts
			(xy 86.36 71.12) (xy 86.36 76.2)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "00e9d746-9ffa-4f88-86d3-6b3fb2d41927")
	)
	(wire
		(pts
			(xy 137.16 71.12) (xy 137.16 74.93)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "2aa729b2-2060-4ee3-9f32-8f5ed7c133e2")
	)
	(wire
		(pts
			(xy 106.68 88.9) (xy 106.68 83.82)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "350ff545-b4d1-450b-8442-3878d298665b")
	)
	(wire
		(pts
			(xy 106.68 71.12) (xy 120.65 71.12)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "3b9b3942-557b-4587-be15-c575decf2118")
	)
	(wire
		(pts
			(xy 57.15 71.12) (xy 57.15 76.2)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "51154639-99c5-4e43-ba21-e8d92e285b87")
	)
	(wire
		(pts
			(xy 72.39 88.9) (xy 86.36 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "51fe2421-6365-41fa-93d3-f11534124a77")
	)
	(wire
		(pts
			(xy 137.16 85.09) (xy 137.16 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "68cd4f32-514a-42bd-be03-b9d0b433c386")
	)
	(wire
		(pts
			(xy 86.36 88.9) (xy 86.36 83.82)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "943d36fa-dae0-4500-bc00-7b1d0d5ea044")
	)
	(wire
		(pts
			(xy 57.15 86.36) (xy 57.15 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c044e1a0-e962-491d-bf09-a9bb46ce5198")
	)
	(wire
		(pts
			(xy 106.68 88.9) (xy 137.16 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c950742f-d6ce-4e15-93b2-998dfdc7e653")
	)
	(wire
		(pts
			(xy 106.68 71.12) (xy 106.68 76.2)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c9de7ea4-c5bb-4634-9c16-89c45bf9e6f3")
	)
	(wire
		(pts
			(xy 86.36 88.9) (xy 106.68 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cd60a6c0-0bc2-4c4b-8e95-9602a08c69ac")
	)
	(wire
		(pts
			(xy 128.27 71.12) (xy 137.16 71.12)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d7209cbe-ea8b-43c4-ac63-48467ac5fed1")
	)
	(wire
		(pts
			(xy 57.15 71.12) (xy 86.36 71.12)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d90b80d8-95c6-407c-b0e1-200183283657")
	)
	(wire
		(pts
			(xy 57.15 88.9) (xy 72.39 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e2467f25-a575-4e64-a3b5-87a9ae201e8f")
	)
	(wire
		(pts
			(xy 86.36 71.12) (xy 106.68 71.12)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "fa07b2a2-189f-4713-abe9-d4f72cf428f7")
	)
	(label "nV0"
		(at 137.16 71.12 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "441a0707-cb69-4350-bb48-bcea38ea60d4")
	)
	(symbol
		(lib_id "Diode:1N914")
		(at 86.36 80.01 90)
		(unit 1)
		(body_style 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(in_pos_files yes)
		(dnp no)
		(fields_autoplaced yes)
		(uuid "2c909f24-5468-42ad-a10a-aac77262750d")
		(property "Reference" "D1"
			(at 88.9 78.7399 90)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
			)
		)
		(property "Value" "1N914"
			(at 88.9 81.2799 90)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
			)
		)
		(property "Footprint" "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal"
			(at 90.805 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Datasheet" "http://www.vishay.com/docs/85622/1n914.pdf"
			(at 86.36 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Description" "100V 0.3A Small Signal Fast Switching Diode, DO-35"
			(at 86.36 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Device" "D"
			(at 86.36 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Pins" "1=K 2=A"
			(at 86.36 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "8d0a884d-8e65-44b0-bddc-39c736642426")
		)
		(pin "1"
			(uuid "fbf8562e-b4a9-4901-b560-e4157120ffdf")
		)
		(instances
			(project "PVCell"
				(path "/20ae6910-fa75-4a11-aa0e-ec2905e49983"
					(reference "D1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 124.46 71.12 90)
		(unit 1)
		(body_style 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(in_pos_files yes)
		(dnp no)
		(fields_autoplaced yes)
		(uuid "3ad021d9-e05b-4501-944b-d73a3c791a52")
		(property "Reference" "R1"
			(at 124.46 64.77 90)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "0.1"
			(at 124.46 67.31 90)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" ""
			(at 124.46 72.898 90)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Datasheet" ""
			(at 124.46 71.12 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Description" "Resistor"
			(at 124.46 71.12 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "49de3071-da98-47d5-9e54-cf6b30baebe0")
		)
		(pin "1"
			(uuid "e09597c9-1199-4e6f-9275-e4fca52fd6dc")
		)
		(instances
			(project "PVCell"
				(path "/20ae6910-fa75-4a11-aa0e-ec2905e49983"
					(reference "R1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 106.68 80.01 0)
		(unit 1)
		(body_style 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(in_pos_files yes)
		(dnp no)
		(fields_autoplaced yes)
		(uuid "84eda725-c9a3-4abc-809a-02c4f4ab5de6")
		(property "Reference" "R2"
			(at 109.22 78.7399 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "1e6"
			(at 109.22 81.2799 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" ""
			(at 104.902 80.01 90)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Datasheet" ""
			(at 106.68 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Description" "Resistor"
			(at 106.68 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "12a75089-de29-4570-97ec-dab8a729ba15")
		)
		(pin "1"
			(uuid "36ed38a4-bfd1-45e6-8111-b411ed8b3d4b")
		)
		(instances
			(project "PVCell"
				(path "/20ae6910-fa75-4a11-aa0e-ec2905e49983"
					(reference "R2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Simulation_SPICE:VSIN")
		(at 137.16 80.01 0)
		(unit 1)
		(body_style 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(in_pos_files yes)
		(dnp no)
		(fields_autoplaced yes)
		(uuid "8b9d2ec0-c518-4ceb-bb1a-ecea31afc1b0")
		(property "Reference" "V1"
			(at 140.97 77.3401 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "VSIN"
			(at 140.97 79.8801 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" ""
			(at 137.16 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Datasheet" "https://ngspice.sourceforge.io/docs/ngspice-html-manual/manual.xhtml#sec_Independent_Sources_for"
			(at 137.16 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Description" "Voltage source, sinusoidal"
			(at 137.16 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Pins" "1=+ 2=-"
			(at 137.16 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Params" "dc=0 ampl=0.85 f=50 ac=1"
			(at 140.97 82.4201 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Sim.Type" "SIN"
			(at 137.16 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Device" "V"
			(at 137.16 80.01 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(pin "2"
			(uuid "4daff4db-32fc-4941-bcf1-dae906e6e4b0")
		)
		(pin "1"
			(uuid "a78b5d92-5b9d-4313-a3ec-e6077caab853")
		)
		(instances
			(project "PVCell"
				(path "/20ae6910-fa75-4a11-aa0e-ec2905e49983"
					(reference "V1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:GND")
		(at 72.39 88.9 0)
		(unit 1)
		(body_style 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(in_pos_files yes)
		(dnp no)
		(fields_autoplaced yes)
		(uuid "a8690f9f-0823-42eb-a3d8-e16d181eff86")
		(property "Reference" "#PWR01"
			(at 72.39 95.25 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "GND"
			(at 72.39 93.98 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" ""
			(at 72.39 88.9 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Datasheet" ""
			(at 72.39 88.9 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Description" "Power symbol creates a global label with name \"GND\" , ground"
			(at 72.39 88.9 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a0926103-cb54-4fc2-97f0-dca2647a7a48")
		)
		(instances
			(project "PVCell"
				(path "/20ae6910-fa75-4a11-aa0e-ec2905e49983"
					(reference "#PWR01")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Simulation_SPICE:IDC")
		(at 57.15 81.28 180)
		(unit 1)
		(body_style 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(in_pos_files yes)
		(dnp no)
		(fields_autoplaced yes)
		(uuid "fd110290-ea0b-44c3-a01f-d1e890f0f81f")
		(property "Reference" "I1"
			(at 60.96 80.0099 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
			)
		)
		(property "Value" "1"
			(at 60.96 82.5499 0)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
			)
		)
		(property "Footprint" ""
			(at 57.15 81.28 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Datasheet" "https://ngspice.sourceforge.io/docs/ngspice-html-manual/manual.xhtml#sec_Independent_Sources_for"
			(at 57.15 81.28 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Description" "Current source, DC"
			(at 57.15 81.28 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Pins" "1=+ 2=-"
			(at 57.15 81.28 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Type" "DC"
			(at 57.15 81.28 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Sim.Device" "I"
			(at 57.15 81.28 0)
			(hide yes)
			(show_name no)
			(do_not_autoplace no)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "de80ca47-8d18-4f8c-b295-3007a5fa2360")
		)
		(pin "2"
			(uuid "829c5401-1bfe-4335-afe4-3139d9556d72")
		)
		(instances
			(project "PVCell"
				(path "/20ae6910-fa75-4a11-aa0e-ec2905e49983"
					(reference "I1")
					(unit 1)
				)
			)
		)
	)
	(sheet_instances
		(path "/"
			(page "1")
		)
	)
	(embedded_fonts no)
)
