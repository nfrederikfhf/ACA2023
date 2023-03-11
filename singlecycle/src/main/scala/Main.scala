import chisel3.emitVerilog
import components.SingleCycleProcessor

/**
 * An object extending App to generate the Verilog code.
 */
object Main extends App {
  emitVerilog(new SingleCycleProcessor())
}
