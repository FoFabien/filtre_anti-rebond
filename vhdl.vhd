library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity compteur is
	port(
	comptage, H : in std_logic;
	fin_comptage : out std_logic
	);
end compteur;

architecture compte of compteur is
	signal AUX : std_logic_vector (17 downto 0);
	begin
		process (H)
			begin

			if H'event and H = '1'
				then fin_comptage <= '0';
				if comptage = '1'
				then AUX <= AUX + 1;
					if AUX = 249999
						then AUX <= "000000000000000000";
						fin_comptage <= '1';
					end if;
				else AUX <= "000000000000000000";
				end if;
			end if;
		end process;
end compte;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity sequenceur is
	port(
		fin_comptage, entree, H, R : in std_logic;
		comptage, sortie : out std_logic
		);
end sequenceur;
		
architecture commande of sequenceur is
	type etats is (validation0, validation1, test1, test0);
	signal etat : etats;
	begin
	changement_etat : process(R, H)
		begin
		if H'event and H='1'
			then case etat is
				when validation1 => if entree = '0' then etat <= test0;  end if;
				when test0 => 	if entree = '1' 
									then etat <= validation1;
									elsif entree = '0' and fin_comptage = '1' 
									then etat <= validation0;
									end if;
				when validation0 => if entree = '1' 
									then etat <= test1;  
									end if;
				when test1 => 	if entree = '0' 
									then etat <= validation0;
									elsif entree = '1' and fin_comptage = '1' 
									then etat <= validation1;
									end if;
				end case;
		end if;
		if R ='1' then etat <= validation0; end if;
		end process;

	definition_etat : process(etat)
		begin
			case etat is
				when validation1 => sortie <= '1'; comptage <= '0';
				when test0 => sortie <= '1'; comptage <= '1';
				when validation0 => sortie <= '0'; comptage <= '0';
				when test1 => sortie <= '0'; comptage <= '1';
			end case;
		end process;
end commande;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity filtre_anti_rebond is
	port(
		entree, H, R : in std_logic;
		sortie : out std_logic
		);
end filtre_anti_rebond;
				
architecture structurelle of filtre_anti_rebond is
	component sequenceur
		port(
			fin_comptage, entree, H, R : in std_logic;
			comptage, sortie : out std_logic
			);
	end component;
	
	component compteur
		port(
			comptage, H : in std_logic;
			fin_comptage : out std_logic
			);
	end component;
	
	signal comptage : std_logic;
	signal fin_comptage : std_logic;
	
	begin
		U0:sequenceur
			port map(entree=>entree, H=>H, R=>R, fin_comptage=>fin_comptage, comptage=>comptage, sortie=>sortie);
		U1:compteur
			port map(H=>H, fin_comptage=>fin_comptage, comptage=>comptage);
			
end structurelle;