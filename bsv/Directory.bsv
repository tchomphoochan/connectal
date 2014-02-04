// bsv libraries
import Vector::*;
import FIFO::*;
import RegFile::*;
import SpecialFIFOs::*;

//portz libraries
import Portal::*;
import AxiMasterSlave::*;

interface Directory;
   interface StdPortal portalIfc;
endinterface

module mkDirectoryPortalIfc#(RegFile#(Bit#(32), Bit#(32)) rf)(StdPortal);
   Axi3Slave#(32,32,12) ctrl_mod <- mkAxi3SlaveFromRegFile(rf);
   method Bit#(32) ifcId();
      return 0;
   endmethod
   method Bit#(32) ifcType();
      return 0;
   endmethod
   interface Axi3Slave ctrl = ctrl_mod;
   interface ReadOnly interrupt;
      method Bool _read;
	 return False;
      endmethod
   endinterface
endmodule

module mkDirectory#(Vector#(n,StdPortal) portals) (Directory);
   let rf = (interface RegFile#(Bit#(32), Bit#(32));
		method Action upd(Bit#(32) addr, Bit#(32) data);
		   noAction;
		endmethod
		method Bit#(32) sub(Bit#(32) _addr);
		   let base = 128;
		   let addr = _addr[15:0]; 
		   if (addr == 0+base)
		      return 1; // directory version
		   else if (addr == 1+base)
		      return `TimeStamp;
		   else if (addr == 2+base)
		      return fromInteger(valueOf(n));
		   else if (addr == 3+base)
		      return 16; // portal Addr bits
		   else if (addr < fromInteger(valueOf(TAdd#(TMul#(2,n),4)))+base) begin
		      let idx = (addr-4-base);
		      if (idx[0] == 0)
		   	 return portals[idx>>1].ifcId;
		      else
		   	 return portals[idx>>1].ifcType;
		   end
		   else
		      return 0;
		endmethod
      	     endinterface);
   let ifc <- mkDirectoryPortalIfc(rf);
   interface StdPortal portalIfc = ifc;
endmodule



