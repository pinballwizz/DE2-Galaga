---------------------------------------------------------------------------------
-- DE2-35 Top level for Galaga Midway by Dar (darfpga@aol.fr) (December 2016)
-- http://darfpga.blogspot.fr
---------------------------------------------------------------------------------
-- Educational use only
-- Do not redistribute synthetized file with roms
-- Do not redistribute roms whatever the form
-- Use at your own risk
---------------------------------------------------------------------------------
--
-- Main features :
--  PS2 keyboard input
--  Wm8731 sound output
--  NO board SRAM/Flash used
--
-- Uses 1 pll for 18MHz and 11MHz generation from 50MHz
--
-- Board key :
--      0 : reset
--
-- Keyboard inputs :
--   F3 : Add coin
--   F2 : Start 2 players
--   F1 : Start 1 player
--   SPACE       : Fire player 1 & 2
--   RIGHT arrow : Move right player 1 & 2
--   LEFT arrow  : Move left player 1 & 2
--
-- Dip switch and other details : see galaga.vhd

---------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity galaga_de2 is
port(
 clock_50  : in std_logic;
-- clock_27  : in std_logic;
-- ext_clock : in std_logic;
-- ledr      : out std_logic_vector(17 downto 0);
-- ledg      : out std_logic_vector(8 downto 0);
 key       : in std_logic_vector(3 downto 0);
-- sw        : in std_logic_vector(17 downto 0);

-- dram_ba_0  : out std_logic;
-- dram_ba_1  : out std_logic;
-- dram_ldqm  : out std_logic;
-- dram_udqm  : out std_logic;
-- dram_ras_n : out std_logic;
-- dram_cas_n : out std_logic;
-- dram_cke   : out std_logic;
-- dram_clk   : out std_logic;
-- dram_we_n  : out std_logic;
-- dram_cs_n  : out std_logic;
-- dram_dq    : inout std_logic_vector(15 downto 0);
-- dram_addr  : out std_logic_vector(11 downto 0);
--
-- fl_addr  : out std_logic_vector(21 downto 0);
-- fl_ce_n  : out std_logic;
-- fl_oe_n  : out std_logic;
-- fl_dq    : inout std_logic_vector(7 downto 0);
-- fl_rst_n : out std_logic;
-- fl_we_n  : out std_logic;
--
-- hex0 : out std_logic_vector(6 downto 0);
-- hex1 : out std_logic_vector(6 downto 0);
-- hex2 : out std_logic_vector(6 downto 0);
-- hex3 : out std_logic_vector(6 downto 0);
-- hex4 : out std_logic_vector(6 downto 0);
-- hex5 : out std_logic_vector(6 downto 0);
-- hex6 : out std_logic_vector(6 downto 0);
-- hex7 : out std_logic_vector(6 downto 0);

 ps2_clk : in std_logic;
 ps2_dat : inout std_logic;

-- uart_txd : out std_logic;
-- uart_rxd : in std_logic;
--
-- lcd_rw   : out std_logic;
-- lcd_en   : out std_logic;
-- lcd_rs   : out std_logic;
-- lcd_data : out std_logic_vector(7 downto 0);
-- lcd_on   : out std_logic;
-- lcd_blon : out std_logic;
 
-- sram_addr : out std_logic_vector(17 downto 0);
-- sram_dq   : inout std_logic_vector(15 downto 0);
-- sram_we_n : out std_logic;
-- sram_oe_n : out std_logic;
-- sram_ub_n : out std_logic;
-- sram_lb_n : out std_logic;
-- sram_ce_n : out std_logic;
 
-- otg_addr   : out std_logic_vector(1 downto 0);
-- otg_cs_n   : out std_logic;
-- otg_rd_n   : out std_logic;
-- otg_wr_n   : out std_logic;
-- otg_rst_n  : out std_logic;
-- otg_data   : inout std_logic_vector(15 downto 0);
-- otg_int0   : in std_logic;
-- otg_int1   : in std_logic;
-- otg_dack0_n: out std_logic;
-- otg_dack1_n: out std_logic;
-- otg_dreq0  : in std_logic;
-- otg_dreq1  : in std_logic;
-- otg_fspeed : inout std_logic;
-- otg_lspeed : inout std_logic;
-- 
-- tdi : in std_logic;
-- tcs : in std_logic;
-- tck : in std_logic;
-- tdo : out std_logic;
 
 vga_r     : out std_logic_vector(9 downto 0);
 vga_g     : out std_logic_vector(9 downto 0);
 vga_b     : out std_logic_vector(9 downto 0);
 vga_clk   : out std_logic;
 vga_blank : out std_logic;
 vga_hs    : out std_logic;
 vga_vs    : out std_logic;
 vga_sync  : out std_logic;
--
 i2c_sclk : out std_logic;
 i2c_sdat : inout std_logic;
 
-- td_clk27 : in std_logic;
-- td_reset : out std_logic;
-- td_data  : in std_logic_vector(7 downto 0);
-- td_hs    : in std_logic;
-- td_vs    : in std_logic;

 aud_adclrck : out std_logic;
 aud_adcdat  : in std_logic;
 aud_daclrck : out std_logic;
 aud_dacdat  : out std_logic;
 aud_xck     : out std_logic;
 aud_bclk    : out std_logic
 
-- enet_data  : inout std_logic_vector(15 downto 0);
-- enet_clk   : out std_logic;
-- enet_cmd   : out std_logic;
-- enet_cs_n  : out std_logic;
-- enet_int   : in std_logic;
-- enet_rd_n  : out std_logic;
-- enet_wr_n  : out std_logic;
-- enet_rst_n : out std_logic;
-- 
-- irda_txd : out std_logic;
-- irda_rxd : in std_logic;
-- 
-- sd_dat  : inout std_logic;
-- sd_dat3 : out std_logic;
-- sd_cmd  : out std_logic;
-- sd_clk  : out std_logic;
-- 
-- gpio_0  : inout std_logic_vector(35 downto 0)
-- gpio_1  : inout std_logic_vector(35 downto 0)
);
end galaga_de2;

architecture struct of galaga_de2 is

 signal clock_18  : std_logic;
 signal clock_9   : std_logic;
-- signal clock_11  : std_logic;
-- signal clock_6   : std_logic;

 signal clock_36  : std_logic;  --mod by somhic
 signal clock_6   : std_logic;  --mod by somhic
 signal clock_12   : std_logic;  --mod by somhic

 signal r         : std_logic_vector(2 downto 0);
 signal g         : std_logic_vector(2 downto 0);
 signal b         : std_logic_vector(1 downto 0);
-- signal video_clk : std_logic;
 signal csync     : std_logic;
 signal hsync     : std_logic;   -- mod by somhic
 signal vsync     : std_logic;   -- mod by somhic
 signal blankn    : std_logic;
 
 -- video signals   -- mod by somhic
 --signal clock_vga       : std_logic;   
 signal video_clk       : std_logic;   
 signal vga_g_i         : std_logic_vector(5 downto 0);   
 signal vga_r_i         : std_logic_vector(5 downto 0);   
 signal vga_b_i         : std_logic_vector(5 downto 0);   
 signal vga_r_o         : std_logic_vector(5 downto 0);   
 signal vga_g_o         : std_logic_vector(5 downto 0);   
 signal vga_b_o         : std_logic_vector(5 downto 0);   
 signal hsync_o         : std_logic;   
 signal vsync_o         : std_logic;   
 signal blankn_o        : std_logic;

 signal vga_r_c         : std_logic_vector(3 downto 0);
 signal vga_g_c         : std_logic_vector(3 downto 0);
 signal vga_b_c         : std_logic_vector(3 downto 0);
 signal vga_hs_c        : std_logic;
 signal vga_vs_c        : std_logic;

 
 
 signal audio        : std_logic_vector(9 downto 0);
 signal sound_string : std_logic_vector(31 downto 0);
 signal reset        : std_logic;
 
 alias  reset_n      : std_logic is key(0);
 
 signal kbd_intr      : std_logic;
 signal kbd_scancode  : std_logic_vector(7 downto 0);
 signal joyPCFRLDU    : std_logic_vector(8 downto 0);

 signal slot      	 : std_logic_vector(2 downto 0) := (others => '0');
 
 component scandoubler        -- mod by somhic
    port (
    clk_sys : in std_logic;
    scanlines : in std_logic_vector (1 downto 0);
    ce_x1 : in std_logic;
    ce_x2 : in std_logic;
    hs_in : in std_logic;
    vs_in : in std_logic;
    r_in : in std_logic_vector (5 downto 0);
    g_in : in std_logic_vector (5 downto 0);
    b_in : in std_logic_vector (5 downto 0);
    hs_out : out std_logic;
    vs_out : out std_logic;
    r_out : out std_logic_vector (5 downto 0);
    g_out : out std_logic_vector (5 downto 0);
    b_out : out std_logic_vector (5 downto 0)
  );
end component;
 
 
begin

reset <= not reset_n;
-- tv15Khz_mode <= sw();

clk_11_18 : entity work.pll50_to_11_and_18
port map(
 inclk0 => clock_50,
  c0 => clock_36,
-- c0 => clock_11,
-- c1 => clock_18,
 locked => open --pll_locked
);

process (clock_36)
begin
 if rising_edge(clock_36) then
  clock_12      <= '0';
	
	clock_18  <= not clock_18;

  if slot = "101" then
   slot <= (others => '0');
  else
		slot <= std_logic_vector(unsigned(slot) + 1);
  end if;   
	
	if slot = "100" or slot = "001" then clock_6 <= not clock_6;	end if;
	if slot = "100" or slot = "001" then clock_12  <= '1';	end if;	

 end if;
end process;


--process (reset, clock_11)
--begin
--	if reset='1' then
--		clock_6  <= '0';
--	else 
--		if rising_edge(clock_11) then
--				clock_6  <= not clock_6;
--		end if;
--	end if;
--end process;

galaga : entity work.galaga
port map(
 clock_18     => clock_18,
 reset        => reset,
-- tv15Khz_mode => tv15Khz_mode,
 video_r      => r,
 video_g      => g,
 video_b      => b,
 video_csync  => csync,
 video_blankn => blankn,
 video_hs     => hsync,
 video_vs     => vsync,
 video_clk    => video_clk,    -- mod by somhic
 audio        => audio,
 
 b_test       => '1',
 b_svce       => '1', 
 coin         => joyPCFRLDU(7), -- t
 start1       => joyPCFRLDU(5), -- f
 left1        => joyPCFRLDU(2),
 right1       => joyPCFRLDU(3),
 fire1        => joyPCFRLDU(4),
 start2       => joyPCFRLDU(6),
 left2        => joyPCFRLDU(2),
 right2       => joyPCFRLDU(3),
 fire2        => joyPCFRLDU(4) 
);

vga_clk   <= clock_18;
vga_sync  <= '0';
vga_blank <= '1'; --blankn;

-- bagman settings
--	vga_clk <= video_clk;
--	vga_sync <=  '0';
--	vga_blank <= '1';

--vga_r <= r & "0000000";
--vga_g <= g & "0000000";
--vga_b <= b & "00000000";

-- adapt video to 6 bits/color only
vga_r_i <= r & r  when blankn = '1' else "000000";
vga_g_i <= g & g  when blankn = '1' else "000000";
vga_b_i <= b & b & b  when blankn = '1' else "000000";

-- vga scandoubler
scandoubler_inst :  scandoubler
  port map (
    clk_sys => clock_12,     --clock_18, video_clk i clock_36 no funciona
    scanlines => "00",       --(00-none 01-25% 10-50% 11-75%)
    ce_x1 => clock_6,     
    ce_x2 => '1',
    hs_in => hsync,
    vs_in => vsync,
    r_in => vga_r_i,
    g_in => vga_g_i,
    b_in => vga_b_i,
    hs_out => hsync_o,
    vs_out => vsync_o,
    r_out => vga_r_o,
    g_out => vga_g_o,
    b_out => vga_b_o
  );

-- synchro composite/ synchro horizontale
--vga_hs <= csync;
-- vga_hs <= csync when tv15Khz_mode = '1' else hsync;
-- commutation rapide / synchro verticale
--vga_vs <= '1';
-- vga_vs <= '1'   when tv15Khz_mode = '1' else vsync;

process (clock_36)
begin
		if rising_edge(clock_36) then
        --VGA adapt video to 4 for lite / 10 bits color only for de2
        vga_r  <= vga_r_o & "0000";
        vga_g  <= vga_g_o & "0000";
        vga_b  <= vga_b_o & "0000";
        vga_hs <= hsync_o;       
        vga_vs <= vsync_o; 	    	
			
		end if;
end process;


sound_string <= "000" & audio & "000" & "000" & audio & "000";

wm8731_dac : entity work.wm8731_dac
port map(
 clk18MHz => clock_18,
 sampledata => sound_string,
 i2c_sclk => i2c_sclk,
 i2c_sdat => i2c_sdat,
 aud_bclk => aud_bclk,
 aud_daclrck => aud_daclrck,
 aud_dacdat => aud_dacdat,
 aud_xck => aud_xck
); 

-- get scancode from keyboard

process (reset, clock_18)
begin
	if reset='1' then
		clock_9  <= '0';
	else 
		if rising_edge(clock_18) then
				clock_9  <= not clock_9;
		end if;
	end if;
end process;

keyboard : entity work.io_ps2_keyboard
port map (
  clk       => clock_9,
  kbd_clk   => ps2_clk,
  kbd_dat   => ps2_dat,
  interrupt => kbd_intr,
  scancode  => kbd_scancode
);

-- translate scancode to joystick
joystick : entity work.kbd_joystick
port map (
  clk         => clock_9,
  kbdint      => kbd_intr,
  kbdscancode => std_logic_vector(kbd_scancode), 
  joy_BBBBFRLDU  => joyPCFRLDU 
);

end struct;
