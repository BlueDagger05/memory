`ifndef SCB
`define SCB
class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)

   pkt pkt_handler, cmp_pkt, rd_pkt;

// associative array for rom
   bit[3:0] memory_rom [bit[7:0]];

   int totalCount = 0;

// analysis port for monitor->scb connection
   uvm_analysis_imp #(pkt, scoreboard) item_collected_export_mon;

// queue
   pkt pkt_queue[$];

   function new(string name = "scoreboard", uvm_component parent = null);
	   super.new(name, parent);
   endfunction: new


   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   item_collected_export_mon = new("item_collected_export_mon", this);

	   memory_rom = '{'hA: 8'hA,
			  'hB: 8'hB,
			  'hC: 8'hC};

   endfunction: build_phase

   // custom print method
   // extern function void ctm_print();


   // compare function 
   extern function void compare(pkt cmp_pkt);


   // write function
   function void write(pkt pkt_handler);

	   if(pkt_handler.wr_en && !pkt_handler.op_en && pkt_handler.cs)
	   begin
		  pkt_queue.push_back(pkt_handler);
	          compare(pkt_handler);
	   end

	   else if(pkt_queue.size > 0)
	   begin

	     if(!pkt_handler.wr_en && pkt_handler.op_en && pkt_handler.cs)
	     begin
	            rd_pkt = pkt_queue.pop_front();
	            compare(rd_pkt);
	     end
	     else
		`uvm_info("SCB", $sformatf("FAILED TO FETCH READ PACKET"), UVM_MEDIUM)
           end

   endfunction: write      

  
/////////////////////////////////////////
// REPORT_PHASE
/////////////////////////////////////////
   function void report_phase(uvm_phase phase);
	   super.report_phase(phase);

	   if(totalCount == 20)

	   begin

	     $display("                                                                      ");
             $display (" $$$$$$$\   $$$$$$\   $$$$$$\   $$$$$$\  $$$$$$$$\ $$$$$$$\""  );  
             $display (" $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  _____|$$  __$$\   ");
             $display (" $$ |  $$ |$$ /  $$ |$$ /  \__|$$ /  \__|$$ |      $$ |  $$ |  ");
             $display (" $$$$$$$  |$$$$$$$$ |\$$$$$$\  \$$$$$$\  $$$$$\    $$ |  $$ |  ");
             $display (" $$  ____/ $$  __$$ | \____$$\  \____$$\ $$  __|   $$ |  $$ |  ");
             $display (" $$ |      $$ |  $$ |$$\   $$ |$$\   $$ |$$ |      $$ |  $$ |  ");
             $display (" $$ |      $$ |  $$ |\$$$$$$  |\$$$$$$  |$$$$$$$$\ $$$$$$$  |  ");
             $display (" \__|      \__|  \__| \______/  \______/ \________|\_______/   ");
	     $display("                                                                      ");
           end

	   else
	   begin
	      $display("                                                                      ");
              $display("  $$$$$$$$|   $$$$$$$ | |$$$$$$|   $$ |        $$$$$$$$|   $$$$$$$ |  ");
              $display("  $$  ____|  $$  __$$ |   $$ |     $$ |       $$  _____|  $$  __$$ |  ");
              $display("  $$ |       $$ /  $$ |   $$ |     $$ |       $$ |        $$ |  $$ |  ");
              $display("  $$$$$ |    $$$$$$$$ |   $$ |     $$ |       $$$$$ |     $$ |  $$ |  ");
              $display("  $$  __|    $$  __$$ |   $$ |     $$ |       $$  __|     $$ |  $$ |  ");
              $display("  $$ |       $$ |  $$ |   $$ |     $$ |       $$ |        $$ |  $$ |  ");
              $display("  $$ |       $$ |  $$ | $$$$$$ |   $$$$$$$$ | $$$$$$$$ |  $$$$$$$  |  ");
              $display("  $__|       $__|  $__| $______|   $________| $________|  $_______/   ");
	      $display("                                                                      ");
            end                                          
                                                          
   endfunction: report_phase
endclass: scoreboard


// function void scoreboard::ctm_print(pkt);

function void scoreboard::compare(pkt cmp_pkt);

	begin
		if(cmp_pkt.data_in == (memory_rom[cmp_pkt.addr_in])  )
		begin
			//$display("PKT PASS");
			//$display("[SCB] :: addr = 0x%0h, addr = 0x%0h", 
			//	cmp_pkt.addr_in, memory_rom[1]);

			//$display("[SCB] :: data = 0x%0h, data = 0x%0h", 
			//	cmp_pkt.data_in, memory_rom[cmp_pkt.addr_in]);

			//// cmp_pkt.print();
			//totalCount++;
		end
		else
			$display("PKT FAIL");
        end
endfunction
`endif
