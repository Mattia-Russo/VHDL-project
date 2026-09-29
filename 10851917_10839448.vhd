----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2025 10:39:55
-- Design Name: 
-- Module Name: project_reti_logiche - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
-- gestione casi finali in cui w5/w6/w7 sono fuori e devono essere 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity project_reti_logiche is
    port (
        i_clk : in std_logic;
        i_rst : in std_logic;
        i_start : in std_logic;
        i_add : in std_logic_vector(15 downto 0);
        
        o_done : out std_logic := '0';
        
        o_mem_addr : out std_logic_vector(15 downto 0);
        i_mem_data : in std_logic_vector(7 downto 0);
        o_mem_data : out std_logic_vector(7 downto 0);
        o_mem_we : out std_logic := '0';
        o_mem_en : out std_logic := '0'
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
signal offset, w_count : integer := 0;
signal k1, k2, s : std_logic_vector(7 downto 0) := (others => '0');
signal c1,c2,c3,c4,c5,c6,c7 : std_logic_vector(7 downto 0) := (others => '0');
signal w1,w2,w3,w4,w5,w6,w7 : std_logic_vector(7 downto 0) := (others => '0');
signal num_word : std_logic_vector(15 downto 0) := (others => '0');
signal mem_en_flag, mem_r_flag, mem_w_flag, next_word_flag, done : boolean := false;


begin
    
    process(i_rst, i_clk, i_start)
    variable sum : SIGNED(19 downto 0);
    variable word1, word2, word3, word4, word5, word6, word7, coef1, coef2, coef3, coef4, coef5, coef6, coef7 : SIGNED(9 downto 0);
    begin
        if(i_rst = '1') then 
            offset <= 0; 
            w_count <= 0;
            c1 <= (others => '0');
            c2 <= (others => '0');
            c3 <= (others => '0');
            c4 <= (others => '0');
            c5 <= (others => '0');
            c6 <= (others => '0');
            c7 <= (others => '0');
            w1 <= (others => '0');
            w2 <= (others => '0');
            w3 <= (others => '0');
            w4 <= (others => '0');
            w5 <= (others => '0');
            w6 <= (others => '0');
            w7 <= (others => '0');
            o_done <= '0';
            mem_en_flag <= false; 
            mem_r_flag <= false;  
            mem_w_flag <= false;  
            next_word_flag <= false;
            done <= false;       
        end if;
          
        if(i_start = '1' and i_clk='1' and done = false) then
            --report "offset: " & integer'image(offset);
            case offset is
            
                when 0 =>
                        if mem_en_flag then
                        mem_en_flag <= false;
                        mem_r_flag <= true;
                        
                  elsif mem_r_flag then
                        k1 <= i_mem_data;
                        mem_r_flag <= false;
                        offset <= offset + 1;
                        o_mem_en <= '0';                        
                  else
                        o_mem_addr <= i_add;
                        o_mem_en <= '1';
                        mem_en_flag <= true;    
                  end if;
                   
                when 1 =>
                  if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                  elsif mem_r_flag then
                       k2 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                  else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                  end if;
                when 2 =>
                      if mem_en_flag then
                           mem_en_flag <= false;
                           mem_r_flag <= true;
                      elsif mem_r_flag then
                           s <= i_mem_data;
                           mem_r_flag <= false;
                           offset <= offset + 1;
                           o_mem_en <= '0';
                      else
                           o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                           o_mem_en <= '1';
                           mem_en_flag <= true;   
                      end if;
                when 3 => 
                    
                    if(s(0)='0') then
                        offset <= offset + 1;
                    else
                        offset <= offset + 7;
                    end if;
                    num_word <= k1&k2;
                    report " k1: " & integer'image(to_integer(signed(k1))) & " k2: " & integer'image(to_integer(signed(k2))) & " s: " & integer'image(to_integer(signed(s)));
                    
                when 4 | 10 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c1 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
                when 5 | 11 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c2 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
               when 6 | 12 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c3 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
                when 7 | 13 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c4 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
                when 8 | 14 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c5 <= i_mem_data;
                       mem_r_flag <= false;
                       if(offset = 8) then
                            offset <= 17;
                       else
                            offset <= offset + 1;
                       end if;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
                when 15 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c6 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
                when 16 => 
                    if mem_en_flag then
                       mem_en_flag <= false;
                       mem_r_flag <= true;
                    elsif mem_r_flag then
                       c7 <= i_mem_data;
                       mem_r_flag <= false;
                       offset <= offset + 1;
                       o_mem_en <= '0';
                    else
                       o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset, 16));
                       o_mem_en <= '1';
                       mem_en_flag <= true;   
                    end if;
                when 17 =>              
                    if(s(0) = '0') then
                        case w_count is 
                            when 0 =>    
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w3 <= i_mem_data;
                                   mem_r_flag <= false;
                                   w_count <= w_count + 1;
                                   o_mem_en <= '0';
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if;
                            when 1 =>
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w4 <= i_mem_data;
                                   mem_r_flag <= false;
                                   w_count <= w_count + 1;
                                   o_mem_en <= '0';
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if;
                            when 2 =>
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w5 <= i_mem_data;
                                   mem_r_flag <= false;
                                   o_mem_en <= '0';
                                   offset <= offset + 1;
                                   w_count <= 0;
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if; 
                                when others =>
                        end case;
                    else
                       case w_count is 
                            when 0 =>
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w4 <= i_mem_data;
                                   mem_r_flag <= false;
                                   w_count <= w_count + 1;
                                   o_mem_en <= '0';
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if;
                            when 1 =>
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w5 <= i_mem_data;
                                   mem_r_flag <= false;
                                   w_count <= w_count + 1;
                                   o_mem_en <= '0';
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if;
                            when 2 =>
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w6 <= i_mem_data;
                                   mem_r_flag <= false;
                                   w_count <= w_count + 1;
                                   o_mem_en <= '0';
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if;
                            when 3 =>
                                if mem_en_flag then
                                   mem_en_flag <= false;
                                   mem_r_flag <= true;
                                elsif mem_r_flag then
                                   w7 <= i_mem_data;
                                   mem_r_flag <= false;
                                   o_mem_en <= '0';
                                   offset <= offset + 1;
                                   w_count <= 0;
                                else
                                   o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset + w_count, 16));
                                   o_mem_en <= '1';
                                   mem_en_flag <= true;   
                                end if;
                            when others =>
                            end case;  
                    end if;                    
                when others =>
                    if not mem_w_flag then
                        if s(0)='0' then
                            word1 := resize(SIGNED(w1), 10);
                            word2 := resize(SIGNED(w2), 10);
                            word3 := resize(SIGNED(w3), 10);
                            word4 := resize(SIGNED(w4), 10);
                            word5 := resize(SIGNED(w5), 10);
                            coef1 := resize(SIGNED(c1), 10);
                            coef2 := resize(SIGNED(c2), 10);
                            coef3 := resize(SIGNED(c3), 10);
                            coef4 := resize(SIGNED(c4), 10);
                            coef5 := resize(SIGNED(c5), 10);
                            sum := word1*coef1 + word2*coef2 + word3*coef3 + word4*coef4 + word5*coef5;                           
                            sum := shift_right(SIGNED(sum), 4) + shift_right(SIGNED(sum), 6) + shift_right(SIGNED(sum), 8) + shift_right(SIGNED(sum), 10);
                            report "sum: " &integer'image(to_integer(signed(sum)));
                        else                            
                            word1 := resize(SIGNED(w1), 10);
                            word2 := resize(SIGNED(w2), 10);
                            word3 := resize(SIGNED(w3), 10);
                            word4 := resize(SIGNED(w4), 10);
                            word5 := resize(SIGNED(w5), 10);
                            word6 := resize(SIGNED(w6), 10);
                            word7 := resize(SIGNED(w7), 10);
                            coef1 := resize(SIGNED(c1), 10);
                            coef2 := resize(SIGNED(c2), 10);
                            coef3 := resize(SIGNED(c3), 10);
                            coef4 := resize(SIGNED(c4), 10);
                            coef5 := resize(SIGNED(c5), 10);
                            coef6 := resize(SIGNED(c6), 10);
                            coef7 := resize(SIGNED(c7), 10);
                            sum := word1*coef1 + word2*coef2 + word3*coef3 + word4*coef4 + word5*coef5 + word6*coef6 + word7*coef7;                            
                            sum := shift_right(SIGNED(sum), 6) + shift_right(SIGNED(sum), 10);
                        end if;
                        if(sum < 0 and s(0)='0') then
                            sum:= sum + to_signed(4, 16);
                        elsif sum < 0 then
                            sum:= sum + to_signed(2, 16);
                        end if;
                        if(sum > to_signed(127, 20)) then 
                            sum := to_signed(127, 20);
                        elsif(sum < to_signed(-128, 20)) then
                            sum := to_signed(-128, 20);
                        end if;                    
                    end if;
                    
                    if not next_word_flag then
                        if mem_en_flag then
                           mem_en_flag <= false;
                           mem_r_flag <= true;
                           
                        elsif mem_r_flag then
                           mem_r_flag <= false;
                           o_mem_en <= '0';
                           o_mem_we <= '0';
                           next_word_flag <= true;
                           if w_count = to_integer(UNSIGNED(num_word))-1 then
                              done <= true;
                              o_done <='1';
                           end if;
                           w_count <= w_count + 1;
                
                        else
                           o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset-1 + w_count, 16) + unsigned(num_word));
                           o_mem_data <= std_logic_vector(sum(7 downto 0));
                           o_mem_en <= '1';
                           o_mem_we <= '1';
                           mem_en_flag <= true;
                           mem_w_flag <= true;   
                        end if;
                    else                            
                        if s(0)='0' then
                            if w_count >= to_integer(UNSIGNED(num_word)) - 2  then
                               w1 <= w2;
                               w2 <= w3;
                               w3 <= w4;
                               w4 <= w5;
                               w5 <= (others => '0');
                               next_word_flag <= false;
                               mem_w_flag <= false;                                                     
                            elsif mem_en_flag then
                               mem_en_flag <= false;
                               mem_r_flag <= true;
                            elsif mem_r_flag then
                               w1 <= w2;
                               w2 <= w3;
                               w3 <= w4;
                               w4 <= w5;
                               w5 <= i_mem_data;
                               mem_r_flag <= false;
                               next_word_flag <= false;
                               mem_w_flag <= false;
                               o_mem_en <= '0';
                            else
                               o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset - 1 + w_count + 2, 16));
                               o_mem_en <= '1';
                               mem_en_flag <= true;   
                            end if;
                         else 
                            if w_count >= to_integer(UNSIGNED(num_word)) - 3 then
                               w1 <= w2;
                               w2 <= w3;
                               w3 <= w4;
                               w4 <= w5;
                               w5 <= w6;
                               w6 <= w7;
                               w7 <= (others => '0');
                               next_word_flag <= false;
                               mem_w_flag <= false;
                            elsif mem_en_flag then
                               mem_en_flag <= false;
                               mem_r_flag <= true;
                            elsif mem_r_flag then
                               w1 <= w2;
                               w2 <= w3;
                               w3 <= w4;
                               w4 <= w5;
                               w5 <= w6;
                               w6 <= w7;
                               w7 <= i_mem_data;
                               mem_r_flag <= false;
                               next_word_flag <= false;
                               mem_w_flag <= false;
                               o_mem_en <= '0';
                            else
                               o_mem_addr <= std_logic_vector(unsigned(i_add) + to_unsigned(offset - 1 + w_count + 3, 16));
                               o_mem_en <= '1';
                               mem_en_flag <= true; 
                            end if;
                        end if;
                    end if;
                    
            end case; 
        elsif(i_start ='0' and done = true) then
            o_done <= '0';
            done <= false;
            offset <= 0; 
            w_count <= 0;
            c1 <= (others => '0');
            c2 <= (others => '0');
            c3 <= (others => '0');
            c4 <= (others => '0');
            c5 <= (others => '0');
            c6 <= (others => '0');
            c7 <= (others => '0');
            w1 <= (others => '0');
            w2 <= (others => '0');
            w3 <= (others => '0');
            w4 <= (others => '0');
            w5 <= (others => '0');
            w6 <= (others => '0');
            w7 <= (others => '0');
            mem_en_flag <= false; 
            mem_r_flag <= false;  
            mem_w_flag <= false;  
            next_word_flag <= false;  
        end if;
    end process;
end Behavioral;
