require("lcd")

function display_simcom_logo(display_dev)  
  print("display_simcom_logo\r\n"); 
  local sim_com_str = {
    {252,254,254,142,142,142,142,142,142,142,142,14},
    {225,227,227,227,227,227,227,227,227,255,255,127},
    {0,0,14,14,254,254,254,254,14,14,0,0},
    {0,0,224,224,255,255,255,255,224,224,0,0},
    {254,254,254,28,56,112,112,56,28,254,254,254},
    {255,255,255,0,0,0,0,0,0,255,255,255},
    {0,252,254,254,14,14,14,14,14,14,14,0},
    {0,127,255,255,224,224,224,224,224,224,224,0},
    {0,252,254,254,14,14,14,14,254,254,252,0},
    {0,127,255,255,224,224,224,224,255,255,127,0},
    {254,254,254,28,56,112,112,56,28,254,254,254},
    {255,255,255,0,0,0,0,0,0,255,255,255}
  }

  lcd_set_diaplay_address(display_dev, 24, 24);--display at(24,24)

  for i = 1, 12, 2 do
    for j = 1, 12, 1 do
	  lcd_write_data(display_dev, sim_com_str[i][j]);
	end;
  end;
  lcd_set_diaplay_address(display_dev, 24, 32);--display at(24,32)
  for i = 2, 12, 2 do
    for j = 1, 12, 1 do
	  lcd_write_data(display_dev, sim_com_str[i][j]);
	end;
  end;
end;

function main()
  printdir(1);
  display_dev = lcd_init_device(display_dev);
  display_simcom_logo(display_dev);
end;

display_dev = {};
main();