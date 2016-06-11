function lcd_config_once(display_dev, dc_pin, reset_pin, reset_1st_v, reset_2nd_v, write_1st_v, write_2nd_v)
  if (not display_dev.configured_lcd) then
    --config and reset LCD screen.
	display_dev.dc_pin = dc_pin;
	display_dev.reset_pin = reset_pin;
    display_dev.configured_lcd = true;
	gpio.setdrt(dc_pin, 1);--out
	gpio.setdrt(reset_pin, 1);--out
	gpio.setv(dc_pin, 0);--low
	gpio.setv(reset_pin, 0);--low
	gpio.setv(reset_pin, reset_1st_v);
	vmsleep(50);
	gpio.setv(reset_pin, reset_2nd_v);
	vmsleep(50);
  end;
  return display_dev;
end;

function lcd_write_cmd(display_dev, value)
  gpio.setv(display_dev.dc_pin, 0);--low
  spi.write(value);
  gpio.setv(display_dev.dc_pin, 1);--hight
end;

function lcd_write_data(display_dev, value)
  gpio.setv(display_dev.dc_pin, 1);--high
  spi.write(value);
  gpio.setv(display_dev.dc_pin, 0);--low
end;

function lcd_write_string_data(display_dev, str_data)--write string
  gpio.setv(display_dev.dc_pin, 1);--high
  spi.write_buf(nil, str_data);
  gpio.setv(display_dev.dc_pin, 0);--low
end;

-----------------------------------------------------------------------
--NOTE!!! This is just an example matrix LCD, detailed configuration step depends on your hardware SPEC.
-----------------------------------------------------------------------
function lcd_init_device(display_dev)
  print("lcd_init_device\r\n");

  gpio.setfunc(13,false);
  
  vmsleep(50);
  
  spi.set_clk(0, 1, 1);
  vmsleep(5);
  spi.set_cs(0, 0);
  vmsleep(5);
  spi.set_freq(1000, 100000, 1000);
  vmsleep(5);
  spi.set_num_bits(8, 0, 0);
  vmsleep(5);
  --configure SPI device parameters
  spi.config_device(); 
  
  
  --configure and reset LCD
  display_dev = lcd_config_once(display_dev, 41, 2, 0, 1, 1, 0);
  vmsleep(5);

  --Software reset
  lcd_write_cmd(display_dev, 0xe2);  --e2
  vmsleep(5);

  lcd_write_cmd(display_dev, 0xae);  --0xae
  vmsleep(5);
 
  --Set scan direction of SEG -->> normal direction
  lcd_write_cmd(display_dev, 0xa0); --a0  
  vmsleep(5);
 
  --Set output direction pf CPM -->> reverse direction
  lcd_write_cmd(display_dev, 0xc8); --c8  
  vmsleep(5);

  lcd_write_cmd(display_dev, 0x40);  --0x40
  vmsleep(5);
  
   --Set all pixel ON
  lcd_write_cmd(display_dev, 0xa2); --a2
  vmsleep(5);
  
  --power Control
  lcd_write_cmd(display_dev, 0x2c); --0x2c
  vmsleep(5);
  lcd_write_cmd(display_dev, 0x2e); --0x2e
  vmsleep(5);
  lcd_write_cmd(display_dev, 0x2f); --0x2f
  vmsleep(5);

  --Select regulation resistor ratio
  lcd_write_cmd(display_dev, 0x24); --0x26
  vmsleep(5);
  
  lcd_write_cmd(display_dev, 0xac); --0xac
  vmsleep(5);
  lcd_write_cmd(display_dev, 0xaf); --0xaf
  vmsleep(5);

  lcd_write_cmd(display_dev, 0);
  vmsleep(5);
  lcd_write_cmd(display_dev, 0x10);
  vmsleep(5);
  lcd_write_cmd(display_dev, 0xb8);
  vmsleep(5);
  
  --configure LCD other parameters(height, width...)
  display_dev.x_pixels = 128; --width in pixels  
  display_dev.y_pixels = 64; --height in pixels
  display_dev.y_page_size = 8; --bits
  display_dev.ypages = ((display_dev.y_pixels + display_dev.y_page_size - 1) / display_dev.y_page_size);
  
  display_dev.page_address_set  = 176; -- 0xB0
  display_dev.col_addr_set_high = 16;  -- 0x10
  
  display_dev.col_addr_set_low  = 0;   -- 0x00
  
  display_dev.elec_volume_mode = 129; -- 0x81
  
  return display_dev;
end;

function lcd_set_diaplay_address(display_dev, pixel_x, pixel_y)  
  if ((pixel_y >= display_dev.y_pixels) or (pixel_x >= display_dev.x_pixels))then
    return false;
  end;
  local ypage = math.floor(pixel_y/display_dev.y_page_size);
  lcd_write_cmd(display_dev, bit.bor(display_dev.page_address_set, ypage));
  lcd_write_cmd(display_dev, bit.bor(display_dev.col_addr_set_high, bit.rshift(pixel_x,4)));
  lcd_write_cmd(display_dev, bit.bor(display_dev.col_addr_set_low, bit.band(pixel_x,15)));
  return true;
end;