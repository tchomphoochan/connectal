
// defined by user
import Say::*;
// generated by tool
import SayWrapper::*;
// generated by tool
import SayProxy::*;

interface Top;
   interface Axi3Slave#(32,32,4,12) ctrl;
   interface ReadOnly#(Bool) interrupt;
   interface Axi3Master#(40,64,8,12) m_axi;
   interface LEDS leds;
endinterface
   

module mkTop(Top);
   
   Say saySW <- mkSayProxy(7);
   Say sayHW <- mkSay(saySW);
   SayWrapper sayWrapper <- mkSayWrapper(1008,sayHW);

   Vector#(2,Axi3Slave#(32,32,4,12)) ctrls_v;
   Vector#(2,ReadOnly#(Bool)) interrupts_v;

   ctrls_v[0] = sayProxy.ctrl;
   ctrls_v[1] = sayWrapper.ctrl;
   let ctrl_mux <- mkAxiSlaveMux(ctrls_v);
   
   interrupts_v[0] = sayProxy.interrupt;
   interrupts_v[1] = sayWrapper.interrupt;
   let interrupt_mux <- mkInterruptMux(interrupts_v);
   
   interface Axi3Master m_axi = ?;
   interface Axi3Slave ctrl = ctrl_mux;
   interface ReadOnly interrupt = interrupt_mux;
   interface LEDS les = ?;
endmodule


module mkZynqTop (ZYNQ);
   
   Top top <- mkTop;
   PS7Standard ps7 <- mkPS7Standard;
   mkConnection(top.ctrl, ps7.s_gp0);
   mkConnection(top.m_axi, ps7.m_hs0);
   mkConnection(top.interrupt, ps7.interrupt);
   mkConnection(top.leds, ps7.leds);
   
endmodule

module mkPcieTop#(Clock pci_sys_clk_p, 
		  Clock pci_sys_clk_n,
		  Clock sys_clk_p, 
		  Clock sys_clk_n, 
		  Reset pci_sys_reset_n) (KC705_FPGA);
   
   Top top <- mkTop;
   let contentId = 64'h4563686f; // should identify the design loaded at runtime
   X7PcieBridgeIfc#(8) x7pcie <- mkX7PcieBridge(pci_sys_clk_p, pci_sys_clk_n, sys_clk_p, sys_clk_n, pci_sys_reset_n,
						2, // number of portals used in the design 
						contentId );
   mkConnection(top.ctrl, x7pcie.portal0);
   mkConnection(top.m_axi, x7pcie.foo);
   mkConnection(top.interrupt, x7pcie.interrupts);

   interface pcie = x7pcie.pcie
   methods leds = top.leds;

endmodule