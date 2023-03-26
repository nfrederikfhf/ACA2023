package stages
import chisel3._
import utilities._
import chisel3.util._

class ID(datawidth: Int) extends Module {

  val io = IO(new Bundle {
    val in = Flipped(new IF_ID_IO(datawidth))
    val out = new ID_EX_IO(datawidth,5)
  })

}
